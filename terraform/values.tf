terraform {
    backend gcs {
        bucket = "${project}-bucket"
        path = "default.tfstate"
    }
}

locals {
    project="regretmail-project"

    region="asia-northeast1"
    zone="asia-northeast1-a"

    regional = false
    location = local.regional ? local.region : local.zone# 変数=条件 ? 値１ : 値２;
    # これは条件によって判定を行い、 条件に合致していれば値１を変数に代入し、 合致していなければ変数に値２を代入します。

    services= {
        appengine="appengine.googleapis.com"
        cloudfunctions="cloudfunctions.googleapis.com"
        cloudbuild="cloudbuild.googleapis.com"
        cloudkms="cloudkms.googleapis.com"
        cloudresourcemanager="cloudresourcemanager.googleapis.com"
        cloudscheduler="cloudscheduler.googleapis.com"
        container="container.googleapis.com"
        containeranalysis="containeranalysis.googleapis.com"
        containerregistry="containerregistry.googleapis.com"
        containerscanning="containerscanning.googleapis.com"
        dns="dns.googleapis.com"
        iam="iam.googleapis.com"
        iamcredentials="iamcredentials.googleapis.com"
        oslogin="oslogin.googleapis.com"
        pubsub="pubsub.googleapis.com"
        artifactregistry="artifactregistry.googleapis.com"
    }
    
    network= {
        name="vpc-cicd"
    }
    
    subnetwork= {
        name="subnetwork-cicd"
        instance = "10.0.0.0/25"
        pod = "10.0.64.0/18"
        service = "10.0.1.0/24"
    }
    
    # dnsとSecurity_policyについては記載しない。 
    gke= {
        name="${project}-cluster"
        version="1.25.10-gke.2700"
        pod_security_policy_config=false
        default_max_pods_per_node="64"
    }
    
    release_channel= {
        channel="STABLE"
    }
    
    node_pool= {
        name="cicd-node-pool"
        min_node_count="0"
        max_node_count="2"
    
        labels= {
            "app_name": local.app_name
        }
    
        preemptible=true tags=[local.app_name,
        "gke"]
    }
    
    namespaces= {
        gitlab_runner= {
           metadata= {
                name="gitlab-runner"
                annotations= {}
                labels= {
                    namespace="gitlab-runner
                }
            }
        }
    }

    bucket = {
        cloud_storage = {
            name = "cloud-functions-ipconfirm4"
            location = local.region
            storage_class = "REGIONAL"
    
            versioning = {
                enabled = true
            }
            lifecycle_rule = [
                {
                    action = {
                        type = "Delete"
                        storage_class = ""
                    }
                    condition = {
                        num_newer_versions = 1
                        age = 90
                    }
                },
            ]
        }
    }
}