# Generate hash string sha256 for .yaml file:

## 1) Release version on Github under a tag, e.g.
tag="v0.1.1"

## 2) Execute this line to check on consistency of the package:
z=warning("query");
warning("off")
pkg install "https://github.com/aumpierre-unb/McCabe-Thiele-for-GNU-Octave/archive/refs/tags/v0.1.1.tar.gz"
warning(z)

## 3) Get the address of .tar.gz:
url=["https://github.com/aumpierre-unb/" ...
     "McCabe-Thiele-for-GNU-Octave/archive/refs/tags/" ...
     tag ...
     ".tar.gz"]

## 4) Set file:
file=[tempdir tag ".tar.gz"]

## 5) Generate file from url:
urlwrite(url,file)

## 6) Generate hash string sha256 for .yaml:
sha256=hash("sha256",fileread(file))

## 7) Copy and paste hash string under quotes to .yaml file

