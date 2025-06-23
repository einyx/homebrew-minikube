class Minikube < Formula
  desc "Run a Kubernetes cluster locally with SSH tunnel support for remote Docker"
  homepage "https://github.com/kubernetes/minikube"
  version "1.36.0-remote"
  license "Apache-2.0"

  depends_on "kubectl"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/einyx/homebrew-minikube-remote/releases/download/v1.36.0-remote/minikube-darwin-arm64"
      sha256 "428a6690733038c4f17e5ab08c44616e94bc1fffdb16149386dff792037e66eb"

      def install
        bin.install "minikube-darwin-arm64" => "minikube"
      end
    else
      url "https://github.com/einyx/homebrew-minikube-remote/releases/download/v1.36.0-remote/minikube-darwin-amd64"
      sha256 "3a69308d25e814f3da4d36fa8321bdb90e50bae17ba424ad1e9fe9713d408de6"

      def install
        bin.install "minikube-darwin-amd64" => "minikube"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/einyx/homebrew-minikube-remote/releases/download/v1.36.0-remote/minikube-linux-arm64"
      sha256 "6d53cc4685e037fc70b38c326a18ad7bf7ce0e08d0be3b27b8f025652fabfc45"

      def install
        bin.install "minikube-linux-arm64" => "minikube"
      end
    else
      url "https://github.com/einyx/homebrew-minikube-remote/releases/download/v1.36.0-remote/minikube-linux-amd64"
      sha256 "6ecf4cff0d2058036177f5db3ff446649bb2435c7b9b4f530617ae1bfe5480e4"

      def install
        bin.install "minikube-linux-amd64" => "minikube"
      end
    end
  end

  def post_install
    (etc/"bash_completion.d").mkpath
    system "#{bin}/minikube", "completion", "bash", "--", ">", 
           "#{etc}/bash_completion.d/minikube" if which("bash")

    (fish_completion/"minikube.fish").write Utils.safe_popen_read(
      "#{bin}/minikube", "completion", "fish", "--"
    ) if which("fish")

    (zsh_completion/"_minikube").write Utils.safe_popen_read(
      "#{bin}/minikube", "completion", "zsh", "--"
    ) if which("zsh")
  end

  test do
    system "#{bin}/minikube", "version"
  end
end