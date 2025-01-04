class PodcastArchiver < Formula
  include Language::Python::Virtualenv

  desc "Archive all episodes from your favorite podcasts"
  homepage "https://github.com/janw/podcast-archiver"
  license "MIT"
  head "https://github.com/janw/podcast-archiver.git", branch: "main"

  url "https://files.pythonhosted.org/packages/ba/21/31aecc47f2f7c4f96e89b000f3529168450b90b1e942e0512ab2893b6af5/podcast_archiver-2.3.0.tar.gz"
  sha256 "fa340f9f993437e7dbd02183f5e2638432a2855b3cec778f976b72327b14bb93"

  depends_on "python@3.12"

  def python3
    "python3.12"
  end

  def std_pip_args(prefix: self.prefix, build_isolation: false)
    ["--verbose", "--ignore-installed"]
  end

  def install
    venv = virtualenv_create(libexec, python3, system_site_packages: false)
    venv.pip_install buildpath
    bin.install_symlink(["#{libexec}/bin/podcast-archiver"])
    generate_completions_from_executable(bin/"podcast-archiver", shells: [:zsh, :fish], shell_parameter_format: :click)
  end

  test do
    assert_match "podcast-archiver, ", shell_output(bin/"podcast-archiver --version")
  end
end
