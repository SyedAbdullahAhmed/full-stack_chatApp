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
pipeline {
  agent any

  environment {
    SONAR_HOME = tool "Sonar"
  }

  stages {
    stage('Clean UP') {
      steps {
        cleanWs()
      }
    }
    stage('Code Check out') {
      steps {
        git branch: 'main',
          url: 'https://github.com/SyedAbdullahAhmed/full-stack_chatApp.git'
      }
    }
    stage('Code Quality') {
      steps {
        withSonarQubeEnv("Sonar") {
          sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=chat-app -Dsonar.projectKey=chat-app -X"
        }
      }
    }
    stage('OWASP DC') {
      steps {
          dependencyCheck additionalArguments: '--scan ./backend --format HTML',
                          outdir: 'owasp-report',
                          odcInstallation: 'dc'
      }
      post {
          always {
              dependencyCheckPublisher pattern: 'owasp-report/dependency-check-report.html'
          }
      }
  	}
    stage('Sonar Quality Gate Scan') {
      steps {
		timeout(time: 2, unit: "MINUTES"){
			waitForQualityGate abortPipeline: false
		}
	  }
  	}
    stage('Trivy File System Scan') {
      steps {
		sh "trivy fs --format table -o trivy-fs-report.html"
	  }
  	}
  }
}

