locals {
  common_tags = {
    company    = "${var.company}"
    project    = "${var.company}-${var.project_id}"
    costcenter = var.cost_center
  }
}