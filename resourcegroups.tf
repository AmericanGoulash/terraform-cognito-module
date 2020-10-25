resource "aws_resourcegroups_group" "ui-resources" {
  name = "cognito-resources"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "Component",
      "Values": ["cognito"]
    }
  ]
}
JSON
  }
}