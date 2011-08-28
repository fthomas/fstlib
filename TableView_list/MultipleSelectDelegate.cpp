#include "MultipleSelectDelegate.h"
#include <QStyledItemDelegate>
#include <QListWidget>
#include <QStringList>
#include <QDebug>

MultipleSelectDelegate::MultipleSelectDelegate(QObject* parent)
  : QStyledItemDelegate(parent) {}

void MultipleSelectDelegate::paint(QPainter* painter,
    const QStyleOptionViewItem& option, const QModelIndex& index) const {
  QStyleOptionViewItemV4 opt = option;
  initStyleOption(&opt, index);

  QStringList list = index.data().toStringList();
  QListWidget list_widget;
  list_widget.addItems(list);
  list_widget.render(painter, opt.rect.topLeft());

  //qDebug() <<
  //QStyle *style = list_widget.style();
  //style->drawPrimitive(QStyle::PE_Widget, &opt, painter, &list_widget);
  //style->drawControl(QStyle::CT_ItemViewItem);
  //  style->drawControl(QStyle::CT_ItemViewItem, &opt, painter, &list_widget);
}

QSize MultipleSelectDelegate::sizeHint(const QStyleOptionViewItem& option,
                                       const QModelIndex& index) const {
  QStringList list = index.data().toStringList();
  QListWidget list_widget;
  list_widget.addItems(list);
  return list_widget.sizeHint();
}
