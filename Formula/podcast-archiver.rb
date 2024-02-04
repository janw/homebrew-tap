class PodcastArchiver < Formula
  include Language::Python::Virtualenv

  desc "Archive all episodes from your favorite podcasts"
  homepage "https://github.com/janw/podcast-archiver"
  license "MIT"
  head "https://github.com/janw/podcast-archiver.git", branch: "main"

  url "https://files.pythonhosted.org/packages/a1/33/b42038813207a0dfaab26c829e06bcb3309aba122c4a00876c738b5dd353/podcast_archiver-1.2.1.tar.gz"
  sha256 "0b9df025268042ba99e38bbcc6ad9e8381ed9612782024dfcc023748c1e00395"

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
