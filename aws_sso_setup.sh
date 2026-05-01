#!/bin/bash

# ============================================================
#  AWS SSO Setup Script
#  Edit the one line below, then run:  bash aws_sso_setup.sh
# ============================================================

SSO_START_URL="https://d-9a675954f5.awsapps.com/start"   # <-- CHANGE THIS

# ============================================================
#  Config — change these if needed, defaults are fine
# ============================================================
SSO_REGION="us-east-1"
SSO_SESSION_NAME="resume-session"
PROFILE_NAME="resume-deploy"
DEFAULT_REGION="us-east-1"
DEFAULT_OUTPUT="json"

# ============================================================
#  Script — no need to edit below this line
# ============================================================

# Validate the URL was changed
if [[ "$SSO_START_URL" == "https://your-sso-portal.awsapps.com/start" ]]; then
  echo "❌  Please edit aws_sso_setup.sh and set your SSO_START_URL before running."
  exit 1
fi

echo "🔧  Configuring AWS SSO profile: '$PROFILE_NAME'"

# Write the SSO session block
aws configure set sso_session "$SSO_SESSION_NAME" --profile "$PROFILE_NAME"
aws configure set sso_start_url "$SSO_START_URL" --profile "$PROFILE_NAME"
aws configure set sso_region "$SSO_REGION" --profile "$PROFILE_NAME"
aws configure set sso_registration_scopes "sso:account:access" --profile "$PROFILE_NAME"
aws configure set region "$DEFAULT_REGION" --profile "$PROFILE_NAME"
aws configure set output "$DEFAULT_OUTPUT" --profile "$PROFILE_NAME"

# Also write the standalone sso-session block in ~/.aws/config
AWS_CONFIG="$HOME/.aws/config"

if ! grep -q "\[sso-session $SSO_SESSION_NAME\]" "$AWS_CONFIG" 2>/dev/null; then
  echo "" >> "$AWS_CONFIG"
  echo "[sso-session $SSO_SESSION_NAME]" >> "$AWS_CONFIG"
  echo "sso_start_url = $SSO_START_URL" >> "$AWS_CONFIG"
  echo "sso_region = $SSO_REGION" >> "$AWS_CONFIG"
  echo "sso_registration_scopes = sso:account:access" >> "$AWS_CONFIG"
  echo "✅  SSO session block added to ~/.aws/config"
fi

echo ""
echo "🌐  Opening browser for SSO login..."
aws sso login --profile "$PROFILE_NAME"

if [ $? -eq 0 ]; then
  echo ""
  echo "✅  Login successful! Verifying credentials..."
  echo ""
  aws sts get-caller-identity --profile "$PROFILE_NAME"
else
  echo ""
  echo "❌  SSO login failed. Check your SSO_START_URL and try again."
  exit 1
fi
