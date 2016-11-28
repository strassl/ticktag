package io.ticktag.persistence.ticketassignment

import io.ticktag.TicktagRepository
import io.ticktag.persistence.TicktagCrudRepository
import io.ticktag.persistence.ticket.entity.AssignedTicketUser
import io.ticktag.persistence.ticket.entity.AssignedTicketUserKey
import java.util.*

@TicktagRepository
interface TicketAssignmentRepository : TicktagCrudRepository<AssignedTicketUser, AssignedTicketUserKey> {
    fun findByUserIdAndTicketId(userId: UUID, ticketId: UUID): List<AssignedTicketUser>
    fun deleteByUserIdAndTicketId(userId: UUID, ticketId: UUID)
}