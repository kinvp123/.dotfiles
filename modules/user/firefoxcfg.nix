{config, pkgs, ...}:

let
  state-true = {
    Value = true;
    Status = "locked";
  };
  state-false = {
    Value = false;
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
      Homepage = {
        URL = "https://kinvp123.github.io/catppuccin-startpage/";
        Locked = true;
        StartPage = "homepage";
      };
      ExtensionSettings = with builtins;
        let extension = pluginName: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${pluginName}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
        in listToAttrs [ 
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
            (extension "sidetabs" "{ccc8cbaa-3c36-46d1-b0ae-d5e122755901}")
            (extension "custom-new-tab-page" "custom-new-tab-page@mint.as")
        ];
      Preferences = {
          "browser.newtabpage.activity-stream.feeds.section.topstories" = state-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = state-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = state-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = state-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = state-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = state-false;
          "browser.newtabpage.activity-stream.showSponsored" = state-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = state-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = state-false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = state-true;
          "reader.parse-on-load.enabled" = state-false;
      };
    };
  };
  home.file.".mozilla/firefox/um3bx2d7.default/chrome/userChrome.css".source = ../theming/styleFiles/userFirefox.css;
}
