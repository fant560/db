package ru.test.db.components

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import org.springframework.web.client.RestTemplate
import org.springframework.web.client.getForEntity

@Component
class DocumentLoader {

    private val link = "http://elasticsearch.prj.elewise.com:8080/docservlet/DocGenerator";

    @Autowired
    private lateinit var restTemplate: RestTemplate


    fun load(): ByteArray{
        return restTemplate.getForEntity<ByteArray>(link).body!!
    }

}