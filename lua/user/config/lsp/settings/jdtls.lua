return {
  initializationOptions = {
    bundles = {
      vim.fn.stdpath("data") .. "/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
    },
  },
  settings = {
    java = {
      inlayHints = { parameterNames = { enabled = "all" } };
    }
  },
}
