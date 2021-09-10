# sentrymode for docker nodes

Checks on the specified interval if the load is higher than the specified threshold. 
If so, it will take a snapshot of: 
- running docker processes
- top output
... and save it to disk. 

It will automatically delete snapshots older than 5 days.

Run locally with:
`ansible-playbook -i <cluster-inventory-file> playbook.yml`
