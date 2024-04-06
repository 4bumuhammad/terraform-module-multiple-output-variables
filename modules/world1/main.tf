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