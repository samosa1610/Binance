#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QPushButton>

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void placeOrder();  // Slot for placing the order when the button is clicked

private:
    QPushButton *button;  // Button to trigger order placement
};

#endif // MAINWINDOW_H
