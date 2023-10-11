// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPL-2.0

import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import com.jolla.gallery 1.0
import Nemo.Configuration 1.0
import Nemo.FileManager 1.0

/*! \qmltype MagicPhotoSource
    \inqmlmodule com.jolla.gallery.magic
    \inherits Sailfish.Gallery.MediaSource
*/
MediaSource {
    id: root

    title: qsTr("MagicSources")
    icon: StandardPaths.resolveImport("com.jolla.gallery.magic.MagicGalleryIcon")
    model: sourceModel
    count: sourceModel.count
    ready: sourceModel.count > 0
    page: StandardPaths.resolveImport("com.jolla.gallery.magic.MagicAlbumsPage")

    /*! \internal */
    property bool applicationActive: Qt.application.active

    // FIXME: add Videos
    type: MediaSource.Photos
    /*! ListModel propulated from parising the photoSources key */
    property ListModel sourceModel: ListModel{}

    /*! DConf location holding the user-specified media source path.
        Format is a JSON string representing an array of objects.
    */
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
                } else if (/^\/run\/media\/[^\/]+/.test(e.path) && (FileEngine.exists(e.path))) {
                    console.info("Media path detected:",  e.path)
                    sourceModel.append(e)
                } else {
                    console.warn("Specified path does not exist or is not a media path, not appending.")
                }
            })
        } else {
            console.info("No paths in magic key")
        }
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
