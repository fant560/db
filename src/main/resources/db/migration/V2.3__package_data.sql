Create or replace package Register_Validate as

	PROCEDURE RegistrerXSD;
PROCEDURE ValidateXML(Name_XSD in VARCHAR2, File_XML in CLOB);

End Register_Validate;
/


--grant execute on (packageName or tableName) to user;


CREATE OR REPLACE PACKAGE BODY Register_Validate as

PROCEDURE RegistrerXSD is

xsd_schema clob;
urlexists number;

BEGIN
xsd_schema :=to_clob(' ')||to_clob('скрипт XSD схемы');
select count(*)into urlexists	from user_xml_schemas
where schema_url = 'schema_XSD';
if urlexists=1 then
	begin
DBMS_XMLSCHEMA.deleteschema('schema_XSD',DBMS_XMLSCHEMA.DELETE_CASCADE_FORCE);
end;
end if;
DBMS_XMLSCHEMA.registerSchema('schema_XSD',xsd_schema,genTypes => false,genTables => false);
END ;


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
end ;


End Register_Validate;
/
