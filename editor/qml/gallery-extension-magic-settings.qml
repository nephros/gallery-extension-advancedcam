import QtQuick 2.6
import Sailfish.Silica 1.0
import Nemo.DBus 2.0

/*! \qmltype EditSourceApp
    \inqmlmodule com.jolla.gallery.magic
    \ingroup ui

     A simple Editor for the source locations used by MagicPhotoSource and MagicVideoSource.
*/

ApplicationWindow { id: editor
    visible: false
    property bool hidden: true
    DBusAdaptor {
        service: "com.jolla.gallery.magic"
        iface: "com.jolla.gallery.magic"
        path: "/com/jolla/gallery/magic/ui"
        function open() {
            console.info("Opened...")
            editor.visible=true
            editor.activate()
        }
    }
    initialPage: page
    cover: coverpage
    Component { id: page; EditSourcePage{} }
    Component { id: coverpage ; CoverPlaceholder {
        icon.source: "image://theme/icon-m-folder-magic"
        text: qsTr("MagicSources")
        Image {
            anchors.fill: parent
            source: "image://theme/graphic-cover-settings"
        }
    }}
    Component.onCompleted: {
        var args = Qt.application.arguments;
        for (var i=0; i<args.length; i++) {
        if (args[i] == "-prestart") {
            console.info("Prestarting...")
            editor.visible=false
        }
        }
    }
}
// vim: ft=javascript ts=4 st=4 sw=4 expandtab
