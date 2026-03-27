if [ "$(tty)" = "/dev/tty1" ]; then
    export WLR_DRM_DEVICES=/dev/dri/card1
    export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json
    export __GLX_VENDOR_LIBRARY_NAME=mesa
    export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/radeon_icd.json
    export LIBVA_DRIVER_NAME=radeonsi
    exec sway
fi
