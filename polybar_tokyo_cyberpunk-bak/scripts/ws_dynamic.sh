#!/bin/bash

i3-msg -t get_tree | jq -r '
def icon(c):
  if c == "Alacritty" then ""
  elif c == "Brave-browser" then ""
  elif c == "firefox" then ""
  elif c == "code" then ""
  elif c == "Thunar" then ""
  else ""
  end;

recurse(.nodes[]?, .floating_nodes[]?)
| select(.type=="workspace")
| . as $ws
| [
    ($ws.nodes[]?, $ws.floating_nodes[]?)
    | recurse(.nodes[]?, .floating_nodes[]?)
    | select(.window_properties.class?)
  ][0]
| if . then
    icon(.window_properties.class)
  else
    ""
  end
'
