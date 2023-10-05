// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

MediaSourcePage { id: root
    SilicaFlickable { id: flick
        anchors.fill: parent
        contentHeight: content.height
        Column { id: content
            width: parent.width
            PageHeader { id: head
                //: "Advanced Camera"
                //% "Advanced Camera"
                title: qsTrId("gallery-extension-advancedcam-title")
            }
            SilicaGridView { id: view
                width: parent.width
                height: root.height - head.height
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
