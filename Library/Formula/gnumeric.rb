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
  depends_on 'cairo'
  depends_on 'libpng'

  def patches
    DATA
  end

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


__END__
--- a/src/libgnumeric.c	2011-06-19 20:47:55.000000000 +0200
+++ gnumeric-1.10.2/src/libgnumeric.c	2011-06-19 20:47:34.000000000 +0200
@@ -146,6 +146,9 @@
 	return group;
 }
 
+#include <mach-o/dyld.h>
+#include <libgen.h>
+
 /**
  * gnm_pre_parse_init :
  * @gnumeric_binary : argv[0]
@@ -180,6 +183,33 @@
 	}
 #endif
 
+
+char path0[4192];
+uint32_t size = sizeof(path0);
+if (_NSGetExecutablePath(path0, &size) != 0)
+/*    printf("executable path is %s\n", path0);*/
+/*else*/
+    printf("buffer too small; need size %u\n", size);
+char *path = dirname(path0);
+
+if (getenv("GNUMERIC_PLUGIN_PATH")==NULL) {
+char gpath[8192];
+sprintf(gpath,"%s/../Frameworks/lib/gnumeric/1.10.2/plugins",path);
+setenv("GNUMERIC_PLUGIN_PATH",gpath,1);
+/*printf("-> %s\n", gpath);*/
+}
+if (getenv("PANGO_RC_FILE")==NULL) {
+char ppath[8192];
+sprintf(ppath,"%s/../Frameworks/etc/pango/pango.rc",path);
+setenv("PANGO_RC_FILE",ppath,1);
+/*printf("-> %s\n", ppath);*/
+}
+if (getenv("PANGO_MODULE_FILE")==NULL) {
+char mpath[8192];
+sprintf(mpath,"%s/../Frameworks/etc/pango/pango.modules",path);
+setenv("PANGO_MODULE_FILE",mpath,1);
+}
+
 	g_thread_init (NULL);
 	g_type_init ();
 
