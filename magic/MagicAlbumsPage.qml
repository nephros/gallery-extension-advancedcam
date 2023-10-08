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
            albumName: displayName.length > 0
                ? displayName
                : "Images"
            imageCount: galleryModel.count
            onClicked: {
                var props = {
                    "title": displayName,
                    "model": galleryModel,
                    "userData": MediaSource.Photos
                }
                //pageStack.animatorPush("MagicImagesGridPage.qml", props)
                pageStack.animatorPush(Qt.resolvedUrl("/usr/share/jolla-gallery/pages/GalleryGridPage.qml"), props)
            }
            DocumentGalleryModel { id: galleryModel
                property string albumName: model.displayName
                rootType: DocumentGallery.Image
                properties: ["url", "mimeType", "title", "orientation", "dateTaken", "width", "height" ]
                sortProperties: ["-dateTaken"]
                autoUpdate: true
                filter: GalleryStartsWithFilter { property: "filePath"; value: albumPath }
                onCountChanged: console.debug("Discovered %1 photos at %2".arg(count).arg(albumPath))
            }
        }

        PullDownMenu {
            MenuItem { text: qsTr("Edit Sources"); onClicked: pageStack.push("editor/EditSourcePage.qml") }
        }

        VerticalScrollDecorator {}
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
