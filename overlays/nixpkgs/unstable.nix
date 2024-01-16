{ inputs, outputs, ... }:

final: prev: {
  unstable = import inputs.nixpkgs-unstable {
    system = prev.system;
    config = outputs.lib.nixpkgsDefaultConfig;
  };
}
