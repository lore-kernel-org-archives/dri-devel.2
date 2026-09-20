Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FF5C982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 19:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BBB10E1FE;
	Sun, 20 Sep 2026 19:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+iteOR/";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4768310E1FA
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:39:55 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso2095343f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789933193; x=1790537993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mHCtwcksOyerky3/ku1+b4FGw0vHXSG1M6MLEq+Vmmo=;
 b=P+iteOR/vBcKbe/MQmIUhza5cq2rg5e8OOTTgb9nPjjQs882KBNqPXwiE/wfxg5lkh
 qcLiS6M45Cl4fcF/f9OqBEZMXAL4GNze343UefVr57EJe3k6xDq9zyOgqM30JFOuZJCj
 pZQLUI18vDqV2JR6nNrGB6VB2+J5YOZW6bTNxEVBnwDZL1oZP5CSBvIREpsbgmM4GUSL
 TNR4teM4hKTjBRUFtnIYs8wNt+SGR7eE52EMIUqneP1hqnSF6lrS+Ek0PxFyPrUVSn/b
 FX5Q/6DLd6HbG571G6wZat4e/1ZfQw/1xTZPaQfff1lMs1ty9uycafv7KRgsJOeRZ4sB
 Iylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789933193; x=1790537993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mHCtwcksOyerky3/ku1+b4FGw0vHXSG1M6MLEq+Vmmo=;
 b=l8CUWW8dxRR/Wtn5dEOQ+wUSvhW5Eptl0CwNFpF2I9wiTFcn5FgDcam643o8rRpwFg
 BEm3jUE5nBAB6gZ3MsRvKTplDl9A4WAWm0YYnFrEN1ph6GVfa29FdI+SyDLM+C/4I+Ce
 YfDMq+2shQhKM02qsC+6L4KcT5Bo/VLPEA6sXxZsoUxyIDedtU2N9X0VPRSy9dGInj5R
 RtsInivMouGqs15danXNQ8pD7Ka4xQP8L6170bRbeym6Ty02CGSgUyorC+/Ex/w8sLw8
 PIW3DtsuAENnZ1w4wa29NzO1TCp/nWpXuWCpuk/CJ7ZS4RxNGpz9FWbZy0jwVDdBVXgi
 500Q==
X-Gm-Message-State: AFuF++liQM9e4fXQGdCi7WjDbHRKxfwpp/mZXUJDYornc3dePfH9hfs/
 88fe9MpbThuf19ZttOF/f3rxPl991aGQ1goZAnlTqnzNHxPEnD30zFkndOLSDj41
X-Gm-Gg: AYBFou3qravM7b6A5ddGKihdEA5GMD/h4Awc2JYCEaX+UJVIrtzHmETEK3V3wlLVEnv
 bMEIR+xdSj9OY91FmMfnjIwS/XWqd5MDxw6nbCaS0Y7V0AYHncGvHLrohIxCDL593wnfgAlmHlG
 +JscbaK1XQ9JrUbYKRHzGM9R9rC24X1w3Nsp/PsmBYWSdsPCU40BJv8MVF56IMrTo2HIUVjMMwZ
 /t/rLHIkvC99+3IRKOYKs/qKw/SDbuLD7zFAuTU1iVHyDk85jP/Mtptk8v3uvkBKSJ4fpqZxKPM
 9xacqwQhZMLI6tG1hs/mGFtXIvXh5X1DgY7Uu/f894i4nUeHaGfjUsQc0J7FK3x4jTQFLM7IAB9
 QLNkHPZjS5PRTADPEETd+hLAKfbqKEHq0WwffhQAJ4VfcIJ5uddHV4oS0q01Ila0hFiMAeSxd1x
 aZTEw/8R6zEhvOjTSW0dYUhKIqi9YOfBOd7lfvDFOPG+OxDFPgWDiiayDUo20rHO7rXAmb2S09A
 uRpzaNhSi+RhlNkEic4DhNpy6l8FnkGFLbV9qr1HrA4O7hYehqNo+5zSrDgAweGThMa5e0aYMut
 MdMz592FSYYx6xSPhhUIwGZmTXBnNAgWCsDI
X-Received: by 2002:a05:600c:3ba4:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49fc57414c4mr152384825e9.27.1789933193502; 
 Sun, 20 Sep 2026 12:39:53 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc56aab7csm168250455e9.1.2026.09.20.12.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 12:39:52 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v5 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
Date: Sun, 20 Sep 2026 21:39:44 +0200
Message-ID: <20260920193944.110983-3-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920193944.110983-1-kieweg.leander@gmail.com>
References: <20260920193944.110983-1-kieweg.leander@gmail.com>
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
 drivers/gpu/drm/tiny/glandagpu.c | 655 +++++++++++++++++++++++++++++++
 4 files changed, 673 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dea93a41..c16d1ed70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8076,6 +8076,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/gud/
 F:	include/drm/gud.h
 
+DRM DRIVER FOR GLANDAGPU
+M:	Leander Kieweg <kieweg.leander@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/kieweg,gpu.yaml
+F:	drivers/gpu/drm/tiny/glandagpu.c
+
 DRM DRIVER FOR GRAIN MEDIA GM12U320 PROJECTORS
 M:	Hans de Goede <hansg@kernel.org>
 S:	Maintained
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f0e72d4b6..267b3103d 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -56,6 +56,17 @@ config DRM_CIRRUS_QEMU
 	   - qxl (DRM_QXL, qemu -vga qxl, works best with spice)
 	   - virtio (DRM_VIRTIO_GPU), qemu -vga virtio)
 
+config DRM_GLANDA
+	tristate "GlandaGPU DRM driver"
+	depends on DRM && MMU && (PCI || COMPILE_TEST)
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
index 000000000..38fa5809f
--- /dev/null
+++ b/drivers/gpu/drm/tiny/glandagpu.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/slab.h>		/* GFP_KERNEL */
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
+#include <drm/drm_vblank_helper.h>
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
+#define to_glanda(dev) container_of_const(dev, struct glanda_device, drm)
+
+static const u32 glanda_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static void glanda_blit_rect(struct glanda_device *gdev,
+			     const struct drm_rect *dst_clip,
+			     const struct iosys_map *src,
+			     struct drm_framebuffer *fb,
+			     int dst_off_x, int dst_off_y,
+				 struct drm_format_conv_state *fmtcnv_state)
+{
+	unsigned int src_pitch = fb->pitches[0];
+	unsigned int width = drm_rect_width(dst_clip);
+	unsigned int height = drm_rect_height(dst_clip);
+	unsigned int x, y;
+	size_t len = width * sizeof(u32);
+	u32 *sbuf;
+
+	sbuf = drm_format_conv_state_reserve(fmtcnv_state, len, GFP_KERNEL);
+	if (!sbuf)
+		return;
+
+	for (y = 0; y < height; y++) {
+		unsigned int dst_y = dst_clip->y1 + y;
+		unsigned int src_y = dst_y - dst_off_y;
+		u32 __iomem *dst = (u32 __iomem *)gdev->vram_base +
+				   (size_t)dst_y * GLANDA_WIDTH + dst_clip->x1;
+		size_t src_off = (size_t)src_y * src_pitch +
+				 (size_t)(dst_clip->x1 - dst_off_x) * sizeof(u32);
+
+		iosys_map_memcpy_from(sbuf, src, src_off, len);
+
+		for (x = 0; x < width; x++) {
+			u32 pixel = le32_to_cpu((__force __le32)sbuf[x]);
+			u32 packed = ((pixel >> 12) & 0x0F00) |
+				((pixel >> 8) & 0x00F0) |
+				((pixel >> 4) & 0x000F);
+
+			writel_relaxed(packed, &dst[x]);
+		}
+	}
+}
+
+static void glanda_plane_atomic_update(struct drm_plane *plane,
+				       struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_state = to_drm_shadow_plane_state(new_state);
+	struct drm_rect vram_clip = DRM_RECT_INIT(0, 0, GLANDA_WIDTH, GLANDA_HEIGHT);
+	struct glanda_device *gdev = to_glanda(plane->dev);
+	struct drm_framebuffer *fb = new_state->fb;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect damage;
+	int dst_off_x, dst_off_y;
+	int ret, idx;
+
+	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
+	if (ret)
+		return;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		goto out_drm_gem_fb_end_cpu_access;
+
+	dst_off_x = new_state->dst.x1 - (new_state->src.x1 >> 16);
+	dst_off_y = new_state->dst.y1 - (new_state->src.y1 >> 16);
+
+	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		struct drm_rect dst_clip = new_state->dst;
+
+		drm_rect_translate(&damage, dst_off_x, dst_off_y);
+
+		if (!drm_rect_intersect(&dst_clip, &damage))
+			continue;
+		if (!drm_rect_intersect(&dst_clip, &vram_clip))
+			continue;
+
+		glanda_blit_rect(gdev, &dst_clip, &shadow_state->data[0], fb,
+				 dst_off_x, dst_off_y, &shadow_state->fmtcnv_state);
+	}
+
+	drm_dev_exit(idx);
+out_drm_gem_fb_end_cpu_access:
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+}
+
+static void glanda_plane_atomic_disable(struct drm_plane *plane,
+					struct drm_atomic_commit *state)
+{
+	struct drm_device *dev = plane->dev;
+	struct glanda_device *gdev = to_glanda(dev);
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
+
+	memset_io(gdev->vram_base, 0, GLANDA_WIDTH * sizeof(u32) * GLANDA_HEIGHT);
+	drm_dev_exit(idx);
+}
+
+static int glanda_plane_atomic_check(struct drm_plane *plane,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state = NULL;
+	int ret;
+
+	if (new_plane_state->crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						  DRM_PLANE_NO_SCALING, DRM_PLANE_NO_SCALING,
+		false,	/* can_position */
+		false); /* can_update_disabled */
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct drm_plane_helper_funcs glanda_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_update = glanda_plane_atomic_update,
+	.atomic_check = glanda_plane_atomic_check,
+	.atomic_disable = glanda_plane_atomic_disable,
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
+static int glanda_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct glanda_device *gdev = to_glanda(crtc->dev);
+	u32 ier;
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return -ENODEV;
+
+	ier = readl(gdev->mmio_base + REG_IER);
+	writel(ier | INT_VSYNC, gdev->mmio_base + REG_IER);
+
+	drm_dev_exit(idx);
+	return 0;
+}
+
+static void glanda_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct glanda_device *gdev = to_glanda(crtc->dev);
+	u32 ier;
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
+
+	ier = readl(gdev->mmio_base + REG_IER);
+	writel(ier & ~INT_VSYNC, gdev->mmio_base + REG_IER);
+
+	drm_dev_exit(idx);
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
+	.atomic_enable = drm_crtc_vblank_atomic_enable,
+	.atomic_disable = drm_crtc_vblank_atomic_disable,
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
+	.desc = "GlandaGPU DRM Driver",
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
+	if (unlikely(isr == 0xFFFFFFFF))
+		return IRQ_NONE;
+
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
+	writel(0, gdev->mmio_base + REG_IER);
+	writel(0xFFFFFFFF, gdev->mmio_base + REG_ISR);	/* clear flags */
+
+	/* DRM mode config */
+	ret = drmm_mode_config_init(&gdev->drm);
+	if (ret)
+		return ret;
+
+	gdev->drm.mode_config.min_width = 640;
+	gdev->drm.mode_config.min_height = 480;
+	gdev->drm.mode_config.max_width = DRM_SHADOW_PLANE_MAX_WIDTH;
+	gdev->drm.mode_config.max_height = DRM_SHADOW_PLANE_MAX_HEIGHT;
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
+	drm_plane_enable_fb_damage_clips(&gdev->primary_plane);
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
+	/* VBlank init */
+	ret = drm_vblank_init(&gdev->drm, 1);
+	if (ret) {
+		drm_err(&gdev->drm, "Failed to initialize vblank\n");
+		return ret;
+	}
+
+	drm_mode_config_reset(&gdev->drm);
+
+	gdev->irq = irq;
+	ret = devm_request_irq(gdev->drm.dev, gdev->irq, glanda_irq_handler,
+			       IRQF_SHARED, "glandagpu", gdev);
+	if (ret) {
+		drm_err(&gdev->drm, "Failed to request IRQ %d\n",
+			gdev->irq);
+		return ret;
+	}
+
+	ret = drm_dev_register(&gdev->drm, 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Shared teardown, mirrors glanda_drm_init() */
+static void glanda_drm_fini(struct glanda_device *gdev)
+{
+	drm_dev_unplug(&gdev->drm);
+	drm_atomic_helper_shutdown(&gdev->drm);
+}
+
+static int glandagpu_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct glanda_device *gdev;
+	int irq;
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
+	if (resource_size(res) < GLANDA_MMIO_OFFSET + GLANDA_MMIO_SIZE) {
+		dev_err(&pdev->dev, "MMIO region too small: %llu bytes, need at least %u\n",
+			(unsigned long long)resource_size(res),
+			GLANDA_MMIO_OFFSET + GLANDA_MMIO_SIZE);
+		return -EINVAL;
+	}
+
+	gdev->vram_phys = res->start;
+	gdev->vram_base = devm_ioremap_wc(&pdev->dev, res->start, GLANDA_VRAM_SIZE);
+	gdev->mmio_base = devm_ioremap(&pdev->dev, res->start + GLANDA_MMIO_OFFSET,
+				       GLANDA_MMIO_SIZE);
+	if (!gdev->vram_base || !gdev->mmio_base) {
+		drm_err(&gdev->drm, "failed to ioremap\n");
+		return -ENOMEM;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
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
+static void glandagpu_shutdown(struct platform_device *pdev)
+{
+	struct glanda_device *gdev = platform_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(&gdev->drm);
+}
+
+/* Device Tree match table. */
+static const struct of_device_id glanda_of_match[] = {
+	{ .compatible = "kieweg,gpu-1.0" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, glanda_of_match);
+
+static struct platform_driver glandagpu_driver = {
+	.driver = {
+		.name = "glandagpu",
+		.of_match_table = glanda_of_match,
+	},
+	.probe = glandagpu_probe,
+	.remove = glandagpu_remove,
+	.shutdown = glandagpu_shutdown,
+};
+
+/* PCI probe path for the QEMU test device, real hardware uses platform_driver */
+#ifdef CONFIG_PCI
+static int glandagpu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct glanda_device *gdev;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+	pci_set_master(pdev);
+
+	if (pci_resource_len(pdev, 0) < GLANDA_MMIO_SIZE ||
+	    pci_resource_len(pdev, 1) < GLANDA_VRAM_SIZE) {
+		dev_err(&pdev->dev, "BAR too small: BAR0=%llu (need %u), BAR1=%llu (need %u)\n",
+			(unsigned long long)pci_resource_len(pdev, 0), GLANDA_MMIO_SIZE,
+			(unsigned long long)pci_resource_len(pdev, 1), GLANDA_VRAM_SIZE);
+		return -EINVAL;
+	}
+
+	ret = pcim_iomap_regions(pdev, BIT(0), "glandagpu");
+	if (ret)
+		return ret;
+
+	ret = pcim_request_region(pdev, 1, "glandagpu");
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
+	gdev->vram_phys = pci_resource_start(pdev, 1);
+
+	gdev->vram_base = devm_ioremap_wc(&pdev->dev, gdev->vram_phys, GLANDA_VRAM_SIZE);
+	if (!gdev->vram_base)
+		return -ENOMEM;
+
+	return glanda_drm_init(gdev, pdev->irq);
+}
+
+static void glandagpu_pci_remove(struct pci_dev *pdev)
+{
+	glanda_drm_fini(pci_get_drvdata(pdev));
+}
+
+static void glandagpu_pci_shutdown(struct pci_dev *pdev)
+{
+	struct glanda_device *gdev = pci_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(&gdev->drm);
+}
+
+static const struct pci_device_id glanda_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_DEVICE_ID_GLANDA_GPU) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, glanda_pci_ids);
+
+static struct pci_driver glandagpu_pci_driver = {
+	.name = "glandagpu-pci",
+	.id_table = glanda_pci_ids,
+	.probe = glandagpu_pci_probe,
+	.remove = glandagpu_pci_remove,
+	.shutdown = glandagpu_pci_shutdown,
+};
+#endif /* CONFIG_PCI */
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
+#ifdef CONFIG_PCI
+	ret = pci_register_driver(&glandagpu_pci_driver);
+	if (ret) {
+		pr_err("GlandaGPU: Failed to register PCI driver\n");
+		platform_driver_unregister(&glandagpu_driver);
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
+static void __exit glandagpu_exit(void)
+{
+#ifdef CONFIG_PCI
+	pci_unregister_driver(&glandagpu_pci_driver);
+#endif
+	platform_driver_unregister(&glandagpu_driver);
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

