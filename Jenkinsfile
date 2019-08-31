node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "hello-nam"
    registryHost = "10.9.2.151:5000/"
    imageName = "${registryHost}${appName}:${tag}"
    env.BUILDIMG=imageName
    //dir = pwd()
    tok = readFile('Token').replace("\n", "").replace("\r", "")
    a = readFile('k8s/123')	
    stage "Build"
    
        sh "docker build -t ${imageName} ."
	
    stage "Push"

        sh "docker push ${imageName}"

    stage "Deploy"
	
	sh "sed -i 's/ID/${appName}:${tag}/'  k8s/deployment.yaml"

    	sh "kubectl --insecure-skip-tls-verify --server=https://10.9.2.151:6443 --token=${tok} apply -f k8s/deployment.yaml" 
	
	sh "sed -i 's/${appName}:${tag}/ID/'  k8s/deployment.yaml"
}
