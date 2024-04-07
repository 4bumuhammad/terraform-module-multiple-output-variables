# Terraform module multiple output variables

&nbsp;

&#x1F516; Information on the user's device.<br />
<pre>
    ❯ system_profiler SPSoftwareDataType SPHardwareDataType

        Software:
            System Software Overview:
                System Version: macOS 13.3.1 (22E261)
                Kernel Version: Darwin 22.4.0
                Boot Volume: Macintosh HD
                Boot Mode: Normal    
                . . .

        Hardware:
            Hardware Overview:
                Model Name: MacBook Pro
                Model Identifier: MacBookPro17,1
                Model Number: MYD82ID/A
                Chip: Apple M1
                Total Number of Cores: 8 (4 performance and 4 efficiency)
                Memory: 8 GB
                . . .
</pre>

&nbsp;

<div align="center">
    <img src="./gambar-petunjuk/ss_terraform_logo_black.png" alt="ss_terraform_logo_black" style="display: block; margin: 0 auto;">
</div> 

&nbsp;

---

&nbsp;

Project structure.
<pre>
    ❯ tree -L 3 -a -I 'README.md|.DS_Store|.git|.gitignore|gambar-petunjuk|.terraform|*.hcl|*.tfstate|*.tfstate.backup' ./
        ├── main.tf
        ├── modules
        │   └── world1
        │       ├── main.tf
        │       └── outputs.tf
        ├── outputs.tf
        ├── provider.tf
        └── variables.tf

        2 directories, 6 files
</pre>

&nbsp;

**Reference :**<br />
- Stack overflow | "Why is my Terraform output not working in module?".
  <pre>https://stackoverflow.com/questions/52503528/why-is-my-terraform-output-not-working-in-module</pre>


&nbsp;

&nbsp;

### Code : 

<pre>
    ❯ vim provider.tf


        terraform {
          required_providers {
            null = {
              source = "hashicorp/null"
            }
          }
        }
</pre>

&nbsp;

<pre>
    ❯ vim main.tf


        module "world_stage_1" {
          source          = "./modules/world1"
          word_transition = var.word_hello
        }
</pre>

&nbsp;

<pre>
    ❯ vim variables.tf


        variable "word_hello" {
          description = "Kalimat Hello World"
          default     = "HELLO WORLD! from root variables."
        }
</pre>

&nbsp;

Modules : <br/>

<pre>
    ❯ vim modules/world1/main.tf


        variable "word_transition" {
          type = string
        }
        
        resource "null_resource" "echo_word_say_hello" {
          triggers = {
            always_run = "${timestamp()}"
          }
        
          provisioner "local-exec" {
            command = "echo '${var.word_transition}'"
          }
        }
</pre>

&nbsp;

<pre>
</pre>

&nbsp;

<pre>
</pre>

&nbsp;

<pre>
</pre>


### &#x1F530; TERRAFORM STAGES :



&nbsp;

&nbsp;

---

&nbsp;

<div align="center">
    <img src="./gambar-petunjuk/well_done.png" alt="well_done" style="display: block; margin: 0 auto;">
</div> 

&nbsp;

---

&nbsp;

&nbsp;