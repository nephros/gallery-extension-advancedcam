TEMPLATE = aux
TARGET = gallery-extension-magic-editor
CONFIG += sailfishapp_qml

qml.files = qml
qml.path = $$PREFIX/share/$$TARGET

desktop.files = $${TARGET}.desktop
desktop.path = $$PREFIX/share/applications

INSTALLS += desktop qml

message(Installing Settings Editor)

lupdate_only {
	SOURCES += qml/*.qml
}

TRANSLATIONS += translations/$${TARGET}-en.ts \
                translations/$${TARGET}-de.ts

include(translations/translations.pri)
