class Tox < Formula
  include Language::Python::Virtualenv

  desc "Generic Python virtualenv management and test command-line tool"
  homepage "https://tox.readthedocs.io/"
  url "https://files.pythonhosted.org/packages/d4/75/d78928839460c421a3c80233ae5ca54bf9e8036ef9cd204a4afbff959134/tox-4.0.13.tar.gz"
  sha256 "2830e668374ab1c484964f2d0e3d6f8fcfa170c5c388ec54d47fa359ea996715"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ce75ac71aacae8c9e6481c1c1e697ededcd6236c214b60ddf3198d621b4d1352"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8ff18f496881db687cd12cff4d25e1ae2505f41f46cbef379335d066a314489b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4b815f4d4366f8a716a9076c7b8c543132287f62a758ec22228b871abe07a22b"
    sha256 cellar: :any_skip_relocation, ventura:        "0581bca61fd0bd1e5f5a14dff47790ca8105e8d517de1af83184a9ae81684a94"
    sha256 cellar: :any_skip_relocation, monterey:       "8ba07b20632f9d4ee71e89a4dd8bcca0d28d7883216bb9654739fdb11f49701b"
    sha256 cellar: :any_skip_relocation, big_sur:        "8247dec2d990bc89918d2a83a5ec428f71d6f1b62aac651d5d5739a9e8016e13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "799ed00263251b2d8ad2b62dae209ba3c458e0b7b1366620226d259854486bcc"
  end

  depends_on "python@3.11"
  depends_on "six"

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/c2/6f/278225c5a070a18a76f85db5f1238f66476579fa9b04cda3722331dcc90f/cachetools-5.2.0.tar.gz"
    sha256 "6a94c6402995a99c3970cc7e4884bb60b4a8639938157eeed436098bf9831757"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/41/32/cdc91dcf83849c7385bf8e2a5693d87376536ed000807fa07f5eab33430d/chardet-5.1.0.tar.gz"
    sha256 "0d62712b956bc154f85fb0a266e2a3c5913c2967e00348701b32411d6def31e5"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6e0531a20572697297273c47b8cae5a63ffc6d6ed5c201be6e44"
  end

  resource "distlib" do
    url "https://files.pythonhosted.org/packages/58/07/815476ae605bcc5f95c87a62b95e74a1bce0878bc7a3119bc2bf4178f175/distlib-0.3.6.tar.gz"
    sha256 "14bad2d9b04d3a36127ac97f30b12a19268f211063d8f8ee4f47108896e11b46"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/d8/73/292d9ea2370840a163e6dd2d2816a571244e9335e2f6ad957bf0527c492f/filelock-3.8.2.tar.gz"
    sha256 "7565f628ea56bfcd8e54e42bdc55da899c85c1abfe1b5bcfd147e9188cebb3b2"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/6b/f7/c240d7654ddd2d2f3f328d8468d4f1f876865f6b9038b146bec0a6737c65/packaging-22.0.tar.gz"
    sha256 "2198ec20bd4c017b8f9717e00f0c8714076fc2fd93816750ab48e2c41de2cfd3"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/ec/4c/9af851448e55c57b30a13a72580306e628c3b431d97fdae9e0b8d4fa3685/platformdirs-2.6.0.tar.gz"
    sha256 "b46ffafa316e6b83b47489d240ce17173f123a9b9c83282141c3daf26ad9ac2e"
  end

  resource "pluggy" do
    url "https://files.pythonhosted.org/packages/a1/16/db2d7de3474b6e37cbb9c008965ee63835bba517e22cdb8c35b5116b5ce1/pluggy-1.0.0.tar.gz"
    sha256 "4224373bacce55f955a878bf9cfa763c1e360858e330072059e10bad68531159"
  end

  resource "pyproject-api" do
    url "https://files.pythonhosted.org/packages/b8/ec/6f414433d8b924a000ff57e70ea3348182c93f36db77972753f6729b67ef/pyproject_api-1.2.1.tar.gz"
    sha256 "093c047d192ceadcab7afd6b501276bf2ce44adf41cb9c313234518cddd20818"
  end

  resource "virtualenv" do
    url "https://files.pythonhosted.org/packages/7b/19/65f13cff26c8cc11fdfcb0499cd8f13388dd7b35a79a376755f152b42d86/virtualenv-20.17.1.tar.gz"
    sha256 "f8b927684efc6f1cc206c9db297a570ab9ad0e51c16fa9e45487d36d1905c058"
  end

  def install
    virtualenv_install_with_resources
  end

  # Avoid relative paths
  def post_install
    lib_python_path = Pathname.glob(libexec/"lib/python*").first
    lib_python_path.each_child do |f|
      next unless f.symlink?

      realpath = f.realpath
      rm f
      ln_s realpath, f
    end
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    pyver = Language::Python.major_minor_version(Formula["python@3.11"].opt_bin/"python3.11").to_s.delete(".")
    (testpath/"tox.ini").write <<~EOS
      [tox]
      envlist=py#{pyver}
      skipsdist=True

      [testenv]
      deps=pytest
      commands=pytest
    EOS
    (testpath/"test_trivial.py").write <<~EOS
      def test_trivial():
          assert True
    EOS
    assert_match "usage", shell_output("#{bin}/tox --help")
    system bin/"tox"
    assert_predicate testpath/".tox/py#{pyver}", :exist?
  end
end
