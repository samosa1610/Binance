#include "mainwindow.h"
#include <QApplication>
#include <QCoreApplication>

int main(int argc, char *argv[]) {
    // Force software OpenGL to avoid driver issues
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);
    QApplication app(argc, argv);
    MainWindow window;
    window.show();
    return app.exec();
}
