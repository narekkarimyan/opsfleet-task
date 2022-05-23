# Manage secrets on Kubernetes

Hereby I will present two options on how the team can manage their secrets on Kubernetes.

Firstly, the client team is using an insecure and unrecommended way (config file in Github repo) of storing their secrets. Thus, the first option for them, as the ones who run their applications on Kubernetes, is to create **Secret** objects. Those are Kubernetes objects, which are designed to store sensitive data. The values can be stored in encrypted format, and so it is a safe-to-use option too. Immediately, it eliminates the use of keeping sensitive data in the application code. Then, those secrets can be easily fetched and passed into Kubernetes Services, Deployments, etc. So, Kubernetes Secrets is one better option of sensitive data management.

As the client team runs the Kubernetes cluster in AWS EKS, they can try to use **AWS Secrets Manager**, which is by far the best option in terms of security and management. So, the client team can add their secret data to AWS Secrets Manager and then with the appropriate AWS driver those values can be mounted into Kubernetes pods. Even though the setup of this mechanism may not be as easy as the first option, it creates seemless integration between Kubernetes cluster and AWS cloud, provides stronger security and, finally, possibility to manage those secrets through AWS Console. Thus, by using AWS Secrets Manager the client team can easily and securely manage their secrets.

Another option could also be HashiCorp **Vault** integration. However as it is mentioned that the team is small and self-hosted, we won't consider that option for the present time.