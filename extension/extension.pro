TEMPLATE = aux
TARGET = gallery-extension-magic
CONFIG += sailfishapp_qml

lupdate_only {
SOURCES += \
    mediasource/*.qml \
    magic/*.qml \
}

TRANSLATIONS += translations/$${TARGET}-en.ts \
                translations/$${TARGET}-de.ts

magic.files = magic
magic.path = $$LIBDIR/qt5/qml/com/jolla/gallery
INSTALLS += magic

mediasource.files = mediasource/*.qml
mediasource.path = $$PREFIX/share/jolla-gallery/mediasources
INSTALLS += mediasource

include(translations/translations.pri)
