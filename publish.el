(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			                   ("org" . "https://orgmode.org/elpa/")
			                   ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Init use-package on non-linux. we need this for macbook :/
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


;; make sure all used packages are installed
(require 'use-package)
(setq use-package-always-ensure t)

(use-package org :pin org)

(setq org-publish-project-alist
      '(("site"
         :base-directory "./"
         :base-extension "org"
         :html-postamble nil
         :publishing-directory "./build_out")
        ("notes"
         :base-directory "./notes"
         :base-extension "org"
         :html-postamble "<p class=\"date\">Written: %d</p>"
         :publishing-directory "./build_out/notes")
        ("work"
         :base-directory "./work"
         :base-extension "org"
         :html-postamble nil
         :publishing-directory "./build_out/work")
        ))

(let ((org-html-toplevel-hlevel 2)
      (org-export-with-toc nil)
      (org-export-with-section-numbers nil)
      (org-html-head-extra "
<style>
html, body {
  margin: 0;
  height: 100%;
  font-family: serif;
}

.title {
  text-align: left!important;
}

body {
  display: flex;
  flex-direction: column;
}

a {
  color: blue;
}

.content {
  max-width: 800px!important;
  padding: 20px;
}

.horizbullets > ul {
  display: flex;
  list-style-type: none;
  margin: 0;
  padding: 0;
  gap: 10px;
}

.status {
  padding: 20px;
  text-align: right;
}
</style>
")) (org-publish-all t))
