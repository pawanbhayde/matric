cask "matric" do
  version "1.0.0"
  sha256 "2bff287a4f5fa247ab535f0ca2c4a80dd83bf32c7e32c078227624e8bcce8aec"

  url "https://github.com/pawanbhayde/matric/releases/download/v#{version}/Matric-#{version}.dmg"
  name "Matric"
  desc "System monitor and developer workspace companion"
  homepage "https://github.com/pawanbhayde/matric"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Matric.app"

  uninstall quit: "com.pawanbhayde.matric"

  zap trash: [
    "~/Library/Application Support/Matric",
    "~/Library/Caches/com.pawanbhayde.matric",
    "~/Library/Preferences/com.pawanbhayde.matric.plist",
    "~/Library/Saved Application State/com.pawanbhayde.matric.savedState",
  ]
end
