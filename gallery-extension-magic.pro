TEMPLATE = subdirs
TARGET = gallery-extension-magic
# needed to define prefix and libdir
CONFIG += sailfishapp_qml

SUBDIRS += extension
SUBDIRS += settings
SUBDIRS += editor
SUBDIRS += icons

QMAKE_EXTRA_TARGETS += documentation
documentation.commands = tools/makedocs

QMAKE_EXTRA_TARGETS += ts
ts.commands = lupdate *.pro

OTHER_FILES += $$files(rpm/*)

QMAKE_CLEAN += -r icons/z*
QMAKE_CLEAN += debug*.list
QMAKE_CLEAN += elfbins.list
QMAKE_CLEAN += documentation.list
QMAKE_CLEAN += build.log
