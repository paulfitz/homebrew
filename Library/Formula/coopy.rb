require 'formula'

class Coopy < Formula
  url 'https://github.com/paulfitz/coopy/tarball/v0.5.5'
  homepage 'http://share.find.coop'
  head 'git://github.com/paulfitz/coopy.git'

  depends_on 'cmake' => :build

  depends_on 'mdbtools'
  depends_on 'mysql-connector-c'
  depends_on 'gnumeric'
  depends_on 'gettext'
  depends_on 'wxmac'

  def install
    ENV.m32   # native wxwidgets on snow leopard seems to need this
    # make sure everything else is compatible (use --universal flag)
    system "cmake #{std_cmake_parameters} -DUSE_ACCESS=TRUE -DUSE_REMOTE_SQL=TRUE -DUSE_MYSQL=TRUE -DUSE_GNUMERIC=TRUE"
    system "make install"
  end
end
