// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

GridItem { id: root
    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        clip: true
        source: filePath
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
