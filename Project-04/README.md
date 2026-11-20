
## Test evidence / finding
- simulate-custom-policy (policy alone): GetObject, ListBucket = allowed; PutObject, DeleteObject = implicitDeny, so least privilege works
- simulate-principal-policy (real user): explicitDeny on all actions, AllowedByOrganizations = false. The lab account's Organizations SCP overrides the user's allow (explicit deny always wins).
