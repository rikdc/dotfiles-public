function aic --description "Claude Code AI Assistant via AWS Bedrock"
    env CLAUDE_CODE_USE_BEDROCK=true \
        AWS_REGION=us-west-2 \
        AWS_PROFILE=tooling-ai-coding-assistant \
        claude --model us.anthropic.claude-sonnet-4-20250514-v1:0 $argv
end
