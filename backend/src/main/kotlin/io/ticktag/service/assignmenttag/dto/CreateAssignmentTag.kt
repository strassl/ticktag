package  io.ticktag.service.assignmenttag.dto

import io.ticktag.persistence.ticket.entity.TicketTag
import java.util.*
import javax.validation.constraints.Pattern
import javax.validation.constraints.Size

data class CreateAssignmentTag(
        val pID: UUID,
        @field:Size(min = 1, max = 30) val name: String,
        @field:Pattern(regexp = TicketTag.COLOR_REGEX) val color: String //RGB HEX Color
)