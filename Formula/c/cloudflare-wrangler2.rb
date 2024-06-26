require "language/node"

class CloudflareWrangler2 < Formula
  include Language::Node::Shebang

  desc "CLI tool for Cloudflare Workers"
  homepage "https://github.com/cloudflare/workers-sdk"
  url "https://registry.npmjs.org/wrangler/-/wrangler-3.51.0.tgz"
  sha256 "9a373fa275f8e15e28e39b72af7b381ea218c2002d3e67b730bc8c8992d46e9b"
  license any_of: ["Apache-2.0", "MIT"]

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "729752dcb18bb2346231e560b9836722e7a97c11895b65e18e68ecfdcdfc9076"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "729752dcb18bb2346231e560b9836722e7a97c11895b65e18e68ecfdcdfc9076"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "729752dcb18bb2346231e560b9836722e7a97c11895b65e18e68ecfdcdfc9076"
    sha256 cellar: :any_skip_relocation, sonoma:         "3e2264d0e85a5344597fccdb8c2566cb1349ee94acbe96f143f44d2e02d52a2e"
    sha256 cellar: :any_skip_relocation, ventura:        "3e2264d0e85a5344597fccdb8c2566cb1349ee94acbe96f143f44d2e02d52a2e"
    sha256 cellar: :any_skip_relocation, monterey:       "3e2264d0e85a5344597fccdb8c2566cb1349ee94acbe96f143f44d2e02d52a2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a04ffc436171af422e9f00ef972aa0ee0292afb12fdc67e39ceacf48d9a51e5"
  end

  depends_on "node"

  conflicts_with "cloudflare-wrangler", because: "both install `wrangler` binaries"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    rewrite_shebang detected_node_shebang, *Dir["#{libexec}/lib/node_modules/**/*"]
    bin.install_symlink Dir["#{libexec}/bin/wrangler*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wrangler -v")
    assert_match "Required Worker name missing", shell_output("#{bin}/wrangler secret list 2>&1", 1)
  end
end
