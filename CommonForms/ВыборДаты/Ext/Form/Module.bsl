﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче 
	// параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	Если Параметры.Свойство("ТекущаяДата") 
		И ЗначениеЗаполнено(Параметры.ТекущаяДата) Тогда
		ДатаНачалаМесяца = НачалоМесяца(Параметры.ТекущаяДата);
		ВыбраннаяДата = Параметры.ТекущаяДата;
	Иначе
		ДатаНачалаМесяца = НачалоМесяца(ТекущаяДата());
		ВыбраннаяДата = НачалоДня(ТекущаяДата());
	КонецЕсли;
	
	Если Параметры.Свойство("СписокСобытий") Тогда
		ПоказыватьСписокСобытий = Параметры.СписокСобытий;
	КонецЕсли;
	
	Если Не ПоказыватьСписокСобытий Тогда
		Элементы.События.Видимость = Ложь;
	КонецЕсли;
	
	ВызывающийЭлемент = Параметры.Элемент;

	// Предварительная настройка используемых элементов оформления
	ЦветБуднихДнейМесяца = Новый Цвет(0, 0, 0);
	ЦветБуднихДнейНеТекущегоМесяца = Новый Цвет(169, 169, 169);
	ЦветВыходныхДнейМесяца = Новый Цвет(255, 0, 0);
	ЦветВыходныхДнейНеТекущегоМесяца = Новый Цвет(250, 128, 114);

	ШрифтОбычный = Новый Шрифт();
	ШрифтЖирный = Новый Шрифт(,,Истина);
	РамкаОтсутствует = Новый Рамка(ТипРамкиЭлементаУправления.БезРамки);
	РамкаПодчеркивание = Новый Рамка(ТипРамкиЭлементаУправления.Подчеркивание);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СобытияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ПредыдущийМесяцНажатие(Элемент)

	ДатаНачалаМесяца = ДобавитьМесяц(ДатаНачалаМесяца, -1);

КонецПроцедуры

&НаКлиенте
Процедура ДекорацияСегодняНажатие(Элемент)

	ДатаНачалаМесяца = НачалоМесяца(ТекущаяДата());
	ВыбраннаяДата = НачалоДня(ТекущаяДата());
	БывшаяДата = "";

КонецПроцедуры

&НаКлиенте
Процедура СледующийМесяцНажатие(Элемент)

	ДатаНачалаМесяца = ДобавитьМесяц(ДатаНачалаМесяца, 1);

КонецПроцедуры

&НаКлиенте
Процедура ДеньНажатие(Элемент)

	НоваяДата = Дата(Элемент.Заголовок);

	// Скорее всего это просто выбор дня для просмотра 
	Если ПоказыватьСписокСобытий И Не ВыбраннаяДата = НоваяДата Тогда

		// Оформим предыдущее выбранное число обычным шрифтом
		Если ЗначениеЗаполнено(БывшаяДата) Тогда
			Элементы[БывшаяДата].Шрифт = ШрифтОбычный;
		КонецЕсли;

		Элементы[Элемент.Имя].Шрифт = ШрифтЖирный;

		ВыбраннаяДата = НоваяДата;
		БывшаяДата = Элемент.Имя;

		Элементы.События.ОтборСтрок = Новый ФиксированнаяСтруктура("Дата", ВыбраннаяДата);

	Иначе

		// Выбор даты для переноса в вызывающую форму

		Оповестить("ВыбранаДатаКалендаря", НоваяДата, ВызывающийЭлемент);

		Закрыть();

	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Готово(Команда)

	Оповестить("ВыбранаДатаКалендаря", ВыбраннаяДата, ВызывающийЭлемент);

	Закрыть();

КонецПроцедуры

#КонецОбласти
