// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import com.jolla.gallery 1.0
import QtDocGallery 5.0
import Nemo.FileManager 1.0

MediaSource { id: root

    title: qsTr("Advanced Camera\nVideos", "Please preserve the line break, it's important for correct display")
    icon: "../pages/VideoIcon.qml"
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

}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
