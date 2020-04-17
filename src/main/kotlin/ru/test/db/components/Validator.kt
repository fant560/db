package ru.test.db.components

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import org.xml.sax.SAXException
import java.io.ByteArrayInputStream
import java.io.File
import java.io.IOException
import java.nio.file.Files
import java.nio.file.Paths
import javax.xml.XMLConstants
import javax.xml.transform.stream.StreamSource
import javax.xml.validation.SchemaFactory

@Component
class Validator {

    private val schema: File = Paths.get("src/main/resources/schema.xsd").toFile()

    private val logger = LoggerFactory.getLogger(javaClass)

    fun validate(xml: ByteArray) {
        try {
            val schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI)
            val xsdSchema = schemaFactory.newSchema(schema)
            val validator = xsdSchema.newValidator()

            validator.validate(StreamSource(ByteArrayInputStream(xml)))

        } catch (s: SAXException) {
            logger.error("Ошибка валидации - ${s.message}")
            throw RuntimeException(s)
        }
    }

}