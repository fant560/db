import {Inject, Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {Main} from '../model/main.component';

@Injectable()
export class RestDatasource {

  public http: HttpClient;

  constructor(@Inject(HttpClient) http: HttpClient) {
    this.http = http;
  }

  getHeaders(): Observable<Array<Main>> {
    console.log('calling rest data');
    return this.http.get<Array<Main>>('/lines/all');
  }

}
