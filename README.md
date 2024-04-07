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
    ❯ vim modules/world1/outputs.tf

        output "echo_word_say_hello_output" {
          value = "Hi, ${var.word_transition}\nOutput from module world1."
        }
</pre>

&nbsp;

Output in root : <br/>

<pre>
    ❯ vim outputs.tf


        output "world_echo_word_say_hello_output_says" {
          value = module.world_stage_1.echo_word_say_hello_output
        }
</pre>

&nbsp;

&nbsp;


### &#x1F530; TERRAFORM STAGES :

<pre>
    ❯ terraform init



            Initializing the backend...
            Initializing modules...

            Initializing provider plugins...
            - Reusing previous version of hashicorp/null from the dependency lock file
            - Using previously-installed hashicorp/null v3.2.2

            Terraform has been successfully initialized!

            You may now begin working with Terraform. Try running "terraform plan" to see
            any changes that are required for your infrastructure. All Terraform commands
            should now work.

            If you ever set or change modules or backend configuration for Terraform,
            rerun this command to reinitialize your working directory. If you forget, other
            commands will detect it and remind you to do so if necessary.
</pre>

&nbsp;

<pre>
    ❯ terraform fmt
    ❯ terraform validate

        Success! The configuration is valid.
</pre>

&nbsp;

<pre>
    ❯ terraform plan



            module.world_stage_1.null_resource.echo_word_say_hello: Refreshing state... [id=1224189821322960773]

            Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            -/+ destroy and then create replacement

            Terraform will perform the following actions:
 
            # module.world_stage_1.null_resource.echo_word_say_hello must be replaced
            -/+ resource "null_resource" "echo_word_say_hello" {
                ~ id       = "1224189821322960773" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run" = "2024-04-06T21:32:53Z" -> (known after apply)
                    }
                }

            Plan: 1 to add, 0 to change, 1 to destroy.

            ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

            Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
</pre>

&nbsp;

Test the output :
<pre>
    ❯ jq --version

        jq-1.6


    ❯ terraform output -json world_echo_word_say_hello_output_says

        "Hi, HELLO WORLD! from root variables.\nOutput from module world1."
</pre>

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