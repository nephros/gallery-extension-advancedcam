// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import com.jolla.gallery 1.0
import QtDocGallery 5.0

/*! \qmltype MagicAlbumsPage
    \inqmlmodule com.jolla.gallery.magic
    \inherits MediaSourcePage
*/
MediaSourcePage {
    id: root

    SilicaGridView { id: view

        anchors.fill: parent
        cacheBuffer: Screen.height
        model: root.model
        cellHeight: Theme.itemSizeExtraLarge // fixed from delegate
        cellWidth: Math.min(parent.width/2, parent.height/2)

        header: PageHeader {
            title: qsTr("Magic Albums")
        }

        delegate: MagicAlbumDelegate {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            albumName: displayName.length > 0
                ? displayName
                : "Images"
            serviceIcon: "image://theme/icon-m-file-folder-magic"
            onClicked: {
                var props = {
                    "title": displayName,
                    "model": imagesModel,
                    "userData": MediaSource.Photos
                }
                pageStack.animatorPush(Qt.resolvedUrl("/usr/share/jolla-gallery/pages/GalleryGridPage.qml"), props)
            }
            property string albumPath:  StandardPaths.home + "/" + path
            imagesModel: DocumentGalleryModel {
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
