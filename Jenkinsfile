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
    
    stage "Push"

        sh "docker push ${imageName}"

    stage "Deploy"
    	sh "kubectl --insecure-skip-tls-verify --server=https://10.9.2.151:6443 --token=eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tNDdocHQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImJjMDIyMTNhLTU2NTYtNDdlMy1hY2Q1LTBlYWRmYzM5M2M1MyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.HMa-nPbfRG_SPN3N4Wqkyh7c8K0SqnOzaitNlUSUx7sEFfaEhadC7bTSV6N-bRVZ9fP1EFCvBg-wxy_e_ChvywhoGkZBRFNbvy1YGsQxFSLFr0_3hDicVvQswHV5UjI8E3c1vvgBzIhV7dIYnX8VmBMBAWyS8hqOJcXA4M3qtSU998redNz-Myz7yxnRYmUkT6Uio7DLlZ10wdlZQ5JXEhanupRZV3sIqsess3BNIwP6JkBaZsUXHbMpaJ_5lKvFQbCzzRJsAOEgEG6GjC3w2bC3pmX8lX4zATSmQmRoUpie37dpcEu9W2lnIXMSb6cxYwTx1nqOf8ZqsT2q7yU4Hg apply -f k8s/deployment.yaml"
}
