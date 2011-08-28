#ifndef MULTIPLESELECTDELEGATE_H
#define MULTIPLESELECTDELEGATE_H

#include <QStyledItemDelegate>

class MultipleSelectDelegate : public QStyledItemDelegate {
  Q_OBJECT

 public:
  MultipleSelectDelegate(QObject* parent = 0);

  void paint(QPainter* painter, const QStyleOptionViewItem& option,
             const QModelIndex& index) const;

  QSize sizeHint(const QStyleOptionViewItem& option,
                 const QModelIndex& index) const;
};

#endif // MULTIPLESELECTDELEGATE_H
