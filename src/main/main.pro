include(../defines.pri)

isEqual(QT_MAJOR_VERSION, 5) {
    QT += webkitwidgets network widgets printsupport sql script
} else {
    QT += core gui webkit sql network script
}

TARGET = qupzilla
mac: TARGET = QupZilla

TEMPLATE = app

compile_libtool {
LIBS += $$QZ_DESTDIR/libQupZilla.la
}
else {
!unix|mac: LIBS += -L$$QZ_DESTDIR -lQupZilla
!mac:unix: LIBS += $$QZ_DESTDIR/libQupZilla.so
}

unix:!contains(DEFINES, "DISABLE_DBUS") QT += dbus

INCLUDEPATH += ../lib/3rdparty \
               ../lib/app \
               ../lib/session \
               ../lib/webtab \

DEPENDPATH += $$INCLUDEPATH

SOURCES = main.cpp

OTHER_FILES += appicon.rc \
               appicon_os2.rc \
               Info.plist \

os2:RC_FILE = appicon_os2.rc
win32:RC_FILE = appicon.rc

openbsd-*|freebsd-*|haiku-* {
    LIBS += -lexecinfo
}

include(../install.pri)

unix:contains(DEFINES, "NO_SYSTEM_DATAPATH"): QMAKE_LFLAGS+=$${QMAKE_LFLAGS_RPATH}\\$\$ORIGIN
