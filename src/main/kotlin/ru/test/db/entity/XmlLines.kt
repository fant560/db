package ru.test.db.entity

import java.util.*
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.*
import javax.validation.constraints.Max
import javax.validation.constraints.Pattern
import javax.validation.constraints.Size

@Entity(name = "XMLD_UTD_LINES")
class XmlLines(
        //Номер строки таблицы
        @Column(name = "NUMBER_OF_ROW ")
        val numberOfRow: Long?,

        //Наименование товара (описание выполненных работ, оказанных услуг), имущественных прав
        @Max(1000)
        @Column(name = "NAME_OF_PRODUCT")
        val nameOfProduct: String?,

        //Количество
        @Column(name = "QUANTITY")
        val quantity: Double?,

        //Код единицы измерения по Общероссийскому классификатору единиц измерения
        @Max(4)
        @Column(name = "UNIT_CODE")
        val unitCode: String?,

        //Цена (тариф) за единицу измерения
        @Column(name = "PRICE_OF_UNIT")
        val priceOfUnit: Double?,

        //Стоимость товаров (работ, услуг), имущественных прав без налога - всего
        @Column(name = "SUM_OF_PRODUCT_WITHOUT_TAX")
        val sumOfProductWithoutTax: Double?,

        //Сумма налога, предъявляемая покупателю
        @Column(name = "SUM_OF_TAX")
        val sumOfTax: Double?,

        //Стоимость товаров (работ, услуг), имущественных прав с налогом - всего
        @Column(name = "SUM_OF_PRODUCT_WITH_TAX ")
        val sumOfProductWithTax: Double?,

        //Сумма акциза
        @Column(name = "SUM_OF_EXCISE")
        val sumOfExcise: Double?,

        //Дата записи
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "DATE_OF_RECORDING")
        val dateOfRecording: Date?,

        //Цифровой код страны происхождения товара
        @Size(min = 3, max = 3)
        @Column(name = "COUNTRY_CODE_OF_PRODUCT")
        val countryCodeOfProduct: String?,

        //Дата последнего обновления
        @Temporal(TemporalType.TIMESTAMP)
        @Column(name = "DATE_OF_LAST_UPDATE")
        val dateOfLastUpdate: Date?,

        @Pattern(regexp = "[123456]")
        @Column(name = "ATTRIBUTE_OF_PRODUCT")
        val attributeOfProduct: String?,

        //Дополнительная информация о признаке
        @Max(4)
        @Column(name = "OTHER_INFO_ABOUT_PRODUCT")
        val otherInfoAboutProduct: String?,

        //Характеристика/код/артикул/сорт товара
        @Max(255)
        @Column(name = "CODE_OF_PRODUCT")
        val codeOfProduct: String?,

        //Наименование единицы измерения
        @Max(255)
        @Column(name = "UNIT_NAME")
        val unitName: String?,

        //Краткое наименование страны происхождения товара
         @Max(255)
         @Column(name="BRIEF_NAME_OF_COUNTRY_OF_PROD")
         val briefNameOfCountryOfProd: String?,

        //Количество надлежит отпустить
        @Column(name="QUANTITY_OF_LETTING_GO")
        val quantityOfLettingGo: Double?,

        //TODO написать паттерн
        //Корреспондирующие счета: дебет
        @Size(min = 9, max = 9)
        @Column(name = "COR_ACC_DEBIT")
        val corAccDebit: String?,

        //Корреспондирующие счета: кредит
        @Size(min = 9, max = 9)
        @Column(name = "COR_ACC_CR")
        val corAccCredit: String?,

        //Налоговая ставка
        @Pattern(regexp = "0%|10%|18%|10/110|18/118|без НДС")
        @Max(7)
        @Column(name = "TAX_RATE")
        val taxRate: String?
) {
    @Id
    @GeneratedValue(generator = "XMLD_UTD_LINES_ID_SEQ_GEN")
    @SequenceGenerator(name = "XMLD_UTD_LINES_ID_SEQ_GEN", sequenceName = "XMLD_UTD_LINES_ID_SEQ", allocationSize = 1)
    @Column(name = "UTD_LINE_ID")
    val id: Long = 0

    @OneToOne(cascade = [CascadeType.ALL], orphanRemoval = true, targetEntity = XmlHeaders::class)
    @JoinColumn(name = "UTD_ID", referencedColumnName = "UTD_ID")
    var xmlHeaders: XmlHeaders? = null


}