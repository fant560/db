package ru.test.db.entity

import java.util.*
import javax.persistence.*
import javax.validation.constraints.Max
import javax.validation.constraints.Pattern
import javax.validation.constraints.Size

@Entity(name = "XMLD_UTD_HEADERS")
class XmlHeaders(
        // Порядковый номер счета-фактуры
        @Max(1000)
        @Column(name = "SERIAL_NUMBER_OF_THE_INVOICE")
        val serialNumberOfTheInvoice: String?,
        //Дата составления счета-фактуры
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "DATE_OF_INVOICING")
        val dateOfInvoicing: Date?,
        //Код формы по Классификатору налоговой документации
        @Pattern(regexp = "11151125")
        @Column(name = "CODE_OF_FORM")
        val codeOfForm: String?,
        //Дата формирования файла обмена счета-фактуры (информации продавца) или файла обмена информации продавца
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "DATE_OF_CR_OF_THE_INVOICE")
        val dateOfCrOfTheInvoice: Date?,
        //Время формирования файла обмена счета-фактуры (информации продавца)
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "TIME_OF_CR_OF_THE_INVOICE")
        val timeOfCrOfTheInvoice: Date?,
        //Код валюты по Общероссийскому классификатору валют
        @Max(3)
        @Column(name = "CODE_OF_CURRENCY")
        val codeOfTHeCurrency: String?,

        // TODO тут валидации чисел с плавающей точкой нет
        // TODO оставляем валидацию на уровень БД
        //Номер исправления
        @Column(name = "NUMBER_OF_CORRECTION")
        val numberOfTheCorrection: Double?,
        //Дата исправления
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "DATE_OF_CORRECTION")
        val dateOfTheCorrection: Date?,
        //Сумма налога
        @Column(name = "SUM_OF_TAX")
        val sumOfTax: Double?,
        //Всего к оплате, Стоимость товаров (работ, услуг), имущественных прав с налогом - всего
        @Column(name = "COST_OF_GOODS_WITH_TAX")
        val costOfGoodsWithTaxNumber: Double?,
        //Всего к оплате, Стоимость товаров (работ, услуг), имущественных прав без налога - всего
        @Column(name = "COST_OF_GOODS_WITHOUT_TAX")
        val costOfGoodsWithoutTaxNumber: Double?,
        //Дата создания записи
        @Max(100)
        @Column(name = "DATE_OF_NOTE")
        val dateOfNote: String?,
        //Идентификатор файла
        @Max(200)
        @Column(name = "FILE_ID")
        val fileId: String?,
        //Идентификатор участника документооборота – отправителя файла обмена счета-фактуры (информации продавца)
        @Size(min = 4, max = 46)
        @Column(name = "FILE_SENDER_ID")
        val fileSenderId: String?,
        //Идентификатор участника документооборота - получателя файла обмена счета-фактуры (информации продавца)
        @Size(min = 4, max = 46)
        @Column(name = "FILE_RECIPIENT_ID")
        val fileRecipientId: String?,
        //Идентификатор участника документооборота - получателя файла обмена счета-фактуры (информации продавца)
        @Column(name = "DATE_OF_FILE_UPDATE")
        @Temporal(TemporalType.TIMESTAMP)
        val dateOfFile: Date?,
        //Тип документа
        @Pattern(regexp = "СЧФ|СЧФДОП|ДОП")
        @Column(name = "TYPE_OF_DOC")
        val typeOfDoc: String?,
        //Наименование первичного документа, определенное организацией (согласованное сторонами сделки)
        @Max(255)
        @Column(name = "NAME_OF_DOC_OF_ORGANIZATION")
        val nameOfDocOfOrganization: String?,
        //Наименование документа по факту хозяйственной жизни
        @Max(255)
        @Column(name = "NAME_OF_THE_DOC_OF_ECON")
        val nameOfTheDocOfEcon: String?,
        //Наименование экономического субъекта - составителя файла обмена счета-фактуры
        @Max(1000)
        @Column(name = "NAME_OF_THE_ECON_SUB")
        val nameOfTheEconSub: String?,
        //Основание, по которому экономический субъект является составителем файла обмена информации покупателя
        @Max(120)
        @Column(name = "FOUND_OF_THE_CREATOR_FILE")
        val foundOfTheCreatorFile: String?,
        //Идентификатор государственного контракта
        @Max(255)
        @Column(name = "GOS_CONTR_ID")
        val gosContrId: String?,
        //Наименование валюты  согласно Общероссийскому классификатору валют (ОКВ)
        @Max(100)
        @Column(name = "NAME_OF_VAL")
        val nameOfVal: String?,
        //Курс валюты
        @Column(name = "CURS_OF_VAL")
        val cursOfVal: Double?,
        @Column(name="WEIGHT")
        val weight: Double?
) {
    //Идентификатор таблицы
    @Id
    @GeneratedValue(generator = "XMLD_UTD_ID_SEQ_GEN")
    @SequenceGenerator(name = "XMLD_UTD_ID_SEQ_GEN", sequenceName = "XMLD_UTD_ID_SEQ", allocationSize = 1)
    @Column(name = "UTD_ID")
    val id: Long = 0

    @OneToOne(cascade = [CascadeType.ALL], orphanRemoval = true, targetEntity = XmlParticipants::class)
    @JoinColumn(name = "VENDOR_PARTICIPANT_ID", referencedColumnName = "PARTICIPANT_ID")
    var vendorParticipant: XmlParticipants? = null


    @OneToOne(cascade = [CascadeType.ALL], orphanRemoval = true, targetEntity = XmlParticipants::class)
    @JoinColumn(name = "SHIP_PARTICIPANT_ID", referencedColumnName = "PARTICIPANT_ID")
    var shipParticipant: XmlParticipants? = null

    @OneToOne(cascade = [CascadeType.ALL], orphanRemoval = true, targetEntity = XmlParticipants::class)
    @JoinColumn(name = "CONS_PARTICIPANT_ID", referencedColumnName = "PARTICIPANT_ID")
    var consParticipant: XmlParticipants? = null

    @OneToOne(cascade = [CascadeType.ALL], orphanRemoval = true, targetEntity = XmlParticipants::class)
    @JoinColumn(name = "BUYER_PARTICIPANT_ID", referencedColumnName = "PARTICIPANT_ID")
    var buyerParticipant: XmlParticipants? = null
}