TEMPLATE = aux
TARGET = gallery-extension-magic-settings
CONFIG += sailfish_qml

qml.path = $$PREFIX/share/$$TARGET
qml.files = qml

desktop.files = *.desktop
desktop.path = $$PREFIX/share/applications

INSTALLS += desktop qml

message(Installing Settings Editor)

lupdate_only {
	SOURCES += qml/*.qml
}

TRANSLATIONS += translations/$${TARGET}-en.ts \
	translations/$${TARGET}-de.ts

include(translations/translations.pri)
