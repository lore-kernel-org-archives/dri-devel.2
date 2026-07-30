Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11D8C5516F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6478910F00F;
	Thu, 30 Jul 2026 17:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AgW0qMoZ";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EEB10EFC5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:38:35 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so5944685e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785433114; x=1786037914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZhJ9dDn9StjcE3/O6+7fc/4cLeTc6otyvNEaonuGzpk=;
 b=AgW0qMoZMYmaqbov1W6aWp3hsCX6yW+D3iS0zrA/8UplCk96/xPbXYpG74wKKXkSDF
 HGZx4/VkGQSR/Ttnh2GsUeSzEzSarfW3wMOldzonzvYAlmFxrNixvNkKYjFDfzwZZ3XR
 pYTSBvxv6PgDBA7SxGHS7InJjcc+NkLZcRvsnxVxO3RZ+d42AHS57V2kFreRiQYfG9PM
 ZDNlTYoB0CwIQJXbCaUajzlycSKGWArpP2JbaQ+5QPctOpe5UG0f7d7JyInkmhnihVVB
 bqNUTCWN0DMA9dE+vuL3KIl6ZFYLM4vlGONEMU9I5GBTwcgKkd14tXgQFEvhIr+pyMJG
 ZRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785433114; x=1786037914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZhJ9dDn9StjcE3/O6+7fc/4cLeTc6otyvNEaonuGzpk=;
 b=dxVPmMiNzmxGJVn+L7kxJPOgp/Eiu09dDWrh6CW0Do4fV9SqmOg3jTNleS0NJi5dv1
 SvcvUqB6qpbaB0IdGd1VR6CoMIFwExFoTQB4rGHwezYsHLO5337e3rLM74dfBwuD0qO1
 VsZwlbwSts0saxZrEp3mgXfvfQ26+cKeIrtfhTJhf/6Tt81b+jjDmM/OA3tQRTt7yO97
 lBJpDw4ieO4zS1axEjmcmNk9nMEdgKDoS+sGhVh00URLm8L4VFsL6zaO9geJmPG0OKJ2
 1VJ9U6N14zZGdshhHXsLFgw8No2zKJSgHn2NpU2j3Vwv48AuL5hYSkVKVkGemD4nPxj4
 pWjA==
X-Gm-Message-State: AOJu0YyU2cFSB3g5dx/og7nhltlXpLStyvXlXR8uuvliYwRTUh1L2RUn
 CwElRsvGkqEKMq8CdjFnGxRoqT6IJv21OSMeaJtomQGZz/5xp6HKLlGyJnCscYBpX+Q=
X-Gm-Gg: AR+sD1243r31qLr49+uI7F793B5JgOmSp10iXRUMZ4XVgTZC2Nvza+5uvpctybC/ZEo
 GMdvig00JuQ3ZejlpYkMw+CS6SXQsUiO/MrPkL4t9eMWntZ4DZZ+NzoDwnjaR07UKSlkqIfRrF9
 GGsCexIxT/4UGBMNQgAR9PJ6wpTNqzWGTcAIFtIWH1c9XtTTZGeiHOYH1XlL0iiVGuI7tFuZEU3
 uKjyVhj1GjLeOVEGwDwyEcCzyk2zjiAaPrujdJpH2MI+1+ods8CyXOHKAR7m3Avx2qrED8uK1jk
 pI9JJsh7RLpDUH9KwZ0F17YAcgaYVD/dgiEFMXLR5sQkxR5vbQCCOxaDm37ryAXj/QwjIyzOhRR
 AgP2EITQjfIOme9MwL2W+bPvCC3t5MLRjCRPqMRr9hmHMunnxLbVREdHhcCOmgQ0Fhm92BM1YT/
 5UXZhtB7JHJQ+TGDT7yJ0I1B/NF66/jEYJrSDg0oXI07WIlVmZnBN/UsJJsS7vcqf9kLTWU0s+g
 sGyiroeuHFMN7Na6oTNLPkb4gNZrb+5+B7WXCW0dxbFrNlBY5pclscFr0mePQvDI6cD7aG8kdFQ
 tEflJ/9YDB8a7vuPSVkUF31Iu0U=
X-Received: by 2002:a05:600c:35d0:b0:495:4f84:7280 with SMTP id
 5b1f17b1804b1-49804ce5284mr17433565e9.4.1785433113357; 
 Thu, 30 Jul 2026 10:38:33 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f0ecd4sm71603455e9.1.2026.07.30.10.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:38:32 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v2 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
Date: Thu, 30 Jul 2026 19:36:42 +0200
Message-ID: <20260730173643.256052-3-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730173643.256052-1-kieweg.leander@gmail.com>
References: <20260730173643.256052-1-kieweg.leander@gmail.com>
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

Introduce the core DRM/KMS driver for GlandaGPU. This driver
supports basic modesetting, atomic updates via shadow plane helpers,
and optional QEMU PCI probing alongside the platform driver.

Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
---
 MAINTAINERS                      |   6 +
 drivers/gpu/drm/tiny/Kconfig     |  11 +
 drivers/gpu/drm/tiny/Makefile    |   1 +
 drivers/gpu/drm/tiny/glandagpu.c | 579 +++++++++++++++++++++++++++++++
 4 files changed, 597 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dea93a41..8bb0513eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8076,6 +8076,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/gud/
 F:	include/drm/gud.h
 
+DRM DRIVER FOR GLANDAGPU
+M:	Leander Kieweg <kieweg.leander@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/glanda,gpu.yaml
+F:	drivers/gpu/drm/tiny/glandagpu.c
+
 DRM DRIVER FOR GRAIN MEDIA GM12U320 PROJECTORS
 M:	Hans de Goede <hansg@kernel.org>
 S:	Maintained
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f0e72d4b6..f5aaf499e 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -56,6 +56,17 @@ config DRM_CIRRUS_QEMU
 	   - qxl (DRM_QXL, qemu -vga qxl, works best with spice)
 	   - virtio (DRM_VIRTIO_GPU), qemu -vga virtio)
 
+config DRM_GLANDA
+	tristate "GlandaGPU DRM driver"
+	depends on DRM
+	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	help
+	  DRM/KMS driver for the GlandaGPU display controller
+	  (FPGA soft IP). This driver supports basic modesetting,
+	  dumb buffers, and atomic updates via shadow planes.
+	  It also provides PCI probing for QEMU testing.
+
 config DRM_GM12U320
 	tristate "GM12U320 driver for USB projectors"
 	depends on DRM && USB && MMU
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index 48d30bf61..b4fa1554a 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_APPLETBDRM)		+= appletbdrm.o
 obj-$(CONFIG_DRM_ARCPGU)		+= arcpgu.o
 obj-$(CONFIG_DRM_BOCHS)			+= bochs.o
 obj-$(CONFIG_DRM_CIRRUS_QEMU)		+= cirrus-qemu.o
+obj-$(CONFIG_DRM_GLANDA) 			+= glandagpu.o
 obj-$(CONFIG_DRM_GM12U320)		+= gm12u320.o
 obj-$(CONFIG_DRM_PANEL_MIPI_DBI)	+= panel-mipi-dbi.o
 obj-$(CONFIG_DRM_PIXPAPER)              += pixpaper.o
diff --git a/drivers/gpu/drm/tiny/glandagpu.c b/drivers/gpu/drm/tiny/glandagpu.c
new file mode 100644
index 000000000..e4dfddaba
--- /dev/null
+++ b/drivers/gpu/drm/tiny/glandagpu.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/delay.h>	/* udelay (polling) */
+#include <linux/of.h>
+#include <linux/slab.h>		/* GFP_KERNEL */
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/uaccess.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/iosys-map.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_vblank.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_print.h>
+
+/* Hardware Constants */
+#define GLANDA_WIDTH      640
+#define GLANDA_HEIGHT     480
+#define GLANDA_VRAM_SIZE  (GLANDA_WIDTH * GLANDA_HEIGHT * 4)
+#define GLANDA_MMIO_SIZE  32
+#define GLANDA_MMIO_OFFSET 0x00200000
+
+/* QEMU test device ID, from the range reserved for experimental use (docs/specs/pci-ids.rst). */
+#define PCI_DEVICE_ID_GLANDA_GPU 0x10f0
+
+/* Register Offsets */
+#define REG_STATUS  0x00
+#define REG_CTRL    0x04
+#define REG_COORD0  0x08
+#define REG_COORD1  0x0C
+#define REG_COLOR   0x10
+#define REG_ISR     0x14
+#define REG_IER     0x18
+
+/* Bit Masks */
+#define INT_DONE    BIT(0)
+#define INT_VSYNC   BIT(1)
+
+#define STATUS_BUSY BIT(0)
+#define CMD_CLEAR   (0x1)
+#define CMD_RECT    (0x2)
+#define CMD_LINE    (0x3)
+#define CTRL_START  BIT(4)
+
+struct glanda_device {
+	struct drm_device drm;
+
+	/* hw */
+	void __iomem *mmio_base;
+	void __iomem *vram_base;
+	phys_addr_t vram_phys;
+
+	int irq;
+
+	/* drm */
+	struct drm_plane primary_plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+};
+
+#define to_glanda(dev) container_of(dev, struct glanda_device, drm)
+
+static const u32 glanda_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static void glanda_plane_atomic_update(struct drm_plane *plane,
+				       struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_state = to_drm_shadow_plane_state(new_state);
+	struct drm_framebuffer *fb = new_state->fb;
+	struct glanda_device *gdev = to_glanda(plane->dev);
+	u32 src_pitch, width, height, x, y;
+	int idx;
+
+	if (!fb)
+		return;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
+
+	src_pitch = fb->pitches[0];
+	width = min_t(u32, fb->width, GLANDA_WIDTH);
+	height = min_t(u32, fb->height, GLANDA_HEIGHT);
+
+	for (y = 0; y < height; y++) {
+		size_t offset = y * GLANDA_WIDTH * sizeof(u32);
+		u32 __iomem *dst = (u32 __iomem *)(gdev->vram_base + offset);
+
+		for (x = 0; x < width; x++) {
+			u32 pixel = iosys_map_rd(&shadow_state->data[0],
+						 y * src_pitch + x * sizeof(u32), u32);
+			u32 packed = ((pixel >> 12) & 0x0F00) |
+				((pixel >> 8) & 0x00F0) |
+				((pixel >> 4) & 0x000F);
+
+			writel_relaxed(packed, &dst[x]);
+		}
+	}
+
+	drm_dev_exit(idx);
+}
+
+static int glanda_plane_atomic_check(struct drm_plane *plane,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *crtc_state;
+
+	if (!new_plane_state->crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+
+	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
+		DRM_PLANE_NO_SCALING, DRM_PLANE_NO_SCALING,
+		false,	/* can_position */
+		false	/* can_update_disabled */);
+}
+
+static const struct drm_plane_helper_funcs glanda_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_update = glanda_plane_atomic_update,
+	.atomic_check = glanda_plane_atomic_check,
+};
+
+static const struct drm_plane_funcs glanda_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int glanda_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_create(connector->dev);
+	if (!mode) {
+		dev_err(connector->dev->dev, "GlandaGPU: failed to create display mode\n");
+		return 0;
+	}
+
+	/* Standard VGA timing: 640x480 @ 60 Hz. */
+	mode->hdisplay = 640;
+	mode->hsync_start = 656;
+	mode->hsync_end = 752;
+	mode->htotal = 800;
+
+	mode->vdisplay = 480;
+	mode->vsync_start = 490;
+	mode->vsync_end = 492;
+	mode->vtotal = 525;
+
+	mode->clock = 25175;	/* 25.175 MHz pixel clock */
+
+	mode->flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static enum drm_connector_status glanda_connector_detect(struct drm_connector
+							 *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static int glanda_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct glanda_device *gdev = to_glanda(crtc->dev);
+	u32 ier;
+
+	ier = readl(gdev->mmio_base + REG_IER);
+	writel(ier | INT_VSYNC, gdev->mmio_base + REG_IER);
+
+	return 0;
+}
+
+static void glanda_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct glanda_device *gdev = to_glanda(crtc->dev);
+	u32 ier = readl(gdev->mmio_base + REG_IER);
+
+	writel(ier & ~INT_VSYNC, gdev->mmio_base + REG_IER);
+}
+
+static void glanda_crtc_atomic_enable(struct drm_crtc *crtc,
+				      struct drm_atomic_commit *state)
+{
+	drm_crtc_vblank_on(crtc);
+}
+
+static void glanda_crtc_atomic_disable(struct drm_crtc *crtc,
+				       struct drm_atomic_commit *state)
+{
+	drm_crtc_vblank_off(crtc);
+}
+
+static void glanda_crtc_atomic_flush(struct drm_crtc *crtc,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_pending_vblank_event *event;
+
+	if (new_state->event) {
+		event = new_state->event;
+
+		new_state->event = NULL;
+
+		spin_lock_irq(&crtc->dev->event_lock);
+
+		if (drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
+}
+
+static const struct drm_crtc_funcs glanda_crtc_funcs = {
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank = glanda_crtc_enable_vblank,
+	.disable_vblank = glanda_crtc_disable_vblank,
+};
+
+static const struct drm_crtc_helper_funcs glanda_crtc_helper_funcs = {
+	.atomic_enable = glanda_crtc_atomic_enable,
+	.atomic_disable = glanda_crtc_atomic_disable,
+	.atomic_flush = glanda_crtc_atomic_flush,
+};
+
+static const struct drm_connector_helper_funcs glanda_connector_helper_funcs = {
+	.get_modes = glanda_connector_get_modes,
+};
+
+static const struct drm_encoder_funcs glanda_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct drm_connector_funcs glanda_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.detect = glanda_connector_detect,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const struct drm_mode_config_funcs glanda_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+DEFINE_DRM_GEM_FOPS(glanda_drm_fops);
+
+static const struct drm_driver glanda_drm_driver = {
+	.driver_features =
+	    DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.name = "glandagpu",
+	.desc = "GlandaGPU Hardware Accelerated DRM Driver",
+	.major = 1,
+	.minor = 0,
+	.fops = &glanda_drm_fops,
+	.dumb_create = drm_gem_shmem_dumb_create,
+};
+
+static irqreturn_t glanda_irq_handler(int irq, void *dev_id)
+{
+	struct glanda_device *gdev = dev_id;
+	u32 isr, ier;
+
+	if (!gdev || !gdev->mmio_base)
+		return IRQ_NONE;
+
+	isr = readl(gdev->mmio_base + REG_ISR);
+	ier = readl(gdev->mmio_base + REG_IER);
+
+	if (!(isr & ier))
+		return IRQ_NONE;
+
+	if (isr & INT_VSYNC)
+		drm_crtc_handle_vblank(&gdev->crtc);
+
+	/* Clear interrupt(W1C) */
+	writel(isr, gdev->mmio_base + REG_ISR);
+	return IRQ_HANDLED;
+}
+
+/* Common DRM setup once MMIO/VRAM/IRQ are known(used by both probe paths) */
+static int glanda_drm_init(struct glanda_device *gdev, int irq)
+{
+	int ret;
+
+	gdev->irq = -1;
+
+	writel(0, gdev->mmio_base + REG_IER);
+	writel(0xFFFFFFFF, gdev->mmio_base + REG_ISR);	/* clear flags */
+
+	/* DRM mode config */
+	drm_mode_config_init(&gdev->drm);
+	gdev->drm.mode_config.min_width = 640;
+	gdev->drm.mode_config.min_height = 480;
+	gdev->drm.mode_config.max_width = 640;
+	gdev->drm.mode_config.max_height = 480;
+	gdev->drm.mode_config.funcs = &glanda_mode_config_funcs;
+
+	ret = drm_universal_plane_init(&gdev->drm, &gdev->primary_plane, 1 << 0,
+				       &glanda_plane_funcs,
+				       glanda_plane_formats,
+				       ARRAY_SIZE(glanda_plane_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret) {
+		drm_err(&gdev->drm, "Failed to initialize primary plane\n");
+		return ret;
+	}
+	drm_plane_helper_add(&gdev->primary_plane, &glanda_plane_helper_funcs);
+
+	/* VBlank init */
+	ret = drm_vblank_init(&gdev->drm, 1);
+	if (ret) {
+		drm_err(&gdev->drm, "Failed to initialize vblank\n");
+		return ret;
+	}
+
+	/* CRTC init */
+	ret = drm_crtc_init_with_planes(&gdev->drm, &gdev->crtc,
+					&gdev->primary_plane, NULL,
+					&glanda_crtc_funcs, NULL);
+	if (ret) {
+		drm_err(&gdev->drm, "Failed to initialize CRTC with planes\n");
+		return ret;
+	}
+	drm_crtc_helper_add(&gdev->crtc, &glanda_crtc_helper_funcs);
+
+	ret = drm_encoder_init(&gdev->drm, &gdev->encoder, &glanda_encoder_funcs,
+			       DRM_MODE_ENCODER_DAC, NULL);
+	if (ret) {
+		drm_err(&gdev->drm, "Failed to initialize encoder\n");
+		return ret;
+	}
+	gdev->encoder.possible_crtcs = 1;
+
+	ret = drm_connector_init(&gdev->drm, &gdev->connector,
+				 &glanda_connector_funcs, DRM_MODE_CONNECTOR_VGA);
+	if (ret) {
+		drm_err(&gdev->drm, "Failed to initialize connector\n");
+		return ret;
+	}
+	drm_connector_helper_add(&gdev->connector, &glanda_connector_helper_funcs);
+
+	drm_connector_attach_encoder(&gdev->connector, &gdev->encoder);
+
+	/* Populate connector state early so userspace can enumerate modes. */
+	mutex_lock(&gdev->drm.mode_config.mutex);
+	drm_helper_probe_single_connector_modes(&gdev->connector, 1024, 768);
+	mutex_unlock(&gdev->drm.mode_config.mutex);
+
+	drm_mode_config_reset(&gdev->drm);
+
+	if (irq > 0) {
+		gdev->irq = irq;
+		ret = devm_request_irq(gdev->drm.dev, gdev->irq, glanda_irq_handler,
+				       IRQF_SHARED, "glandagpu", gdev);
+		if (ret) {
+			drm_err(&gdev->drm, "Failed to request IRQ %d\n",
+				gdev->irq);
+			return ret;
+		}
+
+		writel(INT_DONE, gdev->mmio_base + REG_IER);
+		drm_info(&gdev->drm, "IRQ %d requested and enabled\n", gdev->irq);
+	} else {
+		drm_warn(&gdev->drm, "No IRQ found, falling back to polling\n");
+	}
+
+	ret = drm_dev_register(&gdev->drm, 0);
+	if (ret)
+		return ret;
+
+	drm_info(&gdev->drm, "GlandaGPU DRM Initialized (/dev/dri/cardX created)\n");
+	return 0;
+}
+
+/* Shared teardown, mirrors glanda_drm_init() */
+static void glanda_drm_fini(struct glanda_device *gdev)
+{
+	drm_dev_unplug(&gdev->drm);
+	drm_atomic_helper_shutdown(&gdev->drm);
+
+	/* Disable interrupts */
+	writel(0, gdev->mmio_base + REG_IER);
+
+	drm_info(&gdev->drm, "GlandaGPU DRM Driver removed\n");
+}
+
+static int glandagpu_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct glanda_device *gdev;
+	int irq;
+
+	dev_info(&pdev->dev, "GlandaGPU Probe started\n");
+
+	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
+	if (IS_ERR(gdev))
+		return PTR_ERR(gdev);
+
+	platform_set_drvdata(pdev, gdev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	gdev->vram_phys = res->start;
+	gdev->vram_base = devm_ioremap(&pdev->dev, res->start, GLANDA_VRAM_SIZE);
+	gdev->mmio_base = devm_ioremap(&pdev->dev, res->start + GLANDA_MMIO_OFFSET,
+				       GLANDA_MMIO_SIZE);
+	if (!gdev->vram_base || !gdev->mmio_base) {
+		drm_err(&gdev->drm, "failed to ioremap\n");
+		return -ENOMEM;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq == -ENXIO)
+		irq = -1;	/* no IRQ resource, fall back to polling */
+	else if (irq < 0)
+		return irq;
+
+	return glanda_drm_init(gdev, irq);
+}
+
+static void glandagpu_remove(struct platform_device *pdev)
+{
+	glanda_drm_fini(platform_get_drvdata(pdev));
+}
+
+/* Device Tree match table. */
+static const struct of_device_id glanda_of_match[] = {
+	{ .compatible = "glanda,gpu-1.0" },
+	{ /* end of table */  }
+};
+
+MODULE_DEVICE_TABLE(of, glanda_of_match);
+
+static struct platform_driver glandagpu_driver = {
+	.driver = {
+		.name = "glandagpu",
+	   .of_match_table = glanda_of_match,
+	},
+	.probe = glandagpu_probe,
+	.remove = glandagpu_remove,
+};
+
+/* PCI probe path for the QEMU test device, real hardware uses platform_driver */
+static int glandagpu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct glanda_device *gdev;
+	int ret;
+
+	dev_info(&pdev->dev, "GlandaGPU PCI Probe started\n");
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+	pci_set_master(pdev);
+
+	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(1), "glandagpu");
+	if (ret)
+		return ret;
+
+	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
+	if (IS_ERR(gdev))
+		return PTR_ERR(gdev);
+
+	pci_set_drvdata(pdev, gdev);
+
+	gdev->mmio_base = pcim_iomap_table(pdev)[0];
+	gdev->vram_base = pcim_iomap_table(pdev)[1];
+	gdev->vram_phys = pci_resource_start(pdev, 1);
+
+	return glanda_drm_init(gdev, pdev->irq);
+}
+
+static void glandagpu_pci_remove(struct pci_dev *pdev)
+{
+	glanda_drm_fini(pci_get_drvdata(pdev));
+}
+
+static const struct pci_device_id glanda_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_DEVICE_ID_GLANDA_GPU) },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(pci, glanda_pci_ids);
+
+static struct pci_driver glandagpu_pci_driver = {
+	.name = "glandagpu-pci",
+	.id_table = glanda_pci_ids,
+	.probe = glandagpu_pci_probe,
+	.remove = glandagpu_pci_remove,
+};
+
+static int __init glandagpu_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&glandagpu_driver);
+	if (ret) {
+		pr_err("GlandaGPU: Failed to register platform driver\n");
+		return ret;
+	}
+
+	ret = pci_register_driver(&glandagpu_pci_driver);
+	if (ret) {
+		pr_err("GlandaGPU: Failed to register PCI driver\n");
+		platform_driver_unregister(&glandagpu_driver);
+		return ret;
+	}
+
+	pr_info("GlandaGPU: Module loaded successfully\n");
+	return 0;
+}
+
+static void __exit glandagpu_exit(void)
+{
+	pci_unregister_driver(&glandagpu_pci_driver);
+	platform_driver_unregister(&glandagpu_driver);
+	pr_info("GlandaGPU: Module unloaded\n");
+}
+
+module_init(glandagpu_init);
+module_exit(glandagpu_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Leander Kieweg <kieweg.leander@gmail.com>");
+MODULE_DESCRIPTION("DRM driver for GlandaGPU, an FPGA-based 2D GPU with VGA output");
-- 
2.43.0

