{ config, lib, ... }:

with lib;

let
  # Replace all the calls to undefined below by your code.
  undefined = abort "I have no definition yet...";

  # This function takes a list of functions and applies them
  # one after the other:
  # compose [ h g f ] x == h (g (f x))
  compose =
    let
      apply = f: x: f x;
    in
    lib.flip (lib.foldr apply);

  inherit (config.networking) hostName;

  usersFromJSON = undefined;
in
{
  users.users = traceValSeq
    ({
      superuser = {
        isNormalUser = true;
      };
    } // usersFromJSON);
}

