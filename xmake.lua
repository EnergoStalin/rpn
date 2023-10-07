add_cflags("-Wall", "-Werror", "-Wextra")
set_languages("c11")

add_toolchains("gcc")

target("rpn")
  set_kind("static")
  add_files("*.c")
  add_headerfiles("*.h")
