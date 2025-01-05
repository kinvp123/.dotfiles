{config, pkgs, ...}:
{
  programs = {
    vscode = {
		  enable = true;
		  package = pkgs.vscodium;
		  extensions = with pkgs.vscode-extensions; 
			[
				bradlc.vscode-tailwindcss
				jnoortheen.nix-ide
				ms-vscode.live-server
			];
	  };
  };
}
