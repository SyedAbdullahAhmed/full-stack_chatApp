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


pipeline {
  agent any

  environment {
    DOCKER_REGISTRY = "docker.io"
    BACKEND_REPO    = "syedabdullahahmed/new-chatapp-backend"
    IMAGE_TAG       = "latest"
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
  }
}
