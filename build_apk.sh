#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

MODE="release"

for arg in "$@"; do
  case "$arg" in
  -r | --release)
    MODE="release"
    ;;
  -d | --debug)
    MODE="debug"
    ;;
  -p | --profile)
    MODE="profile"
    ;;
  -h | --help)
    echo "Usage: $0 [-r|--release|-d|--debug|-p|--profile]"
    echo "  (default)        Build release APK and copy it to ./apk/"
    echo "  -r, --release    Build release APK"
    echo "  -d, --debug      Build debug APK"
    echo "  -p, --profile    Build profile APK"
    exit 0
    ;;
  *)
    echo "Unknown option: $arg" >&2
    echo "Usage: $0 [-r|--release|-d|--debug|-p|--profile]" >&2
    exit 1
    ;;
  esac
done

echo "Building APK ($MODE)..."
flutter build apk "--$MODE"

APP_NAME=$(awk '/^name:[[:space:]]*/ { print $2; exit }' pubspec.yaml | tr -d '"'\''')
APP_VERSION=$(awk '/^version:[[:space:]]*/ { print $2; exit }' pubspec.yaml | tr -d '"'\''')

APP_NAME="${APP_NAME:-app}"
if [ -n "$APP_VERSION" ]; then
  APK_FILENAME="${APP_NAME}-${APP_VERSION}-${MODE}.apk"
else
  APK_FILENAME="${APP_NAME}-${MODE}.apk"
fi

APK_SOURCE="build/app/outputs/flutter-apk/app-$MODE.apk"
APK_DEST_DIR="apk"
APK_DEST="$APK_DEST_DIR/$APK_FILENAME"

if [ ! -f "$APK_SOURCE" ]; then
  echo "Error: generated APK not found at $APK_SOURCE" >&2
  exit 1
fi

mkdir -p "$APK_DEST_DIR"
cp -f "$APK_SOURCE" "$APK_DEST"

echo "APK copied to $APK_DEST"
