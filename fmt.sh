#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

MODE="default"

for arg in "$@"; do
  case "$arg" in
  -a | --all)
    MODE="all"
    ;;
  -h | --help)
    echo "Usage: $0 [-a|--all]"
    echo "  (default)   Format Dart files inside lib/ and test/ and all Markdown (.md) files"
    echo "  -a, --all   Format Dart and Markdown (.md) files in the entire repository"
    exit 0
    ;;
  *)
    echo "Unknown option: $arg" >&2
    echo "Usage: $0 [-a|--all]" >&2
    exit 1
    ;;
  esac
done

format_dart_default() {
  local targets=()
  for dir in lib test; do
    if [ -d "$dir" ]; then
      targets+=("$dir")
    fi
  done

  if [ ${#targets[@]} -gt 0 ]; then
    dart format "${targets[@]}"
  else
    echo "⚠️  Neither 'lib/' nor 'test/' found. Skipping Dart formatting."
  fi
}

format_dart_all() {
  find . \( -path "*/.*" -o -path "*/build" -o -path "*/.dart_tool" -o -path "*/ios" -o -path "*/android" -o -path "*/macos" -o -path "*/linux" -o -path "*/windows" \) -prune -o \
    -name "*.dart" -type f -exec dart format {} +
}

format_markdown() {
  find . \( -path "*/.*" -o -path "*/build" -o -path "*/.dart_tool" -o -path "*/ios" -o -path "*/android" -o -path "*/macos" -o -path "*/linux" -o -path "*/windows" \) -prune -o \
    -name "*.md" -type f -exec "$@" --write {} +
}

# 1. Format Dart files with dart format
if ! command -v dart >/dev/null 2>&1; then
  echo "⚠️  'dart' not found. Skipping Dart formatting."
elif [ "$MODE" = "all" ]; then
  echo "✨ Formatting Dart files in entire repository with dart format..."
  format_dart_all
else
  echo "✨ Formatting Dart files in 'lib/' and 'test/' with dart format..."
  format_dart_default
fi

# 2. Format Markdown files with Prettier (if available)
if command -v prettier >/dev/null 2>&1; then
  PRETTIER_CMD=(prettier)
elif command -v npx >/dev/null 2>&1; then
  PRETTIER_CMD=(npx --yes prettier)
else
  PRETTIER_CMD=()
fi

if [ ${#PRETTIER_CMD[@]} -eq 0 ]; then
  echo "⚠️  Neither 'prettier' nor 'npx' found. Skipping Markdown formatting."
else
  echo "📝 Formatting Markdown files with ${PRETTIER_CMD[*]}..."
  format_markdown "${PRETTIER_CMD[@]}"
fi

# 3. Format Shell scripts (prefers native shfmt from brew, falls back to uvx)
if command -v shfmt >/dev/null 2>&1; then
  echo "📜 Formatting shell scripts (shfmt)..."
  find . \( -path "*/.*" -o -path "*/build" -o -path "*/.dart_tool" \) -prune -o \
    -name "*.sh" -type f -exec shfmt -i 2 -w {} +
elif command -v uvx >/dev/null 2>&1; then
  echo "📜 Formatting shell scripts (uvx shfmt-py)..."
  find . \( -path "*/.*" -o -path "*/build" -o -path "*/.dart_tool" \) -prune -o \
    -name "*.sh" -type f -exec uvx --from shfmt-py shfmt -i 2 -w {} +
else
  echo "⚠️  Neither 'shfmt' nor 'uvx' found. Install with: brew install shfmt"
fi

echo "✅ Done!"
