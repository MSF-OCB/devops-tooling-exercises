# Exercise 1

For the first exercise, we will be building NixOS with a GitHub Actions workflow.

Steps:
1. Create a new, empty repository on GitHub.
   Create the repository in your personal profile, not in the OCB organisation.
1. Clone the repository on your local machine.
1. In the cloned repo, create a very basic NixOS configuration consisting of
   a single file, `configuration.nix`.
   This file will contain the following minimal configuration which will allow
   us to build it:
   ```nix
   {

     fileSystems."/" = {
       device = "/dev/null";
       fsType = "ext4";
     };

     boot.loader.grub.device = "/dev/null";

     system.stateVersion = "22.05";
   }
   ```
   This configuration would not lead to a usable system, but we can fix that later.
1. You should now be able to build this configuration, on a NixOS system you can
   run
   ```bash
   nixos-rebuild -I nixos-config=./configuration.nix build --fast --no-build-output
   ```
1. You can commit and push this code.
1. We will now add a CI action.
   The first step is to browse through the
   [documentation for workflows][workflow_docs] in GitHub Actions.

1. As you will see in the documentation, you can create a workflow by creating a
   file `.github/workflows/build_nixos.yml`.
   Your task now will be to:
   1. Make the workflow trigger when commits are pushed to your main branch
   1. Define a single job which will build our NixOS config, and which will contain
      three steps
      1. Do a checkout of the current repo using the `actions/checkout` action
      1. Install nix using the `cachix/install-nix-action` action
      1. Build the NixOS config by running a command

1. When you are done defining the workflow, commit the file and push it to GitHub.
   If all went well, your workflow should now run.

1. If you used the `nixos-rebuild` command that we used before, you will notice
   that the workflow will fail.
   This command is only available on NixOS systems, but our workflow is running on
   a Ubuntu server provided by GitHub.
   To solve this, we can use nix directly to build our NixOS config, using the following
   command:
   ```bash
   nix-build '<nixpkgs/nixos>' -I nixos-config=./configuration.nix -A config.system.build.toplevel
   ```
   This is the same thing that `nixos-rebuild` would do under the hood on a NixOS system.

   (Don't worry too much at this point about how this command works exactly,
   we can get into those details later if needed.)

1. There is one important optimisation left.
   The `nix-build` command will download a lot of store paths into the
   nix store, and it is rather inefficient to do this every time in CI.
   To avoid this, we can have nix only evaluate our config and make the plan
   for how to build it, but not actually build and download everything.
   You can compare this to a compiler that only does parsing and typechecking,
   but doesn't do the actual code generation.
   (Which is for instance what a typical IDE does when showing you inline
   errors in the editor.)

   To only do the evaluation, you replace `nix-build` by `nix-instantiate`:
   ```bash
   nix-instantiate '<nixpkgs/nixos>' -I nixos-config=./configuration.nix -A config.system.build.toplevel
   ```

[workflow_docs]: https://docs.github.com/en/actions/using-workflows/about-workflows

