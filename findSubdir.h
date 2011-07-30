#include <functional>
#include <QDir>
#include <QList>
#include <QString>

struct dir_exists : public std::unary_function<QDir, bool> {
  bool operator()(const QDir& dir) const {
    return dir.exists();
  }
};

struct dir_contains : public std::unary_function<QDir, bool> {
  explicit dir_contains(const QList<QString>& paths) : paths_(paths) {}

  explicit dir_contains(const QString& path) : paths_() {
    paths_.append(path);
  }

  bool operator()(const QDir& dir) const {
    foreach (const QString& path, paths_) {
      if (!dir.exists(path)) return false;
    }
    return dir.exists();
  }

 private:
  QList<QString> paths_;
};

template<class Predicate>
QString findSubdir(QString subdir, QList<QDir> search_dirs,
                   Predicate pred = dir_exists()) {

}
