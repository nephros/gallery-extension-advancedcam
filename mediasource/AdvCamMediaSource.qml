// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import com.jolla.gallery 1.0
import com.jolla.gallery.extensions 1.0

MediaSource { id: root
    page: Qt.resolvedUrl("/usr/share/gallery-extension-advancedcam/AdvCamMediaPage.qml")
    //: "Advanced Camera"
    //% "Advanced Camera"
    title: qsTrId("gallery-extension-advancedcam-title")

    icon: Qt.resolvedUrl("/usr/share/gallery-extension-advancedcam/AdvCamMediaIcon.qml")
    property bool ready

    model: MediaSourceModel { id: advcamSourceModel
        //: "Advanced Camera Photos"
        //% "Advanced Camera Photos"
        title: qsTrId("gallery-extension-advancedcam-source-title")
        type: MediaSource.Photos
        //ready: true
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
