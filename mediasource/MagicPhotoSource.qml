// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import com.jolla.gallery 1.0
import Nemo.Configuration 1.0
import Nemo.FileManager 1.0

/*! \qmlmodule com.jolla.gallery.magic
    \brief A Gallery plugin which displays dynamic entries in the Jolla Gallery application.

    Application or users can register paths using DConf.

    The DConf key is \c{"/apps/jolla-gallery/extrapaths/pictures"} for
    pictures, and \c{"/apps/jolla-gallery/extrapaths/videos"} for Videos.

    The value of the key is a JSON string.

    The JSON represents an array of objects.

    Each objects has the format:

    \badcode
    {
        displayName: "My Apps Pictures",
        path:        "Downloads/MyApp"
    }
    \endcode

    \c{path} is a filesystem location relative to the user home, e.g. \c{Downloads/MyApp} for \c{/home/user/Downloads/MyApp}

    \note Localization for displayNames nit currently not supperted.

    For example, you may set the key form a QML app using something like this:

    \code
    import QtQuick 2.6
    import Nemo.Configuration 1.0

    ...

    ConfigurationValue {
        id: photoSources
        key: "/apps/jolla-gallery/extrapaths/pictures"
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
                return
            }
        } else {
            const entry = [
                {
                    "displayName": name,
                    "path": path
                },
            ]
            photoSources.value = JSON.stringify(entry)
        }
        photoSources.sync()
    }

    ...

    \endcode

*/
/*! \qmltype MagicPhotoSource
    \inqmlmodule com.jolla.gallery.magic
    \inherits Sailfish.Gallery.MediaSource
*/
MediaSource {
    id: root

    title: qsTr("MagicSources")
    //icon: StandardPaths.resolveImport("com.jolla.gallery.magic.MagicGalleryIcon")
    icon: "image://theme/icon-m-folder-magic"
    model: sourceModel
    count: sourceModel.count
    ready: sourceModel.count > 0
    page: StandardPaths.resolveImport("com.jolla.gallery.magic.MagicAlbumsPage")

    property bool applicationActive: Qt.application.active

    // FIXME: add Videos
    type: MediaSource.Photos
    property ListModel sourceModel: ListModel{}

    property ConfigurationValue photoSources: ConfigurationValue {
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
    Component.onCompleted: {
        var sources
        try {
            sources = JSON.parse(photoSources.value)
        } catch (e) {
            console.warn("Could not parse magic values:", photoSources.value )
            return
        }
        if (sources.length > 0) {
            sources.forEach(function(e) {
                if (FileEngine.exists(StandardPaths.home + "/" + e.path)) {
                    console.info("Appending to source model:",  e.path)
                    sourceModel.append(e)
                } else {
                    console.warn("Specified path does not exist, not appending.")
                }
            })
        } else {
            console.info("No paths in magic key")
        }
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
