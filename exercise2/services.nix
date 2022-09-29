{ lib, ... }:

let
  # Replace all the calls to undefined below by your code.
  undefined = abort "I have no definition yet...";

  # Utility function used below to avoid too many parentheses.
  # This function takes a list of functions and applies them
  # one after the other:
  # compose [ h g f ] x == h (g (f x))
  compose =
    let
      apply = f: x: f x;
    in
    lib.flip (lib.foldr apply);

  # Read the given file from the current directory and
  # parse its content as JSON.
  parseServices = file: undefined;

  # Take the list of service definitions and convert it to an attribute set
  # having the service names as keys.
  # So we convert a list like [ { name = "foo"; command = "bar"; } ]
  # into an attribute set { foo = { command = "bar"; }
  #
  # Tip: functional languages like Nix do not have for loops. Search for a
  #      function called foldl in the nixpkgs library.
  #      You can search online for explanations about folding in functional
  #      programming if you have never seen this concept before.
  convertToAttrSet = services: undefined;

  # From an attribute set defining services and their commands,
  # we generate an attribute set defining systemd services as expected by NixOS.
  # See the documentation for systemd services in NixOS here:
  #   https://search.nixos.org/options?query=systemd.services
  # You can use the script option to define the command to be executed by the service.
  defineServices = services: undefined;
in

{
  # Using the functions that we defined above, we tie it all together now.
  # We use the compose function defined above to compose all functions together,
  # which avoids too many brackets for all the nested function calls.
  # We also trace the result after every function call to see how the data is
  # modified at each step.
  systemd.services = compose [
    lib.traceValSeq
    defineServices
    lib.traceValSeq
    convertToAttrSet
    lib.traceValSeq
    parseServices
  ] ./services.json;
}

