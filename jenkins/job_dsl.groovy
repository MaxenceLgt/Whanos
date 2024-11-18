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
