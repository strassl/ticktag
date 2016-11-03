import {Component} from '@angular/core';
import {Router} from '@angular/router';
import {AuthApi} from '../api/api/AuthApi';
import {LoginRequest} from '../api/model/LoginRequest';
import {AuthService} from '../service/auth/auth.service';

@Component({
  selector: 'tt-login',
  templateUrl: './login.component.html',
})
export class LoginComponent {
  private email: string;
  private password: string;

  constructor(private router: Router,
              private authApi: AuthApi,
              private authService: AuthService) {
  }

  onSubmit(): void {
    let req: LoginRequest = {
      email: this.email,
      password: this.password,
    };

    this.authApi.loginUsingPOST(req)
      .subscribe(result => {
        this.authService.setToken(result.token);
        this.router.navigate(['/whoami']);
      }, error => {
        alert(error);
      });
  }
}
