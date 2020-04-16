package ru.test.db.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.jpa.repository.query.Procedure
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository
import ru.test.db.entity.BufferXml

@Repository
interface BufferXmlRepository: JpaRepository<BufferXml, Long> {

    @Procedure("call REGISTER_VALIDATE.ValidateXML(:Name_XSD, to_clob(:File_XML))")
    fun validate(@Param("Name_XSD") schemaName : String = "schema_XSD",
                 @Param("File_XML") data: ByteArray): Boolean

}