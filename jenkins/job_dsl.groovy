folder('/Whanos base images') {
    displayName('Whanos base images')
}
folder('/Projects') {
    displayName('Projects')
}

languages = ["c", "java", "javascript"]

languages.each { language ->
    freeStyleJob("/Whanos base images/whanos-$language") {
        steps {
            shell("docker build -t whanos-$language -f /images/$language/Dockerfile.base /images/$language")
        }
    }
}
