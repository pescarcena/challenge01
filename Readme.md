
# Challenge 01

# **Pre-requisites**

- Docker
- Pulumi
- Npm
- GKE Account
- GKE SDK

# **GKE  additional steps**

- Go into GKE console make an Service Account
- Export **service account** credentials as **json** into project with the name  **credentials.json**
- Go to  GKE Kubernetes Engine and add permission to **service account created**

# **Project structure**

    challenge-01
    ├── Dockerfile
    ├── credentials.json
    ├── .env
    ├── deployk8s.sh
    ├── destroy.sh
    ├── docker.sh
    ├── gcp-pulumi
    │   ├── Pulumi.dev.yaml
    │   ├── Pulumi.yaml
    │   ├── index.ts
    │   ├── package.json
    │   └── tsconfig.json
    ├── py-server
    │   └── app.py
    └── run.sh

# **Environments**

Create an **.env** file using **.env.example** template

# **Run**

Execute this project with the following command:

    $ sh run.sh
