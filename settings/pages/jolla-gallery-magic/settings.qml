import QtQuick 2.6
import Sailfish.Silica 1.0
import com.jolla.settings 1.0
import Nemo.DBus 2.0

ApplicationSettings { id: root
    property bool pageReady: root.status == PageStatus.Active
    onPageReadyChanged: if (pageReady) pageReady = true // remove binding
    SectionHeader{ text: "MagicSources" }
    DBusInterface { id: dbus
        service: "com.jolla.gallery.magic"
        iface: "com.jolla.gallery.magic"
        path: "/com/jolla/gallery/magic/ui"
    }
    ButtonLayout {
        Button {
            text: qsTr("MagicSources Editor")
            //onClicked: pageStack.push(Qt.resolvedUrl("EditSourcePage.qml"))
            onClicked: dbus.call("Open", [], function(){},function(r){console.warn("error:",r)} )
        }
    }
}
// vim: ft=javascript ts=4 st=4 sw=4 expandtab
