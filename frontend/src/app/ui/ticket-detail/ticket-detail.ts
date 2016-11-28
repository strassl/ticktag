import {
  TicketResultJson, CommentResultJson, UserResultJson, TicketTagResultJson,
  AssignmentTagResultJson, TimeCategoryJson
} from '../../api';
import * as imm from 'immutable';
import { Tag } from '../../util/taginput/taginput.component';

export class TicketDetailAssignment {
  readonly tag: TicketDetailAssTag;
  readonly transient: boolean;

  constructor(tag: TicketDetailAssTag, transient: boolean) {
    this.tag = tag;
    this.transient = transient;
    Object.freeze(this);
  }
}
Object.freeze(TicketDetailAssignment.prototype);

export class TicketDetailTransient<T> {
  value: T;
  transient: boolean;

  constructor(value: T, transient: boolean) {
    this.value = value;
    this.transient = transient;
    Object.freeze(this);
  }
}
Object.freeze(TicketDetailTransient.prototype);

export class TicketDetailTransientUser {
  readonly user: TicketDetailUser;
  readonly tags: imm.Set<string>;  // This does not need to be a rich object, because all tags are known.

  constructor(user: TicketDetailUser, tags: imm.Set<string>) {
    this.user = user;
    this.tags = tags;
    Object.freeze(this);
  }
}
Object.freeze(TicketDetailTransientUser.prototype);

export class TicketDetailTimeCategory {
  readonly id: string;
  readonly normalizedName: string;
  readonly name: string;

  constructor(category: TimeCategoryJson) {
    this.id = category.id;
    this.normalizedName = category.normalizedName;
    this.name = name;
    Object.freeze(this);
  }
}
Object.freeze(TicketDetailTimeCategory.prototype);

export class TicketDetailComment {
  readonly id: string;
  readonly createTime: number;
  readonly text: string;
  readonly user: TicketDetailUser;

  constructor(comment: CommentResultJson, users: imm.Map<string, TicketDetailUser>) {
    this.id = comment.id;
    this.createTime = comment.createTime;
    this.text = comment.text;
    this.user = users.get(comment.userId);  // TODO do something if the user does not exist
    Object.freeze(this);
  }
}
Object.freeze(TicketDetailComment.prototype);

export class TicketDetailUser {
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
Object.freeze(TicketDetailUser.prototype);

export class TicketDetailTag implements Tag {
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
Object.freeze(TicketDetailTag.prototype);

export class TicketDetailAssTag implements Tag {
  readonly id: string;
  readonly name: string;
  readonly normalizedName: string;
  readonly order: number;
  readonly color: string;

  constructor(tag: AssignmentTagResultJson, order: number) {
    this.id = tag.id;
    this.name = tag.name;
    this.normalizedName = tag.normalizedName;
    this.order = order;
    this.color = tag.color;
    Object.freeze(this);
  }
}
Object.freeze(TicketDetailAssTag.prototype);

export class TicketDetailSubticket {
  readonly id: string;
  readonly projectId: string;
  readonly number: number;
  readonly title: string;
  readonly open: boolean;
  readonly currentEstimatedTime: number;
  readonly loggedTime: number;

  constructor(ticket: TicketResultJson) {
    this.id = ticket.id;
    this.projectId = ticket.projectId;
    this.number = ticket.number;
    this.title = ticket.title;
    this.open = ticket.open;
    this.currentEstimatedTime = ticket.currentEstimatedTime;
    // TODO real value here!!!
    this.loggedTime = this.currentEstimatedTime / 2;
    Object.freeze(this);
  }
}
Object.freeze(TicketDetailSubticket.prototype);

export class TicketDetail {
  readonly comments: imm.List<TicketDetailComment>;
  readonly createTime: number;  // TODO convert
  readonly createdBy: TicketDetailUser;
  readonly currentEstimatedTime: number|undefined;  // TODO convert
  readonly dueDate: number|undefined;  // TODO convert
  readonly description: string;
  readonly id: string;
  readonly initialEstimatedTime: number|undefined;  // TODO convert
  readonly number: number;
  readonly open: boolean;
  readonly storyPoints: number|undefined;
  readonly tags: imm.List<TicketDetailTransient<TicketDetailTag>>;
  readonly title: string;
  readonly users: imm.Map<TicketDetailUser, imm.List<TicketDetailAssignment>>;
  readonly projectId: string;
  readonly subtickets: imm.List<TicketDetailSubticket>;

  constructor(
      ticket: TicketResultJson,
      comments: imm.Map<string, TicketDetailComment>,
      subtickets: imm.List<TicketDetailSubticket>,
      users: imm.Map<string, TicketDetailUser>,
      ticketTags: imm.Map<string, TicketDetailTag>,
      assignmentTags: imm.Map<string, TicketDetailAssTag>,
      transientUsers: imm.List<TicketDetailTransientUser>,
      transientTags: imm.Set<string>) {
    this.comments = imm.List(ticket.commentIds)
      .map(cid => comments.get(cid))
      .filter(it => !!it)
      .toList();
    this.createTime = ticket.createTime;
    this.createdBy = users.get(ticket.createdBy);  // TODO error handling or create a dummy user
    this.currentEstimatedTime = ticket.currentEstimatedTime;
    this.dueDate = ticket.dueDate;
    this.description = ticket.description;
    this.id = ticket.id;
    this.initialEstimatedTime = ticket.initialEstimatedTime;
    this.number = ticket.number;
    this.open = ticket.open;
    this.storyPoints = ticket.storyPoints;
    this.tags = imm.List(ticket.tagIds)
      .map(tid => new TicketDetailTransient(ticketTags.get(tid), false))
      .filter(it => !!it.value)
      .toList()
      .withMutations(tags => {
        transientTags.forEach(transientTag => {
          let i = tags.findIndex(tag => tag.value.id === transientTag);
          if (i >= 0) {
            let old = tags.get(i);
            tags.set(i, new TicketDetailTransient(old.value, true));
          } else {
            let tag = ticketTags.get(transientTag);
            if (tag) {
              tags.push(new TicketDetailTransient(tag, true));
            }
          }
        });
      });
    this.title = ticket.title;
    this.users = imm.List(ticket.ticketUserRelations)
      .map(as => ({ user: users.get(as.userId), tag: assignmentTags.get(as.assignmentTagId) }))
      .filter(as => !!as.user && !!as.tag)
      .groupBy(as => as.user)
      .map(entry => entry.map(as => new TicketDetailAssignment(as.tag, false)).toList())
      .toMap()
      .withMutations(us => {
        transientUsers.forEach(transientUser => {
          let key = us.findKey((_, k) => k.id === transientUser.user.id);
          if (!key) {
            key = transientUser.user;
            us.set(key, imm.List<TicketDetailAssignment>());
          }
          us.set(key, us.get(key).withMutations((assignments) => {
            transientUser.tags.forEach((tagId) => {
              let i = assignments.findIndex(ass => ass.tag.id === tagId);
              if (i >= 0) {
                let old = assignments.get(i);
                assignments.set(i, new TicketDetailAssignment(old.tag, true));
              } else {
                let tag = assignmentTags.get(tagId);
                if (tag) {
                  assignments.push(new TicketDetailAssignment(tag, true));
                }
              }
            });
          }));
        });
      });
    this.projectId = ticket.projectId;
    this.subtickets = subtickets;
    Object.freeze(this);
  }
}
Object.freeze(TicketDetail.prototype);