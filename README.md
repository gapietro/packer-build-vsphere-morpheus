# packer-build-vsphere-morpheus

How to use:

1.  update variables.auto.pkrvars.hcl with VMWare Details
2.  execute packer build with:

    packer build -var-file=VARFILE TEMPLATE
    example:  packer build -var-file=variables.auto.pkrvars.hcl centos-8.4.vsp.pkr.hcl 
    
