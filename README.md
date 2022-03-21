# Setup

Demo application to show using ko with k3s. The demo application leverages [nerdCTL](https://github.com/containerd/nerdctl) and [limactl](https://github.com/lima-vm/lima) to load the images into k3s kubernetes cluster.

## Start k3s cluster

We can use [Rancher Desktop](https://rancherdesktop.io/) or spin k3s using [lima](https://github.com/lima-vm/lima) as shown below,

(OR)

```shell
limactl start --tty=false $PWD/ko-k3s-demos.yaml
```

## Environment Variables

The demo uses the [direnv](https://direnv.net) to set the local demo app environment. If you don't _direnv_ you can set things as per convenience.

But here are some important variables to set,

- `KO_DOCKER_REPO` - set this to **k3s.local** to enable ko to recognize this build is for k3s.
- `LIMA_INSTANCE`  - set this to the lima-vm name, if you use the above command it will be `ko-k3s-demos`. If you use rancher-desktop then you are not required to set this as the default lima-vm name is assumed to be **default**

## ko the Application

__IMPORTANT___: if you are test against the dev build make sure to set the path of `ko` to your local build.

With all set we are good to run `ko` against the demo-ap but let's do a sanity check to see if the application image already exists,

```shell
limactl shell $LIMA_INSTANCE nerdctl --namespace="k8s.io" images | grep -i k3s.local
```

For the very first run you should not see an image with `k3s.local`; OK now lets run,

```shell
ko resolve -f configs | kubectl apply -f -
```

If all went well we should have myapp pod and service running in default namespace,

```shell
kubectl get po,svc -lapp=myapp
```

Lets do port forward of the `deploy/myapp` to access the service locally,

```shell
kubectl port-forward deploy/myapp 8080
```

Call the service,

```shell
curl http://localhost:8080/ping
```

If you got the `pong` then you are all set :)
