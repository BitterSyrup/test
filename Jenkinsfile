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
    //tok = readFile('app/Token').replace("\n", "").replace("\r", "")
    	
    stage "Build"
    
        sh "docker build -t ${imageName} ."
	
    stage "Push"

        sh "docker push ${imageName}"

    stage "Deploy"

	kubernetesDeploy(
                                credentialsType: 'KubeConfig',
                                kubeConfig: [path: '/var/lib/jenkins/workspace/.kube/config'],
				configs: 'k8s/deployment.yaml',
                                
                                )
	
	sh "sed -i 's/ID/${appName}:${tag}/'  k8s/deployment.yaml"
	
	sh "kubectl apply -f k8s/deployment.yaml"

    	//sh "kubectl --insecure-skip-tls-verify --server=https://10.9.2.151:6443 --token=${tok} apply -f k8s/deployment.yaml" 
		
}
