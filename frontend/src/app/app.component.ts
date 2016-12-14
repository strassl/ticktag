import { Component, OnInit, ViewContainerRef, OnDestroy, NgZone } from '@angular/core';
import '../style/app.scss';
import { AuthService, ApiCallService, User, ErrorHandler } from './service';
import { Router } from '@angular/router';
import { Overlay } from 'angular2-modal';
import { Modal } from 'angular2-modal/plugins/bootstrap';
import { Response } from '@angular/http';
import * as $ from 'jquery';


@Component({
  selector: 'tt-app',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit, OnDestroy, ErrorHandler {
  private title: string;
  private user: User;
  private directTicketLinkEvent: (eventObject: JQueryEventObject) => any;

  // TODO make readonly once Intellij supports readonly properties in ctr
  constructor(
    private authService: AuthService,
    private modal: Modal,
    private overlay: Overlay,
    private vcRef: ViewContainerRef,
    private router: Router,
    private zone: NgZone,
    private apiCallService: ApiCallService) {

    apiCallService.initErrorHandler(this);
    this.title = 'TickTag';
    overlay.defaultViewContainer = vcRef;
  }


  ngOnInit(): void {
    this.user = this.authService.user;
    this.authService.observeUser()
      .subscribe(user => {
        this.user = user;
      });

    $(document).on('click', 'a.grammar-htmlifyCommands', this.directTicketLinkEvent = (e) => {
      e.preventDefault();
      this.zone.run(() => {
        this.router.navigate([
          '/project',
          e.currentTarget.getAttribute('data-projectId'),
          'ticket',
          e.currentTarget.getAttribute('data-ticketNumber'),
        ]);
      });
    });
  }

  ngOnDestroy() {
    if (this.directTicketLinkEvent) {
      $(document).off('click', 'a.grammar-htmlifyCommands', this.directTicketLinkEvent);
    }
  }

  logout(): void {
    this.clearUser();
    this.gotoHome();
  }

  onError(resp: any): void {
    console.dir(resp);
    if (resp instanceof Response) {
      if (statusGroup(resp.status) === 500) {
        console.log('Error: server');
        this.serverError(resp);
      } else if (statusGroup(resp.status) === 400) {
        console.log('Error: client');
        this.clientError(resp);
      } else {
        console.log('Error: other');
        this.otherError(resp);
      }
    } else {
      console.log('Error: unknown');
      this.unknownError(resp);
    }
  }

  private clientError(resp: Response): void {
    if (resp.status === 401) {
      console.log('Client error: unauthenticated');
      this.unauthenticatedError(resp);
    } else if (resp.status === 403) {
      console.log('Client error: unauthorized');
      this.unauthorizedError(resp);
    } else if (resp.status === 404) {
      console.log('Client error: not found');
      this.notFoundError(resp);
    } else {
      console.log('Client error: other');
      this.otherError(resp);
    }
  }

  private unauthenticatedError(resp: Response): void {
    this.modal.alert()
      .size('sm')
      .isBlocking(true)
      .title('Unauthenticated')
      .body('You are not logged in')
      .okBtn('Login')
      .open()
      .then(promise => {
        promise.result.then(result => {
          this.clearUser();
          this.gotoLogin();
        });
      });
  }

  private unauthorizedError(resp: Response): void {
    // TODO the backend should respond with unauthenticated, but this is an acceptable workaround
    if (this.user == null) {
      console.log('User is not logged in, switching to unauthenticated');
      this.unauthenticatedError(resp);
      return;
    }

    this.modal.alert()
      .size('sm')
      .title('Unauthorized')
      .body('You are not permitted to access this page')
      .okBtn('Okay ☹')
      .open()
      .then(promise => {
        promise.result.then(result => this.gotoHome());
      });
  }

  private notFoundError(resp: Response): void {
    this.modal.alert()
      .size('sm')
      .title('Not found')
      .body('Sorry. Whatever you are looking for...it\'s not here')
      .open()
      .then(promise => {
        promise.result.then(result => this.gotoHome());
      });
  }

  private serverError(resp: Response): void {
    let bodyHtml = '<p>';
    bodyHtml += 'Sorry, something went terribly wrong. Please contact us so we can fix it';
    bodyHtml += '</p>';
    bodyHtml += '<code>';
    bodyHtml += resp;
    bodyHtml += '</code>';

    this.modal.alert()
      .size('sm')
      .title('Server error')
      .body(bodyHtml)
      .open()
      .then(promise => {
        promise.result.then(result => this.gotoHome());
      });
  }

  private otherError(resp: Response): void {
    this.unknownError(resp);
  }

  private unknownError(resp: any): void {
    let bodyHtml = '<p>';
    bodyHtml += 'We don\'t know what just happened but it\'s not good. Please contact us so we can fix it';
    bodyHtml += '</p>';
    bodyHtml += '<hr />';
    bodyHtml += '<code>';
    bodyHtml += resp;
    bodyHtml += '</code>';

    this.modal.alert()
      .size('lg')
      .title('Unknown error')
      .body(bodyHtml)
      .open()
      .then(promise => {
        promise.result.then(result => this.gotoHome());
      });
  }

  private gotoLogin() {
    this.router.navigate(['/login']);
  }

  private gotoHome() {
    this.router.navigate(['/']);
  }

  private clearUser() {
    this.authService.user = null;
  }
}

function statusGroup(statusCode: number) {
  return Math.floor(statusCode / 100) * 100;
}
