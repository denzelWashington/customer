import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Photo} from "./passe/photo.model";

@Injectable({
  providedIn: 'root'
})
export class HelloService {

  constructor(private httplient: HttpClient) {
  }

  getphoto(): Observable<Photo[]> {
    return this.httplient.get<Photo[]>("https://jsonplaceholder.typicode.com/photos");
  }

}
