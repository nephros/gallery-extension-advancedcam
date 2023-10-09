import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0
import Nemo.Configuration 1.0

Page { id: root
    property var psources
    property var vsources
    property string sname
    property string spath
    readonly property var homeRE: new RegExp(/^\/home\/[^/]+\//)

    ConfigurationValue {
        id: photoSources
        key: "/apps/jolla-gallery/extrapaths/pictures"
        defaultValue: JSON.stringify([
                {
                    "displayName": "EMail",
                    "path": "Downloads/mail_attachments"
                },
                {
                    "displayName": "Album Art",
                    "path": "Music"
                },
                {
                    "displayName": "Downloaded",
                    "path": "Downloads"
                },
        ])
    }
    ConfigurationValue {
        id: videoSources
        key: "/apps/jolla-gallery/extrapaths/videos"
        defaultValue: JSON.stringify([
                {
                    "displayName": "Camera Videos",
                    "path": "Videos/Camera"
                },
                {
                    "displayName": "Music Videos",
                    "path": "Videos/Music"
                },
                {
                    "displayName": "Downloaded",
                    "path": "Downloads"
                },
        ])
    }

    Component { id: litem
        ListItem {
            property string type: ListView.view.type
            contentHeight: Theme.itemSizeSmall
            DetailItem {
                anchors.verticalCenter: parent.verticalCenter
                label: modelData.displayName
                value: "~/" + modelData.path
            }
            menu: ContextMenu {
                MenuItem { text: qsTr("Remove") ; onClicked: remorseDelete(function() {root.removeSource(type, index)})}
            }
        }
    }
    Component{ id: dirPicker
        FolderPickerPage{
            showSystemFiles: false
            dialogTitle: qsTr("Source Path")
            onSelectedPathChanged: root.spath = selectedPath.replace(homeRE,"")
        }
    }
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: content.height - head.height
        PageHeader { id: head; title: qsTr("MagicSources Editor") }
        Column { id: content
            anchors.top: head.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - Theme.horizontalPageMargin
            spacing: Theme.paddingMedium
            Label {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Here you can add or remove media sources.")
                    + qsTr("Pick a path from your home, give it a name and set it as either video, or picture source.")
                    + "<br />"
                    + "<br />"
                    + qsTr("Note that sources will only show up if their path exists.")
                    + "<br />"
                    + qsTr("You will have to restart the app after changing anything.")
                color: Theme.secondaryHighlightColor
                wrapMode: Text.Wrap
            }
            ValueButton {
                value: root.spath ? "~/" + root.spath : "please select"; label: qsTr("Source Path")
                onClicked: pageStack.push(dirPicker)
            }
            TextField { text: root.sname; label: qsTr("Display Name")
                onTextChanged: root.sname = text
                EnterKey.onClicked: focus = false
            }
            ButtonLayout {
                Button { text: "Set as Picture source"
                    enabled: ((root.sname.length > 0) && (root.spath.length > 0))
                    onClicked: { setPhotoSource(root.sname,root.spath); photoSources.sync }
                }
                Button { text: "Set as Video source"
                    enabled: ((sname.length > 0) && (spath.length > 0))
                    onClicked: { setVideoSource(sname,spath); videoSources.sync }
                }
            }

            Separator { width: ListView.view.width; color: Theme.secondaryColor }
            ListView { id: pview
                property string type: "picture"
                width: parent.width
                height: Theme.itemSizeSmall * Math.min (5, count)
                header: SectionHeader { text: qsTr("Picture Sources: %Ln", "", pview.count) }
                footer: Separator { width: ListView.view.width; color: Theme.secondaryColor }
                footerPositioning: ListView.OverlayFooter
                model: root.psources
                visible: (!!root.psources) && count > 0
                clip: true
                delegate: litem
            }
            Separator { width: ListView.view.width; color: Theme.secondaryColor }
            ListView { id: vview
                property string type: "video"
                width: parent.width
                height: Theme.itemSizeSmall * Math.min (5, count)
                header: SectionHeader { text: qsTr("Video Sources: %Ln", "", vview.count) }
                footer: Separator { width: ListView.view.width; color: Theme.secondaryColor }
                footerPositioning: ListView.OverlayFooter
                model: root.vsources
                visible: (!!root.vsources) && count > 0
                clip: true
                delegate: litem
            }
        }
    }

    Component.onCompleted: { reload() }
    function reload() {
        var s
        s = photoSources.value
        try { root.psources = JSON.parse(s) } catch (e) {}
        s = videoSources.value
        try{ root.vsources = JSON.parse(s) } catch (e) {}
    }
    function removeSource(type, index) {
        if (type == "picture") removePicSource(index)
        if (type == "video")   removeVidSource(index)
        reload()
    }
    function removePicSource(index) {
        try {
            var existing = JSON.parse(photoSources.value);
            existing.splice(index,1)
            photoSources.value = JSON.stringify(existing)
            photoSources.sync()
            root.psources = existing
        } catch (e) { }
    }
    function removeVidSource(index) {
        try {
            var existing = JSON.parse(videoSources.value);
            existing.splice(index,1)
            videoSources.value = JSON.stringify(existing)
            videoSources.sync()
            root.vsources = existing
        } catch (e) { }
    }
    function setPhotoSource(name, path) {
        if (!!photoSources.value) {
            const existing = {};
            try {
                existing = JSON.parse(photoSources.value);
                const entry = {
                    "displayName": name,
                    "path": path
                }
                existing.push(entry)
                photoSources.value = JSON.stringify(existing)
            } catch (e) {
                console.warn("Could not parse Entries")
                return
            }
        } else {
            console.info("Key was empty, creating new")
            const entry = [
                {
                    "displayName": name,
                    "path": path
                },
            ]
            photoSources.value = JSON.stringify(entry)
        }
        reload()
    }
}
// vim: ft=javascript ts=4 st=4 sw=4 expandtab
