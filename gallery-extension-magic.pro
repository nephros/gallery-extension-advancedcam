TEMPLATE = aux
TARGET = gallery-extension-magic

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

OTHER_FILES += $$files(rpm/*)

include(translations/translations.pri)

# theme icons:
CONFIG += sailfish-svg2png
SAILFISH_SVG2PNG.profiles += 2.5
SAILFISH_SVG2PNG.scales.2.5 = 2.5

# Configures svg to png
THEMENAME = sailfish-default

