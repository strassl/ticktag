import { Component, Input } from '@angular/core';
import {TicketEventResultJson} from '../../../../api/model/TicketEventResultJson';

@Component({
  selector: 'tt-ticket-event',
  templateUrl: './ticket-event.component.html',
  styleUrls: ['../ticket-events.component.scss']
})
export class TicketEventComponent {
  @Input() event: TicketEventResultJson;

  dateFromInstant(date: number) {
    return new Date(date);
  }
}