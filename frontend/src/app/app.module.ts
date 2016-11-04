import { NgModule, ApplicationRef } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { routing } from './app.routing';

import { removeNgStyles, createNewHosts } from '@angularclass/hmr';
import {AuthService} from './service/auth/auth.service';
import {LoginComponent} from './login/login.component';
import {WhoamiComponent} from './whoami/whoami.component';
import {HomeComponent} from './home/home.component';
import {AuthApi} from './api/api/AuthApi';
import {Ng2Webstorage} from 'ng2-webstorage/dist/app';
import {UsersComponent} from './users/users.component';
import {UserApi} from './api/api/UserApi';

@NgModule({
  imports: [
    BrowserModule,
    HttpModule,
    FormsModule,
    Ng2Webstorage,
    routing
  ],
  declarations: [
    AppComponent,
    HomeComponent,
    LoginComponent,
    WhoamiComponent,
    UsersComponent,
  ],
  providers: [
    AuthApi,
    UserApi,

    AuthService
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
  constructor(public appRef: ApplicationRef) {}
  hmrOnInit(store) {
    console.log('HMR store', store);
  }
  hmrOnDestroy(store) {
    let cmpLocation = this.appRef.components.map(cmp => cmp.location.nativeElement);
    // recreate elements
    store.disposeOldHosts = createNewHosts(cmpLocation);
    // remove styles
    removeNgStyles();
  }
  hmrAfterDestroy(store) {
    // display new elements
    store.disposeOldHosts();
    delete store.disposeOldHosts;
  }
}
