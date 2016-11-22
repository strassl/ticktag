package io.ticktag

import java.util.*

val ADMIN_ID: UUID = UUID.fromString("00000000-0001-0000-0000-000000000001")
val USER_ID: UUID = UUID.fromString("00000000-0001-0000-0000-000000000002")
val OBSERVER_ID: UUID = UUID.fromString("00000000-0001-0000-0000-000000000003")

val ADMIN_USER_ID: UUID = UUID.fromString("00000000-0001-0000-0000-000000000101")
val OBSERVER_USER_ID: UUID = UUID.fromString("00000000-0001-0000-0000-000000000102")
val USER_USER_ID: UUID = UUID.fromString("00000000-0001-0000-0000-000000000103")

//AOU_AUO is Admin has Admin ProjectRole, Observer has User ProjectRole, USER has Observer Projectrole
val PROJECT_AOU_AUO_ID: UUID = UUID.fromString("00000000-0002-0000-0000-000000000101")
val PROJECT_AOU_UOA_ID: UUID = UUID.fromString("00000000-0002-0000-0000-000000000102")
val PROJECT_AOU_OAU_ID: UUID = UUID.fromString("00000000-0002-0000-0000-000000000103")
val PROJECT_NO_MEMBERS_ID: UUID = UUID.fromString("00000000-0002-0000-0000-000000000104")

val TIMECAT_CONTENT: List<String> = listOf("dev", "plan")
val TIMECAT_PROJECT_AOU_AUO_IDS: List<UUID> = listOf(UUID.fromString("00000000-0007-0000-0000-000000000101"), UUID.fromString("00000000-0007-0000-0000-000000000102"))
val TIMECAT_PROJECT_AOU_UOA_IDS: List<UUID> = listOf(UUID.fromString("00000000-0007-0000-0000-000000000103"), UUID.fromString("00000000-0007-0000-0000-000000000104"))
val TIMECAT_PROJECT_AOU_OAU_IDS: List<UUID> = listOf(UUID.fromString("00000000-0007-0000-0000-000000000105"), UUID.fromString("00000000-0007-0000-0000-000000000106"))
val TIMECAT_PROJECT_NO_MEMBERS_IDS: List<UUID> = listOf(UUID.fromString("00000000-0007-0000-0000-000000000107"), UUID.fromString("00000000-0007-0000-0000-000000000108"))