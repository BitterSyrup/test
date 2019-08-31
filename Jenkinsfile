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

    stage "Build"
    
        sh "docker build -t ${imageName} ."
	
    stage "Push"

        sh "docker push ${imageName}"

    stage "Deploy"
	
	sh "sed -i 's/ID/${appName}:${tag}/'  k8s/deployment.yaml"

    /*	sh "kubectl --insecure-skip-tls-verify --server=https://10.9.2.151:6443 --token=eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImNsdXN0ZXItYWRtaW4tZGFzaGJvYXJkLXNhLXRva2VuLWJxZDRyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImNsdXN0ZXItYWRtaW4tZGFzaGJvYXJkLXNhIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiNWM3NjcyNWMtMGIyMS00NzBiLTg1Y2YtNGVjMmE5NWU3NTI3Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmRlZmF1bHQ6Y2x1c3Rlci1hZG1pbi1kYXNoYm9hcmQtc2EifQ.kddDuUrPYnrXf9Y6a8hVkETT6mJG1JXCT3Fi0LRog_cMKrVTH18FQ1w9XK_aR7Zw9UH4e8Cs8MS8nZdUF1BQd86RX8SrW3G5hkKBn5CIaU318s0deTYfQxjekJX1Pe0IXjS5XqTRhMOTFAZlOYuq5kM1utFjSFEZm6Mf8PXo5Wtx_XVYTklHUZ7V2EH0lt7L2-Lko4zvjnltipQCqaMCLFKk_wMbiKUBYip0vUvBhYi4wv7C9IzgS4654DSEDhIQ3V77QSIj2edSkJLKphehIlGchz6qs7zTz9xS3OOG5pyZRsUzz9m7GuYWbVMfMNTobaG-c4F3Nd-6P8JXh-D2ng apply -f k8s/deployment.yaml" */
	
	sh "kubectl --insecure-skip-tls-verify=true --server=https://10.9.2.151:6443 apply --token=eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlcGxveW1lbnQtYWNjb3VudC10b2tlbi1xajdrNiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkZXBsb3ltZW50LWFjY291bnQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI1MzVkMmU0YS1lMWE0LTQ0NWItOWU2NS0wNTFmMzI0MTFjOGUiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkZXBsb3ltZW50LWFjY291bnQifQ.J1_fb98Y9whrXFzqYpGo7ZTUF75x2B3sbP-4NSCRGCi2x3Ez5Zv0QfkOMofTy4rXavjyKxQkt7BhhutgD-7fYCiMns116IimZR2ifDvXVyUu7wgS0wabS-WDdGDFHUWrHw5xJ59caKqtw4NMgMlQsqmf2g0faH0T1Q3-V_KTzDWDLIVHZVEuE4NtuCE1e9Kq8gfCnDK0fvt5R3QGvPVkMj9CwveQkp-ec5i6SJewXA18AHcsDYHRQRbZKqSml-rMS6n91O5dnRU3QeWdvWh8WvE3ETMHXs6gu4VNRkpVJJtRn3k3sF6Su6TVwieFpcNSVM1r5I9Y-a09VBvH-hJLAQ -f k8s/deployment.yaml"
	sh "sed -i 's/${appName}:${tag}/ID/'  k8s/deployment.yaml"
}
