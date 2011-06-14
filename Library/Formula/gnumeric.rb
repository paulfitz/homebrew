require 'formula'

class Gnumeric < Formula
  homepage 'http://projects.gnome.org/gnumeric/'
  url 'http://ftp.gnome.org/pub/gnome/sources/gnumeric/1.10/gnumeric-1.10.2.tar.bz2'
  sha256 'b42b5320f44e49ad0a838469c59065dbb51f4b18e5b63464870c341c932dd4c9'

  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'glib'
  depends_on 'intltool'
  depends_on 'libglade'
  depends_on 'goffice'
  depends_on 'libgsf'
  depends_on 'gtk+'

  def options
  [
    ['--universal', 'Build universal binaries.'],
  ]
  end

  def install
    ENV.universal_binary if ARGV.build_universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--disable-schemas-install", "--without-gda", "--without-paradox",
                          "--without-psiconv", "--without-python"
    system "make"
    system "cd doc/C; make gnumeric-C.omf.out"
    system "make install"
  end
end
