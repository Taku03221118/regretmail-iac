resource google_storage_bucket buckets {
    project = var.project
    for_each = var.bucket
    name = each.value.name
    location = each.value.location
    storage_class = each.value.storage_class

    versioning {
        enabled = each.value.versioning.enabled
    }

    dynamic lifecycle_rule {
        for_each = [for rule in each.value.lifecycle_rule : {
            type = rule.action.type
            storage_class = rule.action.storage_class
            age = rule.condition.age
            num_newer_versions = rule.condition.num_newer_versions
        }]

        content {
            action {
                type = lifecycle_rule.value.type
                storage_class = lifecycle_rule.value.storage_class
            }
            condition {
                age = lifecycle_rule.value.age
                num_newer_versions = lifecycle_rule.value.num_newer_versions
            }
        }
    }
    depends_on = [
        var.module_depends_on,
    ]
}