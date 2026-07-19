#!/usr/bin/env bash

# Calculate approximate moon phase
moonphase() {

  local lp=2551443
  local now=$(date -u +"%s")
  local newmoon=592500
  local phase=$((($now - $newmoon) % $lp))
  local phase_number=$(((phase * 100000) / 86400))
  local phase_day=$((($phase / 86400) + 1));

  # parse arguments
  local args=$@
  local icon_flag=false
  local emoji_flag=false
  if [ $# -ge 1 ]; then

    for arg in $args; do

      if [ $arg == "-i" ]; then  # echo just the icon when -i passed
        local icon_flag=true
      fi

      if [ $arg == "-e" ]; then
        local emoji_flag=true
      fi

    done

  fi

  # determine moon phase
  # multiply by 100000 so that we can do integer comparison in bash.
  if   [ $phase_number -lt 184566 ];   then
    if [ $emoji_flag == true ]; then local icon_phase="🌑 New"
    else                             local icon_phase="○ New"
    fi
  elif [ $phase_number -lt 553699 ];   then
    if [ $emoji_flag == true ]; then local icon_phase="🌒 Waxing Crescent"
    else                             local icon_phase="❩ Waxing Crescent"
    fi
  elif [ $phase_number -lt 922831 ];   then
    if [ $emoji_flag == true ]; then local icon_phase="🌓 First Quarter"
    else                             local icon_phase="◗ First Quarter"
    fi
  elif [ $phase_number -lt 1291963 ];  then
    if [ $emoji_flag == true ]; then local icon_phase="🌔 Waxing Gibbous"
    else                             local icon_phase="◑ Waxing Gibbous"
    fi
  elif [ $phase_number -lt 1661096 ];  then
    if [ $emoji_flag == true ]; then local icon_phase="🌕 Full"
    else                             local icon_phase="● Full"
    fi
  elif [ $phase_number -lt 2030228 ];  then
    if [ $emoji_flag == true ]; then local icon_phase="🌖 Waning Gibbous"
    else                             local icon_phase="◐ Waning Gibbous"
    fi
  elif [ $phase_number -lt 2399361 ];  then
    if [ $emoji_flag == true ]; then local icon_phase="🌗 Last Quarter"
    else                             local icon_phase="◖ Last Quarter"
    fi
  elif [ $phase_number -lt 2768493 ];  then
    if [ $emoji_flag == true ]; then local icon_phase="🌘 Waning Crescent"
    else                             local icon_phase="❨ Waning Crescent"
    fi
  else
    if [ $emoji_flag == true ]; then local icon_phase="🌑 New"
    else                             local icon_phase="○ New"
    fi
  fi

  # construct output
  local just_icon=$(echo $icon_phase | cut -b1-4)
  local full_output="$icon_phase Moon. Day $phase_day"

  # dump output
  if [ $icon_flag == true ]; then
    echo $just_icon
  else  # echo full_output when no arguments passed
    echo $full_output
  fi
}

# Run the function
moonphase $@

