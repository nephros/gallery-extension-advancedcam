// Copyright (c) Peter G. sailfish@nephros.org
// SPDX-License-Identifier: GPLv2

import QtQuick 2.6
import QtQml.Models 2.3
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import com.jolla.gallery 1.0
import com.jolla.gallery.extensions 1.0
import QtDocGallery 5.0
import Nemo.Configuration 1.0

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

    title: qsTr("Magic")
    //icon: StandardPaths.resolveImport("com.jolla.gallery.nextcloud.NextcloudGalleryIcon")
    //model: magicAlbums
    model: galleryModel
    count: Math.max(sourceModel.count, galleryModel.count)
    ready: (sourceModel.count > 0)  || (galleryModel.count > 0)
    //ready: sourceModel.count > 0 && ( instantiator.count == sourceModel.count)
    //ready: nextcloudUsers.count > 0
    page: StandardPaths.resolveImport("com.jolla.gallery.magic.MagicAlbumsPage")

    property bool applicationActive: Qt.application.active

    property Instantiator instantiator: Instantiator {
        active: false
        delegate: DocumentGalleryModel {
            property string albumName: model.displayName
            rootType: DocumentGallery.Image
            properties: ["url", "mimeType", "title", "orientation", "dateTaken", "width", "height" ]
            sortProperties: ["-dateTaken"]
            autoUpdate: true
            filter: GalleryStartsWithFilter { property: "filePath"; value: StandardPaths.home + "/" + model.path }
        }
        onActiveChanged: console.debug("Instantiator is now active:", active)
        onObjectAdded: function(i, o) {
            galleryModel.append(o)
            console.debug("Instantiator added:", JSON.stringify(o))
        }
    }

    property ListModel sourceModel: ListModel{}
    property ObjectModel galleryModel: ObjectModel{}

    property ConfigurationValue photoSources: ConfigurationValue {
        key: "/apps/jolla-gallery/extrapaths/pictures"
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
                console.debug("Appending:",  JSON.stringify(e))
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
