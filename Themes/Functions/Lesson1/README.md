# Конструкция Функции

```sql
CREATE [OR REPLACE] FUNCTION func (param type, param type)
    RETURNS TYPE
    LANGUAGE pgplsql
AS 
$$
    DECLARE 
        -- Объявление локальных переменных 
    BEGIN
        -- Операторы
    END;
$$;

```

Здесь 
+ `CREATE`: Создание
+ `OR REPLACE`: или заменить, если такая функция уже создана
+ `param` `type`: параметр и тип параметра
+ `RETURNS TYPE`: тип возвращаемого объекта 
+ `LANGUAGE pgplsql`: язык на котором мы пишем функцию 
