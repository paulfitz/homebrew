require 'formula'

class Coopy < Formula
  url 'https://github.com/paulfitz/coopy/tarball/v0.6.1'
  md5 'f22bb1331fbdf1d9f0373e7bbf45d4d5'
  homepage 'http://share.find.coop'
  head 'git://github.com/paulfitz/coopy.git'

  depends_on 'cmake' => :build

  depends_on 'gnumeric' unless ARGV.include? "--no-gnumeric"
  depends_on 'mysql-connector-c' unless ARGV.include? "--no-mysql"
  depends_on 'mdbtools' unless ARGV.include? "--no-mdb"
  depends_on 'wxmac' if ARGV.include? "--wx"

  def options
    [
      ["--no-gnumeric", "Build without spreadsheet support."],
      ["--no-mysql", "Build without MYSQL support."],
      ["--no-access", "Build without MDB (MS Access) support."],
      ["--wx", "Build with wxWidgets support for GUI."],
    ]
  end

  def install
    parameters = std_cmake_parameters
    parameters << " -DUSE_GNUMERIC=TRUE" unless ARGV.include? "--no-gnumeric"
    parameters << " -DUSE_REMOTE_SQL=TRUE -DUSE_MYSQL=TRUE" unless ARGV.include? "--no-mysql"
    parameters << " -DUSE_ACCESS=TRUE" unless ARGV.include? "--no-access"
    parameters << " -DCOMPILE_GUI=FALSE" unless ARGV.include? "--wx"
    system "cmake #{parameters}"
    system "make install"
  end
end
