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

settings.files = settings/*
settings.path = $$PREFIX/share/jolla-settings
INSTALLS += settings

QMAKE_EXTRA_TARGETS += documentation
documentation.commands = tools/makedocs

OTHER_FILES += $$files(rpm/*)

QMAKE_CLEAN += -r icons/z*
QMAKE_CLEAN += debug*.list
QMAKE_CLEAN += elfbins.list
QMAKE_CLEAN += documentation.list
QMAKE_CLEAN += build.log

include(translations/translations.pri)
