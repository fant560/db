package ru.test.db.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.test.db.entity.XmlPaymentDocuments
import ru.test.db.repository.XmlPaymentsRepository

@RestController
@RequestMapping(value = ["/payments"])
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])

class XmlPaymentDocumentController {

    @Autowired
    private lateinit var paymentsRepository: XmlPaymentsRepository

    @RequestMapping(value = ["/all"])
    fun findAll(): MutableList<XmlPaymentDocuments> {
        return paymentsRepository.findAll()
    }

}