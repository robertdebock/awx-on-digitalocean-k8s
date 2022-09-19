# AWX on Digitaloceans K8s offering.

An experiment that runs [AWX](https://github.com/ansible/awx) on [Digitalocan](https://www.digitalocean.com), on the [Kubernetes](https://kubernetes.io).

## Create the Kubernetes cluster and the awx-operator.

```shell
terraform apply
```

## Create a deployment of AWX, based on the awx-operator.

```shell
kubectl --kubeconfig=kube_config.yaml create namespace awx
kubectl --kubeconfig=kube_config.yaml -n awx apply -f awx-deployment.yaml
```

## Forward a (local) port to the AWX instance.

```shell
kubectl --kubeconfig=kube_config.yaml -n awx port-forward service/awx-service 8080:80
```

## Get the admin password.

```shell
kubectl  --kubeconfig=kube_config.yaml -n awx get secret awx-admin-password -o jsonpath="{.data.password}" | base64 --decode
```
