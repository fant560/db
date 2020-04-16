
export class Main {
  constructor(
    public numberOfRow: number,
    public nameOfProduct: string,
    public quantity: number,
    public unitCode: string,
    public priceOfUnit: number,
    public sumOfProductWithoutTax: number,
    public sumOfTax: number,
    public sumOfProductWithTax: number,
    public sumOfExcise: number,
    public dateOfRecording: string,
    public countryCodeOfProduct: string,
    public dateOfLastUpdate: string,
    public attributeOfProduct: string,
    public otherInfoAboutProduct: string,
    public codeOfProduct: string,
    public unitName: string,
    public briefNameOfCountryOfProd: string,
    public quantityOfLettingGo: number,
    public corAccDebit: string,
    public corAccCredit: string,
    public taxRate: string,
    public id: number
  ) {
  }
}
