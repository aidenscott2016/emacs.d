# -*- mode: snippet -*-
# name: new nix module
# key: nm
# uuid: nm
# expand-env: ((yas-indent-line 'fixed) (yas-wrap-around-region 'nil))
# --
params@{ lib, pkgs, config, ... }:
with lib;
let moduleName = "$1";
    cfg = config.aiden.modules.\${moduleName};
in {
  options = {
    aiden.modules.\${moduleName}.enabled = mkEnableOption moduleName;
  };
  config = mkIf cfg.enabled {
    $0
  };
}
