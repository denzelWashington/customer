import {HttpClient} from "@angular/common/http";
import {Customer} from "./model";
import {Observable, tap} from "rxjs";
import {Injectable} from "@angular/core";
import {environment} from "../environments/environment";

@Injectable({ providedIn: 'root' })  // ✅

export class CustomerService {

  private apiUrl = `${environment.url}/customers`;


  constructor(private httpClient:HttpClient) {

  }

  public  getCustomer(): Observable<Customer[]> {
    console.log(this.apiUrl);
    return this.httpClient.get<Customer[]>("http://localhost:8082/customers");
  }

}
