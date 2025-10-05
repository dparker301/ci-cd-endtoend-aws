# CI/CD End-to-End Lab (GitHub + Jenkins + Ansible + Tekton + AWS ECR/ECS/ALB)

## Quick Local Run (Ubuntu)
```bash
./deploy.sh
curl http://localhost:5000/healthz
```

## Jenkins (local)
Use `Jenkinsfile` for lint → test → package → Ansible deploy → healthcheck.

## AWS Path (ECR + ECS Fargate + ALB via Terraform)
```bash
cd aws/terraform
terraform init
terraform apply -auto-approve
terraform output alb_dns_name
```
Create a Pipeline job with `Jenkinsfile.aws`:
- Configure Jenkins String credentials: `aws-default-region`, `aws-account-id`, `aws-access-key-id`, `aws-secret-access-key`
- The job builds Docker, logs into ECR, pushes `:latest`, and updates the ECS service with a new task definition.

## Tekton (optional)
Apply tasks + pipeline and run; use `ecr-build-push.yaml` with a Secret `ecr-creds` (keys: `aws_region`, `aws_access_key_id`, `aws_secret_access_key`).

## Health
- App: `/` JSON greeting
- Health: `/healthz` (used by ALB & ECS)
