import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges } from '@angular/core';
import { TicketDetailTag, TicketDetailTransient, TicketDetailUser, TicketDetailRelated } from '../ticket-detail';
import * as imm from 'immutable';

@Component({
  selector: 'tt-ticket-core',
  templateUrl: './ticket-core.component.html',
  styleUrls: ['./ticket-core.component.scss']
})
export class TicketCoreComponent implements OnChanges {
    @Input() open: boolean;
    // TODO no output
    @Input() title: string;
    @Output() titleChange = new EventEmitter<string>();
    @Input() description: string;
    @Output() descriptionChange = new EventEmitter<string>();
    @Input() storypoints: number;
    @Output() storypointsChange = new EventEmitter<number>();
    @Input() tags: imm.List<TicketDetailTransient<TicketDetailTag>>;
    private tagIds: imm.List<{id: string, transient: boolean}>;  // generated by tags
    @Output() tagAdd = new EventEmitter<string>();
    @Output() tagRemove = new EventEmitter<string>();
    @Input() initialEstimatedTime: number;
    // TODO no output
    @Input() currentEstimatedTime: number;
    // TODO no output
    @Input() dueDate: number;
    // TODO no output
    @Input() subtickets: TicketDetailRelated[];
    // TODO no output

    // Readonly
    @Input() number: number;
    @Input() creator: TicketDetailUser;
    @Input() createTime: number;
    @Input() allTags: imm.Map<string, TicketDetailTag>;

    editingTitle: boolean = false;
    editingDescription: boolean = false;

    ngOnChanges(changes: SimpleChanges): void {
      if ('tags' in changes) {
        this.tagIds = this.tags.map(tag => ({ id: tag.value.id, transient: tag.transient })).toList();
      }
    }
}
