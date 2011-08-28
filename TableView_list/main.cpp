#include <QApplication>
#include <QTableView>
#include "MultipleSelectDelegate.h"
#include "TableModel.h"

int main(int argc, char *argv[]) {
  QApplication app(argc, argv);

  QTableView* table = new QTableView();
  TableModel* model = new TableModel(table);
  MultipleSelectDelegate* delegate = new MultipleSelectDelegate(table);
  table->setModel(model);
  table->setItemDelegate(delegate);
  table->show();

  return app.exec();
}
