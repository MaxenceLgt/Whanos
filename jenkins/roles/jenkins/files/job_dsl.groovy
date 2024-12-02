folder('/Whanos base images') {
    displayName('Whanos base images')
}
folder('/Projects') {
    displayName('Projects')
}

languages = ["c", "java", "javascript", "python", "befunge"]

languages.each { language ->
    freeStyleJob("/Whanos base images/whanos-$language") {
        steps {
            shell("docker build -t whanos-$language -f /images/$language/Dockerfile.base /images/$language")
        }
    }
}

freeStyleJob("Whanos base images/Build all base images") {
    steps {
        publishers {
            downstream (
                languages.collect { language ->
                    "/Whanos base images/whanos-$language"
               }
            )
        }
    }
}

freeStyleJob('link-project') {
    parameters {
        stringParam("DISPLAY_NAME", null, "Display name for the job.")
        stringParam("SSH_URL", null, "Git repository URL [ssh]")
        stringParam("CREDENTIALS_ID", null, "Reference to jenkins credentials ssh_key")
    }
    steps {
        dsl {
            text('''
                freeStyleJob("Projects/$DISPLAY_NAME") {
                    wrappers {
                        preBuildCleanup()
                    }
                    scm {
                        git {
                            remote {
                                url(SSH_URL)
                                credentials(CREDENTIALS_ID)
                            }
                            branch('main')
                        }
                    }
                    triggers {
                        scm("* * * * *")
                    }
                    steps {
                        shell("/usr/bin/linkproject.sh")
                    }
                }
            '''.stripIndent())
        }
    }
}
