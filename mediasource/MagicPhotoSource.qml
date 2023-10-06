// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0
import com.jolla.gallery.extensions 1.0
import Nemo.configuration 1.0

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

*/
/*! \qmltype MagicPhotoSource
    \inqmlmodule com.jolla.gallery.magic
    \inherits Sailfish.Gallery.MediaSource
*/
MediaSource {
    id: root

    title: qsTr("Magic")
    //icon: StandardPaths.resolveImport("com.jolla.gallery.nextcloud.NextcloudGalleryIcon")
    //model: magicAlbums
    model: sourceModel
    ready: sourceModel.count > 0
    //ready: nextcloudUsers.count > 0
    page: StandardPaths.resolveImport("com.jolla.gallery.magic.MagicAlbumsPage")

    property bool applicationActive: Qt.application.active

    Instantiator { id: instantiator
        active: false
        delegate: DocumentGalleryModel {
            rootType: DocumentGallery.Image
            properties: ["url", "mimeType", "title", "orientation", "dateTaken", "width", "height" ]
            sortProperties: ["-dateTaken"]
            autoUpdate: true
            filter: GalleryStartsWithFilter { property: "filePath"; value: model.magicpath }
        }
        OnActiveChanged: console.debug("Instantiator is now active:", active)
        OnObjectAdded: function(i, o) { console.debug("Instantiator added:", JSON.stringify(o)) }
    }
    ListModel { id: sourceModel }
    ConfigurationValue {
        id: photoSources
        key: "/apps/jolla-gallery/extrapaths/pictures"
        defaultValue: JSON.stringufy([ { }, ])
    }
    Component.onCompleted: {
        var sources = JSON.parse(photoSources.value())
        console.debug("Magic Key has values:", sources)
        if (sources.length > 0) {
        sources.forEach(function(e) {
            const o = { magicpath: e }
            console.debug("Äppending:",  JSON.stringify(o))
            sourceModel.append(e)
        })
        instantiator.model = sourceModel
        instantiator.active = true
        } else {
            console.info("No paths in magic key")
        }
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
