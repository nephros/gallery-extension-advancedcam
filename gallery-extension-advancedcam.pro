
TARGET = "gallery-extension-advancedcam"
CONFIG += sailfishapp_no_deploy_qml
QT -= gui

lupdate_only {
SOURCES += \
    $$TARGET/*.qml

}

TRANSLATIONS += translations/$${TARGET}-en.ts \
                translations/$${TARGET}-de.ts

qml.files = $$TARGET
qml.path = $$PREFIX/share/jolla-gallery/mediasources/$$TARGET
INSTALLS += qml

OTHER_FILES += $$files(rpm/*)

include(translations/translations.pri)
