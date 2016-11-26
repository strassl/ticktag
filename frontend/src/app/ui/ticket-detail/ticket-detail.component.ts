import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ApiCallService } from '../../service';
import {
  TicketApi, TicketResultJson, CommentsApi, AssignmenttagApi,
  AssignmentTagResultJson, CommentResultJson, TicketTagResultJson,
  TickettagApi, TimeCategoryJson, TimecategoryApi, UserResultJson,
  GetApi, GetResultJson
} from '../../api';
import { Observable } from 'rxjs';

@Component({
  selector: 'tt-ticket-detail',
  templateUrl: './ticket-detail.component.html',
  styleUrls: ['./ticket-detail.component.scss']
})
export class TicketDetailComponent implements OnInit {
  private loading = true;
  private ticket: TicketResultJson | null = null;
  private comments: CommentResultJson[] | null = null;
  private allAssignmentTags: AssignmentTagResultJson[] | null = null;
  private allTicketTags: TicketTagResultJson[] | null = null;
  private allTimeCategories: TimeCategoryJson[] | null = null;
  private assignedUsers: UserResultJson[] | null = null;

  // TODO make readonly once Intellij supports readonly properties in ctr
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private apiCallService: ApiCallService,
    private ticketApi: TicketApi,
    private commentsApi: CommentsApi,
    private assigmentTagsApi: AssignmenttagApi,
    private ticketTagsApi: TickettagApi,
    private timeCategoryApi: TimecategoryApi,
    private getApi: GetApi) {
  }

  ngOnInit(): void {
    this.route.params
      .do(() => { this.loading = true; })
      .switchMap(params => {
        let ticketId = '' + params['ticketNumber'];
        let projectId = '' + params['projectId'];

        let ticketObs = this.apiCallService
          .callNoError<TicketResultJson>(p => this.ticketApi.getTicketUsingGETWithHttpInfo(ticketId, p));
        let commentsObs = this.apiCallService
          .callNoError<CommentResultJson[]>(p => this.commentsApi.listCommentsUsingGETWithHttpInfo(ticketId, p));
        let assignmentTagsObs = this.apiCallService
          .callNoError<AssignmentTagResultJson[]>(p => this.assigmentTagsApi.listAssignmentTagsUsingGETWithHttpInfo(projectId, p));
        let ticketTagsObs = this.apiCallService
          .callNoError<TicketTagResultJson[]>(p => this.ticketTagsApi.listTicketTagsUsingGETWithHttpInfo(null, projectId, p));
        let timeCategoriesObs = this.apiCallService
          .callNoError<TimeCategoryJson[]>(p => this.timeCategoryApi.listProjectTimeCategoriesUsingGETWithHttpInfo(projectId, p));

        return Observable.zip(ticketObs, commentsObs, assignmentTagsObs, ticketTagsObs, timeCategoriesObs);
      })
      .switchMap(tuple => {
        let wantedUsers = tuple[0].ticketUserRelations.map(ta => ta.userId);
        let obs = this.apiCallService
          .callNoError<GetResultJson>(p => this.getApi.getUsingGETWithHttpInfo(wantedUsers, p));
        return Observable.zip(Observable.of(tuple), obs);
      })
      .subscribe(tuple => {
        let [[ticket, comments, assignmentTags, ticketTags, timeCategories], joined] = tuple;
        this.ticket = ticket;
        this.comments = comments;
        this.allAssignmentTags = assignmentTags;
        this.allTicketTags = ticketTags;
        this.allTimeCategories = timeCategories;
        this.assignedUsers = ticket.ticketUserRelations.map(ta => joined.users[ta.userId]).filter(it => it);
        this.loading = false;
      });
  }
}
