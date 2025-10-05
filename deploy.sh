#!/usr/bin/env bash
set -euo pipefail
sudo apt-get update -y
sudo apt-get install -y rsync
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip ansible requests
ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml
python scripts/healthcheck.py http://localhost:5000/healthz
echo "Deployment + healthcheck complete."
