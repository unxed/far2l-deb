# far2l-deb
**Readme in english is below**

.deb пакеты [far2l](https://github.com/elfmz/far2l) (linux порт [Far Manager 2](http://www.farmanager.com/index.php?l=ru)) для Ubuntu/Mint.

Если нет пакета для нужного дистрибутива или архитектуры, вы можете попробовать собрать пакет самостоятельно, используя скрипт `make_far2l_deb.sh`.

По умолчанию far2l работает как GUI-приложение на wxWidgets. Также поддерживается работа в консоли, запускается по `far2l --tty`.

Консольная версия лучше всего работает во встроенном терминале wx-версии. Но и в xterm и его производных тоже можно пользоваться (правда, тогда не будет синхронизации буфера обмена и части горячих клавиш). Даже в putty можно, но тоже [с некоторыми ограничениями](https://github.com/elfmz/far2l/issues/472) (или можно использовать [специальную версию putty](https://github.com/unxed/putty4far2l)).

Установка:
```
sudo dpkg -i ПАКЕТ_ДЛЯ_ВАШЕГО_ДИСТРИБУТИВА.deb
sudo apt-get install -f
sudo dpkg -i ПАКЕТ_ДЛЯ_ВАШЕГО_ДИСТРИБУТИВА.deb
```

В ppa могут быть более свежие сборки, равно как и сборки для других выпусков дистрибутивов:

https://launchpad.net/~far2l-team/+archive/ubuntu/ppa

P.S. far2l_2.2~ubuntu20.04_amd64_wx31.deb — специальная версия, собранная на Ubuntu 20.04 с wx 3.1 отсюда:
https://wiki.codelite.org/pmwiki.php/Main/WxWidgets31Binaries
В ней нормально работает быстрый поиск по клавише Alt с не латинскими символами.

P.P.S. Что ещё тут есть интересного?

cygwin — предсобранные бинарные сборки far2l для cygwin с инструкцией, как установить

misc — всякие вспомогательные скрипты, большей частью устаревшие, и мелкий фикс для colorera

portable — tty-версия far2l, собранная со всеми библиотеками в один исполняемый файл, пригодится на shared хостингах

themes — темы оформления интерфейса far2l

---

.deb packages of [far2l](https://github.com/elfmz/far2l) ([Far Manager 2](http://www.farmanager.com/index.php?l=en) linux port) for Ubuntu/Mint.

If there is no package for your OS release or architecture, you may try to build package yourself using `make_far2l_deb.sh`.

far2l defaults to run as GUI app based on wxWidgets toolkit. You can run `far2l --tty` to get console support.

Console-based version works best inside internal terminal of wx-based version, but is still usable under xterm and its derivatives (but no clipboard sync and some hotkeys fail in this case). Usable under putty, but [some limitations](https://github.com/elfmz/far2l/issues/472) apply also (or you can use [special putty version](https://github.com/unxed/putty4far2l)).

Installation:
```
sudo dpkg -i PACKAGE_FOR_YOUR_DISTRO.deb
sudo apt-get install -f
sudo dpkg -i PACKAGE_FOR_YOUR_DISTRO.deb
```

https://launchpad.net/~far2l-team/+archive/ubuntu/ppa may have more recent builds as well as builds for unsupported here distros.

P.S. far2l_2.2~ubuntu20.04_amd64_wx31.deb is a special version built on Ubuntu 20.04 with wx 3.1 from here:
https://wiki.codelite.org/pmwiki.php/Main/WxWidgets31Binaries
Quick search using Alt key with non-Latin characters works fine in it.

P.P.S. What else interesting is there?

cygwin - prebuilt binaries of far2l for cygwin with instructions (russian only) on how to install

misc - all sorts of auxiliary scripts, mostly outdated, and a minor fix for colorer

portable - the tty version of far2l, packaged with all the libraries into one executable file, useful on shared hosting

themes - themes for far2l UI
