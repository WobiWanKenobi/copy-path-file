# -*- coding: utf-8 -*-
# pylint: disable=E1101
"""
Copy Path to File - Ubuntu
==========================
*Created on 26.05.2024 by Tobias Witte*
*Copyright (C) 2024*
*For COPYING and LICENSE details, please refer to the LICENSE file*

"""

import subprocess
from gi.repository import Nautilus, GObject
import gi
gi.require_version("Nautilus", "3.0")


class CopyPathExtension(GObject.Gobject, Nautilus.MenuProvider):

    def __init__(self):
        pass

    def get_file_items(self, window, files):
        if len(files) != 1:
            return

        file = files[0]
        item = Nautilus.MenuItem(
            name="CopyPathExtension::CopyPath",
            label="Copy Path to File",
            tip="",
            icon=""
        )

        item.connect("activate", self.copy_file_path, file)
        return [item]

    def copy_file_path(self, menu, file):
        file_path = file.get_location().get_path()
        subprocess.run(['xclip', '-selection', 'clipboard'],
                       input=file_path.encode('utf-8'))
