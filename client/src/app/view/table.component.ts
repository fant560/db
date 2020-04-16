import {Component, Inject, OnInit} from '@angular/core';
import {RestDatasource} from '../datasource/rest.datasource';
import {Main} from '../model/main.component';

@Component({
  selector: 'app-table-main',
  templateUrl: './table.component.html'
})
export class TableComponent implements OnInit {

  private data: Array<Main> = new Array<Main>();
  private restDatasource: RestDatasource;
  public date = new Date();

  constructor(@Inject(RestDatasource) restDatasource: RestDatasource) {
    this.restDatasource = restDatasource;
  }

  ngOnInit() {
    this.restDatasource.getHeaders().subscribe(it => this.data.push(...it));
  /*  this.restDatasource.getHeaders().subscribe(it => {
      it.forEach(element => {
        const main = new Main(
          element.nameOfProduct,
          element.unitCode,
          element.countryCodeOfProduct,
          element.quantity,
          element.priceOfUnit,
          element.sumOfProductWithoutTax,
          element.sumOfExcise,
          element.taxRate,
          element.sumOfTax,
          element.sumOfProductWithTax,
          element.countryCodeOfProduct,
          element.countryCodeOfProduct,
          element.corAccDebit
        );
        this.data.push(main);
      });
    });*/

  }

  getData(): Array<Main> {
    return this.data;
  }

  getTotalCount(): number {
    return this.data.map(data => data.priceOfUnit * data.quantity).reduce((n1, n2) =>{
      return n1 + n2;
    }, 0);
  }

  getLocalDate(): string {
    return this.date.toLocaleDateString();
  }
}
