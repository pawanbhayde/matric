#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Matric macOS Build, Codesign & DMG Packaging Script
# ==============================================================================

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

VERSION="${VERSION:-$(git describe --tags --abbrev=0 2>/dev/null || echo "1.0.0")}"
VERSION="${VERSION#v}" # Strip leading 'v' if present
CONFIGURATION="${CONFIGURATION:-Release}"
OUTPUT_DIR="${OUTPUT_DIR:-$PROJECT_DIR/build/dist}"
DERIVED_DATA_DIR="${DERIVED_DATA_DIR:-$PROJECT_DIR/build/DerivedData}"
APP_NAME="Matric"
DMG_NAME="${APP_NAME}-${VERSION}.dmg"
DMG_PATH="${OUTPUT_DIR}/${DMG_NAME}"
SIGNING_IDENTITY="${SIGNING_IDENTITY:--}"

echo "=================================================="
echo " Building ${APP_NAME} v${VERSION} (${CONFIGURATION})"
echo " Output DMG: ${DMG_PATH}"
echo " Signing Identity: ${SIGNING_IDENTITY}"
echo "=================================================="

# 1. Clean previous build output
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# 2. Build Universal Application (Apple Silicon arm64 + Intel x86_64)
echo "==> Building universal binary via xcodebuild..."
xcodebuild -project matric.xcodeproj \
  -scheme matric \
  -configuration "$CONFIGURATION" \
  -destination 'platform=macOS' \
  ARCHS="arm64 x86_64" \
  ONLY_ACTIVE_ARCH=NO \
  MACOSX_DEPLOYMENT_TARGET=14.0 \
  MARKETING_VERSION="$VERSION" \
  PRODUCT_BUNDLE_IDENTIFIER="com.pawanbhayde.matric" \
  -derivedDataPath "$DERIVED_DATA_DIR" \
  CODE_SIGN_IDENTITY="" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO \
  clean build

BUILT_APP="${DERIVED_DATA_DIR}/Build/Products/${CONFIGURATION}/${APP_NAME}.app"

if [ ! -d "$BUILT_APP" ]; then
  echo "Error: Built application not found at ${BUILT_APP}"
  exit 1
fi

# 3. Codesign the Application Bundle
echo "==> Signing ${APP_NAME}.app..."
ENTITLEMENTS_FILE="${PROJECT_DIR}/matric/matric.entitlements"

if [ "$SIGNING_IDENTITY" != "-" ]; then
  echo "==> Signing with Developer ID: ${SIGNING_IDENTITY}"
  codesign --force --deep --options runtime --timestamp \
    --entitlements "$ENTITLEMENTS_FILE" \
    --sign "$SIGNING_IDENTITY" \
    "$BUILT_APP"
else
  echo "==> Signing with Ad-Hoc Identity (-)..."
  codesign --force --deep --options runtime \
    --entitlements "$ENTITLEMENTS_FILE" \
    --sign - \
    "$BUILT_APP"
fi

echo "==> Verifying code signature..."
codesign --verify --deep --strict --verbose=2 "$BUILT_APP"

# 4. Stage DMG Files
STAGING_DIR="${OUTPUT_DIR}/dmg_staging"
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"

cp -R "$BUILT_APP" "$STAGING_DIR/"
ln -s /Applications "$STAGING_DIR/Applications"

# 5. Create DMG Installer
echo "==> Packaging into DMG..."
if command -v create-dmg >/dev/null 2>&1; then
  echo "==> Using create-dmg utility..."
  create-dmg \
    --volname "${APP_NAME}" \
    --window-pos 200 120 \
    --window-size 660 400 \
    --icon-size 128 \
    --icon "${APP_NAME}.app" 180 170 \
    --hide-extension "${APP_NAME}.app" \
    --app-drop-link 480 170 \
    --no-internet-enable \
    "$DMG_PATH" \
    "$STAGING_DIR" || {
      # In case create-dmg returns 2 on warning, verify if DMG was created
      if [ ! -f "$DMG_PATH" ]; then
        echo "create-dmg failed, falling back to hdiutil..."
        hdiutil create -volname "${APP_NAME}" -srcfolder "$STAGING_DIR" -ov -format UDZO "$DMG_PATH"
      fi
    }
else
  echo "==> Using native macOS hdiutil..."
  hdiutil create -volname "${APP_NAME}" -srcfolder "$STAGING_DIR" -ov -format UDZO "$DMG_PATH"
fi

rm -rf "$STAGING_DIR"

# 6. Sign DMG (if certificate provided)
if [ "$SIGNING_IDENTITY" != "-" ]; then
  echo "==> Signing DMG with ${SIGNING_IDENTITY}..."
  codesign --force --timestamp --sign "$SIGNING_IDENTITY" "$DMG_PATH"
fi

# 7. Notarize DMG (if Apple ID credentials provided)
if [ -n "${APPLE_ID:-}" ] && [ -n "${APPLE_APP_SPECIFIC_PASSWORD:-}" ] && [ -n "${APPLE_TEAM_ID:-}" ]; then
  echo "==> Submitting DMG for Apple Notarization..."
  xcrun notarytool submit "$DMG_PATH" \
    --apple-id "$APPLE_ID" \
    --password "$APPLE_APP_SPECIFIC_PASSWORD" \
    --team-id "$APPLE_TEAM_ID" \
    --wait

  echo "==> Stapling notarization ticket to DMG..."
  xcrun stapler staple "$DMG_PATH"
fi

# 8. Compute Checksums
echo "==> Generating SHA256 checksum..."
cd "$OUTPUT_DIR"
shasum -a 256 "${DMG_NAME}" > "${DMG_NAME}.sha256"

# Create a generic symlink Matric.dmg for latest releases
ln -sf "${DMG_NAME}" "${OUTPUT_DIR}/Matric.dmg"
shasum -a 256 "Matric.dmg" > "${OUTPUT_DIR}/Matric.dmg.sha256"

echo "=================================================="
echo " Build & Packaging Complete!"
echo " DMG: ${DMG_PATH}"
echo " SHA256: $(cat "${OUTPUT_DIR}/${DMG_NAME}.sha256")"
echo "=================================================="
