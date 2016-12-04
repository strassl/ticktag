import {Component, OnInit} from '@angular/core';
import * as imm from 'immutable';
import {ApiCallService} from '../../service/api-call/api-call.service';
import {BoardApi} from '../../api/api/BoardApi';
import {Router, ActivatedRoute} from '@angular/router';
import { Observable } from 'rxjs';
import {UserResultJson} from '../../api/model/UserResultJson';
import {Tag} from '../../util/taginput/taginput.component';
import {TicketTagResultJson} from '../../api/model/TicketTagResultJson';
import {TicketResultJson} from '../../api/model/TicketResultJson';
import {KanbanColumnResultJson} from '../../api/model/KanbanColumnResultJson';
import {GetResultJson} from '../../api/model/GetResultJson';
import {GetApi} from '../../api/api/GetApi';
import {TickettagApi} from '../../api/api/TickettagApi';
import { idListToMap } from '../../util/listmaputils';

@Component({
  selector: 'tt-kanban-board-detail',
  templateUrl: './kanban-board-detail.component.html',
  styleUrls: ['./kanban-board-detail.component.scss']
})
export class KanbanBoardDetailComponent implements OnInit {
  private kanbanColumns: imm.List<KanbanDetailColumn>;
  private allTicketTags: imm.Map<string, KanbanDetailTag>;
  private interestingTickets: imm.Map<string, KanbanDetailTicket>;
  private interestingUsers: imm.Map<string, KanbanDetailUser>;

  private loading = true;

  constructor(private route: ActivatedRoute,
              private router: Router,
              private apiCallService: ApiCallService,
              private getApi: GetApi,
              private ticketTagsApi: TickettagApi,
              private kanbanBoardApi: BoardApi) {}

  ngOnInit(): void {
    this.route.params
      .do(() => { this.loading = true; })
      .switchMap(params => {
        let projectId = params['projectId'];
        let boardId = params['boardId'];
        return this.refresh(projectId, boardId);
      })
      .subscribe(() => {
        this.loading = false;
      });
  }

  private refresh(projectId: string, boardId: string): Observable<void> {
    let kanbanColumnObs = this.apiCallService
      .callNoError<KanbanColumnResultJson[]>(p => this.kanbanBoardApi.listKanbanColumnsUsingGETWithHttpInfo(boardId, p));

    let ticketTagsObs = this.apiCallService
      .callNoError<TicketTagResultJson[]>(p => this.ticketTagsApi.listTicketTagsUsingGETWithHttpInfo(null, projectId, p))
      .map(tts => idListToMap(tts).map(tt => new KanbanDetailTag(tt)).toMap());
    return Observable
      .zip(kanbanColumnObs, ticketTagsObs)
      .flatMap(tuple => {
        let columnResults = tuple[0];
        let wantedTicketIds: string[] = [];
        columnResults.forEach(c => {
          c.ticketIds.forEach(id => {
            if (!wantedTicketIds.includes(id)) {
              wantedTicketIds.push(id);
            }
          });
        });

        let getObs = this.apiCallService
          .callNoError<GetResultJson>(p => this.getApi.getUsingPOSTWithHttpInfo({ ticketIds: wantedTicketIds }, p));
        return Observable.zip(Observable.of(tuple), getObs);
      })
      .flatMap(tuple => {
        let ticketsResult = tuple[1];
        let wantedUserIds: string[] = [];
        for (let key in ticketsResult.tickets) {
          if (ticketsResult.tickets.hasOwnProperty(key)) {
            let t = ticketsResult.tickets[key];
            t.ticketUserRelations.map(ta => wantedUserIds.push(ta.userId));
          }
        }

        let getObs = this.apiCallService
          .callNoError<GetResultJson>(p => this.getApi.getUsingPOSTWithHttpInfo({ userIds: wantedUserIds }, p));

        return Observable.zip(Observable.of(tuple[0]), Observable.of(tuple[1]), getObs);
      })
      .do(tuple => {

        this.allTicketTags = tuple[0][1];
        this.interestingUsers = imm.Map(tuple[2].users).map(u => new KanbanDetailUser(u)).toMap();
        this.interestingTickets = imm.Map(tuple[1].tickets)
          .map(t => new KanbanDetailTicket(t, this.interestingUsers, this.allTicketTags)).toMap();
        this.kanbanColumns = imm.List(tuple[0][0]).map(c => new KanbanDetailColumn(c, this.interestingTickets)).toList();
        console.log(this.kanbanColumns);
      })
      .map(it => undefined);
  }
}


export class KanbanDetailColumn {
  readonly color: string;
  readonly id: string;
  readonly kanbanBoardId: string;
  readonly name: string;
  readonly normalizedName: string;
  readonly order: number;
  readonly tickets: imm.List<KanbanDetailTicket>;

  constructor(c: KanbanColumnResultJson,
              tickets: imm.Map<string, KanbanDetailTicket>) {
    this.color = c.color;
    this.id = c.id;
    this.kanbanBoardId = c.kanbanBoardId;
    this.name = c.name;
    this.normalizedName = c.normalizedName;
    this.order = c.order;
    this.tickets = imm.List(c.ticketIds)
      .map(id => tickets.get(id))
      .toList();
    Object.freeze(this);
  }

}
Object.freeze(KanbanDetailColumn.prototype);

export class KanbanDetailUser {
  readonly id: string;
  readonly mail: string;
  readonly name: string;
  readonly username: string;

  constructor(user: UserResultJson) {
    this.id = user.id;
    this.mail = user.mail;
    this.name = user.name;
    this.username = user.username;
    Object.freeze(this);
  }
}
Object.freeze(KanbanDetailUser.prototype);

export class KanbanDetailTag implements Tag {
  readonly id: string;
  readonly name: string;
  readonly normalizedName: string;
  readonly order: number;
  readonly color: string;

  constructor(tag: TicketTagResultJson) {
    this.id = tag.id;
    this.name = tag.name;
    this.normalizedName = tag.normalizedName;
    this.order = tag.order;
    this.color = tag.color;
    Object.freeze(this);
  }
}
Object.freeze(KanbanDetailTag.prototype);

export class KanbanDetailTicket {
  readonly createTime: number;
  readonly currentEstimatedTime: number|undefined;
  readonly dueDate: number|undefined;
  readonly description: string;
  readonly id: string;
  readonly initialEstimatedTime: number|undefined;
  readonly number: number;
  readonly open: boolean;
  readonly storyPoints: number|undefined;
  readonly tags: imm.List<KanbanDetailTag>;
  readonly title: string;
  readonly users: imm.List<KanbanDetailUser>;
  readonly projectId: string;

  constructor(
    ticket: TicketResultJson,
    users: imm.Map<string, KanbanDetailUser>,
    ticketTags: imm.Map<string, KanbanDetailTag>) {
    this.createTime = ticket.createTime;
    this.currentEstimatedTime = ticket.currentEstimatedTime;
    this.dueDate = ticket.dueDate;
    this.description = ticket.description;
    this.id = ticket.id;
    this.initialEstimatedTime = ticket.initialEstimatedTime;
    this.number = ticket.number;
    this.open = ticket.open;
    this.storyPoints = ticket.storyPoints;
    this.tags =  imm.List(ticket.tagIds)
      .map(tid => ticketTags.get(tid))
      .sort((a, b) => (a.order < b.order) ? -1 : (a.order === b.order ? 0 : 1))
      .toList();
    this.title = ticket.title;
    let tempUserIds: string[] = [];
    ticket.ticketUserRelations.forEach(r => {
      if (!tempUserIds.includes(r.userId)) {
        tempUserIds.push(r.userId);
      }
    });
    this.users = imm.List(tempUserIds)
      .map(id => users.get(id))
      .toList();
    this.projectId = ticket.projectId;
  }
}
Object.freeze(KanbanDetailTicket.prototype);

