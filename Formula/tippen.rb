class Tippen < Formula
  desc "Tiny text expander for macOS"
  homepage "https://github.com/leonardonapoless/Tippen"
  url "https://github.com/leonardonapoless/Tippen/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_RUN_SHASUM_ON_THE_RELEASE_TARBALL"

  depends_on :macos

  def install
    system "make"
    bin.install "tippen"
  end

  service do
    run [opt_bin/"tippen"]
    keep_alive true
    log_path var/"log/tippen.log"
    error_log_path var/"log/tippen.err"
  end

  def caveats
    <<~EOS
      tippen needs Accessibility permission to read keystrokes.

      1. Open System Settings > Privacy & Security > Accessibility
      2. Add #{opt_bin}/tippen
      3. Toggle it on

      Start tippen as a background service:
        brew services start tippen
    EOS
  end

  test do
    assert_match "accessibility", shell_output("#{bin}/tippen 2>&1", 1)
  end
end
