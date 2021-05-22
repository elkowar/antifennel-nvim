if has("nvim")
  command! -range Antifennel :lua require('antifennel-nvim').convert_selection()
endif
