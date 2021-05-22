(module antifennel-nvim
  {autoload {a aniseed.core
             str aniseed.string}})

; TODO remove
(if (not vim.g.antifennel_executable)
  (set vim.g.antifennel_executable "antifennel"))
(if (not vim.g.antifennel_tmp_path)
  (set vim.g.antifennel_tmp_path "/tmp/antifennel-nvim-convert.lua"))


(defn- antifennel [path]
  (print vim.g.antifennel_executable)
  (let [compiler-path (or vim.g.antifennel_executable "antifennel")]
    (vim.fn.system (.. compiler-path " " path))))


(defn- get-selection []
  (let [[_ s-start-line s-start-col] (vim.fn.getpos "'<")
        [_ s-end-line s-end-col]     (vim.fn.getpos "'>")
        n-lines                      (+ 1 (math.abs (- s-end-line s-start-line)))
        lines                        (vim.api.nvim_buf_get_lines 0 (- s-start-line 1) s-end-line false)]
    (tset lines 1 (string.sub (. lines 1) s-start-col -1))
    (if (= 1 n-lines)
      (tset lines n-lines (string.sub (. lines n-lines) 1 (+ 1 (- s-end-col s-start-col))))
      (tset lines n-lines (string.sub (. lines n-lines) 1 s-end-col)))
    (values s-start-line s-end-line lines)))

(defn convert_antifennel [text]
  (a.spit vim.g.antifennel_tmp_path text)
  (antifennel vim.g.antifennel_tmp_path))

(defn convert_selection []
  (print "heyho")
  (let [(s-start s-end lua-code) (get-selection)
        fennel-code              (str.split (convert_antifennel (str.join "\n" lua-code)) "\n")]
    (print "hey")
    (vim.api.nvim_buf_set_lines 0 (- s-start 1) s-end false fennel-code)))

