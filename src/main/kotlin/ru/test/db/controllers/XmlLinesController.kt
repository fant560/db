package ru.test.db.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.test.db.entity.XmlLines
import ru.test.db.repository.XmlLinesRepository

@RestController
@RequestMapping(value = ["/lines"])
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])

class XmlLinesController {
    @Autowired
    private lateinit var linesRepository: XmlLinesRepository

    @RequestMapping(value = ["/all"])
    fun findAll(): MutableList<XmlLines> {
        return linesRepository.findAll()
    }
}