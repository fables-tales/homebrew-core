require "language/node"

class Cdk8s < Formula
  desc "Define k8s native apps and abstractions using object-oriented programming"
  homepage "https://cdk8s.io/"
  url "https://registry.npmjs.org/cdk8s-cli/-/cdk8s-cli-2.1.79.tgz"
  sha256 "6d16462af8d08d940e520e64f7a04173396eb1a5a8d40e80ee09a02ad93e7860"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "b7da6eb6b5b81f86ae886eb5f59bff4154333f3f26e6ae73a79eb660a5097f08"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "Cannot initialize a project in a non-empty directory",
      shell_output("#{bin}/cdk8s init python-app 2>&1", 1)
  end
end
