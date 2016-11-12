package io.ticktag

import java.io.File
import java.io.FileInputStream
import java.util.*

class PropertiesLoader {
    companion object {
        val OVERRIDE_PROPERTIES_KEY = "TICKTAG_CONFIG"
    }

    fun getProperties(): ApplicationProperties {
        return parseProperties(loadProperties())
    }

    private fun parseProperties(props: Properties): ApplicationProperties {
        return object : ApplicationProperties {
            override val dbUrl: String
                get() = props["db.url"] as String
            override val dbUser: String
                get() = props["db.user"] as String
            override val dbPassword: String
                get() = props["db.password"] as String
            override val dbValidate: Boolean
                get() = (props["db.validate"] as String).toBoolean()
            override val httpPort: Int
                get() = (props["http.port"] as String).toInt()
            override val serverSecret: String
                get() = props["server.secret"] as String
            override val serverNumber: Int
                get() = (props["server.number"] as String).toInt()
            override val adminMail: String
                get() = props["admin.mail"] as String
            override val adminPassword: String
                get() = props["admin.password"] as String
        }
    }

    private fun loadProperties(): Properties {
        return loadEnvProperties() ?: loadLocalProperties()
    }

    private fun loadLocalProperties(): Properties {
        val props = Properties()
        val fp = javaClass.classLoader.getResourceAsStream("application.properties")
        try {
            props.load(fp)
            return props
        } finally {
            fp.close()
        }
    }

    private fun loadEnvProperties(): Properties? {
        val path: String = System.getProperty(OVERRIDE_PROPERTIES_KEY) ?: return null
        FileInputStream(File(path)).use {
            val props = Properties()
            props.load(it)
            return props
        }
    }
}