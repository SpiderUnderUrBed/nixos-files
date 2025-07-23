{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "tuido";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "NiloCK";
    repo = "tuido";
    rev = "9f96cf844e7800696a6791c0a103ad0d9e465f62"; 
    sha256 = "sha256-xE9Aq5FhyOUNnJWBjr4k5YS23MV3m/elH8efMm/eZEU="; 
  };

  vendorHash = "sha256-Jy9OTyce4XUQ/EMW2QAc2ED5V/loeQFiTzvOHpFSX1s=";
#"sha256-Jy9OTyce4XUQ/EMW2QAc2ED5V/loeQFiTzvOHpFSX1s="; 

  subPackages = [ "." ];

  meta = with lib; {
    description = "Terminal UI for todo.txt files";
    homepage = "https://github.com/NiloCK/tuido";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
