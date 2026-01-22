import {Component, EventEmitter, input, Input, output, Output} from '@angular/core';
import {CurrencyPipe} from "@angular/common";
import {HelloService} from "../hello.service";
import {Photo} from "./photo.model";
import {ButtonModule} from 'primeng/button'; // 1. Importe le module du bouton

@Component({
  selector: 'app-passe',
  imports: [CurrencyPipe, ButtonModule],
  templateUrl: './passe.component.html',
  styleUrl: './passe.component.css',
  standalone: true,
})
export class PasseComponent {

  photos: Photo[] = [];

  constructor(private helloService: HelloService) {
    this.helloService.getphoto().subscribe(value => this.photos = value);
  }

  clicked = output<number>();
  devise = input<number>(0);  // Nouvelle syntaxe


  ngOnChanges() {
    console.log(this.devise);
  }

  send() {
    this.clicked.emit(this.devise())
  }


}
