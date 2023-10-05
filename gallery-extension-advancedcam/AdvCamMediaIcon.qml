// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import com.jolla.gallery 1.0

MediaSourceIcon { id: root
    Image {
        anchors.fill: parent
        source: "image://theme/harbour-advenced-camera"
        fillMode: Image.PreserveAspectCrop
        clip: true
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
