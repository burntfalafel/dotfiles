# Better GDB defaults ----------------------------------------------------------

set history save
set confirm off
set verbose off
set print pretty on
set print array off
set print array-indexes on
set python print-stack full
set radix 16

# Functions ---------------------------------------------------------------------
define reboot
    start
    c
end
# Start ------------------------------------------------------------------------


python
import gdb, os

# Define ANSI color codes.
BOLD = "\033[1m"
RED = "\033[31m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
BLUE = "\033[34m"
MAGENTA = "\033[35m"
CYAN = "\033[36m"
WHITE = "\033[37m"
RESET = "\033[0m"

class Dashboard(gdb.Command):
    """Persistent Dashboard: displays breakpoints and variables with color."""
    def __init__(self):
        super(Dashboard, self).__init__("dashboard", gdb.COMMAND_USER)
        self.banner = (BOLD + MAGENTA + "=" * 1 + RESET + "\n" +
                       BOLD + BLUE + "   *** GDB Custom Dashboard ***" + RESET + "\n" +
                       BOLD + MAGENTA + "=" * 1 + RESET + "\n")
        gdb.events.stop.connect(self.on_stop)

    def on_stop(self, event):
        self.render()

    def render(self):
        # Clear the screen.
        #  gdb.write("\033[H\033[2J")
        gdb.write(self.banner)

        # Display breakpoints.
        bp_info = gdb.execute("info breakpoints", to_string=True)
        gdb.write(GREEN + "Breakpoints:" + RESET + "\n" + bp_info + "\n")

        # Display arguments.
        args_info = gdb.execute("info args", to_string=True)
        gdb.write(YELLOW + "Arguments:" + RESET + "\n" + args_info + "\n")

        # Display locals but truncate if more than 10 entries.
        locals_info = gdb.execute("info locals", to_string=True)
        locals_lines = locals_info.splitlines()
        if len(locals_lines) > 10:
            locals_lines = locals_lines[:10] + [f"... ({len(locals_lines)-10} more locals)"]
        gdb.write(CYAN + "Locals:" + RESET + "\n" + "\n".join(locals_lines) + "\n")

        # Final prompt.
        gdb.write(BOLD + WHITE + ">>> " + RESET)

    def invoke(self, arg, from_tty):
        self.render()

Dashboard()
end

# ------------------------------------------------------------------------------
# Copyright (c) 2025 burntfalafel
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------
# vim: filetype=python
# Local Variables:
# mode: python
# End:
