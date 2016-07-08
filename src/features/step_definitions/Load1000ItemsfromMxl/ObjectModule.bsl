﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

// контекст фреймворка Vanessa-Behavior
Перем Ванесса;

// Служебная функция.
Функция ДобавитьШагВМассивТестов(МассивТестов,Снипет,ИмяПроцедуры,ПредставлениеТеста = Неопределено,Транзакция = Неопределено,Параметр = Неопределено)
	Структура = Новый Структура;
	Структура.Вставить("Снипет",Снипет);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ПредставлениеТеста",ПредставлениеТеста);
	Структура.Вставить("Транзакция",Транзакция);
	Структура.Вставить("Параметр",Параметр);
	МассивТестов.Добавить(Структура);
КонецФункции

// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	ДобавитьШагВМассивТестов(ВсеТесты,"ИмеетсяМетаданное(Парам01)","ИмеетсяМетаданное","Дано:  Имеется метаданное ""Справочник1""");
	ДобавитьШагВМассивТестов(ВсеТесты,"СуществуетМакет(Парам01)","СуществуетМакет","и существует макет ""ТысячаЭлементовСправочника1""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагружаюМакет(Парам01)","ЯЗагружаюМакет","И я загружаю макет ""ТысячаЭлементовСправочника1""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВСпискеЭлементовСправочникаСуществуетНеМенееЭлементов(Парам01,Парам02)","ВСпискеЭлементовСправочникаСуществуетНеМенееЭлементов","Тогда В списке элементов справочника ""Справочник1"" существует не менее 1000 элементов");

	Возврат ВсеТесты;
КонецФункции
	
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакет(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

//Дано:  Имеется метаданное "Справочник1"
//@ИмеетсяМетаданное(Парам01)
Процедура ИмеетсяМетаданное(ИмяОбъекта) Экспорт
	
	Ванесса.ПроверитьНеРавенство(Метаданные.НайтиПоПолномуИмени(ИмяОбъекта),Неопределено);
	
КонецПроцедуры

//и существует макет "ТысячаЭлементовСправочника1"
//@СуществуетМакет(Парам01)
Процедура СуществуетМакет(ИмяМакета) Экспорт
	
	Попытка
		Макет = ПолучитьМакет(ИмяМакета);
	Исключение
		ВызватьИсключение "Не найден макет "+ИмяМакета+" ошибка: "+ОписаниеОшибки();
	КонецПопытки;
	
КонецПроцедуры

//И я загружаю макет "ТысячаЭлементовСправочника1"
//@ЯЗагружаюМакет(Парам01)
Процедура ЯЗагружаюМакет(ИмяМакета) Экспорт
	Ошибка = """";
	Попытка
		ОбычнаяФормаВанессы 				= Ванесса.ПолучитьФорму("Форма");
		ОбработкаСвязаннаяСИсполняемойФичей = ОбычнаяФормаВанессы.ОбработкаСвязаннаяСИсполняемойФичей; 
		Макет 								= ОбработкаСвязаннаяСИсполняемойФичей.ПолучитьМакетОбработки(ИмяМакета);
		СтруктураДанных 					= Ванесса.СоздатьДанныеПоТабличномуДокументу(Макет);
		Ванесса.ПроверитьНеРавенство(СтруктураДанных,Неопределено,"Получили структуру данных.");
	Исключение
		Ошибка =  СокрЛП(ОписаниеОшибки());  		
		ВызватьИсключение "Шаг выполнен с ошибкой: " + СокрЛП(Ошибка);	
	КонецПопытки;  
КонецПроцедуры

//Тогда В списке элементов справочника "Справочник1" существует не менее 1000 элементов
//@ВСпискеЭлементовСправочникаСуществуетНеМенееЭлементов(Парам01,Парам02)
Процедура ВСпискеЭлементовСправочникаСуществуетНеМенееЭлементов(ИмяСправочника,Количество) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	КОЛИЧЕСТВО(*) КАК Счетчик
	|ИЗ
	|	Справочник."+ИмяСправочника+" КАК ИмяСправочника";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	
	СуществуетЭлементов = ВыборкаДетальныеЗаписи.Счетчик;
	
	Ванесса.ПроверитьРавенство(СуществуетЭлементов>Количество, Истина)

	
КонецПроцедуры
