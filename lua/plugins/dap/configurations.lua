return {
  go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "delve",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    {
      -- works with go.mod packages and sub packages
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  },

  php = {
    {
      name = "Run current script",
      type = "php",
      request = "launch",
      port = 9004,
      cwd = "${fileDirname}",
      program = "${file}",
      runtimeExecutable = "php",
    },
    {
      name = "Listen for Xdebug local",
      type = "php",
      request = "launch",
      port = 9004,
    },
    {
      -- Note add this to the php service in the docker-compose
      --  extra_hosts:
      --  - "host.docker.internal:host-gateway"
      name = "Listen for Xdebug docker",
      type = "php",
      request = "launch",
      port = 9004,
      -- this is where your file is in the container
      pathMappings = {
        ["/var/www/app"] = "${workspaceFolder}",
      },
    },
  },
}
