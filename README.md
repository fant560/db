# Инструкция

## Порядок важен!

#### Проверить версию java 
<pre>
Пишем в консоли java --version
Должна быть версия 1.8(в принципе oracle требует jre, так что все должно быть нормально)
</pre>

#### Сменить настройки подключения
<pre>
редактируем файл src/main/resources/application.yml
меняем вот эти три строчки 
spring.datasource.url=jdbc:oracle:thin:@localhost:1522:xe
spring.datasource.username=SYSTEM
spring.datasource.password=admin
конфигурацию можно посмотреть в sql-developer'е. Должно быть интуитивно понятно
</pre>

#### Собрать и запустить проект на чистой БД
<pre>
в консоли в папке проекта пишем: gradlew.bat clean build bootRun

1. Проект создаст схему по переданным скриптам.
2. Проект зарегистрирует пакет с валидацией xml-файлов
3. Проект скачает один xml-файл и сохранит его в базе данных если данные из xml пройдут валидацию(написан триггер).
4. Проверить таблицу XMLD_BUFFER_XML_FILES
5. Отключить - в консоли с процессом нажать Ctrl+c, потом y.
6. Если нужно больше xml-файлов то просто запустить: gradlew.bat bootRun
</pre>


### Примечания
<pre>
1. Основная логика в файлах DocumentLoader.kt и DataSaver.kt
2. Sql-код в src/main/resources/db/migration/
3. Валидация xml на триггере полностью на уровне СУБД
</pre>