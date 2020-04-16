package ru.test.db.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.test.db.entity.XmlHeaders
import ru.test.db.repository.XmlHeadersRepository

@RestController
@RequestMapping(value = ["/header"])
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])

class XmlHeadersController {

    @Autowired
    private lateinit var xmlHeadersRepository: XmlHeadersRepository

    @RequestMapping(value = ["/all"])
    fun findAll(): MutableList<XmlHeaders> {
        return xmlHeadersRepository.findAll()
    }
}