import {TestBed} from '@angular/core/testing';
import {provideRoutes} from '@angular/router';
import {RouterTestingModule} from '@angular/router/testing';
import {AppComponent} from './app.component';
import {AuthService, ApiCallService} from './service';
import {User} from './service/auth/user';
import {Observable} from 'rxjs/Rx';
import {Injectable} from '@angular/core';
import {MaterialModule} from '@angular/material';
import {Overlay, OverlayRenderer} from 'angular2-modal';
import {Modal} from 'angular2-modal/plugins/bootstrap';

@Injectable()
class MockAuthService extends AuthService {
  constructor() {
    super(null);
  }

  get user(): User|null {
    return null;
  }

  set user(user: User|null) {
  }

  observeUser(): Observable<User|null> {
    return Observable.empty<User|null>();
  }
}

describe('App', () => {
  // provide our implementations or mocks to the dependency injector
  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [RouterTestingModule, MaterialModule.forRoot()],
      declarations: [AppComponent],
      providers: [provideRoutes([]), {provide: AuthService, useClass: MockAuthService}, ApiCallService, Overlay, Modal, OverlayRenderer],
    });
  });

  it('should have a title', () => {
    let fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    expect(fixture.debugElement.componentInstance.title).toEqual('TickTag');
  });
});
