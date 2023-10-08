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
    }
    ConfigurationValue {
        id: videoSources
        key: "/apps/jolla-gallery/extrapaths/videos"
    }

    Component { id: litem
        ListItem {
            property string type: ListView.view.type
            contentHeight: di.height
            DetailItem { id: di
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
        contentHeight: content.height
        Column { id: content
            width: parent.width
            PageHeader { title: qsTr("MagicSources Editor") }
            TextField { text: root.sname; label: qsTr("Display Name")
                onTextChanged: root.sname = text
                EnterKey.onClicked: focus = false
            }
            ValueButton {
                value: root.spath ? "~/" + root.spath : "please select"; label: qsTr("Source Path")
                onClicked: pageStack.push(dirPicker)
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

            SectionHeader { text: qsTr("Picture Sources: %Ln", "", pview.count) }
            ListView { id: pview
                property string type: "picture"
                width: parent.width
                height: parent.width/2
                model: root.psources
                visible: (!!root.psources) && count > 0
                delegate: litem
            }
            SectionHeader { text: qsTr("Video Sources: %Ln", "", vview.count) }
            ListView { id: vview
                property string type: "video"
                width: parent.width
                height: parent.width/2
                model: root.vsources
                visible: (!!root.vsources) && count > 0
                delegate: litem
            }
        }
    }

    Component.onCompleted: {
        var s
        s = photoSources.value
        try { root.psources = JSON.parse(s) } catch (e) {}
        s = videoSources.value
        try{ root.vsources = JSON.parse(s) } catch (e) {}
    }
    function removeSource(type, index) {
        console.debug("remove:", type,index)
        if (type == "picture") removePicSource(index)
        if (type == "video") removeVidSource(index)
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
        console.debug("Value is:", photoSources.value);
        if (!!photoSources.value) {
            const existing = {};
            try {
                existing = JSON.parse(photoSources.value);
                const entry = {
                    "displayName": name,
                    "path": path
                }
                existing.push(entry)
                console.debug("Entry is:", JSON.stringify(entry, null, 2))
                console.debug("Value is now:", JSON.stringify(existing, null, 2))
                photoSources.value = JSON.stringify(existing)
            } catch (e) {
                console.warn("Could not parse Entries")
                return
            }
        } else {
            console.debug("Key was empty, creating new")
            const entry = [
                {
                    "displayName": name,
                    "path": path
                },
            ]
            photoSources.value = JSON.stringify(entry)
        }
    }
}
// vim: ft=javascript ts=4 st=4 sw=4 expandtab
