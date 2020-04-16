package ru.test.db.entity

import java.util.*
import javax.persistence.*
import javax.validation.constraints.Max
import javax.validation.constraints.Pattern

@Entity(name = "XMLD_BUFFER_XML_FILES")
class BufferXml(
        @Column(name = "XML_CONTENT")
        val xmlContent: ByteArray,
        @Max(50)
        @Pattern(regexp = "WEB-SERVICE|MANUAL|FILESYSTEM|по сети")
        @Column(name = "XML_RESOURCE")
        val xmlResource: String,
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "RECORD_DATE")
        val recordDate: Date
) {
    @Id
    @GeneratedValue(generator = "XMLD_BUFFER_XML_FILES_ID_SEQ_GEN")
    @SequenceGenerator(name = "XMLD_BUFFER_XML_FILES_ID_SEQ_GEN", sequenceName = "XMLD_BUFFER_XML_FILES_ID_SEQ", allocationSize = 1)
    @Column(name = "XML_ID")
    val id: Long = 0
}
