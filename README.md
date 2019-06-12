# Ghost blog for Dromomania

This repo contains Kubernetes configuration setting up a Ghost blog for [Dromomania](https://dromomania.be) on Digital Ocean.

## Repo structure

* `kubernetes/` [Managing Helm releases the GitOps way](https://www.weave.works/blog/managing-helm-releases-the-gitops-way).
* `terraform/` Bootstrap the k8s cluster with Terraform on Digital Ocean

## Requirements

Install these tools with your favorite package manager:

* `terraform`
* `doctl`
* `kubectl`
* `helm`

You should have a Digital Ocean API token available for `doctl` and `terraform`.

## Installation steps

This should bootstrap the environment, Flux takes care of the deployment.

```bash
    # Create the k8s cluster and the domain for DNS
    cd terraform
    terraform apply
    cd -

    # Configure your kubectl to access the cluster
    doctl kubernetes cluster kubconfig save simplistic-production-1
    kubectl config use-context do-ams3-simplistic-production-1

    # Install Helm/Tiller and Flux
    cd kubernetes/shared/
    ./install-tiller.sh
    ./install-flux.sh
    cd -

```

I didn't include the DO API token in source for obvious security reasons, so it still has to be changed in the cluster.

```bash
    echo -n $DIGITALOCEAN_API_TOKEN | base64 | pbcopy
    kubectl edit secrets default-external-dns
    kubectl delete pod -l app=external-dns
```

Finally you want to login on the blog, so you need a password.

```bash
    kubectl get secrets default-ghost-dromomania -o yaml | grep ghost-password | awk -F' ' '{ print $2 }' | base64 -D | pbcopy
```

Now go to [https://dromomania.be/](https://dromomania.be/) and login with dromomania@simplistic.be and the password on your clipboard.

## Credits

The kubernetes/flux config is based on [https://github.com/travis-ci/kubernetes-config](https://github.com/travis-ci/kubernetes-config).

Charts:

* [ghost](https://hub.helm.sh/charts/bitnami/ghost)
* [cert-manager](https://hub.helm.sh/charts/jetstack/cert-manager)
* [external-dns](https://hub.helm.sh/charts/stable/external-dns)
* [nginx-ingress](https://hub.helm.sh/charts/stable/nginx-ingress)

Tutorials:

* [How To Set Up an Nginx Ingress on DigitalOcean Kubernetes Using Helm](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-on-digitalocean-kubernetes-using-helm)
* [How To Automatically Manage DNS Records From DigitalOcean Kubernetes Using ExternalDNS](https://www.digitalocean.com/community/tutorials/how-to-automatically-manage-dns-records-from-digitalocean-kubernetes-using-externaldns)

## License

MIT

## Author Information

Jeroen Op 't Eynde, jeroen@simplistic.be
