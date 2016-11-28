package io.ticktag.restinterface.get.controllers

import io.swagger.annotations.Api
import io.ticktag.TicktagRestInterface
import io.ticktag.restinterface.get.schema.GetRequestJson
import io.ticktag.restinterface.get.schema.GetResultJson
import io.ticktag.restinterface.ticket.schema.TicketResultJson
import io.ticktag.restinterface.user.schema.UserResultJson
import io.ticktag.service.Principal
import io.ticktag.service.ticket.service.TicketService
import io.ticktag.service.user.services.UserService
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import javax.inject.Inject

@TicktagRestInterface
@RequestMapping("/get")
@Api(tags = arrayOf("get"), description = "get literally anything")
open class GetController @Inject constructor(
        private val userService: UserService,
        private val ticketService: TicketService
) {
    // Unfortunately request bodies in GET requests are not supported by swagger
    // So this is a POST endpoint, whatever
    @PostMapping
    open fun get(
            @RequestBody request: GetRequestJson,
            @AuthenticationPrincipal principal: Principal
    ): GetResultJson {
        val userIds = request.userIds
        val ticketIds = request.ticketIds
        val users = if (userIds == null) emptyMap() else userService.getUsers(userIds).mapValues { UserResultJson(it.value) }
        val tickets = if (ticketIds == null) emptyMap() else ticketService.getTickets(ticketIds, principal).mapValues { TicketResultJson(it.value) }

        return GetResultJson(
                users = users,
                tickets = tickets
        )
    }
}