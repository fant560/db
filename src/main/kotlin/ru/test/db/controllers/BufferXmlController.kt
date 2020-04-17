package ru.test.db.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.test.db.components.DataSaver
import ru.test.db.components.DocumentLoader
import ru.test.db.entity.BufferXml
import ru.test.db.repository.BufferXmlRepository
import java.nio.charset.Charset
import java.nio.file.Files
import java.nio.file.Paths

@RestController
@RequestMapping(value = ["/buffer"])
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
class BufferXmlController {
    @Autowired
    private lateinit var bufferXmlRepository: BufferXmlRepository

    @Autowired
    private lateinit var dataSaver: DataSaver

    @RequestMapping(value = ["/valid"])
    fun saveValid():ResponseEntity<String> {
        dataSaver.save(Files.readAllLines(Paths.get("src/main/resources/valid.xml"),
                Charset.forName("windows-1251"))
                .joinToString(separator = "")
                .toByteArray(Charset.forName("windows-1251")))
        return ResponseEntity.ok("Успешно сохранено")
    }


    @RequestMapping(value = ["/invalid"])
    fun saveInvalid():ResponseEntity<String> {
        return try {
            dataSaver.save(Files.readAllLines(Paths.get("src/main/resources/invalid.xml"),
                    Charset.forName("windows-1251"))
                    .joinToString(separator = "")
                    .toByteArray(Charset.forName("windows-1251")))
            ResponseEntity.ok("Успешно сохранено")
        } catch (e: Exception) {
            ResponseEntity.ok("Не удалось сохранить. Ошибка - ${e.message}")
        }
    }

}