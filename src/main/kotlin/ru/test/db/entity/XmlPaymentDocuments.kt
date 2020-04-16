package ru.test.db.entity

import java.util.*
import javax.persistence.*
import javax.validation.constraints.Max
import javax.validation.constraints.NotNull
@Entity(name = "XMLD_UTD_PAYMENT_DOCUMENTS")
class XmlPaymentDocuments (
        //Ссылка источника
        @NotNull
        @Column(name="HOLDER_ID")
        val holderId:  Long,

        //Номер платежно-расчетного документа
        @Max(30)
        @Column(name="NUMBER_OF_PAYMENT_DOCUMENT")
        val numberOfPaymentDocument: String?,

        //Дата составления платежно-расчетного документа
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name="DATE_OF_CREATING_PAYMENT_DOC")
        val dateOfCreatingPaymentDoc: Date?
        ){
    //Идентификатор платежно-расчетного документа
    @Id
    @GeneratedValue(generator = "XMLD_UTD_PAYMENT_DOC_ID_SEQ_GEN")
    @SequenceGenerator(name = "XMLD_UTD_PAYMENT_DOC_ID_SEQ_GEN", sequenceName = "XMLD_UTD_PAYMENT_DOC_ID_SEQ", allocationSize = 1)
    //TODO А
    @Column(name = "PAYMENT_DOCUMENT_ID")
    val id: Long = 0

}