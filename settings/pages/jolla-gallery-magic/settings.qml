import QtQuick 2.6
import Sailfish.Silica 1.0
import com.jolla.settings 1.0

ApplicationSettings { id: root
    property bool pageReady: root.status == PageStatus.Active
    onPageReadyChanged: if (pageReady) pageReady = true // remove binding
    SectionHeader{ text: "MagicSources" }
    ButtonLayout {
        Button {
            text: qsTr("MagicSources Editor")
            onClicked: pageStack.push(Qt.resolvedUrl("EditSourcePage.qml"))
        }
    }
}
// vim: ft=javascript ts=4 st=4 sw=4 expandtab
