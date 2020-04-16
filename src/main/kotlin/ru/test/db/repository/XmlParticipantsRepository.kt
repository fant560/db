package ru.test.db.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.test.db.entity.XmlParticipants

@Repository
interface XmlParticipantsRepository: JpaRepository<XmlParticipants, Long> {
}