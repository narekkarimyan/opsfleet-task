# Automate EKS cluster setup on AWS

A Terraform template for provisioning EKS cluster setup on AWS.

## Resources created

This configuration will create EKS cluster, node group, IAM roles, policy attachments and VPC (if you haven't imported into VPC module).

## Usage

To apply EKS and all other required resources on AWS, run below commands. Make sure you have AWS credentials correctly listed in `~/.aws/credentials`

```bash
cd automate-k8s-in-eks
terraform apply
```
After applying the configuration, you will get an output with IAM role ARN, which will be used in k8s pods to perform actions based on required permissions. The ARN of the IAM role should be pasted in `metadata.annotations.[eks.amazonaws.com/role-arn]` in file `serviceaccount.yaml`. By applying that file, a service account is created, which is being bind to the IAM role. That should be created using 
```bash
kubectl apply -f serviceaccount.yaml
```

In `demo_pod.yaml`, a simple configuration is written that runs a pod, where newly created Service Account is used. Same way you can create new Kubernetes resources with that Service Account and it will have the permissions that are attached to the IAM role. For instance, the IAM role that is created in this configuration has a permission to access S3 buckets. This can be tested by having `demo_pod.yaml` applied and running the following command, which will list all S3 buckets existing in your AWS account: 
```bash
kubectl exec aws-k8s-demo -- aws s3api list-buckets
```

