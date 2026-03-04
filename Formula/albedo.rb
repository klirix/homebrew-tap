class Albedo < Formula
  desc "Experimental document store written in Zig"
  homepage "https://github.com/klirix/albedo"
  license "MIT"

  # This formula is intended for a Homebrew tap (e.g. a repo named
  # `klirix/homebrew-tap` or `klirix/homebrew-albedo`).
  #
  # Recommended for stable releases:
  url "https://github.com/klirix/albedo/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "a95d8406bb3902edfcef3960e5ac5a8ec4b847be4dece9038f41915be7ae32d4"
  #
  # Until you cut a tagged release, install from git:
  # head "https://github.com/klirix/albedo.git", branch: "main"

  bottle do
    rebuild 4
    root_url "https://github.com/klirix/homebrew-tap/releases/download/v0.6.2"
    sha256 cellar: :any, arm64_tahoe: "92b89f64192a4a2ed35bf7d97a3ee608610850d9f9aa92c6bced690338096eba"
  end

  bottle do
    rebuild 4
    root_url "https://github.com/klirix/homebrew-tap/releases/download/v0.6.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9d7fe613659e726589922f3b435a9be32482985cfe57a3630bc24d222be3d7af"
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

