#!/bin/bash
# add k8s gpg key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

# install docker
swapoff -a
wget -qO- get.docker.com | sh

# add docker auth for user
sudo usermod -aG docker $(whoami)

# install k8s
apt-get install -y kubelet=1.18.6-00 \
kubeadm=1.18.6-00 \
kubectl=1.18.6-00 \
kubernetes-cni=0.8.7-00

# add kubectl auth for user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# init k8s
kubeadm init

# install cni for k8s
kubectl apply -f \
"https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# check installed successfully
kubectl get pods --namespace kube-system
kubectl get no
echo "All Done"
