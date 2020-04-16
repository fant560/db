package ru.test.db

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.autoconfigure.domain.EntityScan
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.data.jpa.repository.config.EnableJpaRepositories
import org.springframework.web.client.RestTemplate
import ru.test.db.entity.BufferXml
import ru.test.db.repository.BufferXmlRepository

@SpringBootApplication
class DbApplication

fun main(args: Array<String>) {
    runApplication<DbApplication>(*args)
}


@Configuration
@EntityScan(basePackageClasses = [BufferXml::class])
@EnableJpaRepositories(basePackageClasses = [BufferXmlRepository::class])
class SampleConfiguration {

    @Bean
    fun restTemplate():RestTemplate {
        return RestTemplate()
    }
}