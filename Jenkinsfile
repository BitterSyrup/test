node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "hello-nam"
    registryHost = "10.9.2.151:5000/"
    imageName = "${registryHost}${appName}:${tag}"
    env.BUILDIMG=imageName

    stage "Build"
    
        sh "docker build -t ${imageName} ."
	sh ''' 
cat > k8s/deployment.yaml << EOF
apiVersion: v1
kind: Service
metadata:
  name: hello-nam
  labels:
    app: hello-nam
spec:
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: hello-nam
    tier: hello-nam
  type: NodePort

---
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: hello-nam
  labels:
    app: hello-nam
spec:
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: hello-nam
        tier: hello-nam
    spec:
      containers:
      - image: ${imageName}
        name: hello-nam
        ports:
        - containerPort: 80
          name: hello-nam
EOF
'''

    stage "Push"

        sh "docker push ${imageName}"

    stage "Deploy"
    	sh "kubectl --insecure-skip-tls-verify --server=https://10.9.2.151:6443 --token=eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImNsdXN0ZXItYWRtaW4tZGFzaGJvYXJkLXNhLXRva2VuLWJxZDRyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImNsdXN0ZXItYWRtaW4tZGFzaGJvYXJkLXNhIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiNWM3NjcyNWMtMGIyMS00NzBiLTg1Y2YtNGVjMmE5NWU3NTI3Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmRlZmF1bHQ6Y2x1c3Rlci1hZG1pbi1kYXNoYm9hcmQtc2EifQ.kddDuUrPYnrXf9Y6a8hVkETT6mJG1JXCT3Fi0LRog_cMKrVTH18FQ1w9XK_aR7Zw9UH4e8Cs8MS8nZdUF1BQd86RX8SrW3G5hkKBn5CIaU318s0deTYfQxjekJX1Pe0IXjS5XqTRhMOTFAZlOYuq5kM1utFjSFEZm6Mf8PXo5Wtx_XVYTklHUZ7V2EH0lt7L2-Lko4zvjnltipQCqaMCLFKk_wMbiKUBYip0vUvBhYi4wv7C9IzgS4654DSEDhIQ3V77QSIj2edSkJLKphehIlGchz6qs7zTz9xS3OOG5pyZRsUzz9m7GuYWbVMfMNTobaG-c4F3Nd-6P8JXh-D2ng apply -f k8s/deployment.yaml"
}
