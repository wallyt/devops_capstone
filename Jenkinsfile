pipeline {
    agent any

    stages {
        stage('Clean directory') {
            steps {
                sh 'ls -l'
                sh 'touch oneemptyfile'
                sh 'rm -r *'
                echo 'done'
            }
        }
        stage('Clone repository') {
            steps {
                sh 'git clone https://https://github.com/wallyt/python-flask-docker'
                sh 'ls -l'
            }
        }
        stage('Validate python code') {
            steps {
                sh 'pylint --disable=R,C,W1203,E0401,W0621,W0611 /var/lib/jenkins/workspace/python-flask-docker-webapp_master/python-flask-docker-webapp/app.py'
            }
        }
        stage('Validate docker image') {
            steps {
                sh 'docker run --rm -i hadolint/hadolint hadolint --ignore DL3013 - < /var/lib/jenkins/workspace/python-flask-docker-webapp_master/python-flask-docker-webapp/Dockerfile'
            }
        }
        stage('Run docker container') {
            steps {
                sh 'docker build -t capstone /var/lib/jenkins/workspace/python-flask-docker-webapp_master/python-flask-docker-webapp/.'
                sh 'docker run -d -p 5555:5555 capstone'
            }
        }
        stage('Test if container is running on port 5555') {
            steps {
                sh 'curl -Is http://localhost:8080 | head -1'
            }
        }
        stage('Stop container') {
            steps {
                sh 'docker stop $(docker ps -a -q)'
                sh 'sleep 10'
            }
        }
        stage('Push docker image to DockerHUB') {
            steps {
                sh 'echo "wallyt" | docker login --username=wallyt'
                sh '''docker tag $(docker images -a | grep "capstone" | awk '{print $3}') wallyt/capstone-kube'''
                sh 'docker push wallyt/capstone-kube'
            }
        }
        // TODO update with previous project
        stage('Deploy to AWS K8S') {
            steps {
                sh 'dockerpath=ruipbranco/capstone-kube'
                sh 'kubectl run kubernetes-nddevopskubernetes --image=$dockerpath --port=5555'
                sh 'kubectl get pods'
                sh '''export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')'''
                sh 'sleep 10'
                sh 'kubectl port-forward $POD_NAME 5555:5555'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}