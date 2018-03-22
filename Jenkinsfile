// Tutorial Pipeline from https://jenkins.io/blog/2017/02/07/declarative-maven-project/
        def env = 'ITG'
        def family = 'Thor'
        def multimodelSECount = '30'
        def totalSECount = '635'
        def PNs = ['CZ056A','L2E27A','K4G10A','1HA06A','1HA07A','3DB03A']

pipeline { 
    agent any

    environment {
        http_proxy = "http://web-proxy.europe.hp.com:8080"
        https_proxy = "http://web-proxy.europe.hp.com:8080"
    }
	options { buildDiscarder(logRotator(numToKeepStr: '5')) }
  
    stages {

        stage('Multimodel') { 
            steps {
                
				echo 'Run the Multimodel job.' 
				sh "newman run col/SEALS/getSolution/validResponse.json -d data/byFamily/${family}/multimodel.json -e env/SEALS_${env}.json -n ${multimodelSECount} --delay-request 500 --reporters junit,cli --reporter-junit-export newman/${family}/GetSolution_Multimodel.xml --insecure --no-color -x"
              
            }
        }

        stage('Individual PN getSolution') {
            steps {
                script {
                            for (int i = 0; i < PNs.size(); i++){
                            stage("${PNs[i]}") {
                                echo "${PNs[i]} is the right PN for you"
                                echo "newman run col/SEALS/getSolution/validResponse.json -d data/byFamily/${family}/${PNs[i]}_data.json -e env/SEALS_${env}.json -n ${totalSECount} --delay-request 500 --reporters junit,cli --reporter-junit-export newman/${family}/GetSolution_${PNs[i]}.xml --insecure --no-color -x"
                                echo "newman run col/SEALS/getSolution/validResponse.json -d data/byFamily/Thor/failure.json -e env/SEALS_ITG.json -n 4 --delay-request 500 --reporters junit,cli --reporter-junit-export newman/Thor/GetSolution_Multimodel.xml --insecure --no-color -x"
                            }
                        }
                                        
                }
            }
        }

		stage('Test Results') {
		steps {
			junit 'newman/**/*.xml'
			}
		}

    }
}
