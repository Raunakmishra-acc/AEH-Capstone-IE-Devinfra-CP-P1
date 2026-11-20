
## Test evidence / finding
- simulate-custom-policy (policy alone): GetObject, ListBucket = allowed; PutObject, DeleteObject = implicitDeny, so least privilege works
- simulate-principal-policy (real user): explicitDeny on all actions, AllowedByOrganizations = false. The lab account's Organizations SCP overrides the user's allow (explicit deny always wins).
https://github.com/Raunakmishra-acc/AEH-Capstone-IE-Devinfra-CP-P1/blob/main/Project-04/Screenshot%202026-11-20%20170614.png
