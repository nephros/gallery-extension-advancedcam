// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0
import Nemo.FileManager 1.0
//import com.jolla.gallery.extensions 1.0

MediaSource { id: root
    page: StandardPaths.resolveImport("com.jolla.gallery.nextcloud.AdvCamMediaPage")
    //: "Advanced Camera"
    //% "Advanced Camera"
    title: qsTrId("gallery-extension-advancedcam-title")

    icon: Qt.resolvedUrl("/usr/share/gallery-extension-advancedcam/AdvCamMediaIcon.qml")
    //property bool ready: true
    property bool applicationActive: Qt.application.active
    //property alias count: advcamSourceModel.count
    ready: FileEngine.exists(advcamStorage.path)
    count: advcamStorage.count
    model: FileModel{ id: advcamStorage
        path: StandardPaths.pictures + '/AdvancedCam'
    }
    type: MediaSource.Photos
    /*
    MediaSourceModel { id: advcamSourceModel
        //: "Advanced Camera Photos"
        //% "Advanced Camera Photos"
        // title: qsTrId("gallery-extension-advancedcam-source-title")
        //type: MediaSource.Photos
        //ready: true

    }

    Component.onCompleted: {
        advcamSourceModel.refresh()
    }
    */
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
