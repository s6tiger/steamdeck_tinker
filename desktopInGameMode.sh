#!/bin/sh
set -euo pipefail

if [ -z "${DISPLAY:-}" ]; then
  echo 'No $DISPLAY attached to current session.' >&2
  exit 1
fi

if [ -z "${GAMESCOPE_WAYLAND_DISPLAY:-}" ]; then
  zenity --error --text="This script can only be run in a gamescope session."
  exit 1
fi
# Remove the performance overlay, it meddles with some tasks
unset LD_PRELOAD

## Shadow kwin_wayland_wrapper so that we can pass args to kwin wrapper
## whilst being launched by plasma-session
mkdir $XDG_RUNTIME_DIR/nested_plasma -p

_DISPLAY_RESOLUTION="$(xdpyinfo | awk '/dimensions/ {print $2}')"
cat <<EOF > $XDG_RUNTIME_DIR/nested_plasma/kwin_wayland_wrapper
#!/bin/sh
/usr/bin/kwin_wayland_wrapper --width "${_DISPLAY_RESOLUTION%x*}" --height "${_DISPLAY_RESOLUTION#*x}" --no-lockscreen \$@
EOF
chmod a+x $XDG_RUNTIME_DIR/nested_plasma/kwin_wayland_wrapper
export PATH=$XDG_RUNTIME_DIR/nested_plasma:$PATH

dbus-run-session startplasma-wayland

rm $XDG_RUNTIME_DIR/nested_plasma/kwin_wayland_wrapper


#scripted and edited by S6tiger
