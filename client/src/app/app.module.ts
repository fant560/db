import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import {TableComponent} from './view/table.component';
import {RestDatasource} from './datasource/rest.datasource';
import {HttpClient, HttpClientModule} from '@angular/common/http';

@NgModule({
  declarations: [
    TableComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule
  ],
  providers: [RestDatasource],
  bootstrap: [TableComponent]
})
export class AppModule { }
