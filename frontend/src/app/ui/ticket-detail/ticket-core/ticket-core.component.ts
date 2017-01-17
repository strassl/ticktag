import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges } from '@angular/core';
import {
  TicketDetail, TicketDetailTag, TicketDetailTransient,
  TicketDetailUser, TicketDetailRelated, TicketDetailTimeCategory,
  TicketDetailAssTag
} from '../ticket-detail';
import { SubticketCreateEvent } from '../subticket-add/subticket-add.component';
import * as imm from 'immutable';
import { Subject } from 'rxjs';
import { CommandTextviewSaveEvent } from '../../../util/command-textview/command-textview.component';
import { Cmd } from '../../../service/command/grammar';
import { ResetEvent } from '../subticket-add/subticket-add.component';
import { TicketRestoreEvent } from '../subticket/subticket.component';

@Component({
  selector: 'tt-ticket-core',
  templateUrl: './ticket-core.component.html',
  styleUrls: ['./ticket-core.component.scss']
})
export class TicketCoreComponent implements OnChanges {
  @Input() open: boolean;

  @Input() title: string;
  @Input() titleTransient = false;
  @Output() readonly titleChange = new EventEmitter<string>();

  @Input() description: string;
  @Input() descriptionTransient = false;
  @Output() readonly descriptionChange = new EventEmitter<{text: string, commands: imm.List<Cmd>}>();

  @Input() storypoints: number;
  @Input() storypointsTransient = false;
  @Output() readonly storypointsChange = new EventEmitter<number>();

  @Input() tags: imm.List<TicketDetailTransient<TicketDetailTag>>;
  private tagIds: imm.List<{ id: string, transient: boolean }>;  // generated by tags
  @Output() readonly tagAdd = new EventEmitter<string>();
  @Output() readonly tagRemove = new EventEmitter<string>();

  @Input() initialEstimatedTime: number;
  @Input() initialEstimatedTimeTransient: boolean = false;
  @Output() readonly initialEstimatedTimeChange = new EventEmitter<number>();

  @Input() currentEstimatedTime: number;
  @Input() currentEstimatedTimeTransient: boolean = false;
  @Output() readonly currentEstimatedTimeChange = new EventEmitter<number>();

  @Input() dueDate: number;
  @Input() dueDateTransient: boolean = false;
  @Output() readonly dueDateChange = new EventEmitter<number>();

  @Input() subtickets: imm.List<TicketDetailRelated>;
  @Output() subticketAdd = new EventEmitter<SubticketCreateEvent>();

  // Readonly
  @Input() ticket: TicketDetail;
  @Input() number: number;
  @Input() creator: TicketDetailUser;
  @Input() createTime: number;
  @Input() allTicketTags: imm.Map<string, TicketDetailTag>;
  @Input() allTimeCategories: imm.Map<string, TicketDetailTimeCategory>;
  @Input() allAssignmentTags: imm.Map<string, TicketDetailAssTag>;

  // Internal state
  private editingDescription = false;
  private descriptionResetSubject = new Subject<string>();
  private currentDescripton = '';
  private currentCommands = imm.List<Cmd>();

  private readonly subticketAddResetSubject = new Subject<ResetEvent>();

  ngOnChanges(changes: SimpleChanges): void {
    if ('tags' in changes) {
      this.tagIds = this.tags.map(tag => ({ id: tag.value.id, transient: tag.transient })).toList();
    }
  }

  onEditDescription() {
    this.editingDescription = true;
    this.currentDescripton = this.description;
    window.setTimeout(() => {
      this.descriptionResetSubject.next(this.description);
    }, 0);
  }

  onDescriptionChange(val: CommandTextviewSaveEvent) {
    this.currentDescripton = val.text;
    this.currentCommands = val.commands;
  }

  onSaveDescription() {
    this.editingDescription = false;
    this.descriptionChange.emit({
      text: this.currentDescripton,
      commands: this.currentCommands
    });
  }

  onAbortDescription() {
    this.editingDescription = false;
  }

  onSubticketRestore(event: TicketRestoreEvent) {
    this.subticketAddResetSubject.next(event);
  }
}
