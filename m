Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6C6C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9DA10E112;
	Thu, 24 Sep 2026 09:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="p+BhUeAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BU6fSTet";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5OeEiSb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bwzdt44s";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545D710E112;
 Thu, 24 Sep 2026 09:31:16 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87AD921E7D;
 Thu, 24 Sep 2026 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790242252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4B3LaegPwkv2RB4rLF8EsjDYl0Zo7A9//9lFJY8tWIo=;
 b=p+BhUeAKwis+7Pveqn50Kd8hidhfMkAG7C98UjRPF6a9+wK0b8BTUJ5dnKXlki3xLp7KEl
 IwRalfiKpSxB+EKUlfhd4mMaJOaohRFuySIjzBONTPDAcB3OXLPkL4caFkfDSmRlvolGe3
 IiBKL+z+qRLKkNCGZ0EjukLKVxb3rmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790242252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4B3LaegPwkv2RB4rLF8EsjDYl0Zo7A9//9lFJY8tWIo=;
 b=BU6fSTet7EFkX8NjVcwtXqUjYYa8xFdNo2YEIZnIo/7TTUdvh2HMQRkY9lj/MpW6fQ/Qe4
 mR4rkl4aGDEYC4BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J5OeEiSb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Bwzdt44s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790242248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4B3LaegPwkv2RB4rLF8EsjDYl0Zo7A9//9lFJY8tWIo=;
 b=J5OeEiSbj/uzEKnmiI+1p+gOzt3+JFQ814a1QUuhW9f+U8Is7OBmZdcgq1DYuJUhCospwL
 Zf2TsO6gLInQ2nXpuVV8I02bhYTatip+DDxr1LNzd4USKsQVwVxNpPeZOmpQkFSp+4TVOR
 znrFrf8FyfrxJa5tRE4MNQpmLExkPXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790242248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4B3LaegPwkv2RB4rLF8EsjDYl0Zo7A9//9lFJY8tWIo=;
 b=Bwzdt44s0b+M/jpkQAo4NrWHOp+t/YO/PZGq+NrBP7m3AgXaEYIARPGikj6WBDJeCkU2LD
 a5t9D34CWmgy0qAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96837136ED;
 Thu, 24 Sep 2026 09:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2es5CcbttGp+IgAAD6G6ig:T3
 (envelope-from <tzimmermann@suse.de>); Thu, 24 Sep 2026 09:30:47 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jani.nikula@linux.intel.com, Alexander.Deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 2/2] drm/fbdev: Move fbdev helpers into client library
Date: Thu, 24 Sep 2026 11:29:14 +0200
Message-ID: <20260924093036.82356-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924093036.82356-1-tzimmermann@suse.de>
References: <20260924093036.82356-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 87AD921E7D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[23];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,amd.com:email,suse.de:dkim,suse.de:email,suse.de:mid,intel.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLgosu6qu4h11rje89ht7rjgg5)];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

DRM's fbdev helpers are for the fbdev-emulation clients. Move them
into the client-library module. Fix include statements throughout
DRM drivers.

While at it, rename the files from drm_fb_helper to drm_fbdev_helper.
The old name was too reminiscent of DRM's framebuffer code.

The GEM support code for fbdev remains part of DRM's memory managers.

v2:
- update armada und docs

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 Documentation/gpu/drm-kms-helpers.rst                       | 6 +++---
 drivers/gpu/drm/Makefile                                    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                 | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                     | 2 +-
 drivers/gpu/drm/armada/armada_fbdev.c                       | 2 +-
 drivers/gpu/drm/clients/Makefile                            | 3 ++-
 drivers/gpu/drm/clients/drm_fbdev_client.c                  | 2 +-
 .../gpu/drm/{drm_fb_helper.c => clients/drm_fbdev_helper.c} | 2 +-
 drivers/gpu/drm/drm_fbdev_dma.c                             | 2 +-
 drivers/gpu/drm/drm_fbdev_shmem.c                           | 2 +-
 drivers/gpu/drm/drm_fbdev_ttm.c                             | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c                   | 2 +-
 drivers/gpu/drm/gma500/fbdev.c                              | 2 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c                  | 2 +-
 drivers/gpu/drm/msm/msm_debugfs.c                           | 2 +-
 drivers/gpu/drm/msm/msm_fbdev.c                             | 2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c                     | 1 -
 drivers/gpu/drm/omapdrm/omap_debugfs.c                      | 2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c                        | 2 +-
 drivers/gpu/drm/radeon/radeon_device.c                      | 2 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c                       | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                 | 2 +-
 drivers/gpu/drm/sitronix/st7571.c                           | 1 -
 drivers/gpu/drm/tegra/fbdev.c                               | 2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c                       | 2 +-
 include/drm/{drm_fb_helper.h => clients/drm_fbdev_helper.h} | 4 ++--
 26 files changed, 27 insertions(+), 29 deletions(-)
 rename drivers/gpu/drm/{drm_fb_helper.c => clients/drm_fbdev_helper.c} (99%)
 rename include/drm/{drm_fb_helper.h => clients/drm_fbdev_helper.h} (99%)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 400cd0112713..65bc16b96f8f 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -109,13 +109,13 @@ VBLANK Helper Reference
 fbdev Helper Functions Reference
 ================================
 
-.. kernel-doc:: drivers/gpu/drm/drm_fb_helper.c
+.. kernel-doc:: drivers/gpu/drm/clients/drm_fbdev_helper.c
    :doc: fbdev helpers
 
-.. kernel-doc:: include/drm/drm_fb_helper.h
+.. kernel-doc:: include/drm/clients/drm_fbdev_helper.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_fb_helper.c
+.. kernel-doc:: drivers/gpu/drm/clients/drm_fbdev_helper.c
    :export:
 
 Draw Helper Functions Reference
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index f0c340aa2ec6..3a0f2095de3c 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -158,7 +158,6 @@ drm_kms_helper-y := \
 drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
 drm_kms_helper-$(CONFIG_DRM_PANIC_HELPER) += drm_panic_helper.o
 drm_kms_helper-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) += drm_panic_helper_qr.o
-drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 
 #
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 59ea338b554c..126bfd9bb89e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -38,11 +38,11 @@
 
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_modeset_helper.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f2f179421c4d..51a7a4091376 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -28,8 +28,8 @@
 
 #include "amdgpu.h"
 #include <drm/amdgpu_drm.h>
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
 #include "atom.h"
diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index 8bbae94804f8..f35afec2125f 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -9,9 +9,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_print.h>
 
diff --git a/drivers/gpu/drm/clients/Makefile b/drivers/gpu/drm/clients/Makefile
index c16addbc327f..1304ff358509 100644
--- a/drivers/gpu/drm/clients/Makefile
+++ b/drivers/gpu/drm/clients/Makefile
@@ -4,5 +4,6 @@ subdir-ccflags-y += -I$(src)/..
 
 drm_client_lib-y := drm_client_setup.o
 drm_client_lib-$(CONFIG_DRM_CLIENT_LOG) += drm_log.o
-drm_client_lib-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_client.o
+drm_client_lib-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_client.o \
+						drm_fbdev_helper.o
 obj-$(CONFIG_DRM_CLIENT_LIB) += drm_client_lib.o
diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
index 7574bd36f45e..eec463d19943 100644
--- a/drivers/gpu/drm/clients/drm_fbdev_client.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: MIT
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_client.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_print.h>
 
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/clients/drm_fbdev_helper.c
similarity index 99%
rename from drivers/gpu/drm/drm_fb_helper.c
rename to drivers/gpu/drm/clients/drm_fbdev_helper.c
index 76195410db60..fff3cf6a0aed 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_helper.c
@@ -32,9 +32,9 @@
 #include <linux/console.h>
 #include <linux/export.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 9412d9fdd74b..452f84400350 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -4,10 +4,10 @@
 #include <linux/fb.h>
 #include <linux/vmalloc.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fb_dma_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_print.h>
diff --git a/drivers/gpu/drm/drm_fbdev_shmem.c b/drivers/gpu/drm/drm_fbdev_shmem.c
index 458c899b5d4f..8eb05fe9bc98 100644
--- a/drivers/gpu/drm/drm_fbdev_shmem.c
+++ b/drivers/gpu/drm/drm_fbdev_shmem.c
@@ -3,9 +3,9 @@
 #include <linux/export.h>
 #include <linux/fb.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_shmem.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
diff --git a/drivers/gpu/drm/drm_fbdev_ttm.c b/drivers/gpu/drm/drm_fbdev_ttm.c
index 160bc35d8738..8eb59c2ac5ea 100644
--- a/drivers/gpu/drm/drm_fbdev_ttm.c
+++ b/drivers/gpu/drm/drm_fbdev_ttm.c
@@ -4,9 +4,9 @@
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_print.h>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 8641c9e84d4c..f412269d6323 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -10,9 +10,9 @@
 
 #include <linux/fb.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_prime.h>
diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index d1e93588234f..428912574f20 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -7,9 +7,9 @@
 
 #include <linux/fb.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 
 #include "gem.h"
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index db0e36dd8722..219ee17de3f6 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -38,10 +38,10 @@
 #include <linux/vga_switcheroo.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/intel/display_parent_interface.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index f12701e286ec..d05307bfa123 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -9,8 +9,8 @@
 #include <linux/debugfs.h>
 #include <linux/fault-inject.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_debugfs.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index dd6d6c507d77..f37cc3f97a21 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -6,9 +6,9 @@
 
 #include <linux/fb.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_file.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index add19d479ebe..e91130f93db6 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -40,7 +40,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_debugfs.c b/drivers/gpu/drm/omapdrm/omap_debugfs.c
index 9edc1b3f9f95..1c40c489ed72 100644
--- a/drivers/gpu/drm/omapdrm/omap_debugfs.c
+++ b/drivers/gpu/drm/omapdrm/omap_debugfs.c
@@ -6,10 +6,10 @@
 
 #include <linux/seq_file.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_file.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 4881777642d2..e1dcc3cb7c55 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -7,9 +7,9 @@
 #include <linux/fb.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_file.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 9523240110a6..fdbdcefa84e7 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -33,11 +33,11 @@
 #include <linux/vga_switcheroo.h>
 #include <linux/vgaarb.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_cache.h>
 #include <drm/drm_client_event.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_device.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_probe_helper.h>
diff --git a/drivers/gpu/drm/radeon/radeon_fbdev.c b/drivers/gpu/drm/radeon/radeon_fbdev.c
index 3e243f5e2f44..e40c23d9dff2 100644
--- a/drivers/gpu/drm/radeon/radeon_fbdev.c
+++ b/drivers/gpu/drm/radeon/radeon_fbdev.c
@@ -29,9 +29,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 9a1dc9f12072..b55113a7a00b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -8,9 +8,9 @@
 #include <linux/iommu.h>
 #include <linux/vmalloc.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm.h>
 #include <drm/drm_dumb_buffers.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_prime.h>
diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
index fc3ba5e8600f..5e60c4685671 100644
--- a/drivers/gpu/drm/sitronix/st7571.c
+++ b/drivers/gpu/drm/sitronix/st7571.c
@@ -20,7 +20,6 @@
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index 003e80cf7b9a..64c2e64f219b 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -11,9 +11,9 @@
 #include <linux/fb.h>
 #include <linux/vmalloc.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index bb3f7f0ad7c4..7c34299fa531 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -13,11 +13,11 @@
 #include <linux/iosys-map.h>
 #include <linux/export.h>
 
+#include <drm/clients/drm_fbdev_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
diff --git a/include/drm/drm_fb_helper.h b/include/drm/clients/drm_fbdev_helper.h
similarity index 99%
rename from include/drm/drm_fb_helper.h
rename to include/drm/clients/drm_fbdev_helper.h
index 0c5e5ed7b5e7..7575aaf34c62 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/clients/drm_fbdev_helper.h
@@ -27,8 +27,8 @@
  *      Dave Airlie <airlied@linux.ie>
  *      Jesse Barnes <jesse.barnes@intel.com>
  */
-#ifndef DRM_FB_HELPER_H
-#define DRM_FB_HELPER_H
+#ifndef DRM_FBDEV_HELPER_H
+#define DRM_FBDEV_HELPER_H
 
 struct drm_clip_rect;
 struct drm_fb_helper;
-- 
2.55.0

