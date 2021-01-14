if [ -n "$GTK_MODULES" ]; then
    GTK_MODULES="$GTK_MODULES:unity-gtk-module"
else
    GTK_MODULES="unity-gtk-module"
fi

export GTK_MODULES
export UBUNTU_MENUPROXY=1
export KRITA_NO_STYLE_OVERRIDE=1
export QT_STYLE_OVERRIDE=kvantum
