(use-package bazel
  :ensure t
  :commands bazel-build bazel-run bazel-test bazel-coverage
  :mode (("/WORKSPACE\\'"         . bazel-workspace-mode)
         ("/WORKSPACE\\.bazel\\'" . bazel-workspace-mode))
  :custom
  (bazel-buildifier-before-save (executable-find "buildifier")))

(provide '23-bazel)
