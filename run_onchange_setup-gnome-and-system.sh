#!/bin/bash
set -eufo pipefail

main() {
  # Lid switch behavior — guard against duplicate appends
  if ! grep -q "^HandleLidSwitch=ignore" /etc/systemd/logind.conf; then
    echo "HandleLidSwitch=ignore" | sudo tee -a /etc/systemd/logind.conf
  fi
  if ! grep -q "^HandleLidSwitchExternalPower=ignore" /etc/systemd/logind.conf; then
    echo "HandleLidSwitchExternalPower=ignore" | sudo tee -a /etc/systemd/logind.conf
  fi

  gsettings set org.gnome.desktop.interface show-battery-percentage true
  gsettings set org.gnome.desktop.calendar show-weekdate true

  gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 10'
  gsettings set org.gnome.desktop.interface document-font-name 'Adwaita Sans 10'
  gsettings set org.gnome.desktop.interface monospace-font-name 'Adwaita Mono'
  gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Adwaita Sans Bold 10'

  gsettings set org.gnome.mutter center-new-windows true
  gsettings set org.gnome.mutter workspaces-only-on-primary false
  # Disable CapsLock
  gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch', 'caps:none']"
  # Brno Weather
  gsettings set org.gnome.shell.weather locations "[<(uint32 2, <('Brno', 'LKTB', true, [(0.857829327355213, 0.291469985083053)], [(0.85870199198121022, 0.29030642643062599)])>)>]"
  # Boston, Brno, Portland, Pune and Singapore times
  gsettings set org.gnome.shell.world-clocks locations "[<(uint32 2, <('Boston', 'KBOS', true, [(0.73933117517543911, -1.2393680058718144)], [(0.73929408692883414, -1.2402270045697685)])>)>, <(uint32 2, <('Brno', 'LKTB', true, [(0.857829327355213, 0.291469985083053)], [(0.85870199198121022, 0.29030642643062599)])>)>, <(uint32 2, <('Pune', 'VAPO', true, [(0.32019112325387172, 1.2837088634636014)], [(0.32340951039454929, 1.2889256525978121)])>)>, <(uint32 2, <('Singapore', 'WSAP', true, [(0.023852838928353343, 1.8136879868485383)], [(0.022568084612667797, 1.8126262332513803)])>)>, <(uint32 2, <('Portland', 'KPDX', true, [(0.79571014457688405, -2.1397785149603687)], [(0.7945341242735976, -2.1411037260081156)])>)>]"

  gsettings set org.gnome.software download-updates false
  gsettings set org.gnome.software download-updates-notify false
}

if [ -f /run/.toolboxenv ]; then
  exec flatpak-spawn --host bash -c "$(declare -f main); main"
else
  main
fi
