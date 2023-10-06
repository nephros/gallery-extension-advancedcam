// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

BackgroundItem {
    id: root

    property alias albumName: dirItem.title
    property int imageCount

    MagicDirItem {
        id: dirItem

        titleLabel.color:(highlighted ? Theme.highlightColor : Theme.primaryColor)

        icon {
            source: "icon-m-folder-magic.svg"
            width: Theme.iconSizeLarge
            height: Theme.iconSizeLarge
            sourceSize.height: height
            sourceSize.width: width
            fillMode: Image.PreserveAspectCrop
        }

        countText: root.imageCount
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
