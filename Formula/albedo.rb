class Albedo < Formula
  desc "Experimental document store written in Zig"
  homepage "https://github.com/klirix/albedo"
  license "MIT"

  # This formula is intended for a Homebrew tap (e.g. a repo named
  # `klirix/homebrew-tap` or `klirix/homebrew-albedo`).
  #
  # Recommended for stable releases:
  url "https://github.com/klirix/albedo/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "250f817fccb96e0d9b06fdb44984c0b95d7ba9b5e1cf08050ec54408300d0de5"
  #
  # Until you cut a tagged release, install from git:
  # head "https://github.com/klirix/albedo.git", branch: "main"

  bottle do
    rebuild 2
    root_url "https://github.com/klirix/homebrew-tap/releases/download/albedo-v0.5.0"
    sha256 cellar: :any, arm64_sequoia: "9ac32f7454fc7e497df6efb614bbf126f68fd657d8c5232468c358d44ce5025d"
  end

  depends_on "zig" => :build

  def install
    ENV["ZIG_GLOBAL_CACHE_DIR"] = buildpath/"zig-global-cache"
    ENV["ZIG_LOCAL_CACHE_DIR"] = buildpath/"zig-local-cache"

    system "zig", "build", "--release=fast", "--prefix", prefix
    system "zig", "build", "--release=fast", "-Dstatic=true", "--prefix", prefix

    include.install "include/albedo.h"
  end

  test do
    assert_path_exists include/"albedo.h", :exist?

    if OS.mac?
      assert_path_exists lib/"libalbedo.dylib", :exist?
    else
      assert_path_exists lib/"libalbedo.so", :exist?
    end
  end
end

