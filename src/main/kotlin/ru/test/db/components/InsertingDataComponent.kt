package ru.test.db.components

import org.apache.commons.lang3.RandomStringUtils
import org.apache.commons.lang3.StringUtils
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import ru.test.db.entity.*
import ru.test.db.repository.*
import java.util.*
import javax.annotation.PostConstruct

@Component
class InsertingDataComponent {

    private val logger = LoggerFactory.getLogger(javaClass)

    @Autowired
    private lateinit var bufferXmlRepository: BufferXmlRepository

    @Autowired
    private lateinit var xmlHeadersRepository: XmlHeadersRepository

    @Autowired
    private lateinit var xmlLinesRepository: XmlLinesRepository

    @Autowired
    private lateinit var xmlParticipantsRepository: XmlParticipantsRepository

    @Autowired
    private lateinit var xmlPaymentDocumentsRepository: XmlPaymentsRepository

    @Autowired
    private lateinit var xmlSignersRepository: XmlSignersRepository


    fun init() {

        logger.warn("Вызов метода заполнения таблиц")

        val bufferFiles = BufferXml(
                xmlContent = ByteArray(16) { it -> (it % 10).toByte() },
                xmlResource = "MANUAL",
                recordDate = Date()
        )

        bufferXmlRepository.save(bufferFiles)


        val xmlLines = XmlLines(
                numberOfRow = 2,
                nameOfProduct = "Подсолнечное масло",
                quantity = 120.0,
                unitCode = "л",
                priceOfUnit = 50.6,
                sumOfProductWithoutTax = 120.0 * 50.6,
                sumOfTax = 13.0,
                sumOfProductWithTax = 120.0 * 50.6 / 0.87,
                sumOfExcise = 18.0,
                dateOfRecording = Date(),
                countryCodeOfProduct = "009",
                dateOfLastUpdate = Date(),
                attributeOfProduct = "5",
                otherInfoAboutProduct = "доп.",
                codeOfProduct = "ПМ",
                unitName = "литр",
                briefNameOfCountryOfProd = "RUS",
                quantityOfLettingGo = 120.0,
                corAccDebit = "987654321",
                corAccCredit = "987654321",
                taxRate = "без НДС")
        xmlLinesRepository.save(xmlLines)

        val xmlLines2 = XmlLines(
                numberOfRow = 3,
                nameOfProduct = "Восковые свечи",
                quantity = 15.0,
                unitCode = "шт",
                priceOfUnit = 255.0,
                sumOfProductWithoutTax = 15.0 * 255.0,
                sumOfTax = 13.0,
                sumOfProductWithTax = 15.0 * 255.0 / 0.87,
                sumOfExcise = 18.0,
                dateOfRecording = Date(),
                countryCodeOfProduct = "009",
                dateOfLastUpdate = Date(),
                attributeOfProduct = "4",
                otherInfoAboutProduct = "доп.",
                codeOfProduct = "ВС",
                unitName = "штуки",
                briefNameOfCountryOfProd = "RUS",
                quantityOfLettingGo = 15.0,
                corAccDebit = "987654322",
                corAccCredit = "987654322",
                taxRate = "18/118")
        xmlLinesRepository.save(xmlLines2)

        val xmlLines3 = XmlLines(
                numberOfRow = 2,
                nameOfProduct = "Огнетушитель",
                quantity = 7.0,
                unitCode = "шт",
                priceOfUnit = 1200.0,
                sumOfProductWithoutTax = 1200.0 * 7.0,
                sumOfTax = 13.0,
                sumOfProductWithTax = 1200.0 * 7.0 / 0.87,
                sumOfExcise = 18.0,
                dateOfRecording = Date(),
                countryCodeOfProduct = "009",
                dateOfLastUpdate = Date(),
                attributeOfProduct = "2",
                otherInfoAboutProduct = "доп.",
                codeOfProduct = "О",
                unitName = "штука",
                briefNameOfCountryOfProd = "RUS",
                quantityOfLettingGo = 7.0,
                corAccDebit = "987654323",
                corAccCredit = "987654333",
                taxRate = "без НДС")
        xmlLinesRepository.save(xmlLines3)


        val xmlParticipants1 = XmlParticipants(
                participantType = "Продавец",
                InnOfInd = RandomStringUtils.randomAlphabetic(10),
                certif = RandomStringUtils.randomAlphabetic(100),
                aboutInd = RandomStringUtils.randomAlphabetic(255),
                nameOrg = RandomStringUtils.randomAlphabetic(1000),
                innOrg = RandomStringUtils.randomAlphabetic(10),
                reasonReg = RandomStringUtils.randomAlphabetic(9),
                index = RandomStringUtils.randomAlphabetic(6),
                regionCode = RandomStringUtils.randomAlphabetic(2),
                region = RandomStringUtils.randomAlphabetic(50),
                city = RandomStringUtils.randomAlphabetic(50),
                locality = RandomStringUtils.randomAlphabetic(50),
                street = RandomStringUtils.randomAlphabetic(50),
                house = RandomStringUtils.randomAlphabetic(20),
                housing = RandomStringUtils.randomAlphabetic(20),
                flat = RandomStringUtils.randomAlphabetic(20),
                countryCode = RandomStringUtils.randomNumeric(3),
                address = RandomStringUtils.randomAlphabetic(255),
                phone = RandomStringUtils.randomAlphabetic (255),
                email = RandomStringUtils.randomAlphabetic(255),
                bankName = RandomStringUtils.randomAlphabetic(1000),
                bankCode = RandomStringUtils.randomAlphabetic(9),
                corAc = RandomStringUtils.randomAlphabetic(20),
                bankAcNumber = RandomStringUtils.randomAlphabetic(20),
                classifierCode = RandomStringUtils.randomAlphabetic(10),
                structural = RandomStringUtils.randomAlphabetic(1000),
                infoParticipants = RandomStringUtils.randomAlphabetic(255),
                numberAdress = RandomStringUtils.randomAlphabetic(36),
                secondName = RandomStringUtils.randomAlphabetic(60),
                firstName = RandomStringUtils.randomAlphabetic(60),
                patronymic = RandomStringUtils.randomAlphabetic(60)
        )
        xmlParticipantsRepository.save(xmlParticipants1)
        val xmlParticipants2 = XmlParticipants(
                participantType = "Грузоотправитель",
                InnOfInd = RandomStringUtils.randomAlphabetic(10),
                certif = RandomStringUtils.randomAlphabetic(100),
                aboutInd = RandomStringUtils.randomAlphabetic(255),
                nameOrg = RandomStringUtils.randomAlphabetic(1000),
                innOrg = RandomStringUtils.randomAlphabetic(10),
                reasonReg = RandomStringUtils.randomAlphabetic(9),
                index = RandomStringUtils.randomAlphabetic(6),
                regionCode = RandomStringUtils.randomAlphabetic(2),
                region = RandomStringUtils.randomAlphabetic(50),
                city = RandomStringUtils.randomAlphabetic(50),
                locality = RandomStringUtils.randomAlphabetic(50),
                street = RandomStringUtils.randomAlphabetic(50),
                house = RandomStringUtils.randomAlphabetic(20),
                housing = RandomStringUtils.randomAlphabetic(20),
                flat = RandomStringUtils.randomAlphabetic(20),
                countryCode = RandomStringUtils.randomNumeric(3),
                address = RandomStringUtils.randomAlphabetic(255),
                phone = RandomStringUtils.randomAlphabetic (255),
                email = RandomStringUtils.randomAlphabetic(255),
                bankName = RandomStringUtils.randomAlphabetic(1000),
                bankCode = RandomStringUtils.randomAlphabetic(9),
                corAc = RandomStringUtils.randomAlphabetic(20),
                bankAcNumber = RandomStringUtils.randomAlphabetic(20),
                classifierCode = RandomStringUtils.randomAlphabetic(10),
                structural = RandomStringUtils.randomAlphabetic(1000),
                infoParticipants = RandomStringUtils.randomAlphabetic(255),
                numberAdress = RandomStringUtils.randomAlphabetic(36),
                secondName = RandomStringUtils.randomAlphabetic(60),
                firstName = RandomStringUtils.randomAlphabetic(60),
                patronymic = RandomStringUtils.randomAlphabetic(60)
        )
        xmlParticipantsRepository.save(xmlParticipants2)

        val xmlParticipants3 = XmlParticipants(
                participantType = "Грузополучатель",
                InnOfInd = RandomStringUtils.randomAlphabetic(10),
                certif = RandomStringUtils.randomAlphabetic(100),
                aboutInd = RandomStringUtils.randomAlphabetic(255),
                nameOrg = RandomStringUtils.randomAlphabetic(1000),
                innOrg = RandomStringUtils.randomAlphabetic(10),
                reasonReg = RandomStringUtils.randomAlphabetic(9),
                index = RandomStringUtils.randomAlphabetic(6),
                regionCode = RandomStringUtils.randomAlphabetic(2),
                region = RandomStringUtils.randomAlphabetic(50),
                city = RandomStringUtils.randomAlphabetic(50),
                locality = RandomStringUtils.randomAlphabetic(50),
                street = RandomStringUtils.randomAlphabetic(50),
                house = RandomStringUtils.randomAlphabetic(20),
                housing = RandomStringUtils.randomAlphabetic(20),
                flat = RandomStringUtils.randomAlphabetic(20),
                countryCode = RandomStringUtils.randomNumeric(3),
                address = RandomStringUtils.randomAlphabetic(255),
                phone = RandomStringUtils.randomAlphabetic (255),
                email = RandomStringUtils.randomAlphabetic(255),
                bankName = RandomStringUtils.randomAlphabetic(1000),
                bankCode = RandomStringUtils.randomAlphabetic(9),
                corAc = RandomStringUtils.randomAlphabetic(20),
                bankAcNumber = RandomStringUtils.randomAlphabetic(20),
                classifierCode = RandomStringUtils.randomAlphabetic(10),
                structural = RandomStringUtils.randomAlphabetic(1000),
                infoParticipants = RandomStringUtils.randomAlphabetic(255),
                numberAdress = RandomStringUtils.randomAlphabetic(36),
                secondName = RandomStringUtils.randomAlphabetic(60),
                firstName = RandomStringUtils.randomAlphabetic(60),
                patronymic = RandomStringUtils.randomAlphabetic(60)
        )
        xmlParticipantsRepository.save(xmlParticipants3)

        val xmlParticipants4 = XmlParticipants(
                participantType = "Покупатель",
                InnOfInd = RandomStringUtils.randomAlphabetic(10),
                certif = RandomStringUtils.randomAlphabetic(100),
                aboutInd = RandomStringUtils.randomAlphabetic(255),
                nameOrg = RandomStringUtils.randomAlphabetic(1000),
                innOrg = RandomStringUtils.randomAlphabetic(10),
                reasonReg = RandomStringUtils.randomAlphabetic(9),
                index = RandomStringUtils.randomAlphabetic(6),
                regionCode = RandomStringUtils.randomAlphabetic(2),
                region = RandomStringUtils.randomAlphabetic(50),
                city = RandomStringUtils.randomAlphabetic(50),
                locality = RandomStringUtils.randomAlphabetic(50),
                street = RandomStringUtils.randomAlphabetic(50),
                house = RandomStringUtils.randomAlphabetic(20),
                housing = RandomStringUtils.randomAlphabetic(20),
                flat = RandomStringUtils.randomAlphabetic(20),
                countryCode = RandomStringUtils.randomNumeric(3),
                address = RandomStringUtils.randomAlphabetic(255),
                phone = RandomStringUtils.randomAlphabetic (255),
                email = RandomStringUtils.randomAlphabetic(255),
                bankName = RandomStringUtils.randomAlphabetic(1000),
                bankCode = RandomStringUtils.randomAlphabetic(9),
                corAc = RandomStringUtils.randomAlphabetic(20),
                bankAcNumber = RandomStringUtils.randomAlphabetic(20),
                classifierCode = RandomStringUtils.randomAlphabetic(10),
                structural = RandomStringUtils.randomAlphabetic(1000),
                infoParticipants = RandomStringUtils.randomAlphabetic(255),
                numberAdress = RandomStringUtils.randomAlphabetic(36),
                secondName = RandomStringUtils.randomAlphabetic(60),
                firstName = RandomStringUtils.randomAlphabetic(60),
                patronymic = RandomStringUtils.randomAlphabetic(60)
        )
        xmlParticipantsRepository.save(xmlParticipants4)


        val xmlPaymentDocuments = XmlPaymentDocuments(
                holderId = 950,
                numberOfPaymentDocument = "1566",
                dateOfCreatingPaymentDoc = Date()
        )
        xmlPaymentDocumentsRepository.save(xmlPaymentDocuments)

        val xmlSigners = XmlSigners(
                holderId = 53783,
                signerType = "ИП",
                signerAut = "2",
                signerStatus = "1",
                signerAutBas = "трагический",
                orgAutBas = "относительный",
                innOfInd = "72689",
                otherInfAboutInd = "подумать",
                innIfEnterp = "45865",
                nameOfOrg = "сумасшедший",
                pos = "положенный",
                reqOfTheCertif = "60531",
                firstName = "Бачей ",
                secondName = "Тит",
                patronymic = "Юхимович",
                dateOfCreation = Date(),
                dateOfUpdate = Date()
        )
        xmlSignersRepository.save(xmlSigners)

        val xmlHeaders = XmlHeaders(
                serialNumberOfTheInvoice = "течение",
                dateOfInvoicing = Date(),
                codeOfForm = "1115125",
                dateOfCrOfTheInvoice = Date(),
                timeOfCrOfTheInvoice = Date(),
                codeOfTHeCurrency = "USD",
                numberOfTheCorrection = 12.4,
                dateOfTheCorrection = Date(),
                sumOfTax = 14.7,
                costOfGoodsWithTaxNumber = 162.7,
                costOfGoodsWithoutTaxNumber = 148.0,
                dateOfNote = "Июль",
                fileId = RandomStringUtils.randomAlphabetic(10),
                fileSenderId = "Зуфар",
                fileRecipientId = "Казбек",
                dateOfFile = Date(),
                typeOfDoc = "ДОП",
                nameOfDocOfOrganization = "постановление",
                nameOfTheDocOfEcon = "существование",
                nameOfTheEconSub = "производитель",
                foundOfTheCreatorFile = "искусство",
                gosContrId = "12465623",
                nameOfVal = "Доллар США",
                cursOfVal = 61.85,
                weight = 14.4)
        xmlHeadersRepository.save(xmlHeaders)
        xmlHeaders.buyerParticipant=xmlParticipants1
        xmlHeaders.vendorParticipant=xmlParticipants2
        xmlHeaders.shipParticipant=xmlParticipants3
        xmlHeaders.consParticipant=xmlParticipants4

        xmlHeadersRepository.save(xmlHeaders)
    }

}