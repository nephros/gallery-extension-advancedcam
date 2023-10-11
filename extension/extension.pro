TEMPLATE = lib
CONFIG += plugin qmltypes
QT += core gui qml

TARGET = gallery-extension-magic
TARGET = $$qtLibraryTarget($$TARGET)

MODULENAME = com/jolla/gallery/magic

QML_IMPORT_NAME = com.jolla.gallery.magic
QML_IMPORT_MAJOR_VERSION = 1

SOURCES += src/plugin.cpp
INCLUDEPATH += $$PWD
DEPENDPATH += .

QMAKE_CXXFLAGS += -Wall -Werror

lupdate_only {
SOURCES += \
    mediasource/*.qml \
    magic/*.qml \
}

TRANSLATIONS += translations/$${TARGET}-en.ts \
                translations/$${TARGET}-de.ts

TARGETPATH = $$[QT_INSTALL_QML]/$$MODULENAME

target.path = $$TARGETPATH
INSTALLS += target

plugin.files = *.so src/*.so
plugin.path = $$TARGETPATH
INSTALLS += plugin


magic.files = magic
magic.path = $$[QT_INSTALL_QML]/com/jolla/gallery
INSTALLS += magic

mediasource.files = mediasource/*.qml
mediasource.path = $$PREFIX/share/jolla-gallery/mediasources
INSTALLS += mediasource

include(translations/translations.pri)
