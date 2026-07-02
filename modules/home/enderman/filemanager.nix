{
  pkgs,
  lib,
  ...
}: {
  # Install the package
  programs.pcmanfm-qt = {
    enable = true;
  };

  # Optional: Set as default file manager for MIME types
  xdg.mimeApps.defaultApplications."inode/directory" = "pcmanfm-qt.desktop";
}
