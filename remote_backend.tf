terraform {
  backend "remote" {
    organization = "##Your_Organization_Name##"

    workspaces {
      name = "##Your_Workspace_Name##"
    }
  }
}