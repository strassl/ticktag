package io.ticktag.service.ticketevent.services.impl

import io.ticktag.TicktagService
import io.ticktag.persistence.ticket.TicketEventRepository
import io.ticktag.persistence.ticket.entity.TicketEvent
import io.ticktag.service.AuthExpr
import io.ticktag.service.ticketevent.services.TicketEventService
import org.springframework.security.access.method.P
import org.springframework.security.access.prepost.PreAuthorize
import java.util.*
import javax.inject.Inject

@TicktagService
open class TicketEventServiceImpl @Inject constructor(
        val ticketEvents: TicketEventRepository
) : TicketEventService {

    @PreAuthorize(AuthExpr.READ_TICKET)
    override fun listTicketEvents(@P("authTicketId") ticketId: UUID): List<TicketEvent> {
        return ticketEvents.findByTicketId(ticketId)
    }
}