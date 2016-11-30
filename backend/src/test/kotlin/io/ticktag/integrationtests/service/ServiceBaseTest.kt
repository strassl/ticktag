package io.ticktag.integrationtests.service

import io.ticktag.integrationtests.BaseTest
import io.ticktag.TicktagServiceTestApplication
import org.springframework.test.context.ContextConfiguration

@ContextConfiguration(classes = arrayOf(TicktagServiceTestApplication::class))
abstract class ServiceBaseTest : BaseTest()