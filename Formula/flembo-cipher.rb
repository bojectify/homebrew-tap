class FlemboCipher < Formula
  desc "Turn a phrase into a letter-substitution code, with JSON output"
  homepage "https://github.com/bojectify/flembo-cipher"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bojectify/flembo-cipher/releases/download/v0.1.0/flembo-cipher-aarch64-apple-darwin.tar.xz"
      sha256 "3eeae13f72a40a55ca61b0792c3df82f12bfdd9c2db8780c23c9bf9db523b562"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bojectify/flembo-cipher/releases/download/v0.1.0/flembo-cipher-x86_64-apple-darwin.tar.xz"
      sha256 "fb2b544f5e876c34729231aa87b17eadec5d66a63cbdf1aa35cad6cf35f017c7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bojectify/flembo-cipher/releases/download/v0.1.0/flembo-cipher-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0d4e26f7dfd5bdc5dfb86593a4762efe15045b618c2d4f1bb05f6a94a50f8069"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bojectify/flembo-cipher/releases/download/v0.1.0/flembo-cipher-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a542123cfaf2d6d579dd138f5ebd855a116811a0922dd6d0ed6162dc0983109"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "flembo-cipher"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "flembo-cipher"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "flembo-cipher"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "flembo-cipher"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
