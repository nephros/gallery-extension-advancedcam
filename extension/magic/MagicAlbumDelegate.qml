// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPL-2.0

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

/*! \qmltype MagicAlbumDelegate
    \inqmlmodule com.jolla.gallery.magic
*/
BackgroundItem { id: root

    /*! \internal */
    property string albumName
    /*! \internal */
    property alias imagesModel: image.model
    /*! \internal */
    property alias serviceIcon: image.serviceIcon

    enabled: imagesModel.count > 0
    opacity: enabled ? 1.0 : 0.6

    MagicSlideshowIcon {
        id: image
        model: root.imagesModel
        highlighted: root.highlighted
    }

    Column {
        anchors {
            left: image.right
            leftMargin: Theme.paddingLarge
            right: parent.right
            rightMargin: Theme.paddingMedium
            verticalCenter: image.verticalCenter
        }

        Label {
            width: parent.width
            text: albumName
            font.family: Theme.fontFamilyHeading
            font.pixelSize: Theme.fontSizeMedium
            color: highlighted ? Theme.highlightColor : Theme.primaryColor
            truncationMode: TruncationMode.Fade
        }

        Label {
            width: parent.width

            //% "%Ln Pictures"
            text: qsTrId("gallery-extension-magic_piccount", imagesModel.count)
            font.family: Theme.fontFamilyHeading
            font.pixelSize: Theme.fontSizeSmall
            color: highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
            truncationMode: TruncationMode.Fade
        }
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
