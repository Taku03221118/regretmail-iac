resource google_project_service services {
    provider = google-beta
    project = var.project
    for_each = var.services
    service = each.value

    #display_on_destroy = false

    provisioner local-exec {
        command = "sleep 60"
    }
}