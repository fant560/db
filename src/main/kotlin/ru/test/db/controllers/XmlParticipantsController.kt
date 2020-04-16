package ru.test.db.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.test.db.entity.XmlParticipants
import ru.test.db.repository.XmlParticipantsRepository

@RestController
@RequestMapping(value = ["/participants"])
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])

class XmlParticipantsController {
    @Autowired
    private lateinit var participantsRepository: XmlParticipantsRepository

    @RequestMapping(value = ["/all"])
    fun findAll(): MutableList<XmlParticipants> {
        return participantsRepository.findAll()
    }
}