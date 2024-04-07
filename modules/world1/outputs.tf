output "echo_word_say_hello_output" {
  value = "Hi, ${var.word_transition}\nOutput from module world1."
}

output "world_module_says_again" {
  value = "hi again from world module."
}