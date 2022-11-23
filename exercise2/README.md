# Exercise 2
For this exercise, we will be parsing JSON using Nix and using the parsed input to define a set of systemd services.

## Useful references:
1. [Nix builtin functions](https://nixos.org/manual/nix/stable/language/builtins.html)
1. [Nixpkgs library functions](https://nixos.org/manual/nixpkgs/stable/#chap-functions)
1. [Nixpkgs library functions source code](https://github.com/NixOS/nixpkgs/tree/master/lib)

## Goal

We extended the minimal NixOS config from the previous exercise and added a new
module, `services.nix`, to it.
You will be implementing three functions in this module to load some data from
a JSON file and use it to define systemd services.

Along the way, you can test your implementation using
```bash
nixos-rebuild --fast -I nixos-config=./configuration.nix build
```

The module prints out intermediate results using the `traceValSeq` function,
so you can see intermediate results even if the evaluation crashes at a later point.

## Steps

1. Clone this repository and go to the `exercise2` directory.
1. Have a look at the `configuration.nix` file which is now importing the
   new `services.nix` modules.
1. Have a look at this new module, it contains a skeleton implementation that
   you will be completing.
1. Have a look at the `services.json` file, which defines a bunch of services.
1. Now it's your turn.
   You will read the JSON file using Nix and define the services.
   Read the comments in the file for further instructions.
   You can test your code using the `nixos-rebuild` command that we used earlier.
1. If all went well, you should see the services that we defined in
   `result/etc/systemd/system/` and they should each have a line like
   ```
     ExecStart=/nix/store/<some long hash>-unit-script-service-X-start/bin/service-X-start
   ```
   And if you open that file, you should see a script that runs the command that
   we defined in the JSON file.

