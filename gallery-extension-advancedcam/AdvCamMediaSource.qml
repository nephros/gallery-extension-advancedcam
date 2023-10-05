// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import com.jolla.gallery 1.0
import com.jolla.gallery.extensions 1.0

MediaSource { id: root
    page: Qt.resolvedUrl("/usr/share/sailfish-gallery-extension-advancedcam/pages/AdvCamMediaPage.qml")
    //: "Advanced Camera"
    //% "Advanced Camera"
    title: qsTrId("sailfish-galley-extension-advancedcam-title")

    icon: Qt.resolvedUrl("AdvCamMediaIcon.qml")

    model: MediaSourceModel { id: advcamSourceModel
        //: "Advanced Camera Photos"
        //% "Advanced Camera Photos"
        title: qsTrId("sailfish-galley-extension-advancedcam-source-title")
        type: MediaSource.Photos
        ready: true
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
