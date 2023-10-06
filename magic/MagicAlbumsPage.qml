// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import com.jolla.gallery 1.0
import QtDocGallery 5.0

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
            property string albumPath:  StandardPaths.home + "/" + path
            onAlbumPathChanged: console.debug("path:", albumPath)
            albumName: displayName.length > 0
                ? displayName
                : "Images"
            imageCount: model.count
            onClicked: {
                var props = {
                    "title": displayName
                }
                pageStack.animatorPush("MagicImagesGridPage.qml", props)
            }
            property DocumentGalleryModel model: DocumentGalleryModel {
                property string albumName: model.displayName
                rootType: DocumentGallery.Image
                properties: ["url", "mimeType", "title", "orientation", "dateTaken", "width", "height" ]
                sortProperties: ["-dateTaken"]
                autoUpdate: true
                filter: GalleryStartsWithFilter { property: "filePath"; value: albumPath }
                Component.onCompleted: console.debug("Discovered %1 photos at %2".arg(count).arg(albumPath))
                onCountChanged: console.debug("Discovered %1 photos at %2".arg(count).arg(albumPath))
            }
            Component.onCompleted: console.debug("Dalegate completed for", index, path, displayName)
        }

        VerticalScrollDecorator {}
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
