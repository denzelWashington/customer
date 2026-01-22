import {Component, computed, effect, signal} from '@angular/core';
import {RouterOutlet} from '@angular/router';
import {FormBuilder, FormControl, FormGroup, isFormControl, ReactiveFormsModule, Validators} from "@angular/forms";
import {CustomerService} from "./customerService";
import {Customer} from "./model";

import {PasseComponent} from "./passe/passe.component";

@Component({
    selector: 'app-root',
    imports: [RouterOutlet, ReactiveFormsModule, PasseComponent],
    templateUrl: './app.component.html',
    styleUrl: './app.component.css'
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
    });
  }

  title = 'customer';
  count = signal(0);

  doubleCount = computed(() => this.count() * 2);

  inc() {
    this.count.update(v => v + 1);
  }

  onSubmit() {
    if (this.form.valid) {
      console.log(this.form);
      console.log(this.form.pristine);
      console.log(this.form.dirty);
      console.log(this.form.value);
      console.log(this.form.value.arguments);
      console.log("**" + this.form.get("email")?.value);
    } else {
      console.log(this.form.pristine);
      console.log(this.form.dirty);
      this.form.markAsTouched();
    }
  }

  traiterExit(val: any) {
    console.log("la valeur recu" + val);
  }

}
