package ru.test.db.entity

import javax.persistence.*
import javax.validation.constraints.Max
import javax.validation.constraints.Pattern
import javax.validation.constraints.Size

@Entity(name = "XMLD_PARTICIPANTS")
class XmlParticipants(
        // тип участника
        @Column(name = "PARTICIPANT_TYPE")
        @Pattern(regexp = "Продавец|Покупатель|Грузоотправитель|Грузополучатель")
        @Max(20)
        val participantType: String?,
        // ИНН участника
        @Max(12)
        @Column(name = "INN_OF_IND")
        val InnOfInd: String?,
        // реквизиты свидетельства о государтсвенной регистрации
        @Max(100)
        @Column(name = "REQ_OF_THE_CERTIF")
        val certif: String?,
        // другие сведения о физическом лице
        @Max(255)
        @Column(name = "OTHER_INF_ABOUT_IND")
        val aboutInd: String?,
        // название организации
        @Max(1000)
        @Column(name = "NAME_OF_ORG")
        val nameOrg: String?,
        // ИНН организации
        @Max(10)
        @Column(name = "INN_OF_ORG")
        val innOrg: String?,
        // код причины постановки на учет
        @Max(9)
        @Column(name = "CODE_OF_REASON_OF_REG")
        val reasonReg: String?,
        // индекс
        @Max(6)
        @Column(name = "INDEX_")
        val index: String?,
        // код региона
        @Max(2)
        @Column(name = "REGION_CODE")
        val regionCode: String?,
        // регион
        @Max(50)
        @Column(name = "REGION")
        val region: String?,
        // город
        @Max(50)
        @Column(name = "CITY")
        val city: String?,
        // населенный пункт
        @Max(50)
        @Column(name = "LOCALITY")
        val locality: String?,
        // улица
        @Max(50)
        @Column(name = "STREET")
        val street: String?,
        // дом
        @Max(20)
        @Column(name = "HOUSE")
        val house: String?,
        // корпус
        @Max(20)
        @Column(name = "HOUSING")
        val housing: String?,
        // квартира
        @Max(20)
        @Column(name = "FLAT")
        val flat: String?,
        // код страны
        @Size(min = 3, max = 3)
        @Pattern(regexp = "[0-9]{3}")
        @Column(name = "COUNTRY_CODE")
        val countryCode: String?,
        // адрес
        @Max(255)
        @Column(name = "ADDRESS")
        val address: String?,
        // телефон
        @Max(255)
        @Column(name = "PHONE")
        val phone: String?,
        // электронная почта
        @Max(255)
        @Column(name = "EMAIL_ADDRESS")
        val email: String?,
        // название банка
        @Max(1000)
        @Column(name = "BANK_NAME")
        val bankName: String?,
        // БИК
        @Max(9)
        @Column(name = "BANK_IDENTIFIC_CODE")
        val bankCode: String?,
        // корреспондентский номер счета
        @Max(20)
        @Column(name = "COR_AC_OF_THE_BANK")
        val corAc: String?,
        // номер счета
        @Max(20)
        @Column(name = "BANK_AC_NUMBER")
        val bankAcNumber: String?,
        // код в классификаторе
        @Max(10)
        @Column(name = "CODE_IN_CLASSIFIER")
        val classifierCode: String?,
        // структурное подразделение
        @Max(1000)
        @Column(name = "STRUCTURAL_SUBDIVISION")
        val structural: String?,
        // информация для участника документооборота
        @Max(255)
        @Column(name = "INFO_FOR_PARTICIPANTS")
        val infoParticipants: String?,
        // уникальный номер объекта в государственном адресном реестре
        @Max(36)
        @Column(name = "NUMBER_OF_THE_ADDRES_OBJECT")
        val numberAdress: String?,
        // фамилия
        @Max(60)
        @Column(name = "SECOND_NAME")
        val secondName: String?,
        // имя
        @Max(60)
        @Column(name = "FIRST_NAME")
        val firstName: String?,
        // отчество
        @Max(60)
        @Column(name = "PATRONYMIC")
        val patronymic: String?
) {
    @Id
    @GeneratedValue(generator = "XMLD_PARTICIPANTS_ID_SEQ_GEN")
    @SequenceGenerator(name = "XMLD_PARTICIPANTS_ID_SEQ_GEN", sequenceName = "XMLD_PARTICIPANTS_ID_SEQ", allocationSize = 1)
    @Column(name = "PARTICIPANT_ID")
    var id: Long = 0
}
