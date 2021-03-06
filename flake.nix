{
  description = ''Module to provide an interface as similar as possible to Python's math libary'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."pythonmath-master".dir   = "master";
  inputs."pythonmath-master".owner = "nim-nix-pkgs";
  inputs."pythonmath-master".ref   = "master";
  inputs."pythonmath-master".repo  = "pythonmath";
  inputs."pythonmath-master".type  = "github";
  inputs."pythonmath-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."pythonmath-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}