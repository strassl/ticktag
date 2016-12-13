package io.ticktag.service.kanbanBoard.services


import io.ticktag.service.Principal
import io.ticktag.service.kanbanBoard.dto.KanbanBoardResult
import io.ticktag.service.kanbanBoard.dto.KanbanColumnResult
import io.ticktag.service.kanbanBoard.dto.UpdateKanbanColumn
import java.time.Instant
import java.util.*


interface KanbanService {
    fun listColumns(kanbanBoardId: UUID,
                    number: Int?,
                    title: String?,
                    tags: List<String>?,
                    users: List<String>?,
                    progressOne: Float?,
                    progressTwo: Float?,
                    progressGreater: Boolean?,
                    dueDateOne: Instant?,
                    dueDateTwo: Instant?,
                    dueDateGreater: Boolean?,
                    storyPointsOne: Int?,
                    storyPointsTwo: Int?,
                    storyPointsGreater: Boolean?,
                    open: Boolean?): List<KanbanColumnResult>
    fun listBoards(projectId: UUID): List<KanbanBoardResult>
    fun updateKanbanBoard(columns: List<UpdateKanbanColumn>, principal: Principal)
    fun getBoard(boardId: UUID): KanbanBoardResult
}