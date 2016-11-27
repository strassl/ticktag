package io.ticktag.service.ticketassignment.services

import io.ticktag.service.ticketassignment.dto.TicketAssignmentResult
import java.util.*

interface TicketAssignmentService {
    fun getTicketAssignment(ticketId: UUID, tagId: UUID, userId: UUID): TicketAssignmentResult
    fun createTicketAssignment(ticketId: UUID, tagId: UUID, userId: UUID): TicketAssignmentResult
    fun createOrGetIfExistsTicketAssignment(ticketId: UUID, tagId: UUID, userId: UUID): TicketAssignmentResult
    fun deleteTicketAssignment(ticketId: UUID, tagId: UUID, userId: UUID)
    fun deleteTicketAssignments(ticketId: UUID, userId: UUID)
}