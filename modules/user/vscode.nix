{config, pkgs, ...}:
{
  programs = {
    vscode = {
		  enable = true;
		  package = pkgs.vscodium;
		  extensions = with pkgs.vscode-extensions; 
			[
				bradlc.vscode-tailwindcss
				catppuccin.catppuccin-vsc
				catppuccin.catppuccin-vsc-icons
				jnoortheen.nix-ide
				ms-vscode.live-server
			];
	  };
  };
}
