#!/usr/bin/env bash

# Set timezone to Paris to ensure local date/time operations align with Europe/Paris
export TZ="Europe/Paris"

# Calculate a precise moon phase using 28 custom font symbols
# from moon_symbols.txt, while maintaining standard 8-phase descriptions.

show_help() {
  echo "Usage: $(basename "$0") [options]"
  echo ""
  echo "Options:"
  echo "  -i, --icon      Output only the moon icon/symbol"
  echo "  -e, --emoji     Use standard emojis instead of custom font symbols"
  echo "  -h, --help      Show this help message"
  echo ""
  echo "By default, custom font symbols are loaded from moon_symbols.txt."
}

# Parse command line arguments
icon_flag=false
emoji_flag=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -i|--icon)
      icon_flag=true
      shift
      ;;
    -e|--emoji)
      emoji_flag=true
      shift
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      # Ignore unknown arguments
      shift
      ;;
  esac
done

# Lunar cycle calculations
# lp: Lunar Period in seconds (~29.530589 days)
lp=2551443
now=$(date +"%s")
# Reference epoch of a new moon: July 14, 2026 11:43:00 Paris local time (09:43:00 UTC)
# Using a recent reference ensures high accuracy without accumulated drift.
newmoon=1784022180

# Calculate current phase in seconds (ensuring result is positive)
phase=$(( ( (now - newmoon) % lp + lp ) % lp ))
# Calculate phase day (goes from 1 to 30)
phase_day=$(( (phase / 86400) + 1 ))

symbols_str=""

# Strip newlines and whitespace
symbols_str=$(echo -n "$symbols_str" | tr -d '\r\n[:space:]')

# Read and sort by Unicode code point (byte order)
symbols=($(echo -n "$symbols_str" | grep -o . | LC_ALL=C sort))

# Determine the standard 8-phase description, emoji icon, and custom font symbol
# phase_number ranges from 0 to ~2953057 (representing days * 100000)
phase_number=$(( (phase * 100000) / 86400 ))

# Since custom font symbols from moon_symbols.txt use the alternate set (where filled
# pixels represent the shadowed part), they are visually inverted when rendered on
# dark terminal/status bar backgrounds. We shift the indices by 14 (half-cycle) to invert them.
if [ $phase_number -lt 184566 ]; then
  phase_name="New Moon"
  emoji_icon="🌑"
  icon="${symbols[13]}" # Full Moon glyph () renders as New Moon on dark background
elif [ $phase_number -lt 553699 ]; then
  phase_name="Waxing Crescent Moon"
  emoji_icon="🌒"
  sub_idx=$(( (phase_number - 184566) * 6 / 369133 ))
  icon="${symbols[14 + sub_idx]}" # Waning Gibbous glyphs render as Waxing Crescent
elif [ $phase_number -lt 922831 ]; then
  phase_name="First Quarter Moon"
  emoji_icon="🌓"
  icon="${symbols[20]}" # Last Quarter glyph () renders as First Quarter
elif [ $phase_number -lt 1291963 ]; then
  phase_name="Waxing Gibbous Moon"
  emoji_icon="🌔"
  sub_idx=$(( (phase_number - 922831) * 6 / 369132 ))
  icon="${symbols[21 + sub_idx]}" # Waning Crescent glyphs render as Waxing Gibbous
elif [ $phase_number -lt 1661096 ]; then
  phase_name="Full Moon"
  emoji_icon="🌕"
  icon="${symbols[27]}" # New Moon glyph () renders as Full Moon
elif [ $phase_number -lt 2030228 ]; then
  phase_name="Waning Gibbous Moon"
  emoji_icon="🌖"
  sub_idx=$(( (phase_number - 1661096) * 6 / 369132 ))
  icon="${symbols[sub_idx]}" # Waxing Crescent glyphs render as Waning Gibbous
elif [ $phase_number -lt 2399361 ]; then
  phase_name="Last Quarter Moon"
  emoji_icon="🌗"
  icon="${symbols[6]}" # First Quarter glyph () renders as Last Quarter
elif [ $phase_number -lt 2768493 ]; then
  phase_name="Waning Crescent Moon"
  emoji_icon="🌘"
  sub_idx=$(( (phase_number - 2399361) * 6 / 369132 ))
  icon="${symbols[7 + sub_idx]}" # Waxing Gibbous glyphs render as Waning Crescent
else
  phase_name="New Moon"
  emoji_icon="🌑"
  icon="${symbols[13]}"
fi

# Override icon with emoji if requested
if [ "$emoji_flag" = true ]; then
  icon="$emoji_icon"
fi

# Print output
if [ "$icon_flag" = true ]; then
  echo "$icon"
else
  echo "$icon $phase_name. Day $phase_day"
fi
