import {Component, computed, effect, signal} from '@angular/core';
import {RouterOutlet} from '@angular/router';
import {FormBuilder, FormControl, FormGroup, isFormControl, ReactiveFormsModule, Validators} from "@angular/forms";
import {CustomerService} from "./customerService";
import {Customer} from "./model";
import {NgForOf} from "@angular/common";
import {HttpClient} from "@angular/common/http";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, ReactiveFormsModule, NgForOf],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent {

  customers: Customer[] = [];
  form: FormGroup;

  constructor(private fb: FormBuilder, private cs: CustomerService) {
    effect(() => {
      console.log(this.count());
      localStorage.setItem('count', this.count().toString());
    });

    this.cs.getCustomer().subscribe(value => this.customers = value);
    this.form = new FormGroup({
      email: new FormControl('', Validators.required)
    })
  }

  title = 'customer';
  count = signal(0);

  doubleCount = computed(() => this.count() * 2);

  inc() {
    this.count.update(v => v + 1);
  }

}
