# AWX on Digitaloceans K8s offering.

An experiment that runs [AWX](https://github.com/ansible/awx) on [Digitalocan](https://www.digitalocean.com), on the [Kubernetes](https://kubernetes.io).

## Create the Kubernetes cluster, the awx-operator and awx-deployment.

```shell
terraform apply
```

The full deployment may take 15 minutes or so. Terraform creates a Kubernetes deployment and reports as done, although the actual deployment takes a while.

## Get the admin password.

```shell
alias kubectl="kubectl --kubeconfig=kube_config.yaml"
kubectl get secret my-awx-admin-password -o jsonpath="{.data.password}" | base64 --decode
```

## Get the hostname.

The Kubernetes deployments creates a load balancer. Please review the [Digital Ocean load balancer dashboard](https://cloud.digitalocean.com/networking/load_balancers).

The service may take a couple of minutes to be available.

## Cleanup

```shell
terraform destroy
```
