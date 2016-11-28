import { Component, Input } from '@angular/core';
import { TicketDetailSubticket } from '../ticket-detail';

@Component({
  selector: 'tt-subticket',
  templateUrl: './subticket.component.html',
  styleUrls: ['./subticket.component.scss']
})
export class SubticketComponent {
  @Input() ticket: TicketDetailSubticket;
}