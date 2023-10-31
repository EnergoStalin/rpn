includes("rules.lua", "test/xmake.lua")

target("rpn")
  set_default()
  set_kind("static")
  add_files("*.c")
  add_headerfiles("*.h")

  add_rules("coverage")
target_end()
