// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import com.jolla.gallery 1.0
import QtDocGallery 5.0
import Nemo.FileManager 1.0

MediaSource { id: root

    //: "Advanced Camera Videos"
    //% "Advanced Camera Videos"
    title: qsTrId("gallery-extension-advancedcam-title-videos")
    icon: StandardPaths.resolveImport("com.jolla.gallery.advancedcam.AdvCamMediaIcon")
    page: "../pages/GalleryGridPage.qml"

    type: MediaSource.Videos

    property bool applicationActive: Qt.application.active

    property alias count: advcamStorage.count
    ready: FileEngine.exists(advcamStorage.path)
    busy: model.status == DocumentGalleryModel.Active

    model: DocumentGalleryModel{ id: advcamStorage
        readonly property string path: StandardPaths.videos + '/AdvancedCam'
        rootType: DocumentGallery.Video
        properties: ["url", "mimeType", "title", "lastModified", "orientation", "duration"]
        sortProperties: ["-lastModified"]
        autoUpdate: true
        filter: GalleryStartsWithFilter { property: "filePath"; value: advcamStorage.path }
    }

    Component.onCompleted: {
        advcamStorage.refresh()
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
