
provider "aws" {
  alias  = "primary"
  region = "ap-south-1"
}


provider "aws" {
  alias  = "dr"
  region = "us-west-2"
}

