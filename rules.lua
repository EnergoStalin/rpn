rule("coverage")
  on_load(function (target) 
    if not is_mode("coverage") then return end

    target:add("links", "gcov")
  end)

  on_config(function (target) 
    if not is_mode("coverage") then return end

    target:add("cxflags", unpack({"-fprofile-arcs", "-ftest-coverage"}))
  end)
rule_end()

rule("report")
  after_run(function (target) 
    if not is_mode("coverage") then return end

    local testinfo = {}
    for k, v in pairs(target._DEPS) do
      os.execv("lcov", { "-o", path.join(target:targetdir(), k .. ".info"), "-c", "-d", v:objectdir() })
    end
  end)
rule_end()

rule("valgrind")
  if is_mode("valgrind") then
    on_run(function (target) 
      os.execv("valgrind", { "-s", "--leak-check=full", "--", target:targetfile() })
    end)
  end
rule_end()
