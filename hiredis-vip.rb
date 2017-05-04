class HiredisVip < Formula
  desc "Minimalistic client for Redis Cluster vip"
  homepage "https://github.com/vipshop/hiredis-vip"
  url "https://github.com/vipshop/hiredis-vip/archive/0.3.0.tar.gz"
  sha256 "84e0f9367fa25089fc073b7a8a0725043c48cccec827acf4555a63da68f36be5"

  head "https://github.com/vipshop/hiredis-vip.git"

  def install
    # Architecture isn't detected correctly on 32bit Snow Leopard without help
    ENV["OBJARCH"] = "-arch #{MacOS.preferred_arch}"

    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install "examples"
  end

  test do
    # running `./test` requires a database to connect to, so just make
    # sure it compiles
    system ENV.cc, "-I#{include}/hiredis", "-L#{lib}", "-lhiredis",
           pkgshare/"examples/example.c", "-o", testpath/"test"
    File.exist? testpath/"test"
  end

  patch :DATA
end

__END__
diff --git a/Makefile b/Makefile
index 58494bf..fa33b8e 100644
--- a/Makefile
+++ b/Makefile
@@ -7,7 +7,7 @@ OBJ=net.o hiredis.o sds.o async.o read.o hiarray.o hiutil.o command.o crc16.o ad
 EXAMPLES=hiredis-example hiredis-example-libevent hiredis-example-libev hiredis-example-glib
 TESTS=hiredis-test
 LIBNAME=libhiredis_vip
-PKGCONFNAME=hiredis.pc
+PKGCONFNAME=hiredis_vip.pc

 HIREDIS_VIP_MAJOR=$(shell grep HIREDIS_VIP_MAJOR hircluster.h | awk '{print $$3}')
 HIREDIS_VIP_MINOR=$(shell grep HIREDIS_VIP_MINOR hircluster.h | awk '{print $$3}')
