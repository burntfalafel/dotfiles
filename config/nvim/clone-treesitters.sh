#!/usr/bin/env bash

set -euo pipefail

BASE="/tmp/tree-sitter-build"
INSTALL_DIR="$HOME/.config/nvim/parser"
NVIM_DIR="$HOME/.config/nvim"

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

command -v git >/dev/null 2>&1 || fail "git not installed"
command -v tree-sitter >/dev/null 2>&1 || fail "tree-sitter CLI not installed"

mkdir -p "$BASE" "$INSTALL_DIR" "$NVIM_DIR"
cd "$BASE" || fail "cannot cd to $BASE"

repos=(
  "https://github.com/tree-sitter/tree-sitter-c"
  "https://github.com/tree-sitter/tree-sitter-cpp"
  "https://github.com/tree-sitter/tree-sitter-python"
  "https://github.com/tree-sitter/tree-sitter-bash"
  "https://github.com/uyha/tree-sitter-cmake"
  "https://github.com/alemuller/tree-sitter-make"
  "https://github.com/tree-sitter-grammars/tree-sitter-lua"
  "https://github.com/tree-sitter-grammars/tree-sitter-vim"
  "https://github.com/Hubro/tree-sitter-robot"
# "https://github.com/tree-sitter-grammars/tree-sitter-vimdoc"
  "https://github.com/tree-sitter-grammars/tree-sitter-query"
  "https://github.com/burntfalafel/tree-sitter-tarmac"
)

# clone (skip if exists)
for repo in "${repos[@]}"; do
  name="$(basename "$repo")"
  if [[ -d "$name" ]]; then
    echo "Skipping $name"
  else
    echo "Cloning $name..."
    git clone --depth 1 --recursive "$repo" "$name" \
      || fail "clone failed: $name"
  fi
done

# build + install
for dir in tree-sitter-*; do
  [[ -d "$dir" ]] || continue

  echo "Building $dir..."
  cd "$BASE/$dir" || fail "cd failed: $dir"

  # fix cpp dependency
  if [[ "$dir" == "tree-sitter-cpp" ]]; then
    mkdir -p node_modules
    ln -sfn "$BASE/tree-sitter-c" node_modules/tree-sitter-c
  fi

  tree-sitter generate || fail "generate failed: $dir"
  tree-sitter build || fail "build failed: $dir"

  lang="${dir#tree-sitter-}"

  if compgen -G "*.so" >/dev/null; then
    lib="$(ls *.so | head -n 1)"
    ext="so"
  elif compgen -G "*.dylib" >/dev/null; then
    lib="$(ls *.dylib | head -n 1)"
    ext="dylib"
  else
    fail "no parser library found in $dir"
  fi

  mv "$lib" "$INSTALL_DIR/$lang.$ext" \
    || fail "install failed: $dir"

  echo "Installed $lang.$ext"
  cd "$BASE"
done

# install queries
if [[ ! -d "$NVIM_DIR/queries" ]]; then
  echo "Installing queries..."
  TMP="/tmp/nvim-ts-queries"
  rm -rf "$TMP"

  git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter "$TMP" \
    || fail "failed to clone nvim-treesitter"

  cp -r "$TMP/runtime/queries" "$NVIM_DIR/" \
    || fail "failed to copy queries"

  rm -rf "$TMP"
else
  echo "Queries already exist, skipping"
fi

echo "All parsers + queries installed."
