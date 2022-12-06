pipeline{
    agent any
    environment{
        DOCKER_IMAGE_NAME = "vineetakhaitan/vineeta-pritam-image:1.0"
        DOCKER_USERNAME = "vineetakhaitan"
        DOCKER_PASSWORD = credentials('DOCKER_SECRET')
    }
    stages{
        stage('Test'){
            steps{
                sh '''
                    echo "Running the tests......"
                '''
            }
        }
        stage('Build'){
            steps{
                sh '''
                    echo "Building Image"
                    docker build -t "${DOCKER_IMAGE_NAME}" -f ./Dockerfile  .
                '''
            }
        }
        stage('Push'){
            steps{
                sh '''
                        echo "pushing docker image ......"
                        docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                        docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_IMAGE_NAME]": "$BUID_NUMBER"
                        docker push "${DOCKER_IMAGE_NAME}": "$BUILD_NUMBER"
                        docker push "${DOCKER_IMAGE_NAME}": latest
                        echo "cleaning up the local images ...."
                        docker rmi "${DOCKER_IMAGE_NAME]": "$BUILD_NUMBER"
                '''
            }
        }
        stage('Deploy'){
            steps{
                sh '''
                        echo "deploying the application....."
                        docker rm -f metadata-app || true
                        docker run -d -D 8081:8080 --name metadata-app "${DOCKER_IMAGE_NAME}": latest 
                '''
            }
        }
    }
}