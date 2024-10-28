class PodcastArchiver < Formula
  include Language::Python::Virtualenv

  desc "Archive all episodes from your favorite podcasts"
  homepage "https://github.com/janw/podcast-archiver"
  license "MIT"
  head "https://github.com/janw/podcast-archiver.git", branch: "main"

  url "https://files.pythonhosted.org/packages/2f/80/8f94fd82d9e9c1777db499f81a688bbd91c62dd169013ea13f04a8d6d1b3/podcast_archiver-1.7.1.tar.gz"
  sha256 "b04eabb7fb36b1bbe28e90633b2d1165b3cc9db3fcd3b1aa2a196a6f5c62af54"

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
