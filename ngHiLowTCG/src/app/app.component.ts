import { Component, OnInit } from '@angular/core';
import { Authentication } from './services/authentication.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'ngHiLowTCG';
  
  constructor(private auth: Authentication){}
  
  
  ngOnInit() {
    this.tempTestDeleteMeLater(); // DELETE LATER!!!
  }
  
  tempTestDeleteMeLater() {
    this.auth.login('test','test').subscribe({ // change username to match DB
      next: (data) => {
        console.log('Logged in:');
        console.log(data);
      },
      error: (fail) => {
        console.error('Error authenticating:')
        console.error(fail);
      }
    });
  }




}


