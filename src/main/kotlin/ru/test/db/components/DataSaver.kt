package ru.test.db.components

import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.core.PreparedStatementCallback
import org.springframework.stereotype.Component
import ru.test.db.entity.BufferXml
import ru.test.db.repository.BufferXmlRepository
import java.io.ByteArrayInputStream
import java.nio.charset.Charset
import java.time.LocalDateTime
import java.util.*
import javax.annotation.PostConstruct

@Component
class DataSaver {

    private val logger = LoggerFactory.getLogger(javaClass)

    @Autowired
    private lateinit var jdbcTemplate: JdbcTemplate

    @Autowired
    private lateinit var documentLoader: DocumentLoader

    @Autowired
    private lateinit var bufferXmlRepository: BufferXmlRepository

    @Autowired
    private lateinit var validator: Validator

    /**
     * Основной метод загрузки
     */
    @PostConstruct
    fun load(){
        val data = documentLoader.load()
        val buffer = BufferXml(
                xmlContent = data,
                xmlResource = "WEB-SERVICE",
                recordDate = Date()
        )

        try {
            validator.validate(data)
            bufferXmlRepository.save(buffer)
        } catch (e: Exception) {
            logger.warn("Не удалось сохранить сообщение - ошибка валидации - ${e.message}")
            logger.warn("Сообщение - ${String(data)}")
        }





    }


    fun save(data: ByteArray){
        val buffer = BufferXml(
                xmlContent = data,
                xmlResource = "WEB-SERVICE",
                recordDate = Date()
        )
        try {
            validator.validate(data)
            bufferXmlRepository.save(buffer)
        } catch (e: Exception) {
            logger.warn("Не удалось сохранить сообщение - ошибка валидации - ${e.message}")
            logger.warn("Сообщение - ${String(data)}")
            throw RuntimeException(e)
        }

    }
}