variable project {
    description = "The name of the project"
}
variable bucket {
    description = "The name of the bucket"
}
variable module_depends_on {
    type = any
    default = []
    description = "The name of the module used to be dependencies"
}