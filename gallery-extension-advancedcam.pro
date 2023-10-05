TEMPLATE = aux
TARGET = gallery-extension-advancedcam

lupdate_only {
SOURCES += \
    $$TARGET/*.qml
}

TRANSLATIONS += translations/$${TARGET}-en.ts \
                translations/$${TARGET}-de.ts

qml.files = $$TARGET
qml.path = $$PREFIX/share
INSTALLS += qml

mediasource.files = mediasource/AdvCamMediaSource.qml
mediasource.path = $$PREFIX/share/jolla-gallery/mediasources
INSTALLS += mediasource

OTHER_FILES += $$files(rpm/*)

include(translations/translations.pri)
