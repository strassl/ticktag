import {
    Component, Input, ElementRef, AfterViewInit, OnChanges, SimpleChanges,
    OnDestroy, EventEmitter, Output
} from '@angular/core';
import { UserResultJson, UserApi, TicketApi, TicketResultJson } from '../../../api';
import { ApiCallService } from '../../../service';
import { using } from '../../../util/using';
import * as grammar from './grammar';
import * as imm from 'immutable';
import {
    TicketDetailAssTag, TicketDetailTimeCategory, TicketDetailTag,
    TicketDetailTransient, TicketDetailUser, TicketDetailAssignment
} from '../ticket-detail';

const codemirror = require('codemirror');
require('codemirror/addon/hint/show-hint');

const COMMAND_COMPLETIONS = grammar.COMMAND_STRINGS.map(c => {
    if (c === 'close' || c === 'reopen') {
        return `!${c} `;
    } else {
        return `!${c}:`;
    }
}).sort(using<string>(c => c.replace('-', '')));

export type CommentTextviewSaveEvent = {
    commands: imm.List<grammar.Cmd>,
    text: string,
}

@Component({
    selector: 'tt-command-textview',
    templateUrl: './command-textview.component.html',
    styleUrls: ['./command-textview.component.scss']
})
export class CommandTextviewComponent implements AfterViewInit, OnChanges, OnDestroy {
    @Input() initialContent: string;
    @Input() projectId: string;
    @Input() activeTags: imm.List<TicketDetailTransient<TicketDetailTag>>;
    @Input() assignedUsers: imm.Map<TicketDetailUser, imm.List<TicketDetailAssignment>>;
    @Input() allTicketTags: imm.Map<string, TicketDetailTag>;
    @Input() allTimeCategories: imm.Map<string, TicketDetailTimeCategory>;
    @Input() allAssignmentTags: imm.Map<string, TicketDetailAssTag>;
    @Input() working = false;

    @Output() readonly contentChange = new EventEmitter<CommentTextviewSaveEvent>();
    @Output() readonly save = new EventEmitter<void>();

    private content = '';
    private instance: any = null;
    private commands = imm.List<grammar.Cmd>();

    private refreshTimeout: number = null;

    constructor(
        private element: ElementRef,
        private userApi: UserApi,
        private apiCallService: ApiCallService,
        private ticketApi: TicketApi) {
    }

    ngAfterViewInit(): void {
        let ta: HTMLTextAreaElement = this.element.nativeElement.querySelector('textarea');
        ta.value = this.initialContent || '';
        this.content = this.initialContent || '';
        this.instance = codemirror.fromTextArea(ta, {
            mode: 'text',
            lineWrapping: true,
            autofocus: false,
        });
        this.instance.on('changes', () => {
            this.content = this.instance.getValue();
            if (this.refreshTimeout === null) {
                this.refreshTimeout = window.setTimeout(() => {
                    this.refreshTimeout = null;
                    this.processChanges();
                }, 100);
            }
        });
    }

    ngOnChanges(changes: SimpleChanges): void {
        if (this.instance && 'initialContent' in changes) {
            this.instance.setValue(changes['initialContent']);
        }
    }

    ngOnDestroy(): void {
        window.clearTimeout(this.refreshTimeout);
        this.refreshTimeout = null;
        this.instance.toTextArea();
    }

    private processChanges(): void {
      this.updateCommands();
      this.showHints();
      this.emitChange();
    }

    private emitChange(): void {
      this.contentChange.emit({
          commands: this.commands,
          text: this.content,
      });
    }

    private updateCommands() {
        this.commands = grammar.extractCommands(this.content);
    }

    private showHints() {
        let cursor: {line: number, ch: number} = this.instance.getCursor();
        let text: string = this.instance.getRange({line: cursor.line, ch: 0}, cursor);

        let isCommand = new RegExp(String.raw`${grammar.SEPERATOR_FRONT_REGEX}(![a-z-]{0,10})$`, 'ui').exec(text);
        if (isCommand) {
            this.instance.showHint({
                hint: () => ({
                    list: COMMAND_COMPLETIONS,
                    from: {line: cursor.line, ch: cursor.ch - isCommand[1].length},
                    to: cursor,
                    selectedHint: Math.max(0, COMMAND_COMPLETIONS.findIndex(c => c.toLowerCase().startsWith(isCommand[1].toLowerCase()))),
                }),
                completeSingle: false,
            });
            return;
        }

        let isTicket = new RegExp(String.raw`${grammar.SEPERATOR_FRONT_REGEX}#(\S{0,20})$`, 'ui').exec(text);
        if (isTicket) {
            this.instance.showHint({
                hint: () => {
                    let projectId = this.projectId;
                    return this.apiCallService
                        .callNoError<TicketResultJson[]>(p => this.ticketApi.listTicketsFuzzyUsingGETWithHttpInfo(
                            projectId,
                            isTicket[1],
                            ['NUMBER_DESC', 'TITLE_ASC'],
                            p))
                        .map(tickets => ({
                            list: tickets.map(ticket => ({
                                text: `${ticket.number} `,
                                displayText: `#${ticket.number}: ${ticket.title}`,
                            })),
                            from: {line: cursor.line, ch: cursor.ch - isTicket[1].length},
                            to: cursor,
                            selectedHint: Math.max(0, tickets.findIndex(ticket => ('' + ticket.number).startsWith(isTicket[1]))),
                        }))
                        .toPromise();
                },
                completeSingle: false,
            });
            return;
        }

        let isAddRemoveTag = new RegExp(String.raw`${grammar.SEPERATOR_FRONT_REGEX}!(-?)tag:(${grammar.TAG_LETTER}*)$`, 'ui').exec(text);
        if (isAddRemoveTag) {
            let tags = (isAddRemoveTag[1] ? this.activeTags.map(tag => tag.value) : this.allTicketTags)
                .valueSeq()
                .sort(using<TicketDetailTag>(tag => tag.normalizedName))
                .toArray();
            if (tags.length === 0) { return; }
            tags = tags.slice();
            tags.sort(using<TicketDetailTag>(tag => tag.normalizedName));
            this.instance.showHint({
                hint: () => ({
                    list: tags.map(tt => tt.normalizedName + ' '),
                    from: {line: cursor.line, ch: cursor.ch - isAddRemoveTag[2].length},
                    to: cursor,
                    selectedHint: Math.max(0, tags.findIndex(tt => tt.normalizedName.startsWith(isAddRemoveTag[2].toLowerCase()))),
                }),
                completeSingle: false,
            });
            return;
        }

        let isTimeTag = new RegExp(
            String.raw`${grammar.SEPERATOR_FRONT_REGEX}!time:${grammar.TIME_REGEX}@(${grammar.TAG_LETTER}*)$`, 'ui'
        ).exec(text);
        if (isTimeTag) {
            let cats = this.allTimeCategories
                .valueSeq()
                .sort(using<TicketDetailTimeCategory>(cat => cat.normalizedName))
                .toArray();
            if (cats.length === 0) { return; }
            this.instance.showHint({
                hint: () => ({
                    list: cats.map(cat => cat.normalizedName + ' '),
                    from: {line: cursor.line, ch: cursor.ch - isTimeTag[1].length},
                    to: cursor,
                    selectedHint: Math.max(0, cats.findIndex(cat => cat.normalizedName.startsWith(isTimeTag[1].toLowerCase()))),
                }),
                completeSingle: false,
            });
            return;
        }

        let isAssign = new RegExp(String.raw`${grammar.SEPERATOR_FRONT_REGEX}!assign:(${grammar.USER_LETTER}*)$`, 'ui').exec(text);
        if (isAssign) {
            this.instance.showHint({
                hint: () => {
                    let projectId = this.projectId;
                    return this.apiCallService
                        .callNoError<UserResultJson[]>(p => this.userApi.listUsersFuzzyUsingGETWithHttpInfo(
                            projectId,
                            isAssign[1],
                            ['USERNAME_ASC', 'NAME_ASC', 'MAIL_ASC'],
                            p))
                        .map(users => ({
                            list: users.map(user => ({
                                text: user.username + '@',
                                displayText: `${user.username} (${user.name} <${user.mail}>)`,
                            })),
                            from: {line: cursor.line, ch: cursor.ch - isAssign[1].length},
                            to: cursor,
                            selectedHint: Math.max(0, users.findIndex(user => user.username.startsWith(isAssign[1].toLowerCase()))),
                        }))
                        .toPromise();
                },
                completeSingle: false,
            });
            return;
        }

        let isAssignTag = new RegExp(
            String.raw`${grammar.SEPERATOR_FRONT_REGEX}!assign:${grammar.USER_REGEX}?@(${grammar.TAG_LETTER}*)$`,
            'ui'
        ).exec(text);
        if (isAssignTag) {
            let tags = this.allAssignmentTags
                .valueSeq()
                .sort(using<TicketDetailAssTag>(tag => tag.normalizedName))
                .toArray();
            if (tags.length === 0) { return; }
            this.instance.showHint({
                hint: () => ({
                    list: tags.map(tag => tag.normalizedName + ' '),
                    from: {line: cursor.line, ch: cursor.ch - isAssignTag[1].length},
                    to: cursor,
                    selectedHint: Math.max(0, tags.findIndex(tag => tag.normalizedName.startsWith(isAssignTag[1].toLowerCase()))),
                }),
                completeSingle: false,
            });
            return;
        }

        let isUnassign = new RegExp(
            String.raw`${grammar.SEPERATOR_FRONT_REGEX}!-assign:(${grammar.USER_LETTER}*(?:@${grammar.TAG_LETTER}*)?)$`,
            'ui'
        ).exec(text);
        if (isUnassign) {
            let aus = this.assignedUsers
                .map((assignments, user) => assignments.map(ass => ({
                    text: `${user.username}@${ass.tag.normalizedName} `,
                    displayText: `${user.username}@${ass.tag.normalizedName} (${user.name} <${user.mail}>)`,
                })))
                .valueSeq()
                .flatMap(it => it)
                .toArray();
            console.dir(aus);
            if (aus.length === 0) { return; }
            this.instance.showHint({
                hint: () => ({
                    list: aus,
                    from: {line: cursor.line, ch: cursor.ch - isUnassign[1].length},
                    to: cursor,
                    selectedHint: Math.max(0, aus.findIndex(au => au.text.startsWith(isUnassign[1].toLowerCase()))),
                }),
                completeSingle: false,
            });
            return;
        }
    }
}
