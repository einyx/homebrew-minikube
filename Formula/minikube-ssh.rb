class MinikubeSsh < Formula
  desc "Run a Kubernetes cluster locally with SSH tunnel support for remote Docker"
  homepage "https://github.com/kubernetes/minikube"
  version "1.36.0-ssh"
  license "Apache-2.0"

  depends_on "kubectl"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/einyx/minikube/releases/download/v1.36.0-ssh/minikube-darwin-arm64"
      sha256 "08809785caefdb005078035897104e6db16709d47ca3e17a8fa8550de1338f53"

      def install
        bin.install "minikube-darwin-arm64" => "minikube"
      end
    else
      url "https://github.com/einyx/minikube/releases/download/v1.36.0-ssh/minikube-darwin-amd64"
      sha256 "5a6c9ca094d129f6d31b94fd28394e40020955086f47d3de5ced18d64f38b8a2"

      def install
        bin.install "minikube-darwin-amd64" => "minikube"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/einyx/minikube/releases/download/v1.36.0-ssh/minikube-linux-arm64"
      sha256 "a73dd7f0f08466c090e2b8fa05e43f72e8ae19ace5a74e30bf7a9304ef7fdebf"

      def install
        bin.install "minikube-linux-arm64" => "minikube"
      end
    else
      url "https://github.com/einyx/minikube/releases/download/v1.36.0-ssh/minikube-linux-amd64"
      sha256 "70cc2da1288a634019cfb25fe7305e3044708de955ee6c910aa83503d4c9d110"

      def install
        bin.install "minikube-linux-amd64" => "minikube"
      end
    end
  end

  def post_install
    (etc/"bash_completion.d").mkpath
    system "#{bin}/minikube", "completion", "bash", "--", ">", 
           "#{etc}/bash_completion.d/minikube-ssh" if which("bash")

    (fish_completion/"minikube-ssh.fish").write Utils.safe_popen_read(
      "#{bin}/minikube", "completion", "fish", "--"
    ) if which("fish")

    (zsh_completion/"_minikube-ssh").write Utils.safe_popen_read(
      "#{bin}/minikube", "completion", "zsh", "--"
    ) if which("zsh")
  end

  test do
    system "#{bin}/minikube", "version"
  end
end