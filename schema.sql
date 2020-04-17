-- TODO if exists не завезли, нужно писать какие-то процедуры, если триггеров и последовательностей нет
-- УДАЛЕНИЕ ТРИГГЕРОВ
DROP TRIGGER  PARTICIPANTS_ID_BIR;
DROP TRIGGER SIGNERS_ID_BIR;
DROP TRIGGER VALIDATE_DATA_BEFORE_INSERT;
DROP TRIGGER UTD_ID_BIR;
DROP TRIGGER UTD_LINES_ID_BIR;
/
--
-- УДАЛЕНИЕ ПОСЛЕДОВАТЕЛЬНОСТЕЙ
DROP SEQUENCE XMLD_PARTICIPANTS_ID_SEQ;
DROP SEQUENCE XMLD_SIGNERS_ID_SEQ;
DROP SEQUENCE XMLD_SIGNERS_HOLDER_ID_SEQ;
DROP SEQUENCE XMLD_UTD_PAYMENT_DOC_ID_SEQ;
DROP SEQUENCE XMLD_BUFFER_XML_FILES_ID_SEQ;
DROP SEQUENCE XMLD_UTD_LINES_ID_SEQ;
DROP SEQUENCE XMLD_UTD_ID_SEQ;
/
--
-- УДАЛЕНИЕ ТАБЛИЦ
DROP TABLE XMLD_SIGNERS CASCADE CONSTRAINTS;
DROP TABLE XMLD_PARTICIPANTS CASCADE CONSTRAINTS;
DROP TABLE XMLD_UTD_HEADERS CASCADE CONSTRAINTS;
DROP TABLE XMLD_BUFFER_XML_FILES CASCADE CONSTRAINTS;
DROP TABLE XMLD_UTD_LINES CASCADE CONSTRAINTS;
/
--ТАБЛИЦА УЧАСТНИКОВ
CREATE TABLE XMLD_PARTICIPANTS
(
    PARTICIPANT_ID               NUMBER              NOT NULL,
    CONSTRAINT PARTICIPANT_ID_PK PRIMARY KEY (PARTICIPANT_ID),
    PARTICIPANT_TYPE             VARCHAR2(100 CHAR)  NOT NULL,
    CODE_IN_CLASSIFIER           VARCHAR2(10 CHAR),
    STRUCTURAL_SUBDIVISION       VARCHAR2(1000 CHAR),
    INFO_FOR_PARTICIPANTS        VARCHAR2(255 CHAR),
    INN_OF_INDIV                 VARCHAR2(12 CHAR),
    CONSTRAINT INN_OF_INDIV_REGEXP CHECK (REGEXP_LIKE(INN_OF_INDIV, '([0-9][1-9]|[1-9][0-9])[0-9]{10}')),
    OTHER_INF_ABOUT_INDIV        VARCHAR2(255 CHAR),
    FIRST_NAME                   VARCHAR2(60 CHAR)   NOT NULL,
    SECOND_NAME                  VARCHAR2(60 CHAR)   NOT NULL,
    THIRD_NAME                   VARCHAR2(60 CHAR)   NOT NULL,
    NAME_OF_ORG                  VARCHAR2(1000 CHAR) NOT NULL,
    INN_OF_ENTREPRENEUR          VARCHAR2(12 CHAR),
    CONSTRAINT INN_OF_ENTREPRENEUR_REGEXP CHECK (REGEXP_LIKE(INN_OF_INDIV,
                                                             '([0-9][1-9]|[1-9][0-9])[0-9]{8}')),
    REASON_OF_REG                VARCHAR2(9 CHAR),
    CONSTRAINT REASON_OF_REG_REGEXP CHECK (REGEXP_LIKE(REASON_OF_REG,
                                                       '([0-9][1-9]|[1-9][0-9])([0-9]{2})([0-9A-Z]{2})([0-9]{3})')),
    IND                          VARCHAR2(6 CHAR),
    CONSTRAINT IND_REGEXP CHECK (REGEXP_LIKE(IND, '[0-9]{6}')),
    REGION_CODE                  VARCHAR2(2 CHAR),
    CONSTRAINT REGION_CODE_REGEXP CHECK (REGEXP_LIKE(REGION_CODE, '[0-9]{2}')),
    AREA                         VARCHAR2(50 CHAR),
    CITY                         VARCHAR2(50 CHAR),
    LOCALITY                     VARCHAR2(50 CHAR),
    STREET                       VARCHAR2(50 CHAR),
    HOUSE                        VARCHAR2(20 CHAR),
    HOUSING                      VARCHAR2(20 CHAR),
    FLAT                         VARCHAR2(20 CHAR),
    COUNTRY_CODE                 VARCHAR2(255 CHAR),
    ADDRESS                      VARCHAR2(255 CHAR),
    NUMBER_OF_THE_ADDRESS_OBJECT VARCHAR2(34)        NOT NULL,
    PHONE                        VARCHAR2(255 CHAR),
    EMAIL_ADDRESS                VARCHAR2(255 CHAR),
    BANK_ACC_NUMBER              VARCHAR2(20 CHAR),
    BANK_NAME                    VARCHAR2(1000 CHAR),
    BANK_IDENTIFIC_CODE          VARCHAR2(9 CHAR),
    CONSTRAINT BANK_IDENTIFIC_CODE_REGEXP CHECK (REGEXP_LIKE(BANK_IDENTIFIC_CODE, '[0-9]{9}'))
);
/

--ТАБЛИЦА ЗАГОЛОВКОВ ДОКУМЕНТОВ
CREATE TABLE XMLD_UTD_HEADERS
(
    UTD_ID                        NUMBER              NOT NULL,
    CONSTRAINT UTD_ID_PK PRIMARY KEY (UTD_ID),
    ID_OF_SIGNER_SELLER           NUMBER,
    CODE_OF_FORM                  VARCHAR2(7 CHAR)    NOT NULL,
    CONSTRAINT CODE_OF_FORM_CHK CHECK (CODE_OF_FORM = '1115125'),
    TYPE_OF_DOC                   VARCHAR2(6 CHAR)    NOT NULL,
    CONSTRAINT TYPE_OF_DOC_CHK CHECK (UPPER(TYPE_OF_DOC) IN ('СЧФ', 'СЧФДОП', 'ДОП')),
    NAME_OF_THE_DOC_OF_ECON       VARCHAR2(255 CHAR)  NOT NULL,
    NAME_OF_DOC_OF_ORGANIZATION   VARCHAR2(255 CHAR),
    DATE_OF_CR_OF_THE_INVOICE     DATE                NOT NULL,
    TIME_OF_CR_OF_THE_INVOICE     DATE                NOT NULL,
    NAME_OF_THE_ECON_SUB          VARCHAR2(1000 CHAR) NOT NULL,
    FOUND_OF_THE_CREATOR_FILE     VARCHAR2(120 CHAR)  NOT NULL,
    SERIAL_NUMBER_OF_THE_INVOICES VARCHAR2(1000 CHAR) NOT NULL,
    DATE_OF_INVOICING             DATE                NOT NULL,
    CODE_OF_VALUTA                CHAR(3 CHAR)        NOT NULL,
    CONSTRAINT CODE_OF_VALUTA_REGEXP CHECK (REGEXP_LIKE(CODE_OF_VALUTA, '[0-9]{3}')),
    NUMBER_OF_CORRECTION          NUMBER(3, 0)        NOT NULL,
    DATE_OF_CORRECTION            DATE                NOT NULL,
    FILE_SENDER_ID                VARCHAR2(46 CHAR)   NOT NULL,
    CONSTRAINT FILE_SENDER_ID_CHK CHECK (LENGTH(FILE_SENDER_ID) >= 4),
    FILE_RECIPIENT_ID             VARCHAR2(46 CHAR)   NOT NULL,
    CONSTRAINT FILE_RECIPIENT_ID_CHK CHECK (LENGTH(FILE_RECIPIENT_ID) >= 4),
    FILE_ID                       VARCHAR2(200 CHAR)  NOT NULL,
    GOS_CONTR_ID                  VARCHAR2(255 CHAR),
    NAME_OF_VALUTA                VARCHAR2(100 CHAR),
    CURS_OF_VALUTA                NUMBER(10, 4),
    SUM_OF_TAX                    NUMBER(19, 2)       NOT NULL,
    COST_OF_GOODS_WITHOUT_TAX     NUMBER(19, 2)       NOT NULL,
    COST_OF_GOODS_WITH_TAX        NUMBER(19, 2)       NOT NULL,
    SUM_OF_GOODS_WITHOUT_TAX      VARCHAR2(100 CHAR),
    SUM_OF_GOODS_WH_TAX           VARCHAR2(100 CHAR),
    VENDOR_PARTICIPANT_ID         NUMBER              NOT NULL,
    CONSTRAINT VENDOR_PARTICIPANT_ID_FK FOREIGN KEY (VENDOR_PARTICIPANT_ID) REFERENCES XMLD_PARTICIPANTS,
    SHIP_PARTICIPANT_ID           NUMBER              NOT NULL,
    CONSTRAINT SHIP_PARTICIPANT_ID_FK FOREIGN KEY (SHIP_PARTICIPANT_ID) REFERENCES XMLD_PARTICIPANTS,
    CONS_PARTICIPANT_ID           NUMBER              NOT NULL,
    CONSTRAINT CONS_PARTICIPANT_ID_FK FOREIGN KEY (CONS_PARTICIPANT_ID) REFERENCES XMLD_PARTICIPANTS,
    BUYER_PARTICIPANT_ID          NUMBER              NOT NULL,
    CONSTRAINT BUYER_PARTICIPANT_ID_FK FOREIGN KEY (BUYER_PARTICIPANT_ID) REFERENCES XMLD_PARTICIPANTS
);
/
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.UTD_ID IS 'Идентификатор таблицы';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.ID_OF_SIGNER_SELLER IS 'ID на подписантов продавца';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.CODE_OF_FORM IS 'Код формы по Классификатору налоговой документации';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.TYPE_OF_DOC IS 'Тип документа';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.NAME_OF_THE_DOC_OF_ECON IS 'Наименование документа по факту хозяйственной жизни';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.NAME_OF_DOC_OF_ORGANIZATION IS 'Наименование первичного документа, определенное организацией';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.DATE_OF_CR_OF_THE_INVOICE IS 'Дата формирования файла обмена счета-фактуры';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.TIME_OF_CR_OF_THE_INVOICE IS 'Время формирования файла обмена счета-фактуры';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.NAME_OF_THE_ECON_SUB IS 'Наименование экономического субъекта - составителя файла обмена счета-фактуры';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.FOUND_OF_THE_CREATOR_FILE IS 'Основание, по которому экономический субъект является составителем';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.SERIAL_NUMBER_OF_THE_INVOICES IS 'Порядковый номер счета-фактуры';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.DATE_OF_INVOICING IS 'Дата составления счета-фактуры';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.CODE_OF_VALUTA IS 'Код  валюты согласно ОКВ';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.NUMBER_OF_CORRECTION IS 'Номер исправления';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.DATE_OF_CORRECTION IS 'Дата исправления';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.FILE_SENDER_ID IS 'Идентификатор – отправителя файла обмена счета-фактуры';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.FILE_RECIPIENT_ID IS 'Идентификатор – получателя файла обмена счета-фактуры';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.FILE_ID IS 'Идентификатор файла';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.GOS_CONTR_ID IS 'Идентификатор государственного контракта';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.NAME_OF_VALUTA IS 'Наименование валюты согласно (ОКВ)';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.CURS_OF_VALUTA IS 'Курс валюты';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.SUM_OF_TAX IS 'Стоимость товаров, без налога - всего ';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.COST_OF_GOODS_WITHOUT_TAX IS 'Стоимость товаров,с налогом - всего ';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.COST_OF_GOODS_WITH_TAX IS 'Сумма налога, предъявляемая покупателю';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.SUM_OF_GOODS_WITHOUT_TAX IS 'Суммма без НДС';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.SUM_OF_GOODS_WH_TAX IS 'Суммма НДС';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.VENDOR_PARTICIPANT_ID IS 'Идентификатор продавца';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.SHIP_PARTICIPANT_ID IS 'Идентификатор грузоотправителя';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.CONS_PARTICIPANT_ID IS 'Идентификатор грузополучателя';
-- COMMENT ON COLUMN XMLD_UTD_HEADERS.BUYER_PARTICIPANT_ID IS 'Идентификатор покупателя';

--ТАБЛИЧНАЯ ЧАСТЬ
CREATE TABLE XMLD_UTD_LINES
(
    UTD_ID                        NUMBER NOT NULL,
    CONSTRAINT UTD_ID_FK FOREIGN KEY (UTD_ID) REFERENCES XMLD_UTD_HEADERS,
    UTD_LINE_ID                   NUMBER NOT NULL,
    CONSTRAINT UTD_LINE_ID_PK PRIMARY KEY (UTD_LINE_ID),
    HOLDER_ID                     NUMBER NOT NULL,
    NUMBER_OF_ROW                 NUMBER(6),
    NAME_OF_PRODUCT               VARCHAR2(1000 CHAR),
    UNIT_CODE                     VARCHAR2(4 CHAR),
    QUANTITY                      NUMBER(26, 11),
    PRICE_OF_UNIT                 NUMBER(26, 11),
    SUM_OF_PRODUCT_WITHOUT_TAX    NUMBER(19, 2),
    TAX_RATE                      VARCHAR2(7 CHAR),
    CONSTRAINT TAX_RATE_CK CHECK (TAX_RATE IN ('0%', '10%', '18%', '10/110', '18/118', 'без НДС')),
    SUM_OF_PRODUCT_WITH_TAX       NUMBER(19, 2),
    SUM_OF_EXCISE                 VARCHAR2(100 CHAR),
    OF_WITHOUT_EXCISE             VARCHAR2(100 CHAR),
    SUM_OF_TAX                    NUMBER(19, 2),
    GOODS_WITHOUT_TAX             VARCHAR2(100 CHAR),
    COUNTRY_CODE_OF_PRODUCT       VARCHAR2(3 CHAR),
    CONSTRAINT COUNTRY_CODE_OF_PRODUCT_CH CHECK (LENGTH(COUNTRY_CODE_OF_PRODUCT) = 3),
    NUMBER_T_D                    VARCHAR2(29 CHAR),
    ID                            VARCHAR2(50 CHAR),
    VALUE                         VARCHAR2(2000 CHAR),
    ATTRIBUTE_OF_PRODUCT          VARCHAR2(1 CHAR),
    CONSTRAINT ATTRIBUTE_OF_PRODUCT_CK CHECK (ATTRIBUTE_OF_PRODUCT IN ('1', '2', '3', '4', '5')),
    OTHER_INFO_ABOUT_PRODUCT      VARCHAR2(4 CHAR),
    CODE_OF_PRODUCT               VARCHAR2(255 CHAR),
    UNIT_NAME                     VARCHAR2(255 CHAR),
    BRIEF_NAME_OF_COUNTRY_OF_PROD VARCHAR2(255 CHAR),
    QUANTITY_OF_LETTING_GO        NUMBER(15, 11),
    COR_ACC_DEBIT                 VARCHAR2(9 CHAR),
    CONSTRAINT COR_ACC_DEBIT_CK CHECK (LENGTH(COR_ACC_DEBIT) = 9),
    COR_ACC_CREDIT                VARCHAR2(9 CHAR),
    CONSTRAINT COR_ACC_CREDIT_CK CHECK (LENGTH(COR_ACC_CREDIT) = 9)
);
/
-- COMMENT ON COLUMN XMLD_UTD_LINES.UTD_LINE_ID IS 'Идентификатор строки';
-- COMMENT ON COLUMN XMLD_UTD_LINES.HOLDER_ID IS 'Ссылка на источник';
-- COMMENT ON COLUMN XMLD_UTD_LINES.NUMBER_OF_ROW IS 'Номер строки таблицы';
-- COMMENT ON COLUMN XMLD_UTD_LINES.NAME_OF_PRODUCT IS 'Наименование товара';
-- COMMENT ON COLUMN XMLD_UTD_LINES.UNIT_CODE IS 'ОКЕИ_Товара';
-- COMMENT ON COLUMN XMLD_UTD_LINES.QUANTITY IS 'Количество товара';
-- COMMENT ON COLUMN XMLD_UTD_LINES.PRICE_OF_UNIT IS 'Цена товара';
-- COMMENT ON COLUMN XMLD_UTD_LINES.SUM_OF_PRODUCT_WITHOUT_TAX IS 'Стоимость товаров, без налога - всего';
-- COMMENT ON COLUMN XMLD_UTD_LINES.TAX_RATE IS 'Налоговая ставка';
-- COMMENT ON COLUMN XMLD_UTD_LINES.SUM_OF_PRODUCT_WITH_TAX IS 'Стоимость товаров, с налогом - всего';
-- COMMENT ON COLUMN XMLD_UTD_LINES.SUM_OF_EXCISE IS 'Сумма акциза';
-- COMMENT ON COLUMN XMLD_UTD_LINES.OF_WITHOUT_EXCISE IS 'Без акциза';
-- COMMENT ON COLUMN XMLD_UTD_LINES.SUM_OF_TAX IS 'Сумма налога, предъявляемая покупателю';
-- COMMENT ON COLUMN XMLD_UTD_LINES.GOODS_WITHOUT_TAX IS 'Суммма без НДС';
-- COMMENT ON COLUMN XMLD_UTD_LINES.COUNTRY_CODE_OF_PRODUCT IS 'Цифровой код страны происхождения товара';
-- COMMENT ON COLUMN XMLD_UTD_LINES.NUMBER_T_D IS 'Номер таможенной декларации';
-- COMMENT ON COLUMN XMLD_UTD_LINES.ID IS 'Идентефикатор';
-- COMMENT ON COLUMN XMLD_UTD_LINES.VALUE IS ' Значение';
-- COMMENT ON COLUMN XMLD_UTD_LINES.ATTRIBUTE_OF_PRODUCT IS 'Признак';
-- COMMENT ON COLUMN XMLD_UTD_LINES.OTHER_INFO_ABOUT_PRODUCT IS 'Дополнительная информация о признаке';
-- COMMENT ON COLUMN XMLD_UTD_LINES.CODE_OF_PRODUCT IS 'Характеристика/код/артикул/сорт товара';
-- COMMENT ON COLUMN XMLD_UTD_LINES.UNIT_NAME IS 'Наименование единицы измерения';
-- COMMENT ON COLUMN XMLD_UTD_LINES.BRIEF_NAME_OF_COUNTRY_OF_PROD IS 'Краткое наименование страны происхождения товара';
-- COMMENT ON COLUMN XMLD_UTD_LINES.QUANTITY_OF_LETTING_GO IS 'Количество надлежит отпустить';
-- COMMENT ON COLUMN XMLD_UTD_LINES.COR_ACC_DEBIT IS 'Корреспондирующие счета: дебет';
-- COMMENT ON COLUMN XMLD_UTD_LINES.COR_ACC_CREDIT IS 'Корреспондирующие счета: кредит';
--
--
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.PARTICIPANT_ID IS 'Идентификатор участника';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.PARTICIPANT_TYPE IS 'Тип участника';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.INN_OF_INDIV IS 'Тип участника';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.CODE_IN_CLASSIFIER IS 'Код в общероссийском классификаторе предприятий и организаций';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.STRUCTURAL_SUBDIVISION IS 'Структурное подразделение';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.INFO_FOR_PARTICIPANTS IS 'Информация для участника документооборота';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.INN_OF_INDIV IS 'ИНН физического лица';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.OTHER_INF_ABOUT_INDIV IS 'Другие сведения о физическом лице';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.SECOND_NAME IS 'Фамилия';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.FIRST_NAME IS 'Имя';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.NAME_OF_ORG IS 'Название организации';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.INN_OF_ENTREPRENEUR IS 'ИНН юридического лица';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.REASON_OF_REG IS 'Код причины постановки на учет';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.IND IS 'Индекс';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.REGION_CODE IS 'Код региона';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.AREA IS 'Район';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.CITY IS 'Город';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.LOCALITY IS 'Населенный пункт';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.STREET IS 'Улица';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.HOUSE IS 'Дом';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.HOUSING IS 'Корпус';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.FLAT IS 'Квартира';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.COUNTRY_CODE IS 'Код страны';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.ADDRESS IS 'Адрес';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.NUMBER_OF_THE_ADDRESS_OBJECT IS 'Уникальный номер адреса объекта адресации в государственном адресном реестре';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.PHONE IS 'Телефон';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.EMAIL_ADDRESS IS 'Электронная почта';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.BANK_ACC_NUMBER IS 'Номер банковского счета';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.BANK_NAME IS 'Название банка';
-- COMMENT ON COLUMN XMLD_PARTICIPANTS.BANK_IDENTIFIC_CODE IS 'Банковский идентификационный код';

--ТАБЛИЦА ПОДПИСАНТОВ
CREATE TABLE XMLD_SIGNERS
(
    SIGNER_ID             NUMBER              NOT NULL,
    CONSTRAINT XMLD_SIGNERS_PK PRIMARY KEY (SIGNER_ID),
    HOLDER_ID             NUMBER              NOT NULL,
    SIGNER_AUT            NUMBER              NOT NULL CHECK (SIGNER_AUT IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 10)),
    SIGNER_STAT           VARCHAR2(1 CHAR)    NOT NULL,
    CONSTRAINT SIGNER_STAT_NOT_NULL CHECK ((SIGNER_STAT = '3' AND ORG_AUT_BAS IS NOT NULL) OR SIGNER_STAT != '3'),
    CONSTRAINT SIGNER_STAT_VALID CHECK (SIGNER_STAT IN (1, 2, 3, 4)),
    SIGNER_AUT_BAS        VARCHAR2(255 CHAR)  NOT NULL,
    ORG_AUT_BAS           VARCHAR2(255 CHAR),
    SIGNER_TYPE           VARCHAR2(2 CHAR)    NOT NULL,
    CONSTRAINT SIGNER_TYPE_CHK CHECK (UPPER(SIGNER_TYPE) in ('ФЛ', 'ЮЛ', 'ИП')),
    REQ_OF_THE_CERTIF     VARCHAR2(100 CHAR),
    INN_OF_INDIV          VARCHAR2(12 CHAR),
    OTHER_INF_ABOUT_INDIV VARCHAR2(255 CHAR),
    INDIV_NOT_NULL_INN    VARCHAR2(100 CHAR),
    INN_OF_ENTREPRENEUR   VARCHAR2(10)        NOT NULL,
    NAME_OF_ORG           VARCHAR2(1000 CHAR) NOT NULL,
    POS                   VARCHAR2(128 CHAR)  NOT NULL,
    FIRST_NAME            VARCHAR2(60 CHAR)   NOT NULL,
    SECOND_NAME           VARCHAR2(60 CHAR)   NOT NULL,
    THIRD_NAME            VARCHAR2(60 CHAR)   NOT NULL,
    CREATE_DATE           DATE                NOT NULL,
    UPDATE_DATE           DATE                NOT NULL
);
/
-- COMMENT ON COLUMN XMLD_SIGNERS.SIGNER_ID IS 'Идентификатор подписанта';
-- COMMENT ON COLUMN XMLD_SIGNERS.HOLDER_ID IS 'Ссылка на источник';
-- COMMENT ON COLUMN XMLD_SIGNERS.SIGNER_AUT IS 'Область полномочий подписанта';
-- COMMENT ON COLUMN XMLD_SIGNERS.SIGNER_STAT IS 'Статус подписанта';
-- COMMENT ON COLUMN XMLD_SIGNERS.SIGNER_AUT_BAS IS 'Основание полномочий (доверия)';
-- COMMENT ON COLUMN XMLD_SIGNERS.ORG_AUT_BAS IS 'Основание полномочий (доверия) организации';
-- COMMENT ON COLUMN XMLD_SIGNERS.SIGNER_TYPE IS 'Тип подписанта';
-- COMMENT ON COLUMN XMLD_SIGNERS.REQ_OF_THE_CERTIF IS 'Реквизиты свидетельства о государственной регистрации';
-- COMMENT ON COLUMN XMLD_SIGNERS.INN_OF_INDIV IS 'ИНН физического лица';
-- COMMENT ON COLUMN XMLD_SIGNERS.OTHER_INF_ABOUT_INDIV IS 'Другие сведения о физическом лице';
-- COMMENT ON COLUMN XMLD_SIGNERS.INDIV_NOT_NULL_INN IS 'Реквизиты свидетельства о государственной регистрации (случай ИП)';
-- COMMENT ON COLUMN XMLD_SIGNERS.INN_OF_ENTREPRENEUR IS 'ИНН юридического лица';
-- COMMENT ON COLUMN XMLD_SIGNERS.NAME_OF_ORG IS 'Название организации';
-- COMMENT ON COLUMN XMLD_SIGNERS.POS IS 'Должность';
-- COMMENT ON COLUMN XMLD_SIGNERS.SECOND_NAME IS 'Фамилия';
-- COMMENT ON COLUMN XMLD_SIGNERS.FIRST_NAME IS 'Имя';
-- COMMENT ON COLUMN XMLD_SIGNERS.THIRD_NAME IS 'Отчество';
-- COMMENT ON COLUMN XMLD_SIGNERS.CREATE_DATE IS 'Дата создания';
-- COMMENT ON COLUMN XMLD_SIGNERS.UPDATE_DATE IS 'Дата обновления';

--BUFFER
CREATE TABLE XMLD_BUFFER_XML_FILES
(
    XML_ID       NUMBER NOT NULL,
    CONSTRAINT XML_ID_PK PRIMARY KEY (XML_ID),
    XML_CONTENT  CLOB,
    XML_RESOURCE VARCHAR2(20 CHAR),
    CONSTRAINT XML_RESOURCE_CK CHECK (XML_RESOURCE IN ('WEB-SERVICE', 'MANUAL', 'FILESYSTEM')),
    RECORD_DATE  DATE
);
/
-- COMMENT ON COLUMN XMLD_BUFFER_XML_FILES.XML_ID IS 'Идентификатор записи табицы';
-- COMMENT ON COLUMN XMLD_BUFFER_XML_FILES.XML_CONTENT IS 'Содержимое XML-файла';
-- COMMENT ON COLUMN XMLD_BUFFER_XML_FILES.XML_RESOURCE IS 'В ручную, из файла, по сети';
-- COMMENT ON COLUMN XMLD_BUFFER_XML_FILES.RECORD_DATE IS 'Дата записи';

CREATE SEQUENCE XMLD_PARTICIPANTS_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
/

CREATE SEQUENCE XMLD_SIGNERS_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
/

CREATE SEQUENCE XMLD_SIGNERS_HOLDER_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
/

CREATE SEQUENCE XMLD_UTD_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
/

CREATE SEQUENCE XMLD_UTD_LINES_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
/

CREATE SEQUENCE XMLD_UTD_PAYMENT_DOC_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
/

CREATE SEQUENCE XMLD_BUFFER_XML_FILES_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
/

CREATE TRIGGER PARTICIPANTS_ID_BIR
    BEFORE INSERT
    ON XMLD_PARTICIPANTS
    FOR EACH ROW
BEGIN
    :NEW.PARTICIPANT_ID := XMLD_PARTICIPANTS_ID_SEQ.NEXTVAL;
END;
/

CREATE TRIGGER SIGNERS_ID_BIR
    BEFORE INSERT
    ON XMLD_SIGNERS
    FOR EACH ROW
BEGIN
    :NEW.SIGNER_ID := XMLD_SIGNERS_ID_SEQ.NEXTVAL;
END;
/

CREATE TRIGGER UTD_ID_BIR
    BEFORE INSERT
    ON XMLD_UTD_HEADERS
    FOR EACH ROW
BEGIN
    :NEW.UTD_ID := XMLD_UTD_ID_SEQ.NEXTVAL;
END;
/

CREATE TRIGGER UTD_LINES_ID_BIR
    BEFORE INSERT
    ON XMLD_UTD_LINES
    FOR EACH ROW
BEGIN
    :NEW.UTD_ID := XMLD_UTD_LINES_ID_SEQ.NEXTVAL;
END;
/

Create or replace package Register_Validate as

    PROCEDURE RegistrerXSD;
    PROCEDURE ValidateXML(Name_XSD in VARCHAR2, File_XML in CLOB);

End Register_Validate;
/

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
/

CREATE TRIGGER VALIDATE_DATA_BEFORE_INSERT
    BEFORE INSERT
    ON XMLD_BUFFER_XML_FILES
    FOR EACH ROW
BEGIN
    REGISTER_VALIDATE.ValidateXML('schema_XSD', to_clob(:NEW.XML_CONTENT));
END;
/

BEGIN
    REGISTER_VALIDATE.REGISTRERXSD();
END;
/