vault server -dev -dev-root-token-id="root"&

sleep 2

export VAULT_ADDR='http://127.0.0.1:8200'

echo "Create quota and namespace"

terraform init

terraform apply -auto-approve

vault namespace create education

vault write sys/quotas/rate-limit/quota-dev rate=5000 path=education/

vault write sys/quotas/rate-limit/quota-dev rate=5000 path=dev/

echo "Delete quota and namespace"

terraform destroy -auto-approve

vault list sys/quotas/rate-limit
vault namespace list

vault write sys/quotas/rate-limit/dev-limit rate=5000 path=education
