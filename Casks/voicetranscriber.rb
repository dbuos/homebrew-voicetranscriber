cask "voicetranscriber" do
  version "1.0.0"
  sha256 :no_check  # Skip SHA verification for unsigned personal builds

  url "https://github.com/dbuos/VoiceTranscriberApp/releases/download/v#{version}/VoiceInk.dmg"
  name "VoiceInk"
  desc "Voice transcription app for macOS"
  homepage "https://github.com/dbuos/VoiceTranscriberApp"

  # Disable quarantine for unsigned apps
  # This prevents the "macOS cannot verify" warning on your own devices
  livecheck do
    url :url
    strategy :github_latest
  end

  app "VoiceInk.app"

  # Ad-hoc sign after installation (required for Apple Silicon)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/VoiceInk.app"],
                   sudo: false
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/VoiceInk.app"],
                   sudo: false
  end

  # Add note about unsigned app
  caveats do
    <<~EOS
      This is an unsigned personal build with ad-hoc signature.

      The app is automatically signed during installation.
      If you still have issues opening, try:
        sudo codesign --force --deep --sign - /Applications/VoiceInk.app
    EOS
  end

  zap trash: [
    "~/Library/Application Support/VoiceInk",
    "~/Library/Caches/VoiceInk",
    "~/Library/Preferences/com.voiceink.app.plist",
  ]
end
