add_rules("mode.release", "mode.debug")

add_cflags("-Wall", "-Werror", "-Wextra")
set_languages("c11")

add_toolchains("gcc")

add_requires("check")

rule("coverage")
  on_load(function (target) 
    if is_mode("coverage") then
      target:add("links", "gcov")
      target:add("rules", "mode.coverage")
    end
  end)
  on_config(function (target) 
    if is_mode("coverage") then
      target:add("cxflags", unpack({"-fprofile-arcs", "-ftest-coverage"}))
    end
  end)
rule_end()

rule("report")
  after_run(function (target) 
    if is_mode("coverage") then
      local testinfo = path.join(target:objectdir(), "tests.info")
      os.execv("lcov", { "-o", testinfo, "-c", "-d", target._DEPS.rpn:objectdir() })
      os.execv("genhtml", { "-o", path.join(target:targetdir(), "/report"), testinfo })
    end
  end)
rule_end()

target("rpn")
  set_default()
  set_kind("static")
  add_files("*.c")
  add_headerfiles("*.h")

  add_rules("coverage")
target_end()

target("rpn-test")
  set_kind("binary")
  add_files("test/test.c")
  add_rules("mode.valgrind", "report")

  add_packages("check")
  add_deps("rpn")
target_end()
