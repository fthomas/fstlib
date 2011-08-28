#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <QAbstractTableModel>
#include <QModelIndex>
#include <QList>
#include <QObject>
#include <QVariant>

class TableModel : public QAbstractTableModel {
  Q_OBJECT

 public:
  explicit TableModel(QObject* parent = 0);

  int rowCount(const QModelIndex&) const;

  int columnCount(const QModelIndex&) const;

  QVariant data(const QModelIndex& index, int role) const;

 private:
  QList<QVariant> data_;
};

#endif // TABLEMODEL_H
