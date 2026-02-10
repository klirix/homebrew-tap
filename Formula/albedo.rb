class Albedo < Formula
  desc "Experimental document store written in Zig"
  homepage "https://github.com/klirix/albedo"
  license "MIT"

  # This formula is intended for a Homebrew tap (e.g. a repo named
  # `klirix/homebrew-tap` or `klirix/homebrew-albedo`).
  #
  # Recommended for stable releases:
  #   url "https://github.com/klirix/albedo/archive/refs/tags/vX.Y.Z.tar.gz"
  #   sha256 "<fill-me-in>"
  #
  # Until you cut a tagged release, install from git:
  head "https://github.com/klirix/albedo.git", branch: "main"

  depends_on "zig" => :build

  def install
    ENV["ZIG_GLOBAL_CACHE_DIR"] = buildpath/"zig-global-cache"
    ENV["ZIG_LOCAL_CACHE_DIR"] = buildpath/"zig-local-cache"

    # Ensure the dylib has enough header space for install_name changes.
    ENV.append "LDFLAGS", "-Wl,-headerpad_max_install_names"

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

