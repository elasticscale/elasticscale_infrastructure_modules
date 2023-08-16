// this creates the iam users and makes sure they can roleswitch to the other accounts
// normally i would advice use aws sso here, but for this demo it would work
// you need to get the user passwords from the statefile in s3 of the security account

resource "aws_iam_user" "user" {
  for_each      = toset(var.users[*].username)
  name          = each.value
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "console" {
  for_each                = aws_iam_user.user
  user                    = each.value.name
  password_reset_required = true
}

// administrator access policy includes the ability to assume roles
resource "aws_iam_user_policy_attachment" "admin" {
  for_each   = aws_iam_user.user
  user       = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}