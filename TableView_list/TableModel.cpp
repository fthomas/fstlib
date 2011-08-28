#include "TableModel.h"
#include <QStringList>

TableModel::TableModel(QObject* parent) : QAbstractTableModel(parent) {
  QStringList list1, list2;
  list1 << "one" << "two" << "three" << "four";
  list2 << "1111" << "2222" << "3333" << "4444";
  data_ << list1 << list2;
}

int TableModel::rowCount(const QModelIndex&) const {
  return data_.size();
}

int TableModel::columnCount(const QModelIndex&) const {
  return 1;
}

QVariant TableModel::data(const QModelIndex& index, int role) const {
  if (!index.isValid())
    return QVariant();

  if (index.row() >= data_.size())
    return QVariant();

  if (role == Qt::DisplayRole) {
      return data_.at(index.row());
  }
  return QVariant();
}
