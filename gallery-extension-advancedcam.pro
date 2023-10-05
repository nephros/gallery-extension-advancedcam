TEMPLATE = aux
TARGET = gallery-extension-advancedcam

lupdate_only {
SOURCES += \
    mediasource/*.qml \
    advancedcam/*.qml \
}

TRANSLATIONS += translations/$${TARGET}-en.ts \
                translations/$${TARGET}-de.ts \
                translations/$${TARGET}-ru.ts

qml.files = advancedcam
qml.path = $$LIBDIR/qt5/qml/com/jolla/gallery
INSTALLS += qml

mediasource.files = mediasource/AdvCamMediaSource.qml
mediasource.path = $$PREFIX/share/jolla-gallery/mediasources
INSTALLS += mediasource

OTHER_FILES += $$files(rpm/*)

include(translations/translations.pri)
