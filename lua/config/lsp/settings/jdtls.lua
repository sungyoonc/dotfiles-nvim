-- This setting is for nvim-lspconfig setup for jdtls
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
