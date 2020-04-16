package ru.test.db.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.test.db.entity.XmlSigners
import ru.test.db.repository.XmlSignersRepository

@RestController
@RequestMapping(value = ["/signers"])
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])

class XmlSignersController {

    @Autowired
    private lateinit var xmlSignersRepository: XmlSignersRepository

    @RequestMapping(value = ["/all"])
    fun findAll(): MutableList<XmlSigners> {
        return xmlSignersRepository.findAll()
    }
}