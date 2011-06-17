require 'formula'

class Goffice < Formula
  url 'http://ftp.gnome.org/pub/gnome/sources/goffice/0.8/goffice-0.8.12.tar.bz2'
  homepage 'http://freshmeat.net/projects/goffice/'
  sha256 'c165f8b7aaab709295c8225b30f49fe75655149b982fd045d8c23bb7772eb22a'

  depends_on 'pkg-config' => :build
  depends_on 'libgsf'
  depends_on 'gettext'
  depends_on 'intltool'
  depends_on 'pcre'
  depends_on 'cairo'

  def options
  [
    ['--universal', 'Build universal binaries.'],
  ]
  end

  def install
    ENV.universal_binary if ARGV.build_universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--without-gconf"
    system "make install"
  end
end
