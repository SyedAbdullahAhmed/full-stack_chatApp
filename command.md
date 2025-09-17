
# 🚀 Deploying a Full-Stack Chat Application on Amazon EKS

This guide explains how to set up an **EKS cluster**, install the **AWS Load Balancer Controller**, and deploy a **full-stack chat application** with **MongoDB, Backend, and Frontend** using Kubernetes.


# Step 1: Create an EKS Cluster
Create an EKS cluster with 2 `t2.medium` nodes using `eksctl`.

```bash
eksctl create cluster \
  --name chat-app-cluster \
  --version 1.29 \
  --region us-east-1 \
  --nodegroup-name standard-workers \
  --node-type t2.medium \
  --nodes 2 \
  --managed
````

---

# Step 2: Verify Cluster Setup

Check if the cluster nodes and namespaces are available.

```bash
kubectl get nodes
kubectl get ns
```

---

# Step 3: Install AWS Load Balancer Controller

Add Helm repo, create IAM policy, associate OIDC provider, create IAM service account, and install ALB controller.

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update

curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam-policy.json

eksctl utils associate-iam-oidc-provider \
  --region us-east-1 \
  --cluster chat-app-cluster \
  --approve

eksctl create iamserviceaccount \
  --cluster chat-app-cluster \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=chat-app-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

kubectl get pods -n kube-system
```

---

# Step 4: Deploy MongoDB

Apply namespace, secrets, storage configuration, and deploy MongoDB.

```bash
kubectl apply -f namespace.yml
kubectl apply -f secrets.yml -f mongodb-pv.yml
kubectl apply -f mongodb-pvc.yml
kubectl apply -f mongodb-deployment.yml -f mongodb-service.yml
```

---

# Step 5: Deploy Backend

Deploy backend services.

```bash
kubectl apply -f backend-deployment.yml -f backend-service.yml
```

---

# Step 6: Deploy Frontend

Deploy frontend services.

```bash
kubectl apply -f frontend-deployment.yml -f frontend-service.yml
```

---

# Step 7: Configure Ingress

Apply ingress configuration and verify ingress resource.

```bash
kubectl apply -f ingress.yml
kubectl get ingress -n chat-app
```

---

# Step 8: Verify Application

Check pods, services, logs, and use port-forward for local testing.

```bash
kubectl get pods -n chat-app
kubectl get svc -n chat-app
kubectl describe pod <pod-name> -n chat-app
kubectl logs <pod-name> -n chat-app
kubectl port-forward svc/frontend 8080:80 -n chat-app
```

---

# Step 9: Verify Load Balancer

If Load Balancer DNS is not working, recheck if the LB listener is attached to Target Groups.
Check ALB in AWS Console, Ensure listeners are properly attached to target groups


---

# Step 10: Cleanup Resources

Delete the cluster when you are done.

```bash
eksctl delete cluster --name chat-app-cluster --region us-east-1
```

