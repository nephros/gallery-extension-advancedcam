// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

BackgroundItem {
    id: root

    property alias albumName: dirItem.title
    property int imageCount

    height: Theme.itemSizeExtraLarge

    MagicDirItem { id: dirItem

        anchors.horizontalCenter: parent.horizontalCenter
        icon {
            source: "image://theme/icon-m-folder-magic"
            width: icon.sourceSize.width
            height: icon.sourceSize.height
            fillMode: Image.PreserveAspectCrop
        }

        countText: root.imageCount
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
