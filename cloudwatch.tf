resource "aws_cloudwatch_event_rule" "rule" {
    count               = "${var.attach_cloudwatch_rule_config ? 1 : 0}"
    name                = "${var.cloudwatch_rule_config["name"]}"
    description         = "${var.cloudwatch_rule_config["description"]}"
    schedule_expression = "${var.cloudwatch_rule_config["schedule_expression"]}"
}

resource "aws_cloudwatch_event_target" "target" {
    count     = "${var.attach_cloudwatch_rule_config ? 1 : 0}"
    target_id = "${element(concat(aws_lambda_function.lambda.*.function_name, aws_lambda_function.lambda_s3.*.function_name, aws_lambda_function.lambda_with_dl.*.function_name, aws_lambda_function.lambda_with_vpc.*.function_name, aws_lambda_function.lambda_with_dl_and_vpc.*.function_name), 0)}"
    rule      = "${aws_cloudwatch_event_rule.rule.name}"
    arn       = "${element(concat(aws_lambda_function.lambda.*.arn, aws_lambda_function.lambda_s3.*.arn, aws_lambda_function.lambda_with_dl.*.arn, aws_lambda_function.lambda_with_vpc.*.arn, aws_lambda_function.lambda_with_dl_and_vpc.*.arn), 0)}"
}