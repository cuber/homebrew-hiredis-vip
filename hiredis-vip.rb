class HiredisVip < Formula
  desc "Minimalistic client for Redis Cluster vip"
  homepage "https://github.com/vipshop/hiredis-vip"
  url "https://github.com/vipshop/hiredis-vip/archive/f12060498004494a3e1de11f653a8624f3d218c3.tar.gz"
  sha256 "5774ac621aebfc9c2d622e967696b7cef61e2a068dbda0dc15bd04bf3d51e183"

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

end
