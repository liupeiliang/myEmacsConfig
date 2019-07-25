(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

;; locale coding 
(setq locale-coding-system'utf-8) 
(prefer-coding-system'utf-8) 
(set-keyboard-coding-system'utf-8) 
(set-terminal-coding-system'utf-8) 
(set-selection-coding-system'utf-8) 
(set-clipboard-coding-system 'ctext) 
(set-buffer-file-coding-system 'utf-8) 

;; ========================= set default tab =====================
;; when true, emacs use mixture of tab and space to achieve offset
(setq-default indent-tabs-mode nil)
(setq default-tab-width 2)
;(setq tab-stop-list())
(setq c-default-style "linux" c-basic-offset 2)
(setq-default c-basic-offset 2)        ; control length used to offset.
(setq-default tab-width 2)              ; control how emacs explain TAB.

;; ido配置
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(ido-everywhere t)
(setq flx-ido-mode 1)
(setq ido-enable-flex-matching t)

;; 启动全局auto-complete
(global-auto-complete-mode)

;; =========================
;; 启动页面
;; =========================
(load-theme 'monokai t)
; 关闭启动页面
(setq inhibit-startup-message t)
; 启动eshellload
(eshell)
; 分为左右两个窗口
(split-window-horizontally)
; 重命名窗口为run-cmd
(rename-buffer "run-cmd")
; 再新打开一个eshell
(eshell)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(custom-safe-themes
   (quote
    ("1d2f406a342499f0098f9388b87d05ec9b28ccb12ca548f4f5fa80ae368235b6" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" default)))
 '(package-selected-packages
   (quote
    (monokai-pro-theme auto-complete monokai-theme magit))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-added ((t (:foreground "green"))))
 '(magit-diff-added-highlight ((t (:foreground "green"))))
 '(magit-diff-removed ((t (:foreground "red"))))
 '(magit-diff-removed-highlight ((t (:foreground "red"))))
 '(magit-item-highlight ((t nil))))

;; =========================================================
;; 修改一些快捷命令
;; ========================================================

; 设置grep结尾不会自动补上/dev/null
(setq grep-use-null-device nil)
; 
(setq grep-command "grep --color --exclude-dir=test  --exclude-dir='.git' --exclude-dir='release64' --exclude-dir='debug64' --exclude-dir='_external' --binary-files=without-match -nir ")

; Ctrl-w 和 Meta-w 在未选中时剪切和复制当前行
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))


;; =========================================================
;; 下面开始定义快捷键
;; ========================================================

; C-c m 然后利用箭头可以调整窗口的大小，按回车结束调整
;(require 'windresize)
(global-set-key (kbd "C-c m") 'windresize)

; C-c 左箭头：恢复上一个窗口布局
; C-c 右箭头：前进一个窗口布局
(when (fboundp 'winner-mode)
   (winner-mode)
   (windmove-default-keybindings))

; 方向控制 
(global-set-key (kbd "C-<right>") 'other-window) ;windmove-right)
(global-set-key (kbd "C-<left>") (lambda() (interactive) (other-window -1)))

(global-set-key (kbd "C-<up>") 'ff-get-other-file) ;windmove-up)
(global-set-key (kbd "C-<down>") 'ff-get-other-file) ;windmove-down)

(global-set-key (kbd "<ESC><up>") (lambda() (interactive) (scroll-down 5)))
(global-set-key (kbd "<ESC><down>") (lambda() (interactive) (scroll-up 5)))

(global-set-key (kbd "M-p") (lambda() (interactive) (next-line -6)))
(global-set-key (kbd "M-n") (lambda() (interactive) (next-line 6)))

; 清空eshell
(defun my-eshell-clear-buffer ()
  "Eshell clear buffer."
  (interactive)
  (let ((eshell-buffer-maximum-lines 0))
    (eshell-truncate-buffer)))
(global-set-key (kbd "C-c c") 'my-eshell-clear-buffer)

; 切换到run-cmd
(global-set-key (kbd "C-c r") (lambda() (interactive) (switch-to-buffer "run-cmd")))

; 打开eshell
(global-set-key (kbd "C-c e") 'eshell)

; 切换头文件
(global-set-key (kbd "C-c t") 'ff-get-other-file)

; 跳转行号
(global-set-key (kbd "C-c l") 'goto-line)

; 显示行号
(global-set-key (kbd "C-c C-l") 'linum-mode)

; find grep
(global-set-key (kbd "C-c g") 'grep)

; how-many
(global-set-key (kbd "C-c n") 'how-many)

; replace string
(global-set-key (kbd "C-c h") 'replace-string)

; replace string
(global-set-key (kbd "C-c q") 'query-replace)

(defun my-do-compile-commad (command)
  "do compile command"
  (interactive)
  (let ((compile-command command))
    (call-interactively 'compile)))

; osscmd
(global-set-key (kbd "C-c u") (lambda() (interactive) (my-do-compile-commad "osscmd --id=UuJeBkxDXCkGK4ZF --key=hsfknAOmT43jAPWoAKScPnxoTCDeLw --host=oss-cn-hangzhou-zmf.aliyuncs.com put   oss://sepub/qingran/tmp" )))
(global-set-key (kbd "C-c d") (lambda() (interactive) (my-do-compile-commad "osscmd --id=UuJeBkxDXCkGK4ZF --key=hsfknAOmT43jAPWoAKScPnxoTCDeLw --host=oss-cn-hangzhou-zmf.aliyuncs.com multiget " )))

; abxp
(global-set-key (kbd "C-c x") (lambda() (interactive) (my-do-compile-commad "abxp -x -m \"scons=scons -j32 mode=debug\"" )))

; 删除到行首
(defun backspace-to-line-head ()
  "backspace to line head "
  (interactive)
  (kill-line 0)
  (indent-according-to-mode))
(global-set-key (kbd "C-c a") 'backspace-to-line-head)

; 刷新文件
(global-set-key (kbd "<ESC><f5>") (lambda() (interactive) (revert-buffer nil t)))
(global-set-key (kbd "<f5>") 'revert-buffer)

; magit
(defun magit-blame-toggle ()
  "magit blame mode toggle "
  (interactive)
  (if magit-blame-mode
      (magit-blame-quit)
    (magit-blame)))
(global-set-key (kbd "C-c b") 'magit-blame-toggle)
;(global-set-key (kbd "C-c m") 'magit-status)

; 在当前文件夹grep当前选中的部分，未选中时grep当前单词
(defun find-grep-selected ()
  "setting up grep-command using current word under cursor as a search string"
  (interactive)
  (let* ((cur-word (thing-at-point 'word))
         (cmd (concat grep-command "\"" cur-word "\" ."))
         (grep-command cmd))
    (grep cmd)))
(global-set-key (kbd "C-c f") 'find-grep-selected)

; scons
(defun scons-ut ()
  "scons unit test"
  (interactive)
  (let ((compile-command "scons -j 20 -u . gtest_filter="))
    (call-interactively 'compile)))
(global-set-key (kbd "C-c s") 'scons-ut)
(global-set-key (kbd "<f10>") 'recompile)

; gdb
(global-set-key [f7] 'gud-gdb)
(global-set-key [f8] 'gud-break)

;; ======================= git & magit ============================
(require 'magit)
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'diff-added "yellow")
     (set-face-foreground 'diff-removed "red")))

 
(defun call-magit-status()
  "open magit status"
  (interactive) (call-interactively 'magit-status))
(global-set-key (kbd "C-x g") 'call-magit-status)

(eval-after-load "vc-annotate"
'(defun vc-git-annotate-command (file buf &optional rev)
  (let ((name (file-relative-name file)))
    (vc-git-command buf 'async nil "blame" "--date=iso" rev "--" name))))

;; ==================== debug ====================
(require 'compile)
(add-to-list 'compilation-error-regexp-alist
             '("build/debug64/\\([a-zA-Z0-9_/\\.]+\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\):.*$" 1 2 3))
