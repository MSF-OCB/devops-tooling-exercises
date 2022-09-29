# Exercise 3

## Useful references:
1. [Nix builtin functions](https://nixos.org/manual/nix/stable/language/builtins.html)
1. [Nixpkgs library functions](https://nixos.org/manual/nixpkgs/stable/#chap-functions)
1. [Nixpkgs library functions source code](https://github.com/NixOS/nixpkgs/tree/master/lib)

## Goal
We will implement a NixOS module that parses a JSON file with user assignment and
role definitions, and uses that information to define users for our NixOS system.

The goal is to write the algorithm to resolve the users to be enabled on a server,
including cycle detection to avoid that our algorithm ends up in an infinite loop.

The JSON file contains two sections, one defining servers and the users and roles
that are enabled for those servers, and one defining roles.
Both the server and role definitions have the same structure, they contain two
attributes:
1. An `enable` attribute, listing the users that need to be enabled
1. An `enable_roles` attribute, listing the roles that need to be enabled.

A role can itself define users to be directly enabled, or roles to be enabled.
The data thus has a recursive structure where roles can be nested arbitrarily
deeply.

The algorithm will go like this:

1. Find the server definition for the current server
1. Include all users in the `enable` list in the final result
1. For every role listed in the `enable_roles` list:
   1. Find the role definition and recursively apply this algorithm

## Steps
1. Clone this repository and go to the `exercise3` directory.
1. You can evaluate the configuration using the following command
   ```bash
   nix-instantiate '<nixpkgs/nixos>' -I nixos-config=./configuration.nix -A config.system.build.toplevel
   ```
   This command will fail with an error because we have not yet implemented the
   function `usersFromJSON`.
1. Implement the `usersFromJSON` function following the outline given above.
   Start by dealing only with the `enable` property for the server.
   Once you have that working, try to incorporate the `enable_roles` property
   as well, using recursion to resolve all required roles.
1. As you might notice, the current definition in the JSON file has a cycle.
   Instead of having Nix tell the user that it encountered an infinite recursion,
   we would like to print out a proper error message that shows the cycle.
   An example of what such an error message could look like:
   ```
   error: evaluation aborted with the following error message: 'Cycle detected: servers.srv002 -> roles.devops -> roles.devops_admins -> roles.infra -> roles.generic -> roles.generic2 -> roles.generic3 -> roles.infra'
   ```
   This allows the user to quickly identify the issue.
   Extend your implementation to:
   1. Detect cycles as soon as they occur
   1. Print a clear error message including the sequence that makes up the cycle,
      you can use the builtin `abort` function for this.

