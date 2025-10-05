pipeline {
  agent any
  environment { VENV = ".venv" }
  stages {
    stage('Checkout'){ steps{ checkout scm } }
    stage('Setup Python'){
      steps {
        sh '''python3 -m venv ${VENV}
              . ${VENV}/bin/activate
              pip install --upgrade pip
              pip install -r app/requirements.txt requests'''
      }
    }
    stage('Lint'){ steps{ sh '. ${VENV}/bin/activate && flake8 app' } }
    stage('Unit Tests'){ steps{ sh '. ${VENV}/bin/activate && pytest -q' } }
    stage('Package'){ steps{ sh 'tar -czf build.tar.gz app'; archiveArtifacts artifacts: 'build.tar.gz', fingerprint: true } }
    stage('Deploy (Ansible)'){
      steps {
        sh '. ${VENV}/bin/activate && ansible --version || pip install ansible'
        sh '. ${VENV}/bin/activate && ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml'
      }
    }
    stage('Post-Deploy Healthcheck'){ steps{ sh '. ${VENV}/bin/activate && python scripts/healthcheck.py http://localhost:5000/healthz' } }
  }
}