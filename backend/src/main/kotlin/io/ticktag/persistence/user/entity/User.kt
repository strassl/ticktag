package io.ticktag.persistence.user.entity

import io.ticktag.persistence.member.entity.Member
import io.ticktag.persistence.ticket.entity.AssignedTicketUser
import io.ticktag.persistence.ticket.entity.Comment
import io.ticktag.persistence.ticket.entity.Ticket
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "user")
open class User protected constructor() {
    companion object {
        fun create(mail: String, passwordHash: String, name: String, role: Role, currentToken: UUID): User {
            return createWithId(UUID.randomUUID(), mail, passwordHash, name, role, currentToken)
        }

        fun createWithId(uuid: UUID, mail: String, passwordHash: String, name: String, role: Role,
                         currentToken: UUID): User {
            val u = User()
            u.id = uuid
            u.mail = mail
            u.passwordHash = passwordHash
            u.name = name
            u.role = role
            u.currentToken = currentToken
            return u
        }
    }

    @Id
    @Column(name = "id")
    lateinit open var id: UUID
        protected set

    @Column(name = "mail", nullable = false)
    lateinit open var mail: String

    @Column(name = "password_hash", nullable = false)
    lateinit open var passwordHash: String

    @Column(name = "name", nullable = false)
    lateinit open var name: String

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    lateinit open var role: Role

    @Column(name = "current_token", nullable = false)
    lateinit open var currentToken: UUID

    @OneToMany(mappedBy = "user")
    lateinit open var memberships: MutableList<Member>
        protected set

    @OneToMany(mappedBy = "createdBy")
    lateinit open var createdTickets: MutableList<Ticket>
        protected set

    @OneToMany(mappedBy = "user")
    lateinit open var comments: MutableList<Comment>
        protected set

    @OneToMany(mappedBy = "user")
    lateinit open var assignedTicketUsers: MutableList<AssignedTicketUser>
        protected set
}
