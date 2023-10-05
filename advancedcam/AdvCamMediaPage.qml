// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0 as Gallery
import com.jolla.gallery 1.0

MediaSourcePage { id: root
    Gallery.ImageGridView { id: view
        anchors.fill: parent
        header: PageHeader { id: head
            title: qsTr("Advanced Camera")
        }
        model: root.model
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
