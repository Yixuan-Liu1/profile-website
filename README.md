# AWS SSO Setup

Quick setup script for configuring the `resume-deploy` AWS SSO profile.

## Prerequisites

- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed
- Your AWS SSO start URL (get this from your AWS admin or the IAM Identity Center console)

## Setup

**1. Clone or download this repo, then open `aws_sso_setup.sh` and update the SSO URL:**

```bash
SSO_START_URL="https://your-sso-portal.awsapps.com/start"   # <-- CHANGE THIS
```

**2. Make the script executable and run it:**

```bash
chmod +x aws_sso_setup.sh
bash aws_sso_setup.sh
```

**3. A browser window will open — log in with your SSO credentials.**

**4. Once complete, the script will confirm your identity:**

```
{
    "UserId": "...",
    "Account": "123456789012",
    "Arn": "arn:aws:sts::123456789012:assumed-role/..."
}
```

That's it — you're ready to run Terraform.

## Re-authenticating

SSO sessions expire (typically after 8 hours). To log in again:

```bash
aws sso login --profile resume-deploy
```

## Running Terraform

Once authenticated, Terraform will automatically use the `resume-deploy` profile:

```bash
terraform init
terraform plan
terraform apply
```

## Configuration defaults

| Setting          | Value            |
| ---------------- | ---------------- |
| Profile name     | `resume-deploy`  |
| SSO session name | `resume-session` |
| SSO region       | `us-east-1`      |
| Default region   | `us-east-1`      |
| Output format    | `json`           |

To change any of these, edit the config section at the top of `aws_sso_setup.sh`.

## Troubleshooting

**`❌ Please edit aws_sso_setup.sh and set your SSO_START_URL`**
You haven't updated the placeholder URL yet — edit line 6 of the script.

**Browser doesn't open**
Run the login step manually:

```bash
aws sso login --profile resume-deploy
```

**`Error: Token has expired`**
Your session expired — just re-authenticate:

```bash
aws sso login --profile resume-deploy
```

**`aws: command not found`**
Install AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
