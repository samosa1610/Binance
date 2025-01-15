#include "mainwindow.h"
#include <QPushButton>
#include <QFile>
#include <QProcess>
#include <QTextStream>
#include <QDir>
#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    // Create a button
    button = new QPushButton("Place Order", this);
    setCentralWidget(button);
    resize(400, 300);

    // Connect the button click signal to the placeOrder slot
    connect(button, &QPushButton::clicked, this, &MainWindow::placeOrder);
}

MainWindow::~MainWindow()
{
}

void MainWindow::placeOrder()
{
    // Define the relative path to order.sh
    QString scriptPath = QDir::current().filePath("../scripts/order.sh");

    // Ensure the script is executable
    QFile scriptFile(scriptPath);
    if (scriptFile.exists()) {
        // Check if the script has execute permissions
        if (!(scriptFile.permissions() & QFile::ExeUser)) {
            // Make the script executable if it doesn't have execute permission
            scriptFile.setPermissions(scriptFile.permissions() | QFile::ExeUser);
        }

        // Use QProcess to run the script
        QProcess *process = new QProcess(this);

        // Prepare the argument list (empty in this case)
        QStringList arguments;

        // Start the script with no arguments
        process->start(scriptPath, arguments);
        process->waitForFinished();

        // Capture the output and error
        QByteArray output = process->readAllStandardOutput();
        QByteArray errorOutput = process->readAllStandardError();

        // Ensure the "outputs" directory exists
        QDir outputsDir(QDir::current().filePath("../outputs"));
        if (!outputsDir.exists()) {
            outputsDir.mkpath(".");
        }

        // Save the output to a new file in the "outputs" directory
        QFile outputFile(outputsDir.filePath("../outputs/order_output.txt"));
        if (outputFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
            QTextStream out(&outputFile);
            out << "Order Output:\n";
            out << output;
            if (!errorOutput.isEmpty()) {
                out << "\nError Output:\n";
                out << errorOutput;
            }
            outputFile.close();
        } else {
            qDebug() << "Failed to open output file for writing.";
        }

        // Optionally, log the output to the console as well
        qDebug() << "Order placed. Output saved to outputs/order_output.txt.";
    } else {
        // Handle error if the script is not found or not executable
        qDebug() << "Script not found or not executable!";
    }
}
