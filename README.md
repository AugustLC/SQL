# SQL
<br/>
1. Создать таблицы (на выходе: файл в репозитории CreateStructure.sql в ветке Tables)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;1.1. dbo.SKU (ID identity, Code, Name)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.1. Ограничение на уникальность поля Code<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.2. Поле Code вычисляемое: "s" + ID<br/>
&nbsp;&nbsp;&nbsp;&nbsp;1.2. dbo.Family (ID identity, SurName, BudgetValue)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;1.3. dbo.Basket (ID identity, ID_SKU (внешний ключ на таблицу dbo.SKU), ID_Family (Внешний ключ на таблицу dbo.Family) Quantity, Value, PurchaseDate, DiscountValue)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.3.1. Ограничение, что поле Quantity и Value не могут быть меньше 0<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.3.2. Добавить значение по умолчанию для поля PurchaseDate: дата добавления записи (текущая дата)<br/>
2. Создать функцию (на выходе: файл в репозитории dbo.udf_GetSKUPrice.sql в ветке Functions)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;2.1. Входной параметр @ID_SKU<br/>
&nbsp;&nbsp;&nbsp;&nbsp;2.2. Рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.1. сумма Value по переданному SKU / сумма Quantity по переданному SKU<br/>
&nbsp;&nbsp;&nbsp;&nbsp;2.3. На выходе значение типа decimal(18, 2)<br/>
3. Создать представление (на выходе: файл в репозитории dbo.vw_SKUPrice в ветке VIEWs)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;3.1. Возвращает все атрибуты продуктов из таблицы dbo.SKU и расчетный атрибут со стоимостью одного продукта (используя функцию dbo.udf_GetSKUPrice)<br/>
4. Создать процедуру (на выходе: файл в репозитории dbo.usp_MakeFamilyPurchase в ветке Procedures<br/>
&nbsp;&nbsp;&nbsp;&nbsp;4.1. Входной параметр (@FamilySurName varchar(255)) одно из значений атрибута SurName таблицы dbo.Family<br/>
&nbsp;&nbsp;&nbsp;&nbsp;4.2. Процедура при вызове обновляет данные в таблицы dbo.Family в поле BudgetValue по логике<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.2.1. dbo.Family.BudgetValue - sum(dbo.Basket.Value), где dbo.Basket.Value покупки для переданной в процедуру семьи<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.2.2. При передаче несуществующего dbo.Family.SurName пользователю выдается ошибка, что такой семьи нет<br/>
5. Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в ветке Triggers)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;5.1. Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, то значение в поле DiscountValue, для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0<br/>
