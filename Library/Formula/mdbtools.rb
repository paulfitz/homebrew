require 'formula'

class Mdbtools < Formula
  homepage 'http://sourceforge.net/projects/mdbtools/'
  # Last stable release won't build on OS X, but HEAD from CVS does.
  head "cvs://:pserver:anonymous@mdbtools.cvs.sourceforge.net:/cvsroot/mdbtools:mdbtools"

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'gawk' => :optional # To generate docs

  def options
  [
    ['--universal', 'Build universal binaries.'],
  ]
  end

  def install
    inreplace 'autogen.sh', 'libtool', 'glibtool'
    ENV.universal_binary if ARGV.build_universal?
    system "NOCONFIGURE='yes' ACLOCAL_FLAGS='-I#{HOMEBREW_PREFIX}/share/aclocal' ./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}", "--disable-dependency-tracking"
    system "make install"
  end
end
