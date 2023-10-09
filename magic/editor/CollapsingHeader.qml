// This file is part of obs-commader.
// Copyright (c) 2022,2023 Peter G. (nephros)
// SPDX-License-Identifier: Apache-2.0

import QtQuick 2.6
import Sailfish.Silica 1.0

/*! \qmltype CollapsingHeader
    \inqmlmodule OBSMaster
    \inherits Sailfish.Silica.SilicaItem
    \ingroup components

    \brief A collapsing header.

    Typically uses its target property to give which part of the UI it controls.
*/
SilicaItem {
  height: header.height
  width: parent.width

  /*! A (QML id of) an Item which should be controlled by tapping the header */
  property var target
  /*!  \qmlproperty string text
     The title of the header */
  property alias text: header.text
  /*!  \qmlproperty int fontSize
      The size of the header font */
  property alias fontSize: header.font.pixelSize

  Icon { id: icon
    anchors.verticalCenter: sep.verticalCenter
    anchors.right: parent.right
    height: Theme.iconSizeSmall
    width: Theme.iconSizeSmall
    source: "image://theme/icon-s-unfocused-down?" + parent.color
    rotation: target.visible ? 360 : 90
    Behavior on rotation { PropertyAnimation { } }
  }
  SectionHeader { id: header
    width: parent.width
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    font.pixelSize: Theme.fontSizeLarge
    color: ( target.visible ) ? Theme.secondaryColor : Theme.highlightColor 
    Behavior on color { ColorAnimation { } }
  }
  Separator { id: sep
    anchors.top: header.bottom
    width: parent.width - ( icon.width )
    height: 2
    horizontalAlignment: target.visible ? Qt.AlignRight : Qt.AlignHCenter
    color: header.color
  }
}

// vim: expandtab ts=4 st=4 filetype=javascript
