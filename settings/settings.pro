TEMPLATE = aux
TARGET = gallery-extension-magic-settings
CONFIG += sailfishapp_qml

entries.files = entries
entries.path = $$PREFIX/share/jolla-settings
INSTALLS += entries

pages.path = $$PREFIX/share/jolla-settings
pages.files = pages
INSTALLS += pages

message(Installing Settings Page)

lupdate_only {
	SOURCES += pages/*/*.qml
}

TRANSLATIONS += translations/$${TARGET}-en.ts \
                translations/$${TARGET}-de.ts

include(translations/translations.pri)
