// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

/*! \qmltype MagicAlbumDelegate
     \inqmlmodule com.jolla.gallery.magic
*/
BackgroundItem {
    id: root

    /*! the name of the album, displayed on the left of the icon */
    property alias albumName: dirItem.title
    /*! the number of images in of the album, displayed on the right of the icon */
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
