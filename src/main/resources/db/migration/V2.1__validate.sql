Create or replace package Register_Validate as

	PROCEDURE RegistrerXSD;
PROCEDURE ValidateXML(Name_XSD in VARCHAR2, File_XML in CLOB);

End Register_Validate;



--grant execute on (packageName or tableName) to user;


CREATE OR REPLACE
PACKAGE BODY Register_Validate as

PROCEDURE RegistrerXSD is

xsd_schema clob;
urlexists number;

BEGIN
xsd_schema :=to_clob(' ')||to_clob('<?xml version="1.0" encoding="windows-1251"?>

<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
		   xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
		   elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:element name="Файл">
		<xs:annotation>
			<xs:documentation>Файл обмена</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="СвУчДокОбор">
					<xs:annotation>
						<xs:documentation>Сведения об участниках электронного документооборота</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="СвОЭДОтпр" minOccurs="0">
								<xs:annotation>
									<xs:documentation>Сведения об операторе электронного документооборота отправителя файла обмена счета-фактуры (информации продавца)</xs:documentation>
									<xs:documentation>Обязателен при направлении документа через оператора ЭДО СФ</xs:documentation>
								</xs:annotation>
								<xs:complexType>') || to_clob('
									<xs:attribute name="НаимОрг" use="required">
										<xs:annotation>
											<xs:documentation>Наименование</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="1000"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="ИННЮЛ" type="ИННЮЛТип" use="required">
										<xs:annotation>
											<xs:documentation>ИНН</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="ИдЭДО" use="required">
										<xs:annotation>
											<xs:documentation>Идентификатор оператора электронного документооборота отправителя файла обмена счета-фактуры (информации продавца)</xs:documentation>
											<xs:documentation>
											Идентификатор оператора ЭДО СФ, услугами которого пользуется покупатель (продавец), символьный трехзначный код. В значении идентификатора допускаются символы латинского алфавита A-Z, a–z, цифры 0–9, знаки «@», «.», «-». Значение идентификатора регистронезависимо. При включении оператора ЭДО СФ в сеть доверенных операторов ЭДО СФ ФНС России, идентификатор присваивается Федеральной налоговой службой</xs:documentation>
										</xs:annotation>

										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:length value="3"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="ИдОтпр" use="required">
							<xs:annotation>
								<xs:documentation>Идентификатор участника документооборота – отправителя файла обмена счета-фактуры (информации продавца)</xs:documentation>
								<xs:documentation>Значение элемента представляется в виде ИдОЭДОСФКодПрод(Пок), где:
ИдОЭДОСФ - идентификатор оператора электронного оборота счетов-фактур и первичных документов (оператор ЭДО СФ) - символьный трехзначный код. При включении оператора ЭДО СФ в сеть доверенных операторов ЭДО СФ ФНС России, идентификатор присваивается Федеральной налоговой службой;
КодПрод(Пок) - код продавца (покупателя) - уникальный код участника, присваиваемый оператором ЭДО СФ, длина кода продавца (покупателя) не более 43 символов.
При Функция=ДОП и направлении документа не через оператора ЭДО СФ ИдОтпр - глобальный уникальный идентификатор (GUID), однозначно идентифицирующий участника документооборота</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="4"/>
									<xs:maxLength value="46"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="ИдПол" use="required">
							<xs:annotation>') || to_clob('
								<xs:documentation>Идентификатор участника документооборота - получателя файла обмена счета-фактуры (информации продавца)</xs:documentation>
								<xs:documentation>Значение элемента представляется в виде ИдОЭДОСФКодПрод(Пок), где:
ИдОЭДОСФ - идентификатор оператора электронного оборота счетов-фактур и первичных документов (оператор ЭДО СФ) - символьный трехзначный код. При включении оператора ЭДО СФ в сеть доверенных операторов ЭДО СФ ФНС России, идентификатор присваивается Федеральной налоговой службой;
КодПрод(Пок) - код продавца (покупателя) - уникальный код участника, присваиваемый оператором ЭДО СФ, длина кода продавца (покупателя) не более 43 символов.
При Функция=ДОП и направлении документа не через оператора ЭДО СФ ИдПол - глобальный уникальный идентификатор (GUID), однозначно идентифицирующий участника документооборота</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="4"/>
									<xs:maxLength value="46"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Документ">
					<xs:annotation>
						<xs:documentation>Счет-фактура, применяемый при расчетах по налогу на добавленную стоимость, документ об отгрузке товаров (выполнении работ), передаче имущественных прав (документ об оказании услуг) (информация продавца)</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="СвСчФакт">
								<xs:annotation>
									<xs:documentation>Сведения о счете-фактуре (содержание факта хозяйственной жизни 1-  сведения об участниках факта хозяйственной жизни, основаниях и обстоятельствах его проведения)</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ИспрСчФ" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Исправление (строка 1а счета-фактуры)</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:attribute name="НомИспрСчФ" use="required">
													<xs:annotation>
														<xs:documentation>Исправление: №</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:integer">
															<xs:totalDigits value="3"/>
															<xs:minInclusive value="1"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ДатаИспрСчФ" type="ДатаТип" use="required">
													<xs:annotation>
														<xs:documentation>Исправление: Дата</xs:documentation>
														<xs:documentation>
											Дата в формате ДД.ММ.ГГГГ</xs:documentation>
													</xs:annotation>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
										<xs:element name="СвПрод" type="УчастникТип">
											<xs:annotation>
												<xs:documentation>Сведения о продавце (строки 2, 2а, 2б счета-фактуры)</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ГрузОт" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Сведения о грузоотправителе (строка 3 счета-фактуры)</xs:documentation>
												<xs:documentation>Указывается, если грузоотправитель не совпадает с продавцом</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:choice>
													<xs:element name="ГрузОтпр" type="УчастникТип">
														<xs:annotation>
															<xs:documentation>Грузоотправитель и его адрес</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="ОнЖе">
														<xs:annotation>
															<xs:documentation>Указано «он же»</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:length value="5"/>
																<xs:enumeration value="он же"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:choice>
											</xs:complexType>
										</xs:element>
										<xs:element name="ГрузПолуч" type="УчастникТип" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Грузополучатель и его адрес (строка 4 счета-фактуры)</xs:documentation>
												<xs:documentation>Указывается, если грузополучатель не совпадает с покупателем</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="СвПРД" minOccurs="0" maxOccurs="unbounded">
											<xs:annotation>
												<xs:documentation>Сведения о платежно-расчетном документе (строка 5 счета-фактуры)</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:attribute name="НомерПРД" use="required">
													<xs:annotation>
														<xs:documentation>Номер платежно-расчетного документа</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="30"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ДатаПРД" type="ДатаТип" use="required">
													<xs:annotation>
														<xs:documentation>Дата составления платежно-расчетного документа</xs:documentation>
														<xs:documentation>
Дата в формате ДД.ММ.ГГГГ</xs:documentation>
													</xs:annotation>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
										<xs:element name="СвПокуп" type="УчастникТип">
											<xs:annotation>
												<xs:documentation>Сведения о покупателе (строки 6, 6а, 6б счета-фактуры)</xs:documentation>
											</xs:annotation>
										</xs:element>
					')|| to_clob('					<xs:element name="ДопСвФХЖ1" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Дополнительные сведения об участниках факта хозяйственной жизни, основаниях и обстоятельствах его проведения</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:attribute name="ИдГосКон" use="optional">
													<xs:annotation>
														<xs:documentation>Идентификатор государственного контракта</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="255"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="НаимОКВ" use="optional">
													<xs:annotation>
														<xs:documentation>Валюта: Наименование</xs:documentation>
														<xs:documentation>Наименование согласно Общероссийскому классификатору валют (ОКВ).
																	Формируется согласно указанному коду валюты</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="100"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="КурсВал" use="optional">
													<xs:annotation>
														<xs:documentation>Курс валюты</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:decimal">
															<xs:totalDigits value="10"/>
															<xs:fractionDigits value="4"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
										<xs:element name="ИнфПолФХЖ1" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Информационное поле факта хозяйственной жизни 1</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ТекстИнф" type="ТекстИнфТип" minOccurs="0" maxOccurs="20">
														<xs:annotation>
															<xs:documentation>Текстовая информация</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
												<xs:attribute name="ИдФайлИнфПол" use="optional">
													<xs:annotation>
														<xs:documentation>Идентификатор  файла информационного поля</xs:documentation>
														<xs:documentation>GUID.
														Указывается идентификатор файла, связанного со сведениями данного электронного документа</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:length value="36"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
									<xs:attribute name="НомерСчФ" use="required">
										<xs:annotation>
											<xs:documentation>Порядковый номер счета-фактуры (строка 1 счета-фактуры), документа об отгрузке товаров (выполнении работ), передаче имущественных прав (документа об оказании услуг)</xs:documentation>
											<xs:documentation>Для Функция=ДОП может принимать значение б/н (без номера)</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="1000"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="ДатаСчФ" type="ДатаТип" use="required">
										<xs:annotation>
											<xs:documentation>Дата составления счета-фактуры (строка 1 счета-фактуры), документа об отгрузке товаров (выполнении работ), передаче имущественных прав (документа об оказании услуг)</xs:documentation>
											<xs:documentation>
Дата в формате ДД.ММ.ГГГГ</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="КодОКВ" type="ОКВТип" use="required">
										<xs:annotation>
											<xs:documentation>Валюта: Код (строка 7 счета-фактуры)</xs:documentation>
											<xs:documentation>
											Код по Общероссийскому классификатору валют</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
							<xs:element name="ТаблСчФакт" minOccurs="0">
								<xs:annotation>
									<xs:documentation>Сведения таблицы счета-фактуры (содержание факта хозяйственной жизни 2 - наименование и другая информация об отгруженных товарах (выполненных работах, оказанных услугах), о переданных имущественных правах </xs:documentation>
									<xs:documentation>Обязателен при Функция=СЧФ или Функция=СЧФДОП</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="СведТов" maxOccurs="unbounded">
											<xs:annotation>
												<xs:documentation>Сведения об отгруженных  товарах (о выполненных работах, оказанных услугах), переданных имущественных правах</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Акциз" type="СумАкцизТип">
														<xs:annotation>
															<xs:documentation>В том числе сумма акциза (графа 6 счета-фактуры)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="СумНал" type="СумНДСТип">
														<xs:annotation>
															<xs:documentation>Сумма налога, предъявляемая покупателю (графа 8 счета-фактуры)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="СвТД" minOccurs="0" maxOccurs="unbounded">
														<xs:annotation>
															<xs:documentation>Сведения о таможенной декларации</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:attribute name="КодПроисх" type="ОКСМТип" use="required">
																<xs:annotation>
																	<xs:documentation>Цифровой код страны происхождения товара (Графа 10 счета-фактуры)</xs:documentation>
																	<xs:documentation>Код страны по Общероссийскому класси-фикатору стран мира (ОКСМ) или
																	980 - Евросоюз,
																	981 - ЕАЭС</xs:documentation>
																</xs:annotation>
															</xs:attribute>
															<xs:attribute name="НомерТД" use="required">
																<xs:annotation>
																	<xs:documentation>Номер таможенной декларации (Графа 11 счета-фактуры)</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:maxLength value="29"/>
																		<xs:minLength value="1"/>
																	</xs:restriction>
						') || to_clob('										</xs:simpleType>
															</xs:attribute>
														</xs:complexType>
													</xs:element>
													<xs:element name="ИнфПолФХЖ2" type="ТекстИнфТип" minOccurs="0" maxOccurs="20">
														<xs:annotation>
															<xs:documentation>Информационное поле факта хозяйственной жизни 2</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="ДопСведТов" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Дополнительные сведения об отгруженных  товарах (о выполненных работах, оказанных услугах), переданных имущественных правах</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:attribute name="ПрТовРаб" use="optional">
																<xs:annotation>
																	<xs:documentation>Признак Товар/Работа/Услуга/Право/Иное</xs:documentation>
																	<xs:documentation>, где:
																				1 - имущество;
2- работа;
3- услуга;
4 – имущественные права;
5 - иное</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:length value="1"/>
																		<xs:enumeration value="1"/>
																		<xs:enumeration value="2"/>
																		<xs:enumeration value="3"/>
																		<xs:enumeration value="4"/>
																		<xs:enumeration value="5"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="ДопПризн" use="optional">
																<xs:annotation>
																	<xs:documentation>Дополнительная информация о признаке </xs:documentation>
																	<xs:documentation>Содержит информацию, позволяющую сторонам в автоматизированном режиме обрабатывать информацию о признаке  отгруженных товаров (выполненных работ, оказанных услуг), переданных имущественных прав</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="1"/>
																		<xs:maxLength value="4"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="КодТов" use="optional">
																<xs:annotation>
																	<xs:documentation>Характеристика/код/артикул/сорт товара (выполненных работ, оказанных услуг), переданных имущественных прав</xs:documentation>
																	<xs:documentation>Содержит информацию, позволяющую сторонам в автоматизированном режиме обрабатывать информацию о признаке  отгруженных товаров (выполненных работ, оказанных услуг), переданных имущественных прав</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="1"/>
																		<xs:maxLength value="255"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="НаимЕдИзм" use="optional">
																<xs:annotation>
																	<xs:documentation>Наименование единицы измерения (условное обозначение национальное, графа 2а счета-фактуры)</xs:documentation>
																	<xs:documentation>
																	Обязателен при наличии ОКЕИ_Тов.
				Формируется автоматически в соответствии с указанным ОКЕИ_Тов.
При ОКЕИ_Тов=0000 автоматическое формирование наименования единицы измерения не производится. наименование единицы измерения указывается пользователем</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="1"/>
																		<xs:maxLength value="255"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="КрНаимСтрПр" use="optional">
																<xs:annotation>
																	<xs:documentation>Краткое наименование страны происхождения товара (графа 10а счета-фактуры)</xs:documentation>
																	<xs:documentation>Обязателен при наличии КодПроисх. Формируется автоматически в соответствии с указанным КодПроисх</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="1"/>
																		<xs:maxLength value="255"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="НадлОтп" use="optional">
																<xs:annotation>
																	<xs:documentation>Количество надлежит отпустить</xs:documentation>
																	<xs:documentation>Для случаев, если наличие показателя  предусмотрено в установленном порядке</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:decimal">
																		<xs:totalDigits value="26"/>
																		<xs:fractionDigits value="11"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="КорСчДебет" use="optional">
																<xs:annotation>
																	<xs:documentation>Корреспондирующие счета: дебет</xs:documentation>
																	<xs:documentation>Для случаев, если наличие показателя  предусмотрено в установленном порядке</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:length value="9"/>
																		<xs:pattern value="[0-9]{9}"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="КорСчКредит" use="optional">
																<xs:annotation>
																	<xs:documentation>Корреспондирующие счета: кредит</xs:documentation>
																	<xs:documentation>Для случаев, если наличие показателя  предусмотрено в установленном порядке</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:length value="9"/>
																		<xs:pattern value="[0-9]{9}"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
												<xs:attribute name="НомСтр" use="required">
													<xs:annotation>
														<xs:documentation>Номер строки таблицы</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:integer">
															<xs:totalDigits value="6"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="НаимТов" use="required">
													<xs:annotation>
														<xs:documentation>Наименование товара (описание выполненных работ, оказанных услуг), имущественных прав (графа 1 счета-фактуры)</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="1000"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ОКЕИ_Тов" type="ОКЕИТип" use="optional">
													<xs:annotation>
														<xs:documentation>Код единицы измерения (графа 2 счета-фактуры)</xs:documentation>
														<xs:documentation>
														Код единицы измерения по Общероссийскому классификатору единиц измерения или «0000» (при отсутствии необходимой единицы измерения в ОКЕИ).
В случае указания ОКЕИ_Тов=0000 наименование единицы измерения (НаимЕдИзм) определяется пользователем.
Обязателен при Функция=СЧФДОП или Функция=ДОП и наличии натурального измерителя факта хозяйственной жизни</xs:documentation>
													</xs:annotation>
												</xs:attribute>
												<xs:attribute name="КолТов" use="optional">
													<xs:annotation>
														<xs:documentation>Количество (объем) (графа 3 счета-фактуры)</xs:documentation>
														<xs:documentation>Обязателен при Функция=СЧФДОП или Функция=ДОП и при наличии ОКЕИ_Тов</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:decimal">
															<xs:totalDigits value="26"/>
															<xs:fractionDigits value="11"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ЦенаТов" use="optional">
													<xs:annotation>
														<xs:documentation>Цена (тариф) за единицу измерения (графа 4 счета-фактуры)</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:decimal">
															<xs:totalDigits value="26"/>
															<xs:fractionDigits value="11"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="СтТовБезНДС" use="optional">
													<xs:annotation>
														<xs:documentation>Стоимость товаров (работ, услуг), имущественных прав без налога - всего (графа 5 счета-фактуры)</xs:documentation>
														<xs:documentation>
														Обязателен для Функция=СЧФ или Функция=СЧФДОП, кроме случаев, когда отсутствие числового значения предусмотрено Правилами заполнения счета-фактуры, применяемого при расчетах по налогу на добавленную стоимость, утвержденными Постановлением № 1137</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:decimal">
															<xs:totalDigits value="19"/>
															<xs:fractionDigits value="2"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="НалСт" use="required">
													<xs:annotation>
														<xs:documentation>Налоговая ставка (графа 7 счета-фактуры)</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:maxLength value="7"/>
															<xs:minLength value="1"/>
															<xs:enumeration value="0%"/>
															<xs:enumeration value="10%"/>
															<xs:enumeration value="18%"/>
															<xs:enumeration value="10/110"/>
															<xs:enumeration value="18/118"/>
															<xs:enumeration value="без НДС"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="СтТовУчНал" use="required">
													<xs:annotation>
														<xs:documentation>Стоимость товаров (работ, услуг), имущественных прав с налогом - всего (графа 9 счета-фактуры)</xs:documentation>
													</xs:annotation>
								') || to_clob('					<xs:simpleType>
														<xs:restriction base="xs:decimal">
															<xs:totalDigits value="19"/>
															<xs:fractionDigits value="2"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
										<xs:element name="ВсегоОпл">
											<xs:annotation>
												<xs:documentation>Реквизиты строки «Всего к оплате»</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="СумНалВсего" type="СумНДСТип">
														<xs:annotation>
															<xs:documentation>Всего к оплате, Сумма налога, предъявляемая покупателю (строка «Всего к оплате»/графа 8 счета-фактуры)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="НеттоВс" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Количество (масса нетто) - всего по документу</xs:documentation>
															<xs:documentation>Дополнительно к строке Всего к оплате</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:totalDigits value="26"/>
																<xs:fractionDigits value="11"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
												<xs:attribute name="СтТовБезНДСВсего" use="optional">
													<xs:annotation>
														<xs:documentation>Всего к оплате, Стоимость товаров (работ, услуг), имущественных прав без налога - всего (строка «Всего к оплате»/графа 5 счета-фактуры)</xs:documentation>
														<xs:documentation>
														Обязателен для Функция=СЧФ или Функция=СЧФДОП, кроме случаев, когда отсутствие числового значения предусмотрено Правилами заполнения счета-фактуры, применяемого при расчетах по налогу на добавленную стоимость, утвержденными Постановлением № 1137</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:decimal">
															<xs:totalDigits value="19"/>
															<xs:fractionDigits value="2"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="СтТовУчНалВсего" use="required">
													<xs:annotation>
														<xs:documentation>Всего к оплате, Стоимость товаров (работ, услуг), имущественных прав с налогом - всего (строка «Всего к оплате»/графа 9 счета-фактуры)</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:decimal">
															<xs:totalDigits value="19"/>
															<xs:fractionDigits value="2"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="СвПродПер" minOccurs="0">
								<xs:annotation>
									<xs:documentation>Содержание факта хозяйственной жизни 3 – сведения о факте отгрузки  товаров (выполнения  работ), передачи имущественных прав (о предъявлении оказанных услуг) </xs:documentation>
									<xs:documentation>Обязателен при Функция=СЧФДОП или Функция=ДОП</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="СвПер">
											<xs:annotation>
												<xs:documentation>Сведения о передаче (сдаче) товаров, (результатов работ), имущественных прав (о предъявлении оказанных услуг)</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ОснПер" maxOccurs="unbounded">
														<xs:annotation>
															<xs:documentation>Основание отгрузки товаров (передачи результатов работ), передачи  имущественных прав (предъявления оказанных услуг)</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:attribute name="НаимОсн" use="required">
																<xs:annotation>
																	<xs:documentation>Наименование документа - основания</xs:documentation>
																	<xs:documentation>При отсутствии указывается: Отсутствует</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="1"/>
																		<xs:maxLength value="255"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="НомОсн" use="optional">
																<xs:annotation>
																	<xs:documentation>Номер документа - основания</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="1"/>
																		<xs:maxLength value="255"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
															<xs:attribute name="ДатаОсн" type="ДатаТип" use="optional">
																<xs:annotation>
																	<xs:documentation>Дата документа - основания</xs:documentation>
																	<xs:documentation>Обязателен при НаимОсн, отличном от значения «Отсутствует»</xs:documentation>
																</xs:annotation>
															</xs:attribute>
															<xs:attribute name="ДопСвОсн" use="optional">
																<xs:annotation>
																	<xs:documentation>Дополнительные сведения</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="0"/>
																		<xs:maxLength value="1000"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
														</xs:complexType>
													</xs:element>
													<xs:element name="СвЛицПер" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Сведения о лице, передавшем товар (груз) </xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:choice>
																<xs:element name="РабОргПрод">
																	<xs:annotation>
																		<xs:documentation>Работник организации продавца</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="ФИО" type="ФИОТип">
																				<xs:annotation>
																					<xs:documentation>Фамилия, имя, отчество</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																		</xs:sequence>
																		<xs:attribute name="Должность" use="required">
																			<xs:annotation>
																				<xs:documentation>Должность</xs:documentation>
																			</xs:annotation>
																			<xs:simpleType>
																				<xs:restriction base="xs:string">
																					<xs:minLength value="1"/>
																					<xs:maxLength value="128"/>
																				</xs:restriction>
																			</xs:simpleType>
																		</xs:attribute>
																		<xs:attribute name="ИныеСвед" use="optional">
																			<xs:annotation>
																				<xs:documentation>Иные сведения, идентифицирующие физическое лицо</xs:documentation>
																			</xs:annotation>
																			<xs:simpleType>
																				<xs:restriction base="xs:string">
																					<xs:minLength value="1"/>
																					<xs:maxLength value="255"/>
																				</xs:restriction>
																			</xs:simpleType>
																		</xs:attribute>
																		<xs:attribute name="ОснПолн" use="optional">
																			<xs:annotation>
																				<xs:documentation>Основание полномочий (доверия)</xs:documentation>
																				<xs:documentation>Значение по умолчанию «Должностные обязанности» или указываются иные основания полномочий</xs:documentation>
																			</xs:annotation>
																			<xs:simpleType>
																				<xs:restriction base="xs:string">
																					<xs:minLength value="1"/>
																					<xs:maxLength value="120"/>
																				</xs:restriction>
																			</xs:simpleType>
																		</xs:attribute>
																	</xs:complexType>
										') || to_clob('						</xs:element>
																<xs:element name="ИнЛицо">
																	<xs:annotation>
																		<xs:documentation>Иное лицо</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:choice>
																			<xs:element name="ПредОргПер">
																				<xs:annotation>
																					<xs:documentation>Представитель организации, которой доверена отгрузка товаров (передача результатов работ), передача имущественных прав (предъявление оказанных услуг)</xs:documentation>
																				</xs:annotation>
																				<xs:complexType>
																					<xs:sequence>
																						<xs:element name="ФИО" type="ФИОТип">
																							<xs:annotation>
																								<xs:documentation>Фамилия, имя, отчество</xs:documentation>
																							</xs:annotation>
																						</xs:element>
																					</xs:sequence>
																					<xs:attribute name="Должность" use="required">
																						<xs:annotation>
																							<xs:documentation>Должность</xs:documentation>
																						</xs:annotation>
																						<xs:simpleType>
																							<xs:restriction base="xs:string">
																								<xs:minLength value="1"/>
																								<xs:maxLength value="128"/>
																							</xs:restriction>
																						</xs:simpleType>
																					</xs:attribute>
																					<xs:attribute name="ИныеСвед" use="optional">
																						<xs:annotation>
																							<xs:documentation>Иные сведения, идентифицирующие физическое лицо</xs:documentation>
																						</xs:annotation>
																						<xs:simpleType>
																							<xs:restriction base="xs:string">
																								<xs:minLength value="1"/>
																								<xs:maxLength value="255"/>
																							</xs:restriction>
																						</xs:simpleType>
																					</xs:attribute>
																					<xs:attribute name="НаимОргПер" use="required">
																						<xs:annotation>
																							<xs:documentation>Наименование организации</xs:documentation>
																						</xs:annotation>
																						<xs:simpleType>
																							<xs:restriction base="xs:string">
																								<xs:minLength value="1"/>
																								<xs:maxLength value="128"/>
																							</xs:restriction>
																						</xs:simpleType>
																					</xs:attribute>
																					<xs:attribute name="ОснДоверОргПер" use="optional">
																						<xs:annotation>
																							<xs:documentation>Основание, по которому организации доверена отгрузка товаров (передача результатов работ), передача имущественных прав (предъявление оказанных услуг)</xs:documentation>
																						</xs:annotation>
																						<xs:simpleType>
																							<xs:restriction base="xs:string">
																								<xs:minLength value="1"/>
																								<xs:maxLength value="120"/>
																							</xs:restriction>
																						</xs:simpleType>
																					</xs:attribute>
																					<xs:attribute name="ОснПолнПредПер" use="optional">
																						<xs:annotation>
																							<xs:documentation>Основание полномочий представителя организации на отгрузку товаров (передачу результатов работ), передачу имущественных прав (предъявление оказанных услуг)</xs:documentation>
																							<xs:documentation>Значение по умолчанию «Должностные обязанности» или указываются иные основания полномочий</xs:documentation>
																						</xs:annotation>
																						<xs:simpleType>
																							<xs:restriction base="xs:string">
																								<xs:minLength value="1"/>
																								<xs:maxLength value="120"/>
																							</xs:restriction>
																						</xs:simpleType>
																					</xs:attribute>
																				</xs:complexType>
																			</xs:element>
																			<xs:element name="ФЛПер">
																				<xs:annotation>
																					<xs:documentation>Физическое лицо, которому доверена отгрузка товаров (передача результатов работ), передача имущественных прав (предъявление оказанных услуг)</xs:documentation>
																				</xs:annotation>
																				<xs:complexType>
																					<xs:sequence>
																						<xs:element name="ФИО" type="ФИОТип">
																							<xs:annotation>
																								<xs:documentation>Фамилия, имя, отчество</xs:documentation>
																							</xs:annotation>
																						</xs:element>
																					</xs:sequence>
																					<xs:attribute name="ИныеСвед" use="optional">
																						<xs:annotation>
																							<xs:documentation>Иные сведения, идентифицирующие физическое лицо</xs:documentation>
																						</xs:annotation>
																						<xs:simpleType>
																							<xs:restriction base="xs:string">
																								<xs:minLength value="1"/>
																								<xs:maxLength value="255"/>
																							</xs:restriction>
																						</xs:simpleType>
																					</xs:attribute>
																					<xs:attribute name="ОснДоверФЛ" use="optional">
																						<xs:annotation>
																							<xs:documentation>Основание, по которому физическому лицу доверена отгрузка товаров (передача результатов работ), передача имущественных прав (предъявление оказанных услуг)</xs:documentation>
																						</xs:annotation>
																						<xs:simpleType>
																							<xs:restriction base="xs:string">
																								<xs:minLength value="1"/>
																								<xs:maxLength value="120"/>
																							</xs:restriction>
																						</xs:simpleType>
																					</xs:attribute>
																				</xs:complexType>
																			</xs:element>
																		</xs:choice>
																	</xs:complexType>
																</xs:element>
															</xs:choice>
														</xs:complexType>
													</xs:element>
													<xs:element name="ТранГруз" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Транспортировка и груз</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="ТранНакл" minOccurs="0" maxOccurs="unbounded">
																	<xs:annotation>
																		<xs:documentation>Транспортная накладная</xs:documentation>
																		<xs:documentation>Указывается в случае отгрузки с транспортировкой</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:attribute name="НомТранНакл" use="required">
																			<xs:annotation>
																				<xs:documentation>Номер транспортной накладной</xs:documentation>
																			</xs:annotation>
																			<xs:simpleType>
																				<xs:restriction base="xs:string">
																					<xs:minLength value="1"/>
																					<xs:maxLength value="255"/>
																				</xs:restriction>
																			</xs:simpleType>
																		</xs:attribute>
																		<xs:attribute name="ДатаТранНакл" type="ДатаТип" use="required">
																			<xs:annotation>
																				<xs:documentation>Дата транспортной накладной</xs:documentation>
																			</xs:annotation>
																		</xs:attribute>
																	</xs:complexType>
																</xs:element>
																<xs:element name="Перевозчик" type="УчастникТип" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Перевозчик</xs:documentation>
																		<xs:documentation>Для случаев, если наличие показателя  предусмотрено в установленном порядке</xs:documentation>
																	</xs:annotation>
																</xs:element>
															</xs:sequence>
															<xs:attribute name="СвТранГруз" use="optional">
																<xs:annotation>
																	<xs:documentation>Сведения о транспортировке и грузе</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="1"/>
																		<xs:maxLength value="1000"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
														</xs:complexType>
													</xs:element>
													<xs:element name="СвПерВещи" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Сведения о передаче вещи, изготовленной  по договору подряда</xs:documentation>
															<xs:documentation>Реквизиты используются для указания информации о передаче вещи, изготовленной  по договору подряда, в случае ее передачи в другое время и (или) лицу, отличному от ответственного за оформление хозяйственной операции</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:attribute name="ДатаПерВещ" type="ДатаТип" use="optional">
																<xs:annotation>
																	<xs:documentation>Дата передачи вещи, изготовленной  по договору</xs:documentation>
																</xs:annotation>
															</xs:attribute>
															<xs:attribute name="СвПерВещ" use="optional">
																<xs:annotation>
																	<xs:documentation>Сведения о передаче</xs:documentation>
																</xs:annotation>
																<xs:simpleType>
																	<xs:restriction base="xs:string">
																		<xs:minLength value="1"/>
																		<xs:maxLength value="1000"/>
																	</xs:restriction>
																</xs:simpleType>
															</xs:attribute>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
												<xs:attribute name="СодОпер" use="required">
											') || to_clob('		<xs:annotation>
														<xs:documentation>Содержание операции</xs:documentation>
														<xs:documentation>Содержание действий.
Указывается, например, «Товары переданы», «Результаты работ сдал», «Услуги оказаны в полном объеме» или другое
</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="255"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ВидОпер" use="optional">
													<xs:annotation>
														<xs:documentation>Вид операции</xs:documentation>
														<xs:documentation>Дополнительная информация, позволяющая в автоматизированном режиме определять необходимый для конкретного случая порядок использования информации документа у продавца</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="255"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ДатаПер" type="ДатаТип" use="optional">
													<xs:annotation>
														<xs:documentation>Дата отгрузки товаров (передачи результатов работ), передачи имущественных прав (предъявления оказанных услуг)</xs:documentation>
														<xs:documentation>
											Дата в формате ДД.ММ.ГГГГ.
											Обязателен, если ДатаПер отлична от ДатаСчФ</xs:documentation>
													</xs:annotation>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
										<xs:element name="ИнфПолФХЖ3" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Информационное поле факта хозяйственной жизни 3</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ТекстИнф" type="ТекстИнфТип" minOccurs="0" maxOccurs="20">
														<xs:annotation>
															<xs:documentation>Текстовая информация</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
												<xs:attribute name="ИдФайлИнфПол" use="optional">
													<xs:annotation>
														<xs:documentation>Идентификатор  файла информационного поля</xs:documentation>
														<xs:documentation>GUID.
														Указывается идентификатор файла, связанного со сведениями данного электронного документа</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:length value="36"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Подписант" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Сведения о лице, подписывающем файл обмена счета-фактуры (информации продавца) в электронной форме</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:choice>
										<xs:element name="ФЛ">
											<xs:annotation>
												<xs:documentation>Физическое лицо</xs:documentation>
												<xs:documentation>Может быть использован кроме случаев, когда законодательством предусмотрено подписание документа индивидуальным предпринимателем или представителем юридического лица</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ФИО" type="ФИОТип">
														<xs:annotation>
															<xs:documentation>Фамилия, Имя, Отчество</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
												<xs:attribute name="ГосРегИПВыдДов" use="optional">
													<xs:annotation>
														<xs:documentation>Реквизиты свидетельства о государственной регистрации  индивидуального предпринимателя, выдавшего доверенность физическому лицу на подписание счета-фактуры</xs:documentation>
														<xs:documentation>Обязателен для подписанта счета-фактуры в случае выставления счета-фактуры индивидуальным предпринимателем, когда счет-фактура подписывается физическим лицом (в том числе индивидуальным предпринимателем), уполномоченным доверенностью от имени индивидуального предпринимателя</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:maxLength value="100"/>
															<xs:minLength value="1"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ИННФЛ" type="ИННФЛТип" use="optional">
													<xs:annotation>
														<xs:documentation>ИНН физического лица</xs:documentation>
														<xs:documentation>Обязателен для подписанта при наличии в сертификате ключа проверки электронной подписи</xs:documentation>
													</xs:annotation>
												</xs:attribute>
												<xs:attribute name="ИныеСвед" use="optional">
													<xs:annotation>
														<xs:documentation>Иные сведения, идентифицирующие физическое лицо</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="255"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
										<xs:element name="ИП" type="СвИПТип">
											<xs:annotation>
												<xs:documentation>Индивидуальный предприниматель</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ЮЛ">
											<xs:annotation>
												<xs:documentation>Представитель юридического лица</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ФИО" type="ФИОТип">
														<xs:annotation>
															<xs:documentation>Фамилия, Имя, Отчество</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
												<xs:attribute name="ГосРегИПВыдДов" use="optional">
													<xs:annotation>
														<xs:documentation>Реквизиты свидетельства о государственной регистрации  индивидуального предпринимателя, выдавшего доверенность организации на подписание счета-фактуры</xs:documentation>
														<xs:documentation>Обязателен для подписанта счета-фактуры в случае выставления счета-фактуры индивидуальным предпринимателем, когда счет-фактура подписывается работником организации, уполномоченной доверенностью от имени индивидуального предпринимателя</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:maxLength value="100"/>
															<xs:minLength value="1"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ИННЮЛ" type="ИННЮЛТип" use="required">
													<xs:annotation>
														<xs:documentation>ИНН юридического лица</xs:documentation>
													</xs:annotation>
												</xs:attribute>
												<xs:attribute name="НаимОрг" use="optional">
													<xs:annotation>
														<xs:documentation>Наименование</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="1000"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="Должн" use="required">
													<xs:annotation>
														<xs:documentation>Должность</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:maxLength value="128"/>
															<xs:minLength value="0"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
												<xs:attribute name="ИныеСвед" use="optional">
													<xs:annotation>
														<xs:documentation>Иные сведения, идентифицирующие физическое лицо</xs:documentation>
													</xs:annotation>
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xs:minLength value="1"/>
															<xs:maxLength value="255"/>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
									</xs:choice>
									<xs:attribute name="ОблПолн" use="required">
										<xs:annotation>
											<xs:documentation>Область полномочий</xs:documentation>
											<xs:documentation>, где:
0 - лицо, ответственное за подписание счетов-фактур;
1 - лицо, совершившее сделку, операцию;
2 – лицо, совершившее сделку, операцию и ответственное за ее оформление;
3 – лицо, ответственное за оформление свершившегося события;
4 - лицо, совершившее сделку, операцию и ответственное за подписание счетов-фактур;
5 - лицо, совершившее сделку, операцию и ответственное за ее оформление и за подписание счетов-фактур;
6 - лицо, ответственное за оформление свершившегося события и за подписание счетов-фактур</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:length value="1"/>
												<xs:enumeration value="0"/>
												<xs:enumeration value="1"/>
												<xs:enumeration value="2"/>
												<xs:enumeration value="3"/>
												<xs:enumeration value="4"/>
												<xs:enumeration value="5"/>
												<xs:enumeration value="6"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Статус" use="required">
										<xs:annotation>
											<xs:documentation>Статус</xs:documentation>
											<xs:documentation>, где:
1 - работник организации продавца товаров (работ, услуг, имущественных прав);
2 - работник организации - составителя информации продавца;
3 - работник иной уполномоченной организации;
4 - уполномоченное физическое лицо (в том числе индивидуальный предприниматель)</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:length value="1"/>
												<xs:enumeration value="1"/>
												<xs:enumeration value="2"/>
												<xs:enumeration value="3"/>
												<xs:enumeration value="4"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="ОснПолн" use="required">
										<xs:annotation>
											<xs:documentation>Основание полномочий (доверия)</xs:documentation>
											<xs:documentation>Для (Статус=1 или Статус=2 или Статус=3) указываются «Должностные обязанности» по умолчанию или иные основания полномочий (доверия).
											Для Статус=4 указываются основания полномочий (доверия)</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="255"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="ОснПолнОрг" use="optional">
										<xs:annotation>
											<xs:documentation>Основание полномочий (доверия) организации</xs:documentation>
											<xs:documentation>Обязателен для Статус=3. Указываются основания полномочий (доверия) организации</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="255"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="КНД" use="required">
							<xs:annotation>
								<xs:documentation>Код документа  по КНД</xs:documentation>
								<xs:documentation>
								Код по Классификатору налоговой документации (КНД)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="КНДТип">
									<xs:enumeration value="1115125"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="Функция" use="required">
							<xs:annotation>
								<xs:documentation>Функция</xs:documentation>
				') || to_clob ('				<xs:documentation>, где:
								СЧФ - счет-фактура, применяемый при расчетах по налогу на добавленную стоимость;
СЧФДОП - счет-фактура, применяемый при расчетах по налогу на добавленную стоимость, и документ об отгрузке товаров (выполнении работ), передаче имущественных прав (документ об оказании услуг);
ДОП - документ об отгрузке товаров (выполнении работ), передаче имущественных прав (документ об оказании услуг).
Под отгрузкой товаров понимается в том числе  передача (поставка, отпуск) товара (груза)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="3"/>
									<xs:maxLength value="6"/>
									<xs:enumeration value="СЧФ"/>
									<xs:enumeration value="СЧФДОП"/>
									<xs:enumeration value="ДОП"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="ПоФактХЖ" use="optional">
							<xs:annotation>
								<xs:documentation>Наименование документа по факту хозяйственной жизни</xs:documentation>
								<xs:documentation>При Функция=СЧФ не формируется.
При Функция=СЧФДОП или Функция=ДОП ПоФактХЖ= Документ об отгрузке товаров (выполнении работ), передаче имущественных прав (документ об оказании услуг)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="255"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="НаимДокОпр" use="optional">
							<xs:annotation>
								<xs:documentation>Наименование первичного документа, определенное организацией (согласованное сторонами сделки)</xs:documentation>
								<xs:documentation>При Функция=СЧФ не формируется.
При Функция=СЧФДОП принимает значение «Счет-фактура и документ об отгрузке товаров (выполнении работ), передаче имущественных прав (документ об оказании услуг)». При Функция=ДОП самостоятельно установленное наименование документа или «Документ об отгрузке товаров (выполнении работ), передаче имущественных прав (Документ об оказании услуг)» (по умолчанию)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="255"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="ДатаИнфПр" type="ДатаТип" use="required">
							<xs:annotation>
								<xs:documentation>Дата формирования файла обмена счета-фактуры (информации продавца)</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="ВремИнфПр" type="ВремяТип" use="required">
							<xs:annotation>
								<xs:documentation>Время формирования файла обмена счета-фактуры (информации продавца)</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="НаимЭконСубСост" use="required">
							<xs:annotation>
								<xs:documentation>Наименование экономического субъекта – составителя файла обмена счета-фактуры (информации продавца)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="1000"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="ОснДоверОргСост" use="optional">
							<xs:annotation>
								<xs:documentation>Основание, по которому экономический субъект является составителем файла обмена счета-фактуры (информации продавца)</xs:documentation>
								<xs:documentation>Обязателен, если составитель информации продавца не является продавцом</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="120"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
			<xs:attribute name="ИдФайл" use="required">
				<xs:annotation>
					<xs:documentation>Идентификатор файла</xs:documentation>
					<xs:documentation>Содержит (повторяет) имя сформированного файла (без расширения)</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="200"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="ВерсФорм" use="required">
				<xs:annotation>
					<xs:documentation>Версия формата</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="5"/>
						<xs:enumeration value="5.01"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="ВерсПрог" use="optional">
				<xs:annotation>
					<xs:documentation>Версия передающей программы</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:maxLength value="40"/>
						<xs:minLength value="1"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
		</xs:complexType>
	</xs:element>
	<xs:complexType name="АдресТип">
		<xs:annotation>
			<xs:documentation>Сведения об адресе</xs:documentation>
		</xs:annotation>
		<xs:choice>
			<xs:element name="АдрРФ" type="АдрРФТип">
				<xs:annotation>
					<xs:documentation>Адрес местонахождения/почтовый адрес (реквизиты адреса на территории Российской Федерации)</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="АдрИнф" type="АдрИнфТип">
				<xs:annotation>
					<xs:documentation>Адрес местонахождения/почтовый адрес (информация об адресе, в том числе об адресе за пределами территории Российской Федерации)</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="КодГАР" type="string-36">
				<xs:annotation>
					<xs:documentation>Уникальный номер адреса объекта адресации в государственном адресном реестре</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:choice>
	</xs:complexType>
	<xs:complexType name="АдрИнфТип">
		<xs:annotation>
			<xs:documentation>Информация об адресе, в том числе об адресе за пределами территории Российской Федерации</xs:documentation>
		</xs:annotation>
		<xs:attribute name="КодСтр" type="ОКСМТип" use="required">
			<xs:annotation>
				<xs:documentation>Код страны</xs:documentation>
			</xs:annotation>
		</xs:attribute>
		<xs:attribute name="АдрТекст" use="required">
			<xs:annotation>
				<xs:documentation>Адрес</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="255"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
	</xs:complexType>
	<xs:complexType name="АдрРФТип">
		<xs:annotation>
			<xs:documentation>Адрес в Российской Федерации </xs:documentation>
		</xs:annotation>
		<xs:attribute name="Индекс" use="optional">
			<xs:annotation>
				<xs:documentation>Индекс</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:length value="6"/>
					<xs:pattern value="[0-9]{6}"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="КодРегион" use="required">
			<xs:annotation>
				<xs:documentation>Код региона</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="CCРФТип"/>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Район" use="optional">
			<xs:annotation>
				<xs:documentation>Район</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="50"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Город" use="optional">
			<xs:annotation>
				<xs:documentation>Город</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:maxLength value="50"/>
					<xs:minLength value="1"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="НаселПункт" use="optional">
			<xs:annotation>
				<xs:documentation>Населенный пункт</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="50"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Улица" use="optional">
			<xs:annotation>
				<xs:documentation>Улица</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="50"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Дом" use="optional">
			<xs:annotation>
				<xs:documentation>Дом</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="20"/>
				</xs:restriction>
		') || to_clob('	</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Корпус" use="optional">
			<xs:annotation>
				<xs:documentation>Корпус</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="20"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Кварт" use="optional">
			<xs:annotation>
				<xs:documentation>Квартира</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="20"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
	</xs:complexType>
	<xs:complexType name="КонтактТип">
		<xs:annotation>
			<xs:documentation>Контактные данные</xs:documentation>
		</xs:annotation>
		<xs:attribute name="Тлф" use="optional">
			<xs:annotation>
				<xs:documentation>Номер контактного телефона/факс</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="255"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="ЭлПочта" use="optional">
			<xs:annotation>
				<xs:documentation>Адрес электронной почты</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="255"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
	</xs:complexType>
	<xs:complexType name="СумАкцизТип">
		<xs:annotation>
			<xs:documentation>Сумма акциза</xs:documentation>
		</xs:annotation>
		<xs:choice>
			<xs:element name="СумАкциз">
				<xs:annotation>
					<xs:documentation>Сумма акциза</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:decimal">
						<xs:totalDigits value="19"/>
						<xs:fractionDigits value="2"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:element>
			<xs:element name="БезАкциз">
				<xs:annotation>
					<xs:documentation>Без акциза</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:length value="10"/>
						<xs:enumeration value="без акциза"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:element>
		</xs:choice>
	</xs:complexType>
	<xs:complexType name="СвИПТип">
		<xs:annotation>
			<xs:documentation>Сведения об индивидуальном предпринимателе</xs:documentation>
		</xs:annotation>
		<xs:sequence>
			<xs:element name="ФИО" type="ФИОТип">
				<xs:annotation>
					<xs:documentation>Фамилия, Имя, Отчество</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
		<xs:attribute name="ИННФЛ" type="ИННФЛТип" use="required">
			<xs:annotation>
				<xs:documentation>ИНН</xs:documentation>
			</xs:annotation>
		</xs:attribute>
		<xs:attribute name="СвГосРегИП" use="optional">
			<xs:annotation>
				<xs:documentation>Реквизиты свидетельства о государственной регистрации индивидуального предпринимателя</xs:documentation>
				<xs:documentation>Обязателен для случаев подписания счета-фактуры непосредственно продавцом</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:maxLength value="100"/>
					<xs:minLength value="1"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="ИныеСвед" use="optional">
			<xs:annotation>
				<xs:documentation>Иные сведения, идентифицирующие физическое лицо</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="255"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
	</xs:complexType>
	<xs:complexType name="СумНДСТип">
		<xs:annotation>
			<xs:documentation>Сумма НДС</xs:documentation>
		</xs:annotation>
		<xs:choice>
			<xs:element name="СумНал">
				<xs:annotation>
					<xs:documentation>Значение</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:decimal">
						<xs:totalDigits value="19"/>
						<xs:fractionDigits value="2"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:element>
			<xs:element name="БезНДС">
				<xs:annotation>
					<xs:documentation>Без НДС</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:maxLength value="18"/>
						<xs:minLength value="1"/>
						<xs:enumeration value="без НДС"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:element>
		</xs:choice>
	</xs:complexType>
	<xs:complexType name="ТекстИнфТип">
		<xs:annotation>
			<xs:documentation>Текстовая информация</xs:documentation>
		</xs:annotation>
		<xs:attribute name="Идентиф" use="required">
			<xs:annotation>
				<xs:documentation>Идентификатор</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="50"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Значен" use="required">
			<xs:annotation>
				<xs:documentation>Значение</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="2000"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
	</xs:complexType>
	<xs:complexType name="УчастникТип">
		<xs:annotation>
			<xs:documentation>Сведения об участнике факта хозяйственной жизни</xs:documentation>
		</xs:annotation>
		<xs:sequence>
			<xs:element name="ИдСв">
				<xs:annotation>
					<xs:documentation>Идентификационные сведения</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:choice>
						<xs:element name="СвИП" type="СвИПТип">
							<xs:annotation>
								<xs:documentation>Сведения об индивидуальном предпринимателе</xs:documentation>
							</xs:annotation>
						</xs:element>
						<xs:element name="СвЮЛУч">
							<xs:annotation>
								<xs:documentation>Сведения о юридическом лице, состоящем на учете в налоговых органах</xs:documentation>
							</xs:annotation>
							<xs:complexType>
								<xs:attribute name="НаимОрг" use="required">
									<xs:annotation>
										<xs:documentation>Наименование полное</xs:documentation>
									</xs:annotation>
									<xs:simpleType>
										<xs:restriction base="xs:string">
											<xs:minLength value="1"/>
											<xs:maxLength value="1000"/>
										</xs:restriction>
									</xs:simpleType>
								</xs:attribute>
								<xs:attribute name="ИННЮЛ" type="ИННЮЛТип" use="required">
									<xs:annotation>
										<xs:documentation>ИНН</xs:documentation>
									</xs:annotation>
								</xs:attribute>
								<xs:attribute name="КПП" type="КППТип" use="optional">
									<xs:annotation>
										<xs:documentation>КПП</xs:documentation>
									</xs:annotation>
								</xs:attribute>
							</xs:complexType>
						</xs:element>
						<xs:element name="СвИнНеУч">
							<xs:annotation>
								<xs:documentation>Сведения об иностранном лице, не состоящем на учете в налоговых органах</xs:documentation>
							</xs:annotation>
							<xs:complexType>
								<xs:attribute name="НаимОрг" use="required">
									<xs:annotation>
										<xs:documentation>Наименование полное</xs:documentation>
									</xs:annotation>
									<xs:simpleType>
										<xs:restriction base="xs:string">
											<xs:minLength value="1"/>
											<xs:maxLength value="1000"/>
										</xs:restriction>
									</xs:simpleType>
								</xs:attribute>
								<xs:attribute name="ИныеСвед" use="optional">
									<xs:annotation>
										<xs:documentation>Иные сведения, идентифицирующие юридическое лицо</xs:documentation>
										<xs:documentation>В частности, может быть указана страна при отсутствии КодСтр</xs:documentation>
									</xs:annotation>
									<xs:simpleType>
										<xs:restriction base="xs:string">
											<xs:minLength value="1"/>
											<xs:maxLength value="255"/>
										</xs:restriction>
									</xs:simpleType>
								</xs:attribute>
							</xs:complexType>
						</xs:element>
					</xs:choice>
				</xs:complexType>
			</xs:element>
			<xs:element name="Адрес" type="АдресТип" minOccurs="0">
				<xs:annotation>
					<xs:documentation>Адрес</xs:documentation>
					<xs:documentation>Обязателен для Функция=СЧФ и Функция=СЧФДОП</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="Контакт" type="КонтактТип" minOccurs="0">
				<xs:annotation>
					<xs:documentation>Контактные сведения</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="БанкРекв" minOccurs="0">
				<xs:annotation>
					<xs:documentation>Банковские реквизиты</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:sequence>
						<xs:element name="СвБанк" minOccurs="0">
							<xs:annotation>
								<xs:documentation>Сведения о банке</xs:documentation>
							</xs:annotation>
							<xs:complexType>
								<xs:attribute name="НаимБанк" use="optional">
									<xs:annotation>
				') || to_clob('						<xs:documentation>Наименование банка</xs:documentation>
									</xs:annotation>
									<xs:simpleType>
										<xs:restriction base="xs:string">
											<xs:minLength value="1"/>
											<xs:maxLength value="1000"/>
										</xs:restriction>
									</xs:simpleType>
								</xs:attribute>
								<xs:attribute name="БИК" type="БИКТип" use="optional">
									<xs:annotation>
										<xs:documentation>Банковский идентификационный код (БИК) в соответствии со «Справочником БИК РФ»</xs:documentation>
									</xs:annotation>
								</xs:attribute>
								<xs:attribute name="КорСчет" use="optional">
									<xs:annotation>
										<xs:documentation>Корреспондентский счет банка</xs:documentation>
									</xs:annotation>
									<xs:simpleType>
										<xs:restriction base="xs:string">
											<xs:minLength value="1"/>
											<xs:maxLength value="20"/>
										</xs:restriction>
									</xs:simpleType>
								</xs:attribute>
							</xs:complexType>
						</xs:element>
					</xs:sequence>
					<xs:attribute name="НомерСчета" use="optional">
						<xs:annotation>
							<xs:documentation>Номер банковского счета</xs:documentation>
						</xs:annotation>
						<xs:simpleType>
							<xs:restriction base="xs:string">
								<xs:minLength value="1"/>
								<xs:maxLength value="20"/>
							</xs:restriction>
						</xs:simpleType>
					</xs:attribute>
				</xs:complexType>
			</xs:element>
		</xs:sequence>
		<xs:attribute name="ОКПО" use="optional">
			<xs:annotation>
				<xs:documentation>Код в общероссийском классификаторе предприятий и организаций</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="10"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="СтруктПодр" use="optional">
			<xs:annotation>
				<xs:documentation>Структурное подразделение</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="1000"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="ИнфДляУчаст" use="optional">
			<xs:annotation>
				<xs:documentation>Информация для участника документооборота</xs:documentation>
				<xs:documentation>Информация, позволяющая получающему документ участнику документооборота обеспечить его автоматизированную  обработку</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="255"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
	</xs:complexType>
	<xs:complexType name="ФИОТип">
		<xs:annotation>
			<xs:documentation>Фамилия, имя, отчество физического лица</xs:documentation>
		</xs:annotation>
		<xs:attribute name="Фамилия" use="required">
			<xs:annotation>
				<xs:documentation>Фамилия</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="60"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Имя" use="required">
			<xs:annotation>
				<xs:documentation>Имя</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="60"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
		<xs:attribute name="Отчество" use="optional">
			<xs:annotation>
				<xs:documentation>Отчество</xs:documentation>
			</xs:annotation>
			<xs:simpleType>
				<xs:restriction base="xs:string">
					<xs:minLength value="1"/>
					<xs:maxLength value="60"/>
				</xs:restriction>
			</xs:simpleType>
		</xs:attribute>
	</xs:complexType>
	<xs:simpleType name="ВремяТип">
		<xs:annotation>
			<xs:documentation>Время в формате ЧЧ.ММ.СС</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="8"/>
			<xs:pattern value="([0-1]{1}[0-9]{1}|2[0-3]{1})\.([0-5]{1}[0-9]{1})\.([0-5]{1}[0-9]{1})"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="БИКТип">
		<xs:annotation>
			<xs:documentation>БИК банка</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="9"/>
			<xs:pattern value="[0-9]{9}"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="ДатаТип">
		<xs:annotation>
			<xs:documentation>Дата в формате ДД.ММ.ГГГГ (01.01.1900 - 31.12.2099)</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="10"/>
			<xs:pattern value="((((0[1-9]{1}|1[0-9]{1}|2[0-8]{1})\.(0[1-9]{1}|1[0-2]{1}))|((29|30)\.(01|0[3-9]{1}|1[0-2]{1}))|(31\.(01|03|05|07|08|10|12)))\.((19|20)[0-9]{2}))|(29\.02\.((19|20)(((0|2|4|6|8)(0|4|8))|((1|3|5|7|9)(2|6)))))"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="ИННФЛТип">
		<xs:annotation>
			<xs:documentation>Идентификационный номер налогоплательщика - физического лица</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="12"/>
			<xs:pattern value="([0-9]{1}[1-9]{1}|[1-9]{1}[0-9]{1})[0-9]{10}"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="ИННЮЛТип">
		<xs:annotation>
			<xs:documentation>Идентификационный номер налогоплательщика - юридического лица</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="10"/>
			<xs:pattern value="([0-9]{1}[1-9]{1}|[1-9]{1}[0-9]{1})[0-9]{8}"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="КНДТип">
		<xs:annotation>
			<xs:documentation>Код из Классификатора налоговой документации</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="7"/>
			<xs:pattern value="[0-9]{7}"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="КППТип">
		<xs:annotation>
			<xs:documentation>Код причины постановки на учет (КПП) - 5 и 6 знаки от 0-9 и A-Z</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="9"/>
			<xs:pattern value="([0-9]{1}[1-9]{1}|[1-9]{1}[0-9]{1})([0-9]{2})([0-9A-Z]{2})([0-9]{3})"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="CCРФТип">
		<xs:annotation>
			<xs:documentation>Код из Справочника субъекта Российской Федерации </xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="2"/>
			<xs:pattern value="[0-9]{2}"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="ОКСМТип">
		<xs:annotation>
			<xs:documentation>Код из Общероссийского классификатора стран мира</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="3"/>
			<xs:pattern value="[0-9]{3}"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="ОКВТип">
		<xs:annotation>
			<xs:documentation>Код из Общероссийского классификатора валют</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:length value="3"/>
			<xs:pattern value="[0-9]{3}"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="ОКЕИТип">
		<xs:annotation>
			<xs:documentation>Код из Общероссийского классификатора единиц измерения</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:minLength value="3"/>
			<xs:maxLength value="4"/>
			<xs:pattern value="[0-9]{3}"/>
			<xs:pattern value="[0-9]{4}"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="string-36">
		<xs:annotation>
			<xs:documentation>Произвольный текст длиной от 1 до 36 символов</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:maxLength value="36"/>
			<xs:minLength value="1"/>
		</xs:restriction>
	</xs:simpleType>
</xs:schema>
');
select count(*)
into urlexists
from user_xml_schemas
where schema_url = 'schema_XSD';
if urlexists=1 then
	begin
DBMS_XMLSCHEMA.deleteschema('schema_XSD',DBMS_XMLSCHEMA.DELETE_CASCADE_FORCE);
end;
end if;
DBMS_XMLSCHEMA.registerSchema('schema_XSD',xsd_schema,genTypes => false,genTables => false);
END;


PROCEDURE ValidateXML(Name_XSD in VARCHAR2, File_XML in CLOB) is

l_xml xmltype;
v_errm varchar2(200);

begin
l_xml:= xmltype(File_XML, Name_XSD);
l_xml.schemavalidate;
DBMS_OUTPUT.PUT_LINE('Успешно прошла валидация по схеме.');
EXCEPTION  -- exception handlers begin
-- Only one of the WHEN blocks is executed.

   WHEN OTHERS THEN  -- handles all other errors
      DBMS_OUTPUT.PUT_LINE('Ошибка: XML сообщение не валидно.');

v_errm := SUBSTR(SQLERRM, 1 , 200);
DBMS_OUTPUT.PUT_LINE('Error code ' || ': ' || v_errm);
end;


End Register_Validate;

show errors;