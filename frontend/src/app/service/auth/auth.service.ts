import {Injectable} from '@angular/core';
import {LocalStorageService} from 'ng2-webstorage';
import {Observable} from 'rxjs/Rx';

const KEY_TOKEN = 'token';

@Injectable()
export class AuthService {
  constructor(private localStorageService: LocalStorageService) {
  }

  getToken(): string|null {
    let stored = this.localStorageService.retrieve(KEY_TOKEN);
    if (stored) {
      return stored;
    } else {
      return null;
    }
  }

  setToken(token: string|null): void {
    this.localStorageService.store(KEY_TOKEN, token);
  }

  observeToken(): Observable<string|null> {
    return this.localStorageService.observe(KEY_TOKEN).asObservable();
  }
}
