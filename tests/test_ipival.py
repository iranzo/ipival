#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright (C) 2020 Pablo Iranzo Gómez <Pablo.Iranzo@gmail.com>

import os
from unittest import TestCase

import risuclient.shell as risu

testplugins = os.path.join(risu.risudir, "plugins", "test")
risudir = risu.risudir


class risuTest(TestCase):
    def test_findplugins_positive_filter_include(self):
        plugins = risu.findplugins([testplugins], include=["exit_passed"])

        assert len(plugins) == 1

    def test_findplugins_positive_filter_exclude(self):
        plugins = risu.findplugins(
            [testplugins], exclude=["exit_passed", "exit_skipped"]
        )

        for plugin in plugins:
            assert "exit_passed" not in plugin and "exit_skipped" not in plugin

    def test_findplugins_positive(self):
        assert len(risu.findplugins([testplugins])) != 0

    def test_findplugins_negative(self):
        assert risu.findplugins("__does_not_exist__") == []

    def test_which(self):
        assert risu.which("/bin/sh") == "/bin/sh"

    def test_findplugins_ext(self):
        plugins = []
        folder = [os.path.join(risu.risudir, "plugins", "core")]
        for each in risu.findplugins(folders=folder, fileextension=".sh"):
            plugins.append(each)
        assert len(plugins) != 0

    def test_readconfig(self):
        parsed = risu.read_config()
        assert parsed == {}
