// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPL-2.0

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

/*! \qmltype MagicGalleryIcon
    \inqmlmodule com.jolla.gallery.magic
    \inherits com.jolla.gallery.MediaSourceIcon
*/

MediaSourceIcon {
    Image {
        anchors.centerIn: parent
        width: Theme.iconSizeLarge
        source: "image://theme/icon-m-folder-magic"
        fillMode: Image.PreserveAspectFit
        clip: true
    }
}
// vim: ft=javascript ts=4 st=4 sw=4 expandtab

