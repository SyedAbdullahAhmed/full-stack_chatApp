// pipeline {
//   agent any

//   environment {
//     SONAR_HOME = tool "sonarqube"
//   }

//   stages {
//     stage('Clean UP') {
//       steps {
//         cleanWs()
//       }
//     }
//     stage('Code Check out') {
//       steps {
//         git branch: 'master',
//           url: 'https://github.com/iemafzalhassan/full-stack_chatApp.git'
//       }
//     }
//     stage('Code Quality') {
//       steps {
//         withSonarQubeEnv("sonarqube") {
//           sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=chat-app -Dsonar.projectKey=chat-app -X"
//         }
//       }
//     }
//     stage('Deploy') {
//       steps {
//         script {
//           sh 'docker compose up -d --build'
//         }
//       }
//     }
//   }
// }
// pipeline {
//   agent any

//   environment {
//     SONAR_HOME = tool "Sonar"
//   }

//   stages {
//     stage('Clean UP') {
//       steps {
//         cleanWs()
//       }
//     }
//     stage('Code Check out') {
//       steps {
//         git branch: 'main',
//           url: 'https://github.com/SyedAbdullahAhmed/full-stack_chatApp.git'
//       }
//     }
//     stage('Code Quality') {
//       steps {
//         withSonarQubeEnv("Sonar") {
//           sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=chat-app -Dsonar.projectKey=chat-app -X"
//         }
//       }
//     }
//     stage('OWASP DC') {
//       steps {
//           dependencyCheck additionalArguments: '--scan ./backend --format HTML',
//                           outdir: 'owasp-report',
//                           odcInstallation: 'dc'
//       }
//       post {
//           always {
//               dependencyCheckPublisher pattern: 'owasp-report/dependency-check-report.html'
//           }
//       }
//   	}
//     stage('Sonar Quality Gate Scan') {
//       steps {
//         timeout(time: 2, unit: "MINUTES"){
//           waitForQualityGate abortPipeline: false
// 		    }
// 	    }
//   	}
//     stage('Trivy File System Scan') {
//       steps {
// 		    sh "trivy fs ./backend --format table -o trivy-fs-report.html"
// 	    }
//   	}
//   }
// }

// pipeline {
//   agent any

//   environment {
//     SONAR_HOME = tool "Sonar"
//   }

//   stages {
//     stage('Clean UP') {
//       steps {
//         cleanWs()
//       }
//     }
//     stage('Code Check out') {
//       steps {
//         git branch: 'main',
//           url: 'https://github.com/SyedAbdullahAhmed/full-stack_chatApp.git'
//       }
//     }
//     stage('Code Quality') {
//       steps {
//         withSonarQubeEnv("Sonar") {
//           sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=chat-app -Dsonar.projectKey=chat-app -X"
//         }
//       }
//     }
//     stage('OWASP DC') {
//       steps {
//           dependencyCheck additionalArguments: '--scan ./backend --format HTML',
//                           outdir: 'owasp-report',
//                           odcInstallation: 'dc'
//       }
//       post {
//           always {
//               dependencyCheckPublisher pattern: 'owasp-report/dependency-check-report.html'
//           }
//       }
//   	}
//     stage('Sonar Quality Gate Scan') {
//       steps {
//         timeout(time: 2, unit: "MINUTES"){
//           waitForQualityGate abortPipeline: false
// 		    }
// 	    }
//   	}
//     stage('Trivy File System Scan') {
//       steps {
// 		    sh "trivy fs ./backend --format table -o trivy-fs-report.html"
// 	    }
//   	}
//   }
// }


// pipeline {
//   agent any

//   environment {
//     DOCKER_REGISTRY = "docker.io"
//     IMAGE_TAG       = "latest"
//     BACKEND_REPO    = "syedabdullahahmed/new-chatapp-backend"
//     FRONTEND_REPO   = "syedabdullahahmed/new-chatapp-frontend"    
//   }

//   stages {
//     stage('Checkout') {
//       steps {
//         echo "📥 Cloning repository..."
//         git branch: 'main',
//             url: 'https://github.com/SyedAbdullahAhmed/full-stack_chatApp.git'
//         echo "✅ Code checkout completed."
//       }
//     }

//     stage('Docker Login') {
//       steps {
//         echo "🔑 Logging in to Docker Hub..."
//         withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
//           sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin $DOCKER_REGISTRY"
//         }
//         echo "✅ Docker login successful."
//       }
//     }

//     stage('Build Backend Image') {
//       steps {
//         echo "🐳 Building backend Docker image..."
//         sh "docker build -t $BACKEND_REPO:$IMAGE_TAG ./backend"
//         echo "✅ Backend image built: $BACKEND_REPO:$IMAGE_TAG"
//       }
//     }

//     stage('Push Backend Image') {
//       steps {
//         echo "📤 Pushing backend image..."
//         sh "docker push $BACKEND_REPO:$IMAGE_TAG"
//         echo "✅ Backend image pushed."
//       }
//     }

//     stage('Build Frontend Image') {
//       steps {
//         echo "🐳 Building frontend Docker image..."
//         sh "docker build -t $FRONTEND_REPO:$IMAGE_TAG ./frontend"
//         echo "✅ Frontend image built: $FRONTEND_REPO:$IMAGE_TAG"
//       }
//     }

//     stage('Push Frontend Image') {
//       steps {
//         echo "📤 Pushing frontend image..."
//         sh "docker push $FRONTEND_REPO:$IMAGE_TAG"
//         echo "✅ Frontend image pushed."
//       }
//     }
//   }
// }
pipeline {
  agent any

  environment {
    DOCKER_REGISTRY = "docker.io"
    IMAGE_TAG = "${env.BUILD_NUMBER}"     
    BACKEND_REPO    = "syedabdullahahmed/new-chatapp-backend"
    FRONTEND_REPO   = "syedabdullahahmed/new-chatapp-frontend"    
  }

  stages {
    stage('Checkout') {
      steps {
        echo "📥 Cloning repository..."
        git branch: 'main',
            url: 'https://github.com/SyedAbdullahAhmed/full-stack_chatApp.git'
        echo "✅ Code checkout completed."
      }
    }

    stage('Docker Login') {
      steps {
        echo "🔑 Logging in to Docker Hub..."
        withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin $DOCKER_REGISTRY"
        }
        echo "✅ Docker login successful."
      }
    }

    stage('Build Backend Image') {
      steps {
        echo "🐳 Building backend Docker image..."
        sh "docker build -t $BACKEND_REPO:$IMAGE_TAG ./backend"
        echo "✅ Backend image built: $BACKEND_REPO:$IMAGE_TAG"
      }
    }

    stage('Push Backend Image') {
      steps {
        echo "📤 Pushing backend image..."
        sh "docker push $BACKEND_REPO:$IMAGE_TAG"
        echo "✅ Backend image pushed."
      }
    }

    stage('Build Frontend Image') {
      steps {
        echo "🐳 Building frontend Docker image..."
        sh "docker build -t $FRONTEND_REPO:$IMAGE_TAG ./frontend"
        echo "✅ Frontend image built: $FRONTEND_REPO:$IMAGE_TAG"
      }
    }


    stage('Push Frontend Image') {
      steps {
        echo "📤 Pushing frontend image..."
        sh "docker push $FRONTEND_REPO:$IMAGE_TAG"
        echo "✅ Frontend image pushed."
      }
    }

    stage('Update Backend Deployment K8s file') {
      steps {
          sh """
          sed -i "s|image: syedabdullahahmed/new-chatapp-backend:.*|image: syedabdullahahmed/new-chatapp-backend:${IMAGE_TAG}|g" k8s/backend-deployment.yml
          echo 'Updated backend-deployment.yml:'
          cat k8s/backend-deployment.yml
          """
      }
    }
    stage('Update Frontend Deployment K8s file') {
      steps {
          sh """
          sed -i "s|image: syedabdullahahmed/new-chatapp-frontend:.*|image: syedabdullahahmed/new-chatapp-frontend:${IMAGE_TAG}|g" k8s/frontend-deployment.yml
          echo 'Updated frontend-deployment.yml:'
          cat k8s/frontend-deployment.yml
          """
      }
    }

    //  stage('Commit & Push Manifests') {
    //         steps {
    //             withCredentials([usernamePassword(credentialsId: 'github-creds', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
    //                 sh """
    //                 git config --global user.email "abdullahahmedsyed65@gmail.com"
    //                 git config --global user.name "SyedAbdullahAhmed"
    //                 git remote set-url origin https://$GIT_USER:$GIT_PASS@github.com/SyedAbdullahAhmed/full-stack_chatApp.git
    //                 git add .
    //                 git commit -m "Update deployment image tag to ${IMAGE_TAG}" || echo "No changes to commit"
    //                 git push origin main
    //                 """
    //             }

    //         }
    //     }
  }
  post {
        success {
            echo "✅ Deployment successful with image: $ECR_REGISTRY/$ECR_REPO_NAME:$IMAGE_TAG"
        }
        failure {
            echo "❌ Pipeline failed. Please check the logs."
        }
    }
}

// ✅ clone code
// ✅ docker login
// ✅ build backend image 
// ✅ push to docker hub
// ✅ build frontend image 
// ✅ push to docker hub
// update tag in backend  deployment
// update tag in frontend deployment
// git push to main branch
