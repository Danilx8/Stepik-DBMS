**Описание базы данных**

Вы работаете с базой данных содержащей записи о научных статьях, исследователях и конференциях с такой структурой:

    -- Названия конференций. 100 записей
    Conference(id, value)
    -- Города проведения конференций. 50 записей
    Location(id, value)
    -- Название статьи, название конференции, на которую она подана и город проведения конференции. 50000 записей
    Paper(id, title, conference, location)

  

**Задание**

Вам стало известно, что отсутствие нормализации и ссылочной целостности (в вашей БД нет никаких внешних ключей) сыграло злую шутку и данные в таблице Paper стали несогласованными. У нескольких конференций неоднозначно определяется место проведения. У одной статьи записана несуществующая конференция (отсутствующая в таблице Conference)

Вам нужно найти нарушения согласованности. Для этого нужно написать запрос, возвращающий один столбец с названиями конференций с неоднозначным местом проведения и несуществующей конференции. Название столбца и порядок следования конференций в нем не имеют значения.

Вам может пригодиться для этой цели операция UNION, делающая теоретико-множественное объединение результатов двух запросов. Пример валидного, но неправильного запроса с использованием объединения:

    SELECT 'Foo'
    UNION 
    SELECT conference FROM Paper;

  

Ответ проверяется роботом, который будет сравнивать пересечение вашего ответа со своим решением.  Если ответ равен ожидаемому, то робот будет счастлив. Если ответ отличается от ожидаемого, робот скажет, есть ли в запросе что-то лишнее или наоборот, чего-то не хватает.

**Возможные шероховатости**

Проверка выполняется внешним сервисом. Обычно в течение 15 секунд вы должны получить ответ. При нагрузке время ответа может возрасти, но все равно за 5 минут решение должно быть проверено. Если вы не получаете ответ в течение 5 минут, сообщите об этом в комментарии.

Настоятельно рекомендуем не откладывать отсылку решения на последний час перед дедлайном. Рекомендуем проводить основные эксперименты на своем компьютере, и отсылать уже готовый результат, который хотя бы является синтаксически правильным. В случае синтаксической ошибки робот скажет вам только о факте её наличия, без подробностей.

**Тестовые данные**

Вы можете [скачать архив](https://stepik.org/media/attachments/course/3203/HW2Task2.zip), содержащий в себе скрипт, генерирующий 50000 статей. В архиве находится bash скрипт task2-public.sh, который запускает в докере постгрес, соединяется с ним при помощи psql и генерирует данные. Он протестирован на Линуксе с установленным docker'ом. На других системах не тестировался, но должно быть несложно его адаптировать.

При проверке содержимое таблицы Paper генерируется ровно этим же кодом, после чего несколько строк в таблице "ломаются" так, чтоб нарушалась целостность и зависимость Conference->Location. Процедуры, портящие данные, в скрипте отсутствуют, напишите их самостоятельно.