// this simply creates a role in the account that allows the security account to assume it with AdministratorAccess
resource "aws_iam_role" "security" {
  name               = "${var.prefix}-security"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "${var.security_account_id}"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "security" {
  role       = aws_iam_role.security.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}