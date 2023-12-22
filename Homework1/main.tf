resource "aws_iam_user" "saya_user" {
  name = "Saya"
}

resource "aws_iam_user" "kaizen_user" {
  name = "Kaizen"
}

resource "aws_iam_user" "hello_user" {
  name = "Hello1"
}

resource "aws_iam_user" "world_user" {
  name = "World"
}

resource "aws_iam_group" "devops_group" {
  name = "DevOps"
}

resource "aws_iam_group" "qa_group" {
  name = "QA"
}

resource "aws_iam_group_membership" "group_devops" {
  name = "group-DevOps"
  users = [aws_iam_user.saya_user.name, aws_iam_user.kaizen_user.name]
  group = aws_iam_group.devops_group.name
}

resource "aws_iam_group_membership" "hello_qa" {
  name = "Hello-QA"
  users = [aws_iam_user.hello_user.name, aws_iam_user.world_user.name]
  group = aws_iam_group.qa_group.name
}