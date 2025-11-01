cask "voiceink" do
  version "1.0.0"
  sha256 :no_check  # Skip SHA verification for unsigned personal builds

  url "https://github.com/dbuos/VoiceTranscriber/releases/download/v#{version}/VoiceInk.dmg"
  name "VoiceInk"
  desc "Voice transcription app for macOS"
  homepage "https://github.com/dbuos/VoiceTranscriber"

  # Disable quarantine for unsigned apps
  # This prevents the "macOS cannot verify" warning on your own devices
  livecheck do
    url :url
    strategy :github_latest
  end

  app "VoiceInk.app"

  # Add note about unsigned app
  caveats do
    <<~EOS
      This is an unsigned personal build.

      If macOS prevents opening, run:
        xattr -cr /Applications/VoiceInk.app

      Or manually allow in System Settings > Privacy & Security
    EOS
  end

  zap trash: [
    "~/Library/Application Support/VoiceInk",
    "~/Library/Caches/VoiceInk",
    "~/Library/Preferences/com.voiceink.app.plist",
  ]
end
