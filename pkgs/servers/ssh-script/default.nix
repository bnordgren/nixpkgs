{stdenv, ssh, bash, initscripts, key ? null}:

stdenv.mkDerivation {
  name = "ssh-script-0.0.1";
  server = "ssh";
  builder = ./builder.sh ;
  inherit ssh initscripts;
  script = [./sshd];
}
