class PodcastArchiver < Formula
  include Language::Python::Virtualenv

  desc "Archive all episodes from your favorite podcasts"
  homepage "https://github.com/janw/podcast-archiver"
  license "MIT"
  head "https://github.com/janw/podcast-archiver.git", branch: "main"

  url "https://files.pythonhosted.org/packages/6b/1a/da7bf076000a3d45fe8096d538d808ba95e25640088dce7c7b4db0325bb2/podcast_archiver-2.1.0.tar.gz"
  sha256 "d06a2ce587413e7bfbfe1e678a7abe088a1945236c40127afac6b59eed2d2369"

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
