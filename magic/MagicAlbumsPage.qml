// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

MediaSourcePage {
    id: root

    SilicaListView {
        id: view

        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Magic Albums")
        }
        cacheBuffer: Screen.height
        model: root.model

        delegate: MagicAlbumDelegate {
            albumName: model.albumName.length > 0
                       ? model.albumName
                       : "Images"
            onClicked: {
                var props = {
                    "title": albumName
                }
                pageStack.animatorPush(Qt.resolvedUrl("GalleryGridPage.qml"), props)
            }
        }

        VerticalScrollDecorator {}
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
