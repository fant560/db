package ru.test.db.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.test.db.entity.XmlHeaders

@Repository
interface XmlHeadersRepository: JpaRepository<XmlHeaders, Long> {
}