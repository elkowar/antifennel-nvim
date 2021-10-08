local _2afile_2a = "fnl/antifennel-nvim.fnl"
local _0_0
do
  local name_0_ = "antifennel-nvim"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local autoload = (require("aniseed.autoload")).autoload
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {autoload("aniseed.core"), autoload("aniseed.string")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {autoload = {a = "aniseed.core", str = "aniseed.string"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local str = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "antifennel-nvim"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
if not vim.g.antifennel_executable then
  vim.g.antifennel_executable = "antifennel"
end
if not vim.g.antifennel_tmp_path then
  vim.g.antifennel_tmp_path = "/tmp/antifennel-nvim-convert.lua"
end
local antifennel
do
  local v_0_
  local function antifennel0(path)
    print(vim.g.antifennel_executable)
    local compiler_path = (vim.g.antifennel_executable or "antifennel")
    return vim.fn.system((compiler_path .. " " .. path))
  end
  v_0_ = antifennel0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["antifennel"] = v_0_
  antifennel = v_0_
end
local get_selection
do
  local v_0_
  local function get_selection0()
    local _let_0_ = vim.fn.getpos("'<")
    local _ = _let_0_[1]
    local s_start_line = _let_0_[2]
    local s_start_col = _let_0_[3]
    local _let_1_ = vim.fn.getpos("'>")
    local _0 = _let_1_[1]
    local s_end_line = _let_1_[2]
    local s_end_col = _let_1_[3]
    local n_lines = (1 + math.abs((s_end_line - s_start_line)))
    local lines = vim.api.nvim_buf_get_lines(0, (s_start_line - 1), s_end_line, false)
    lines[1] = string.sub(lines[1], s_start_col, -1)
    if (1 == n_lines) then
      lines[n_lines] = string.sub(lines[n_lines], 1, (1 + (s_end_col - s_start_col)))
    else
      lines[n_lines] = string.sub(lines[n_lines], 1, s_end_col)
    end
    return s_start_line, s_end_line, lines
  end
  v_0_ = get_selection0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-selection"] = v_0_
  get_selection = v_0_
end
local convert_antifennel
do
  local v_0_
  do
    local v_0_0
    local function convert_antifennel0(text)
      a.spit(vim.g.antifennel_tmp_path, text)
      return antifennel(vim.g.antifennel_tmp_path)
    end
    v_0_0 = convert_antifennel0
    _0_0["convert_antifennel"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["convert_antifennel"] = v_0_
  convert_antifennel = v_0_
end
local convert_selection
do
  local v_0_
  do
    local v_0_0
    local function convert_selection0()
      local s_start, s_end, lua_code = get_selection()
      local fennel_code = str.split(convert_antifennel(str.join("\n", lua_code)), "\n")
      return vim.api.nvim_buf_set_lines(0, (s_start - 1), s_end, false, fennel_code)
    end
    v_0_0 = convert_selection0
    _0_0["convert_selection"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["convert_selection"] = v_0_
  convert_selection = v_0_
end
return nil
