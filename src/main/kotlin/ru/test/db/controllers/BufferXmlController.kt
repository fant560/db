package ru.test.db.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.test.db.entity.BufferXml
import ru.test.db.repository.BufferXmlRepository

@RestController
@RequestMapping(value = ["/buffer"])
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
class BufferXmlController {
    @Autowired
    private lateinit var bufferXmlRepository: BufferXmlRepository

    @RequestMapping(value = ["/all"])
    fun findAll(): MutableList<BufferXml> {
        return bufferXmlRepository.findAll()
    }

}