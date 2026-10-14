# -*- coding: utf-8 -*-
# pylint: disable=E1101
"""
Copy Path to File - Ubuntu
==========================
*Created on 26.05.2024 by Tobias Witte*
*Copyright (C) 2024*
*For COPYING and LICENSE details, please refer to the LICENSE file*

Fixed 2026-10-14 for Nautilus 4.1 API (GNOME 43+, Ubuntu 26.04):
- require_version("Nautilus", "4.1") before importing gi.repository
- get_file_items(self, files) signature (no window argument)
- Gdk clipboard instead of xclip subprocess
"""

import gi
gi.require_version("Nautilus", "4.1")
gi.require_version("Gdk", "4.0")
from gi.repository import Nautilus, GObject, Gdk


class CopyPathExtension(GObject.Object, Nautilus.MenuProvider):

    def get_file_items(self, files):
        if len(files) != 1:
            return None

        item = Nautilus.MenuItem(
            name="CopyPathExtension::CopyPath",
            label="Copy Path to File",
        )
        item.connect("activate", self.copy_file_path, files[0])
        return [item]

    def copy_file_path(self, menu, file):
        file_path = file.get_location().get_path()
        clipboard = Gdk.Display.get_default().get_clipboard()
        clipboard.set(file_path)
