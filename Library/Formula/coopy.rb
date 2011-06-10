require 'formula'

class Coopy < Formula
  url 'https://github.com/paulfitz/coopy/tarball/v0.5.4'
  md5 '656b79be1ab806c94029b7697702f9bb'
  homepage 'http://coopy.sourceforge.net'
  head 'git://github.com/paulfitz/coopy.git'

  depends_on 'cmake' => :build

  depends_on 'mdbtools'
  depends_on 'mysql-connector-c'

  def install
    ENV.m32   # native wxwidgets on snow leopard seems to need this
    system "cmake #{std_cmake_parameters} -DUSE_ACCESS=TRUE -DUSE_REMOTE_SQL=TRUE -DUSE_MYSQL=TRUE"
    system "make install"
  end
end
