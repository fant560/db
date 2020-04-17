# Инструкция

## Примечания 

1. Программма использовала flyway и автоматом запускала скрипты создания схемы таблицы, но, к сожалению, 
эта библиотека не поддерживает Oracle Enterprise Edition, поэтому не получается сделать все автоматом, 
придется запускать скрипты создания схемы руками в sql-developer'e.

2. Программа-сборщик gradle пишет в лог сборки WARN-сообщения о том что к 7 версии некоторые функции 
перестанут поддерживаться(deprecated), мы используем 6 версию, поэтому смело игнорируем. 

3. Основная логика в файлах DocumentLoader.kt и DataSaver.kt

## Порядок важен!

#### Проверить версию java 
<pre>
Пишем в консоли java -version
Должна быть версия 1.8(в принципе oracle требует jre, так что все должно быть нормально)
</pre>

#### Сменить настройки подключения
<pre>
редактируем файл src/main/resources/application.properties
меняем вот эти три строчки 
spring.datasource.url=jdbc:oracle:thin:@localhost:1522:xe
spring.datasource.username=SYSTEM
spring.datasource.password=admin
конфигурацию можно посмотреть в sql-developer'е. Должно быть интуитивно понятно
</pre>


### Выполнить начальные sql-скрипты в sql-developer'e
<pre>
выполнить sql-скрипт из файла schema.sql в корне
</pre>

#### Собрать и запустить проект на чистой БД
<pre>
в консоли в папке проекта пишем: gradlew.bat clean build bootRun

1. Проект скачает один xml-файл и сохранит его в базе данных если данные из xml пройдут валидацию(написан триггер).
2. Проверить таблицу XMLD_BUFFER_XML_FILES
3. Отключить - в консоли с процессом нажать Ctrl+c, потом y.
4. Если нужно больше xml-файлов то просто запустить: gradlew.bat bootRun
</pre>

### Проверить 
<pre>
1. В src/main/resources лежат 2 файла - valid.xml и invalid.xml
2. Открыть в браузере - http://localhost:8080/buffer/invalid для проверки метода валидации
3. Открыть в браузере - http://localhost:8080/buffer/valid для проверки метода сохранения валидных сообщений
Все данные можно посмотреть в таблице XML_BUFFER_XML_FILES
</pre>

### Постскриптум

Проект выполнен под чутким руководством текущих выпускников УдГУ. За что им большое спасибо.
