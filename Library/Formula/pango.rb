require 'formula'

class Pango < Formula
  homepage 'http://www.pango.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/pango/1.28/pango-1.28.4.tar.bz2'
  sha256 '7eb035bcc10dd01569a214d5e2bc3437de95d9ac1cfa9f50035a687c45f05a9f'

  depends_on 'pkg-config' => :build
  depends_on 'glib'

  fails_with_llvm "Undefined symbols when linking", :build => "2326"

  #if MacOS.leopard?
  depends_on 'fontconfig' # Leopard's fontconfig is too old.
  depends_on 'cairo' # Leopard doesn't come with Cairo.
  depends_on 'libpng'
  #end

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
    system "./configure", "--prefix=#{prefix}", "--with-x", "--disable-dependency-tracking"
    system "make install"
  end
end

__END__
--- a/pango/pango-utils.c	2011-06-20 19:43:00.000000000 +0200
+++ pango-1.28.4/pango/pango-utils.c	2011-06-20 19:40:56.000000000 +0200
@@ -652,6 +652,16 @@
 
   read_config ();
 
+  /*printf("  checking key %s\n", key);*/
+  if (strcmp(key,"Pango/ModuleFiles")==0) {
+      const char *envvar;
+      envvar = g_getenv ("PANGO_MODULE_FILE");
+      if (envvar) {
+        /*printf("  %s --> %s \n", key, envvar);*/
+        return g_strdup(envvar);
+      }
+  }
+
   return g_strdup (g_hash_table_lookup (config_hash, key));
 }
 
