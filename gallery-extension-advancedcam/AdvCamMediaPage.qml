// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0
//import "components" as AdvCam
import "components"

MediaSourcePage { id: root
    SilicaFlickable { id: flick

        anchors.fill: parent
        Column { id: content
            width: parent.width
            PageHeader {
                //: "Advanced Camera"
                //% "Advanced Camera"
                title: qsTrId("gallery-extension-advancedcam-title")
            }
            SilicaGridView { id: view
                model: root.model
                delegate: AdvCamPhotoDelegate {
                    width: GridView.view.width
                    height: Theme.itemSizeLarge
                }
            }
        }
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
