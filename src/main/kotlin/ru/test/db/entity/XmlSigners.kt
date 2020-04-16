package ru.test.db.entity

import java.util.*
import javax.persistence.*
import javax.validation.constraints.Max
import javax.validation.constraints.NotNull
import javax.validation.constraints.Pattern

@Entity(name = "XMLD_SIGNERS")
class XmlSigners(

        // хз, комментария не было
        @NotNull
        @Column(name = "HOLDER_ID")
        val holderId: Long,
        // тип подписанта
        @Max(2)
        @Pattern(regexp = "ФЗ|ЮЛ|ИП")
        @Column(name = "SIGNER_TYPE")
        val signerType: String?,
        // область полномочий
        @Max(1)
        @Column(name = "SIGNER_AUT")
        @Pattern(regexp = "[0123456]")
        val signerAut: String?,
        // статус подписанта
        @Column(name = "SIGNER_STATUS")
        @Max(1)
        @Pattern(regexp = "[1234]")
        val signerStatus: String?,
        // основание полномочий
        @Column(name = "SIGNER_AUT_BAS")
        @Max(255)
        val signerAutBas: String?,
        // основание полномочий организации
        @Column(name = "ORG_AUT_BAS")
        @Max(255)
        val orgAutBas: String?,
        // ИНН физического лица
        @Column(name = "INN_OF_IND")
        @Max(12)
        val innOfInd: String?,
        // другие сведения о физическом лице
        @Column(name = "OTHER_INF_ABOUT_IND")
        @Max(255)
        val otherInfAboutInd: String?,
        // ИНН юридического лица
        @Column(name = "INN_OF_ENTREP")
        @Max(10)
        val innIfEnterp: String?,
        // Название организации
        @Column(name = "NAME_OF_ORG")
        @Max(1000)
        val nameOfOrg: String?,
        // должность
        @Column(name = "POS")
        @Max(128)
        val pos: String?,
        // реквизиты свидетельсктва о государственной регистрации
        @Column(name = "REQ_OF_THE_CERTIF")
        @Max(100)
        val reqOfTheCertif: String?,
        // имя
        @Column(name = "FIRST_NAME")
        @Max(60)
        val firstName: String?,
        // фамилия
        @Column(name = "SECOND_NAME")
        @Max(60)
        val secondName: String?,
        // отчество
        @Column(name = "PATRONYMIC")
        @Max(60)
        val patronymic: String?,
        // дата создания
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "DATE_OF_CREATION")
        val dateOfCreation: Date?,
        // дата обновления
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "DATE_OF_UPDATE")
        val dateOfUpdate: Date?

) {
    @Id
    @GeneratedValue(generator = "XMLD_SIGNERS_ID_SEQ_GEN")
    @SequenceGenerator(name = "XMLD_SIGNERS_ID_SEQ_GEN", sequenceName = "XMLD_SIGNERS_ID_SEQ", allocationSize = 1)
    @Column(name = "SIGNER_ID")
    var id: Long = 0
}