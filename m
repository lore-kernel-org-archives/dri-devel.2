Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8449AC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FA810E72D;
	Sun, 13 Sep 2026 20:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dDY+6xw6";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712FC10E72D
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:50:13 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49e6deb520eso17100005e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789332612; x=1789937412; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vjMoUF4yuavaTKyLY/U0g6P8MTIyeIYTubqXPU+RsMY=;
 b=dDY+6xw6PW7sCM5Zkum28QJHy2qpXmcvWxAtzTwGpoGbSnsbt/iFmPjZXxgff9L3n6
 58blxK7i+X2ZSllEzRl+iHS2LKJKeAejRYzYwc+PuMjo33lliLEN9pwUtYx5635j1K6l
 PXZjNUSKkJgBfZ0QSVajgQcVqSgjHP4+j43SuK3Csa17jo8H+k1AkNFw53en4MQ259jq
 4GxlD07PHB2AOMY/0AKkFRVMFCX6W3gbnIgcTJQefm7c/vagcolR2yo/qQXs+Of6gA1F
 7DkdBpewYFOc/J9RbSvIas1dtKCgs1Mm68RokVUENBvmJKYnBmZoMLN87XR8xps0E3ym
 +74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789332612; x=1789937412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vjMoUF4yuavaTKyLY/U0g6P8MTIyeIYTubqXPU+RsMY=;
 b=K6YZyRkCQMOGwBr3feZ8KV2JUyuNp75wM0PNvYCf8z2MB1mSJ1qqz/2mq5/WqqQaPY
 Ptj8k39bkSXAwNMkkMNrSuc8lsOOtr+w8Qw0ZSQj6WuUr4oFmXl0CSwcwlisZgVIS4Sk
 Nt7T8I26Nz2+0uzIhSyHPCBzj8zmKMQMthtSYL/t2lTp8ceVulkF9+kdljNc0rO+kiLR
 ijP5sQ7vyV34qSCfsTYAaj9HJIXByaIQ00mNEjaxDR0mTcIdnNQwYd/k2eRGGfKlhQ1g
 61Ysw87OKz/W3/VovlDpg2X6Bu732kVd6ssHijZmjogKl5rWBseADWdbFR8nZjSKAYqQ
 qyog==
X-Gm-Message-State: AFuF++l+Typ4nmX4NQtCtd0/udYZLba3T/7ONy03kXjfruakMXX5/fe2
 TeNMy7KfSDkky5Bw3Y+o7kEjo7dmkCGBkIUKNOeKXLdWd+859bc1h4BHYk6CDnKZ
X-Gm-Gg: AYBFou1DGus4LhxxGN2lr6IV+cWuccWro5+riMC8ESaIgKII1MEV7Lcsiqs1DG8PIzt
 fdHBbEhKUp+JHNEWM46/VJNrZuq2CdqbD12tLqNYPECmiGxX528r2sN3pot3RocOpKT9DYNOb+R
 4HJ1WFL36Hk8y0pNYU7wB7AHXPWzQ/Y1UDz34nUp1W2Alll3rusxAwvHnUfyg+3MkEUfkOyVJd0
 cGoKTGhGLWkjeNl7QM56LBco+rnJ8VyrmCi8wRV+ko2JYWCC1VXtQNSSQp9jUxTOInPR73UynL8
 Nwi6OZ/Dghq215weh3EzR5NhrdOzazq1HuV1GGeTpF5Y83gVbhSf8IoAzrh0ScQiqesnGTG3SuT
 teXUhi2M0fPTtU9AP2BP9n3VlWZriSjxdc9iKLrjOat3s/e5m4t6rkMIK/acCx+qMVjT9u31uZi
 m/TRuNNtZ9fnyKkmbpZnNfZUcziWoqI64knNodxkDytE33WvbHyRJG2LloopxQRwvcgHf7+8zXW
 IhscBVsh6ZJjlhDMQvK+RknSCXR9+dWIRxdHL/GGZZN3VDE6f8JxmOoM/4x/1mYv59RnScBtZW+
 Vz8iWhoLs64z5ZK5StsA53d1Zt9ojPXrPs/l9A==
X-Received: by 2002:a05:600c:4e8e:b0:49e:7423:687c with SMTP id
 5b1f17b1804b1-49e742368a8mr56005745e9.1.1789332611594; 
 Sun, 13 Sep 2026 13:50:11 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7723d458sm54986345e9.0.2026.09.13.13.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:50:11 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v4 0/2] drm: Add DRM driver for GlandaGPU (VHDL soft-IP GPU)
Date: Sun, 13 Sep 2026 22:50:05 +0200
Message-ID: <20260913205007.118552-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This is v4 of the GlandaGPU DRM driver series [1][2][3]. It addresses
review feedback from Thomas Zimmermann and the automated review bot
on v3.

GlandaGPU is a small VHDL soft-IP 2D display controller, currently
targeting a Terasic DE10-Standard (Cyclone V SoC). This series has
been tested against a QEMU digital twin and on real hardware.

Hardware/VHDL:   https://github.com/stiangglanda/GlandaGPU
QEMU fork:       https://github.com/stiangglanda/qemu-glandagpu
Userspace tests: https://github.com/stiangglanda/GlandaGPU-userspace-tests

Changes since v3:

dt-bindings:
- Fix alphabetical ordering of the '^kieweg,.*' vendor prefix in
  vendor-prefixes.yaml.

driver core:
- Use devm_ioremap_wc() instead of devm_ioremap() for the VRAM
  mapping in both the platform and PCI probe paths, avoiding a severe
  performance regression from uncached writes (Sashiko bot).
- Only enable the hardware VSYNC interrupt when an IRQ handler is
  actually registered. enable_vblank() now returns -EINVAL when
  falling back to polling mode, instead of risking an unhandled
  interrupt storm (Sashiko bot).
- Stop unconditionally enabling the VSYNC interrupt during probe.
  Let the DRM core enable/disable it through enable_vblank()/
  disable_vblank() as needed (Thomas Zimmermann, Sashiko bot).
- Guard the PCI probe/remove code and pci_driver structure with
  #ifdef CONFIG_PCI so the driver builds with
  CONFIG_COMPILE_TEST=y && CONFIG_PCI=n (Sashiko bot).
- Use container_of_const() instead of container_of() (Thomas
  Zimmermann).
- Add glanda_plane_atomic_disable(), which blanks VRAM when the
  plane is disabled, instead of silently returning on a NULL fb
  (Thomas Zimmermann).
- Wrap direct access to the shadow-plane buffer object in
  drm_gem_fb_begin_cpu_access()/drm_gem_fb_end_cpu_access() to
  synchronize against imported buffers (Thomas Zimmermann).
- Switch atomic_update() to damage-clipped blitting via
  drm_atomic_helper_damage_iter instead of copying the whole frame
  on every update (Thomas Zimmermann).
- Always call drm_atomic_helper_check_plane_state() in
  atomic_check(), even when the plane has no CRTC yet (Thomas
  Zimmermann).
- Support panning within a larger, system-allocated framebuffer by
  calculating the correct source offset when reading pixel data 
  (Thomas Zimmermann).
- Remove glanda_connector_detect(). The default "connected" status
  is sufficient (Thomas Zimmermann).
- Wrap hardware register access in enable_vblank()/disable_vblank()
  with drm_dev_enter()/drm_dev_exit() (Thomas Zimmermann).
- Use drm_crtc_vblank_atomic_enable()/drm_crtc_vblank_atomic_disable()
  instead of custom wrapper functions (Thomas Zimmermann).
- Use drmm_mode_config_init() so the mode-config pipeline is cleaned
  up automatically (Thomas Zimmermann).
- Raise mode_config.max_width/max_height to
  DRM_SHADOW_PLANE_MAX_WIDTH/DRM_SHADOW_PLANE_MAX_HEIGHT instead of
  the fixed 640x480, so userspace can allocate larger framebuffers
  (Thomas Zimmermann).
- Call drm_plane_enable_fb_damage_clips() to enable damage clipping
  (Thomas Zimmermann).
- Move drm_vblank_init() to right before drm_mode_config_reset()
  (Thomas Zimmermann).
- Remove the manual drm_helper_probe_single_connector_modes() call
  during init. The DRM core probes modes on demand (Thomas
  Zimmermann).
- Simplify glanda_drm_fini() to just drm_dev_unplug(). The DRM core
  handles vblank/IRQ teardown after unplug (Thomas Zimmermann).
- Drop "Hardware Accelerated" from the driver description (Thomas
  Zimmermann).

Regarding the panning support: Since the physical VRAM is fixed to 
640x480, the display output itself cannot be panned. Instead, the 
panning is handled on the source side. If userspace allocates a 
larger framebuffer, the driver now calculates the correct src_x and 
src_y offsets from the plane state and copies only the requested 
sub-region into VRAM. Please let me know if this implementation 
matches what you had in mind with the sysfb reference.

[1] v1: https://lore.kernel.org/dri-devel/20260714101146.200416-1-kieweg.leander@gmail.com/T/#t
[2] v2: https://lore.kernel.org/dri-devel/20260730173643.256052-1-kieweg.leander@gmail.com/T/#t
[3] v3: https://lore.kernel.org/dri-devel/20260824195418.17707-1-kieweg.leander@gmail.com/T/#t

Leander Kieweg (2):
  dt-bindings: display: Add GlandaGPU binding
  drm/glanda: Add initial DRM driver for GlandaGPU

 .../bindings/display/kieweg,gpu.yaml          |  55 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  11 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/glandagpu.c              | 642 ++++++++++++++++++
 6 files changed, 717 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c

-- 
2.43.0

