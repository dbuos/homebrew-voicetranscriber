# Homebrew Tap for VoiceInk

Personal Homebrew tap for easy deployment of VoiceInk across your devices.

## Installation

```bash
# Add the tap
brew tap dbuos/voicetranscriber

# Install VoiceInk
brew install --cask voiceink
```

## Updating

```bash
brew upgrade --cask voiceink
```

## Uninstalling

```bash
# Uninstall app
brew uninstall --cask voiceink

# Remove tap (optional)
brew untap dbuos/voicetranscriber
```

## Creating a New Release

1. **Build the app in Xcode**
   - Open `VoiceInk.xcodeproj`
   - Archive the app (Product > Archive)
   - Export as macOS App

2. **Create a DMG**
   ```bash
   # Create a DMG from the built app
   hdiutil create -volname "VoiceInk" -srcfolder /path/to/VoiceInk.app -ov -format UDZO VoiceInk.dmg
   ```

3. **Create GitHub Release**
   ```bash
   # Tag and create release
   cd /path/to/VoiceTranscriber
   git tag v1.0.0
   git push origin v1.0.0

   # Upload DMG to GitHub release
   gh release create v1.0.0 VoiceInk.dmg --title "v1.0.0" --notes "Release notes here"
   ```

4. **Update the cask** (if version changed)
   ```bash
   cd /path/to/homebrew-voicetranscriber
   # Edit Casks/voiceink.rb and update the version number
   git add Casks/voiceink.rb
   git commit -m "Update to v1.0.0"
   git push
   ```

5. **Install on your devices**
   ```bash
   brew upgrade --cask voiceink
   ```

## Notes

- This tap uses `sha256 :no_check` to skip hash verification for unsigned builds
- Apps will need security approval on first run (System Settings > Privacy & Security)
- Alternative: Run `xattr -cr /Applications/VoiceInk.app` to remove quarantine

## Quick Update Script

Create a helper script for releases:

```bash
#!/bin/bash
# release.sh
VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: ./release.sh v1.0.0"
  exit 1
fi

# Build DMG (adjust path as needed)
hdiutil create -volname "VoiceInk" -srcfolder ./build/VoiceInk.app -ov -format UDZO VoiceInk.dmg

# Create release
git tag $VERSION
git push origin $VERSION
gh release create $VERSION VoiceInk.dmg --title "$VERSION" --notes "Release $VERSION"

echo "Release $VERSION created! Update the cask version if needed."
```
