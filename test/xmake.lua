set_project("rpn-test")

add_requires("check")

target("rpn-test")
  set_kind("binary")
  add_files("*.c")
  add_rules("mode.valgrind", "report")

  add_packages("check")
  add_deps("rpn")
  set_group("test")
target_end()
