# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import absolute_import, division, print_function

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


# ask for confirmation when renaming files
class rename(Command):
    """:rename <newname>
    Changes the name of the currently highlighted file to <newname>
    """

    def execute(self):
        from ranger.container.file import File
        from os import access

        new_name = self.rest(1)

        if not new_name:
            return self.fm.notify("Syntax: rename <newname>", bad=True)

        if new_name == self.fm.thisfile.relative_path:
            return None

        def rename(answer):
            if not answer in "yY":
                return

            if access(new_name, os.F_OK):
                return self.fm.notify("Can't rename: file already exists!", bad=True)

            if self.fm.rename(self.fm.thisfile, new_name):
                file_new = File(new_name)
                self.fm.bookmarks.update_path(self.fm.thisfile.path, file_new)
                self.fm.tags.update_path(self.fm.thisfile.path, file_new.path)
                self.fm.thisdir.pointed_obj = file_new
                self.fm.thisfile = file_new

        self.fm.ui.console.ask(
            f"{self.fm.thisfile.relative_path} ~> {new_name}? (y/N)", rename, ("n", "N", "y", "Y"),
        )

        return None

    def tab(self, tabnum):
        if not self.arg(1):
            return self.line + self.fm.thisfile.relative_path


# adapted from https://github.com/ranger/ranger/wiki/Custom-Commands
class fzf_fd(Command):
    """
    :fzf_fd
    Find a file using fzf.
    With a prefix argument select only directories.
    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess

        if self.quantifier:
            # match only directories
            command = "fd -t d . | fzf +m"
        else:
            # match files and directories
            command = "fd . | fzf +m"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode("utf-8").rstrip("\n"))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


# fzf_locate
class fzf_rg(Command):
    """
    :fzf_rg

    Usage: fzf_rg <search string>
    """

    def execute(self):
        if self.arg(1):
            search_string = self.rest(1)
        else:
            self.fm.notify("Usage: fzf_rg <search string>", bad=True)
            return

        import subprocess
        import os.path
        from ranger.container.file import File

        command = "rg '%s' . | fzf +m | awk -F':' '{print $1}'" % search_string
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip("\n"))
            self.fm.execute_file(File(fzf_file))


# tag
class tag(Command):
    """
    :tag

    Usage: tag [tags...]
    """

    def execute(self):
        import subprocess

        cmd = ["filetags"]
        flags = ""
        if self.arg(1):
            cmd.extend(["--tags", self.rest(1)])
            flags += "f"
        else:
            flags += "w"

        cmd.extend([f.realpath for f in self.fm.thistab.get_selection()])
        filetags = self.fm.execute_command(cmd, flags=flags)
        self.fm.reload_cwd()


TAG_AWARE_REGEX = r"^(?P<timestamp>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2} )?(?P<name>.*?)?(?P<rest>( -- .*?)?(\.[^.]+?)*?)$"

# trename
class trename(Command):
    """
    :trename

    Tag-aware rename. Rename `filetags` files keeping the timestamp, tags, and extension intact

    Usage: trename <newname>
    """

    def tab(self, tabnum):
        if not self.arg(1):
            import re

            name = re.match(TAG_AWARE_REGEX, self.fm.thisfile.basename).group("name")
            return self.line + name

    def execute(self):
        new_name = self.rest(1)
        if not new_name:
            return self.fm.notify("Syntax: trename <newname>", bad=True)

        from ranger.container.file import File
        import re
        from os import access

        m = re.match(TAG_AWARE_REGEX, self.fm.thisfile.basename)
        new_filename = os.path.join(
            self.fm.thisfile.dirname,
            f"{m.group('timestamp') or ''}{new_name}{m.group('rest') or ''}",
        )

        if new_filename == self.fm.thisfile.relative_path:
            return None

        i = 1
        while access(new_filename, os.F_OK):
            i = i + 1
            new_filename = os.path.join(
                self.fm.thisfile.dirname,
                f"{m.group('timestamp') or ''}{new_name} {i}{m.group('rest') or ''}",
            )

        def rename(answer):
            if not answer in "yY":
                return

            if self.fm.rename(self.fm.thisfile, new_filename):
                file_new = File(new_filename)
                self.fm.thisdir.pointed_obj = file_new
                self.fm.thisfile = file_new

        self.fm.ui.console.ask(
            f"{self.fm.thisfile.relative_path} ~> {new_filename}? (y/N)",
            rename,
            ("n", "N", "y", "Y"),
        )


# setyear
class setyear(Command):
    """
    :setyear

    Tag-aware rename. Fix the timestamp by setting it to a known year, keeping
    the rest of the filename intact.

    Usage: setyear <year>
    """

    def execute(self):
        from ranger.container.file import File
        import re
        from os import access

        year = self.rest(1)
        if not year:
            return self.fm.notify("Syntax: setyear <year>", bad=True)
        if not re.match(r"^\d{4}$", year):
            return self.fm.notify(f"Invalid year '{year}'", bad=True)

        m = re.match(TAG_AWARE_REGEX, self.fm.thisfile.basename)
        new_filename = os.path.join(
            self.fm.thisfile.dirname,
            f"{year}-00-00T00:00:00 {m.group('name') or ''}{m.group('rest') or ''}",
        )

        if new_filename == self.fm.thisfile.relative_path:
            return None

        i = 1
        while access(new_filename, os.F_OK):
            i = i + 1
            new_filename = os.path.join(
                self.fm.thisfile.dirname,
                f"{m.group('timestamp') or ''}{new_name} {i}{m.group('rest') or ''}",
            )

        def rename(answer):
            if not answer in "yY":
                return

            if self.fm.rename(self.fm.thisfile, new_filename):
                file_new = File(new_filename)
                self.fm.thisdir.pointed_obj = file_new
                self.fm.thisfile = file_new

        self.fm.ui.console.ask(
            f"{self.fm.thisfile.relative_path} ~> {new_filename}? (y/N)",
            rename,
            ("n", "N", "y", "Y"),
        )

class trash(Command):
    """:trash"""

    allow_abbrev = False
    escape_macros_for_shell = True

    def execute(self):
        import shlex
        from functools import partial

        def is_directory_with_files(path):
            return os.path.isdir(path) and not os.path.islink(path) and len(os.listdir(path)) > 0

        if self.rest(1):
            self.fm.notify("Error: this bugfixed :trash does not support arguments", bad=True)
            return

        cwd = self.fm.thisdir
        tfile = self.fm.thisfile
        if not cwd or not tfile:
            self.fm.notify("Error: no file selected for deletion!", bad=True)
            return

        # relative_path used for a user-friendly output in the confirmation.
        files = self.fm.thistab.get_selection()
        many_files = (cwd.marked_items or is_directory_with_files(tfile.path))

        confirm = self.fm.settings.confirm_on_delete
        if confirm != 'never' and (confirm != 'multiple' or many_files):
            self.fm.ui.console.ask(
                "Confirm deletion of: %s (y/N)" % ', '.join(files),
                partial(self._question_callback, files),
                ('n', 'N', 'y', 'Y'),
            )
        else:
            # no need for a confirmation, just delete
            self.fm.execute_file(files, label='trash')

    def tab(self, tabnum):
        return self._tab_directory_content()

    def _question_callback(self, files, answer):
        if answer.lower() == 'y':
            self.fm.execute_file(files, label='trash')
