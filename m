Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D0606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZWyUgRO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E676C1121AF;
	Thu, 12 Nov 2026 15:45:42 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0541121CE
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:45:36 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8a06cc097c7so888444b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794498336; x=1795103136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WmSlmJxec5AsTpasaUYC5fG8yCYvrw2rYznsy5OJWm4=;
 b=pZWyUgRO+weid7Bfb63h+P3g+dCy+SMFJ8S1mdd7Eim5iPdnJ5t2GWz239I2IAtzwh
 GJCseO3Y+wvyI/GK8jiWwqHt86XoupZjVOLjeMmyp7KDDpm4A/XVwsPXajqM07JUg3OH
 CCAxTMjLTCp7waVx0Ro8/XXUAGezE3nEoT30gJG9kSGFLVSCVZf8LFdCIimdJwJ0kFNP
 X3/0FwWbDCHbXtwMbfqUi12u/pyQqgM0KDh1u7iqC1xykozCGFWFyPWDeJMjWnzb3Gbu
 Hg+KrpAGW4q15yxkPuB/ruE9Jh3gn06ZFGCw5BaKRryEm7riHxqxjCRwU2OsD9xEORe2
 0xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794498336; x=1795103136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WmSlmJxec5AsTpasaUYC5fG8yCYvrw2rYznsy5OJWm4=;
 b=T68nOkY2ZRbm2kyQLJzunK9OElHYYbTZOlBE+JMVBPelYm4L95nZs2JTEgmgFa41e0
 YbiqbJOzjOFJ9+cXz4HlahtptFuVAe8tWzUDzjDHVWeV0wtYlecsSuTEMY9hSNTq6fZA
 woRB8F2LbmSSbHSthN2XbTn3gfhOrQaofN+raI9U/JkQ2ne8FPNb+TVvPiY/Dbkeiql4
 55Kphk7rsjT60ZcIKrAHfouUpGYGcqh6HgV5OhxNFBxsaqDagSbAJP1VZRznPoim9rbR
 pOj845lO4oJKgBitiJCWYcKf940eOfzUWz3a8hg7fedAv1BFYEVgCB4+hEJumuiUVfXg
 1zEw==
X-Gm-Message-State: APuU4Z/V2u9ZUKrLXDRxYDxNWYoeqoVejg9ny+rzxTqcE83W18+M1T/U
 tPFT6csd+qeTqYKP7tN9Roy45QGH+2K03/Kq0i2/kt0dtuaIANMLL/1SnJYjlkao
X-Gm-Gg: AYBFou0m4DHVmpfc1+FSw2soNA9KrWmfvmm1FHvKBY4LV7QfO2RbBy+/1Vtd98qCjGm
 9o2xqYEks2dUxxXgdh/dEphzUg39F7e1vVy+VTzm+AdhqOEol2BhYSSC2o2oyoT2WXnAEhTOW8v
 8W13rDfckoTwbeL1m4tUBQU4eF/QsM2zdN1eB1yKSb580PpONTu9IQhxfQ6aISgwG+tNSy4Y/o4
 Pf9wPz5rFoLS2sL59ayzfoXUjo1PoHBC32npLOG5pOHIFCnWMoUdCsnDF0cDlmXA/zvVFYc67rM
 Mahrrg1tl3Pmmf/e0ILVId202NOPKSWFdpY4y0ba+9yxdiS3+HK0WmyoZHiZolOt6JA7PKH2nL+
 EXY6qWD9n2JOXP7Kh+X7M11+NpUzCMdSZGn81B0lvg1eXNzHKDkRVebe+gXM8zn9PNsujn//HHb
 mpGQefWeZSDsJUxg43UqYAIQVs4rrg/cOhQ7kZJkiPwMKPZThYPPWXvYEy1GlqKAajnMepDWJqO
 fVKB87gYx/EpuNDZ0iEQVbBs761Iaskq9gEpirSTRGnN1vzZVlV/XXPSDS4rtg/7xEpBM9artlE
 W8qKvMSCXBcL15arvBs0Fl0Til9ZlvrjLzO5XQCBjZ2ZtYcMyj68bgRM7bxLbQ/FirfozU2J+Xu
 2tK3D1uBkc/b0dexClBTPaWE+BhnftTSRKVxDSvS2
X-Received: by 2002:a05:6a00:1911:b0:882:fafe:9874 with SMTP id
 d2e1a72fcca58-8bc1c49957bmr6269736b3a.31.1794498335500; 
 Thu, 12 Nov 2026 07:45:35 -0800 (PST)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:65cc:625f:9c43:1e88])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8baaa2a6c51sm3727361b3a.14.2026.11.12.07.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:45:34 -0800 (PST)
From: Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: cyrozap@gmail.com, Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6] drm/tiny: trigger5: Add MCT Trigger 5 USB display driver
Date: Thu, 12 Nov 2026 23:45:18 +0800
Message-ID: <20261112154520.151617-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ho Jie Feng <hjf3108@gmail.com>

Add a DRM driver for MCT Trigger 5 USB display adapters.
This supports USB 3 to HDMI/VGA displays adapters with
trigger5 chipsets from j5create, StarTech and various others.

The driver implements modesetting and USB framebuffer updates,
connector detection, and EDID retrieval.

The protocol is based on reverse-engineering work by Forest Crossman
(cyrozap) at: https://github.com/cyrozap/mct-usb-display-adapter-re
and usb packet captures between the Windows driver and the device.

Only the HDMI path has been tested. VGA selection is inferred from the
absence of USB audio interfaces.

Tested on JUA355. The list of USB device IDs are taken from the
Windows driver INF.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
Patchwork:
https://patchwork.freedesktop.org/series/176855/

Changes in v6:
- Replace the USB transfer worker and vmalloc frame buffers
  with eight URBs that send the frame in chunks
- Remove keepalive work, it is not needed if it is never sent,
  and disarm any keepalive it already has
- Use container_of_const(), drm_dbg(), and drm_err_once()
- Group plane code and function tables before CRTC code and tables.
- Use the standard NULL-CRTC plane-check pattern and remove redundant
  mode checks, the driver-specific no-EDID fallback, and the INF comment.

Link to v5:
https://lore.kernel.org/dri-devel/20261026112843.69795-1-hjf3108@gmail.com/
Changes in v5:
- Fix warnings found by kernel test robot

Changes in v4:
- Move the driver to drm/tiny
- Remove the buffer resizing to reduce size of file

Changes in v3:
- Flush the vmalloc buffer before submitting the USB transfer.
- Support display panning by using the source offset

Changes in v2:
- Move the buffer resizing to crtc_* functions so that we can report
  out of memory errors to userspace
- Change the PLL search function so that it is faster and doesn't
  produce checkpatch warnings
- Update drm functions: crtc reset becomes create_state
- Fix warnings reported by kernel test robot

sashiko review false positives in v1-4:
- atomic in these function names mean that the changes should go through
  through at once or not at all, nothing to do with atomic context.
  Furthermore other drivers also have similar patterns
- drm_gem_fb_begin_cpu_access is also required

 MAINTAINERS                     |   7 +
 drivers/gpu/drm/tiny/Kconfig    |  14 +
 drivers/gpu/drm/tiny/Makefile   |   1 +
 drivers/gpu/drm/tiny/trigger5.c | 990 ++++++++++++++++++++++++++++++++
 4 files changed, 1012 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/trigger5.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c4f4e4877..132312af4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8453,6 +8453,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
 F:	drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
 
+DRM DRIVER FOR MCT TRIGGER 5 USB DISPLAY ADAPTERS
+M:	Ho Jie Feng <hjf3108@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/tiny/trigger5.c
+
 DRM DRIVER FOR MGA G200 GRAPHICS CHIPS
 M:	Dave Airlie <airlied@redhat.com>
 R:	Thomas Zimmermann <tzimmermann@suse.de>
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 267b3103d..2c0f3e82b 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -109,6 +109,20 @@ config DRM_PIXPAPER
 
 	  If M is selected, the module will be built as pixpaper.ko.
 
+config DRM_TRIGGER5
+	tristate "MCT Trigger 5 USB display adapters"
+	depends on DRM && USB && MMU
+	select DRM_CLIENT_SELECTION
+	select DRM_GEM_SHMEM_HELPER
+	select DRM_KMS_HELPER
+	help
+	  DRM driver for USB display adapters based on the MCT Trigger 5
+	  chipset, including the StarTech USB32VGAES and USB32HDES and the
+	  j5create JUA310 and JUA350.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called trigger5.
+
 config TINYDRM_HX8357D
 	tristate "DRM support for HX8357D display panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index b4fa1554a..61a7159f0 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_GLANDA) 			+= glandagpu.o
 obj-$(CONFIG_DRM_GM12U320)		+= gm12u320.o
 obj-$(CONFIG_DRM_PANEL_MIPI_DBI)	+= panel-mipi-dbi.o
 obj-$(CONFIG_DRM_PIXPAPER)              += pixpaper.o
+obj-$(CONFIG_DRM_TRIGGER5)		+= trigger5.o
 obj-$(CONFIG_TINYDRM_HX8357D)		+= hx8357d.o
 obj-$(CONFIG_TINYDRM_ILI9163)		+= ili9163.o
 obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
diff --git a/drivers/gpu/drm/tiny/trigger5.c b/drivers/gpu/drm/tiny/trigger5.c
new file mode 100644
index 000000000..46fa6e6ba
--- /dev/null
+++ b/drivers/gpu/drm/tiny/trigger5.c
@@ -0,0 +1,990 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/iosys-map.h>
+#include <linux/jiffies.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_rect.h>
+
+#define DRIVER_NAME		"trigger5"
+#define DRIVER_DESC		"MCT Trigger 5 USB display adapter"
+
+#define DRIVER_MAJOR		1
+#define DRIVER_MINOR		0
+
+#define TRIGGER5_NUM_URBS	8
+#define TRIGGER5_URB_BUF_SIZE	SZ_128K
+#define TRIGGER5_MAX_FRAME_SIZE	SZ_8M
+
+struct trigger5_transfer {
+	struct trigger5_device *trigger5;
+	struct urb *urb;
+	struct completion done;
+};
+
+struct trigger5_device {
+	struct drm_device drm;
+	struct usb_interface *intf;
+	unsigned int bulk_pipe;
+
+	struct drm_connector connector;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+
+	u16 frame_counter;
+
+	int next_transfer;
+	struct trigger5_transfer transfers[TRIGGER5_NUM_URBS];
+
+	atomic_t needs_reset;
+};
+
+struct trigger5_pll {
+	u8 prediv;
+	u8 mul1;
+	u8 mul2;
+	u8 div1;
+	u8 div2;
+} __packed;
+
+struct trigger5_mode_request {
+	__be16 height;
+	__be16 width;
+	__be16 line_total_pixels; /* minus one */
+	__be16 line_sync_pulse; /* minus one */
+	__be16 line_back_porch; /* minus one */
+	__be16 unknown1;
+	__be16 unknown2;
+	__be16 width_minus_one;
+	__be16 frame_total_lines; /* minus one */
+	__be16 frame_sync_pulse; /* minus one */
+	__be16 frame_back_porch; /* minus one */
+	__be16 unknown3;
+	__be16 unknown4;
+	__be16 height_minus_one;
+	struct trigger5_pll pll;
+	u8 hsync_polarity;
+	u8 vsync_polarity;
+} __packed;
+
+/* gm12u320.c uses the same header format */
+struct trigger5_bulk_header {
+	u8 magic; /* 0xfb */
+	u8 length; /* 0x14 */
+	__le16 counter; /* lower 12-bit counter, upper 4-bit packet flags */
+	__le16 horizontal_offset; /* lower 13-bit offset, upper 3-bit unknown */
+	__le16 vertical_offset; /* lower 13-bit offset, upper 3-bit unknown */
+	__le16 width; /* lower 13-bit width, upper 3-bit unknown */
+	__le16 height; /* lower 13-bit height, upper 3-bit unknown */
+	__le32 payload_length; /* lower 28-bit length, upper 4-bit flags */
+	u8 flags; /* bit 0 must be set */
+	u8 unknown1;
+	u8 unknown2;
+	u8 checksum;
+} __packed;
+
+#define TRIGGER5_REQUEST_KEEPALIVE		0x91
+#define TRIGGER5_REQUEST_GET_REGISTER		0xA5
+#define TRIGGER5_REQUEST_GET_STATUS		0xA6
+#define TRIGGER5_REQUEST_GET_EDID		0xA8
+#define TRIGGER5_REQUEST_SET_MODE		0xC3
+#define TRIGGER5_REQUEST_SET_REGISTER		0xC4
+#define TRIGGER5_REQUEST_SET_CURSOR_POSITION	0xC8
+#define TRIGGER5_REQUEST_FIRMWARE_RESET		0xD1
+
+#define TRIGGER5_BULK_TIMEOUT_MS		2000
+
+#define to_trigger5(x) container_of_const(x, struct trigger5_device, drm)
+
+static void trigger5_stop_io(struct trigger5_device *trigger5)
+{
+	int i;
+
+	for (i = 0; i < TRIGGER5_NUM_URBS; i++)
+		usb_kill_urb(trigger5->transfers[i].urb);
+}
+
+static int trigger5_usb_suspend(struct usb_interface *interface,
+				pm_message_t message)
+{
+	struct trigger5_device *trigger5 = usb_get_intfdata(interface);
+	int ret;
+
+	ret = drm_mode_config_helper_suspend(&trigger5->drm);
+	if (ret)
+		return ret;
+
+	trigger5_stop_io(trigger5);
+
+	return 0;
+}
+
+static int trigger5_usb_resume(struct usb_interface *interface)
+{
+	struct trigger5_device *trigger5 = usb_get_intfdata(interface);
+
+	return drm_mode_config_helper_resume(&trigger5->drm);
+}
+
+DEFINE_DRM_GEM_FOPS(trigger5_driver_fops);
+
+static const struct drm_driver trigger5_drm_driver = {
+	.driver_features = DRIVER_ATOMIC | DRIVER_GEM | DRIVER_MODESET,
+
+	/* GEM hooks */
+	.fops = &trigger5_driver_fops,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESC,
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+};
+
+static const struct drm_mode_config_funcs trigger5_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static u64 trigger5_calculate_pll(struct trigger5_pll *pll, int clock)
+{
+	u64 ref_clock = 10000000;
+	u64 target_clock = (u64)clock * 1000;
+	u64 calculated_clock, calculated_err, best_err = U64_MAX;
+	int prediv_div2, prediv, mul1, mul2, div1, div2;
+
+	/* Use values found in the capture */
+	for (prediv_div2 = 0x02; prediv_div2 <= 0x100; prediv_div2 <<= 1) {
+		for (mul1 = 1; mul1 <= 0x32; mul1++) {
+			for (mul2 = mul1; mul2 <= 0x32; mul2++) {
+				for (div1 = 1; div1 <= 0x32; div1++) {
+					if (!best_err)
+						break;
+					calculated_clock =
+						div_u64(ref_clock * mul1 * mul2,
+							prediv_div2 * div1);
+					calculated_err =
+						abs_diff(calculated_clock,
+							 target_clock);
+					if (prediv_div2 <= 0x10) {
+						div2 = prediv_div2;
+						prediv = 1;
+					} else {
+						div2 = 0x10;
+						prediv = prediv_div2 >> 4;
+					}
+					if (calculated_err < best_err) {
+						best_err =
+							calculated_err;
+						pll->mul1 = mul1;
+						pll->mul2 = mul2;
+						pll->div1 = div1;
+						pll->div2 = div2;
+						pll->prediv = prediv;
+					}
+				}
+			}
+		}
+	}
+	return best_err;
+}
+
+static void trigger5_reset(struct trigger5_device *trigger5, int err)
+{
+	if (!atomic_xchg(&trigger5->needs_reset, 1))
+		usb_queue_reset_device(trigger5->intf);
+
+	drm_err(&trigger5->drm, "USB transfer failed: %d, resetting adapter\n",
+		err);
+}
+
+static void trigger5_urb_complete(struct urb *urb)
+{
+	struct trigger5_transfer *transfer = urb->context;
+	struct trigger5_device *trigger5 = transfer->trigger5;
+
+	switch (urb->status) {
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+		break;
+	case 0:
+		if (urb->actual_length == urb->transfer_buffer_length)
+			break;
+		fallthrough;
+	default:
+		trigger5_reset(trigger5, urb->status);
+		break;
+	}
+
+	complete(&transfer->done);
+}
+
+static struct trigger5_transfer *
+trigger5_get_next_urb(struct trigger5_device *trigger5)
+{
+	struct trigger5_transfer *transfer =
+		&trigger5->transfers[trigger5->next_transfer];
+
+	if (atomic_read(&trigger5->needs_reset))
+		return ERR_PTR(-EIO);
+
+	if (!wait_for_completion_timeout(&transfer->done,
+					 msecs_to_jiffies(TRIGGER5_BULK_TIMEOUT_MS))) {
+		trigger5_reset(trigger5, -ETIMEDOUT);
+		return ERR_PTR(-ETIMEDOUT);
+	}
+
+	trigger5->next_transfer =
+		(trigger5->next_transfer + 1) % TRIGGER5_NUM_URBS;
+
+	return transfer;
+}
+
+static int trigger5_submit_urb(struct trigger5_transfer *transfer, size_t len)
+{
+	int ret;
+
+	transfer->urb->transfer_buffer_length = len;
+	ret = usb_submit_urb(transfer->urb, GFP_KERNEL);
+	if (ret) {
+		drm_err_once(&transfer->trigger5->drm,
+			     "failed to submit USB transfer: %d\n", ret);
+		complete(&transfer->done);
+	}
+
+	return ret;
+}
+
+static void trigger5_free_urbs(struct trigger5_device *trigger5)
+{
+	int i;
+
+	for (i = 0; i < TRIGGER5_NUM_URBS; i++)
+		usb_free_urb(trigger5->transfers[i].urb);
+}
+
+static int trigger5_alloc_urbs(struct trigger5_device *trigger5)
+{
+	struct usb_device *udev = interface_to_usbdev(trigger5->intf);
+	struct trigger5_transfer *transfer;
+	struct urb *urb;
+	void *buf;
+	int i;
+
+	for (i = 0; i < TRIGGER5_NUM_URBS; i++) {
+		transfer = &trigger5->transfers[i];
+
+		urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urb)
+			return -ENOMEM;
+		transfer->urb = urb;
+
+		buf = kmalloc(TRIGGER5_URB_BUF_SIZE, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		usb_fill_bulk_urb(urb, udev, trigger5->bulk_pipe, buf,
+				  TRIGGER5_URB_BUF_SIZE, trigger5_urb_complete,
+				  transfer);
+		urb->transfer_flags |= URB_FREE_BUFFER;
+
+		transfer->trigger5 = trigger5;
+		init_completion(&transfer->done);
+		complete(&transfer->done);
+	}
+
+	return 0;
+}
+
+static size_t trigger5_mode_buf_len(const struct drm_display_mode *mode)
+{
+	return size_add(array3_size(mode->hdisplay, mode->vdisplay, 3),
+			sizeof(struct trigger5_bulk_header));
+}
+
+static int trigger5_plane_atomic_check(struct drm_plane *plane,
+				       struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state =
+		to_drm_shadow_plane_state(new_plane_state);
+	struct drm_crtc *crtc = new_plane_state->crtc;
+	struct drm_crtc_state *new_crtc_state = NULL;
+	size_t len;
+	int ret;
+
+	if (crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state,
+						  new_crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret || !new_plane_state->visible)
+		return ret;
+
+	/* For drm_fb_xrgb8888_to_rgb888 temp buffer */
+	len = new_plane_state->fb->width * sizeof(u32);
+	if (!drm_format_conv_state_reserve(&shadow_plane_state->fmtcnv_state,
+					   len, GFP_KERNEL))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static u8 trigger5_bulk_header_checksum(const struct trigger5_bulk_header *header)
+{
+	const u8 *data = (const u8 *)header;
+	u16 checksum = 0;
+	size_t i;
+
+	for (i = 0; i < sizeof(struct trigger5_bulk_header) - 1; i++)
+		checksum += data[i];
+	checksum &= 0xff;
+	checksum = 0x100 - checksum;
+	return checksum & 0xff;
+}
+
+static void trigger5_plane_atomic_update(struct drm_plane *plane,
+					 struct drm_atomic_commit *atomic_state)
+{
+	struct drm_plane_state *old_state =
+		drm_atomic_get_old_plane_state(atomic_state, plane);
+	struct drm_plane_state *state =
+		drm_atomic_get_new_plane_state(atomic_state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state =
+		to_drm_shadow_plane_state(state);
+	struct trigger5_device *trigger5 = to_trigger5(plane->dev);
+	struct trigger5_transfer *transfer;
+	struct trigger5_bulk_header *header;
+	struct drm_rect current_rect, src_rect, clip;
+	struct iosys_map data_map;
+	size_t payload_len;
+	int width, height, lines_per_urb;
+	int idx, y;
+
+	if (!drm_atomic_helper_damage_merged(old_state, state, &current_rect))
+		return;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
+
+	src_rect = drm_plane_state_src(state);
+
+	/* Match drm_atomic_helper_damage_iter_init() rounding. */
+	src_rect.x1 >>= 16;
+	src_rect.y1 >>= 16;
+	src_rect.x2 = (src_rect.x2 >> 16) + !!(src_rect.x2 & 0xffff);
+	src_rect.y2 = (src_rect.y2 >> 16) + !!(src_rect.y2 & 0xffff);
+
+	/* Clip merged damage to the new resolution. */
+	if (!drm_rect_intersect(&current_rect, &src_rect))
+		goto exit;
+
+	width = drm_rect_width(&current_rect);
+	height = drm_rect_height(&current_rect);
+	payload_len = array3_size(width, height, 3);
+	lines_per_urb = TRIGGER5_URB_BUF_SIZE / (width * 3);
+
+	if (drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE) < 0)
+		goto exit;
+
+	transfer = trigger5_get_next_urb(trigger5);
+	if (IS_ERR(transfer))
+		goto exit_end_cpu_access;
+
+	header = transfer->urb->transfer_buffer;
+	header->magic = 0xfb;
+	header->length = 0x14;
+	/* flags 0: uncompressed 24-bit RGB888. */
+	header->counter =
+		cpu_to_le16((trigger5->frame_counter++) & 0xfff);
+	header->horizontal_offset = cpu_to_le16(current_rect.x1 - src_rect.x1);
+	header->vertical_offset = cpu_to_le16(current_rect.y1 - src_rect.y1);
+	header->width = cpu_to_le16(width);
+	header->height = cpu_to_le16(height);
+	header->payload_length = cpu_to_le32((u32)payload_len);
+	header->flags = 0x1;
+	header->unknown1 = 0;
+	header->unknown2 = 0;
+	header->checksum = trigger5_bulk_header_checksum(header);
+
+	if (trigger5_submit_urb(transfer, sizeof(*header)))
+		goto exit_end_cpu_access;
+
+	clip = current_rect;
+	for (y = current_rect.y1; y < current_rect.y2; y += lines_per_urb) {
+		clip.y1 = y;
+		clip.y2 = min(y + lines_per_urb, current_rect.y2);
+
+		transfer = trigger5_get_next_urb(trigger5);
+		if (IS_ERR(transfer))
+			break;
+
+		iosys_map_set_vaddr(&data_map, transfer->urb->transfer_buffer);
+		drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
+					  &shadow_plane_state->data[0],
+					  state->fb, &clip,
+					  &shadow_plane_state->fmtcnv_state);
+
+		if (trigger5_submit_urb(transfer,
+					width * 3 * drm_rect_height(&clip)))
+			break;
+	}
+
+exit_end_cpu_access:
+	drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);
+exit:
+	drm_dev_exit(idx);
+}
+
+static const struct drm_plane_helper_funcs trigger5_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = trigger5_plane_atomic_check,
+	.atomic_update = trigger5_plane_atomic_update,
+};
+
+static const struct drm_plane_funcs trigger5_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static const u32 trigger5_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static void trigger5_crtc_atomic_enable(struct drm_crtc *crtc,
+					struct drm_atomic_commit *state)
+{
+	struct trigger5_device *trigger5 = to_trigger5(crtc->dev);
+	struct usb_device *udev = interface_to_usbdev(trigger5->intf);
+	struct drm_crtc_state *crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_display_mode *mode = &crtc_state->mode;
+	struct trigger5_mode_request request = {};
+	u8 data[4];
+	u64 clk;
+	int idx, ret;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
+
+	trigger5_stop_io(trigger5);
+
+	/* Sequence recovered from USB captures. */
+	ret = usb_control_msg_recv(udev, 0,
+				   TRIGGER5_REQUEST_FIRMWARE_RESET,
+				   USB_DIR_IN | USB_TYPE_VENDOR |
+					   USB_RECIP_DEVICE,
+				   0x0000, 0x0000, data, 1,
+				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	request.height = cpu_to_be16(mode->vdisplay);
+	request.height_minus_one = cpu_to_be16(mode->vdisplay - 1);
+	request.width = cpu_to_be16(mode->hdisplay);
+	request.width_minus_one = cpu_to_be16(mode->hdisplay - 1);
+
+	request.line_total_pixels = cpu_to_be16(mode->htotal - 1);
+	request.line_sync_pulse =
+		cpu_to_be16(mode->hsync_end - mode->hsync_start - 1);
+	request.line_back_porch =
+		cpu_to_be16(mode->htotal - mode->hsync_end - 1);
+
+	request.frame_total_lines = cpu_to_be16(mode->vtotal - 1);
+	request.frame_sync_pulse =
+		cpu_to_be16(mode->vsync_end - mode->vsync_start - 1);
+	request.frame_back_porch =
+		cpu_to_be16(mode->vtotal - mode->vsync_end - 1);
+	request.unknown1 = cpu_to_be16(0xff);
+	request.unknown2 = cpu_to_be16(0xff);
+	request.unknown3 = cpu_to_be16(0xff);
+	request.unknown4 = cpu_to_be16(0xff);
+
+	request.hsync_polarity = (mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : 1;
+	request.vsync_polarity = (mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : 1;
+
+	trigger5_calculate_pll(&request.pll, mode->clock);
+	clk = div_u64(10000000ULL * request.pll.mul1 * request.pll.mul2,
+		      (u32)request.pll.prediv * request.pll.div1 *
+			      request.pll.div2 * 1000);
+	drm_dbg(&trigger5->drm,
+		"pll: %02x %02x %02x %02x %02x -> %llu kHz (want %d kHz)\n",
+		request.pll.prediv, request.pll.mul1, request.pll.mul2,
+		request.pll.div1, request.pll.div2, clk, mode->clock);
+
+	/* wValue can be any value since we are sending a custom mode */
+	ret = usb_control_msg_send(udev, 0, TRIGGER5_REQUEST_SET_MODE,
+				   USB_DIR_OUT | USB_TYPE_VENDOR |
+					   USB_RECIP_DEVICE,
+				   0, 0, &request, sizeof(request),
+				   USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	ret = usb_control_msg_recv(udev, 0,
+				   TRIGGER5_REQUEST_FIRMWARE_RESET,
+				   USB_DIR_IN | USB_TYPE_VENDOR |
+					   USB_RECIP_DEVICE,
+				   0x0201, 0x0000, data, 1,
+				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	ret = usb_control_msg_recv(udev, 0,
+				   TRIGGER5_REQUEST_GET_REGISTER,
+				   USB_DIR_IN | USB_TYPE_VENDOR |
+					   USB_RECIP_DEVICE,
+				   0x0000, 0xec34, data, sizeof(data),
+				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	data[0] = 0x60;
+	data[1] = 0x00;
+	data[2] = 0x00;
+	data[3] = 0x10;
+	ret = usb_control_msg_send(udev, 0,
+				   TRIGGER5_REQUEST_SET_REGISTER,
+				   USB_DIR_OUT | USB_TYPE_VENDOR |
+					   USB_RECIP_DEVICE,
+				   0x0000, 0xec34, data, sizeof(data),
+				   USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	goto exit;
+
+err:
+	drm_err_once(&trigger5->drm, "failed to configure display mode: %d\n", ret);
+exit:
+	drm_dev_exit(idx);
+}
+
+static void trigger5_crtc_atomic_disable(struct drm_crtc *crtc,
+					 struct drm_atomic_commit *state)
+{
+	struct trigger5_device *trigger5 = to_trigger5(crtc->dev);
+	struct usb_device *udev = interface_to_usbdev(trigger5->intf);
+	u8 data;
+	int idx, ret;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
+
+	trigger5_stop_io(trigger5);
+
+	ret = usb_control_msg_recv(udev, 0,
+				   TRIGGER5_REQUEST_FIRMWARE_RESET,
+				   USB_DIR_IN | USB_TYPE_VENDOR |
+					   USB_RECIP_DEVICE,
+				   0x0001, 0x0000, &data, 1,
+				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	if (ret)
+		drm_err_once(&trigger5->drm, "failed to disable display: %d\n", ret);
+
+	drm_dev_exit(idx);
+}
+
+static enum drm_mode_status
+trigger5_crtc_mode_valid(struct drm_crtc *crtc,
+			 const struct drm_display_mode *mode)
+{
+	struct trigger5_pll pll;
+	u64 err, ppm;
+
+	if (mode->hsync_end <= mode->hsync_start ||
+	    mode->htotal <= mode->hsync_end)
+		return MODE_H_ILLEGAL;
+
+	if (mode->vsync_end <= mode->vsync_start ||
+	    mode->vtotal <= mode->vsync_end)
+		return MODE_V_ILLEGAL;
+
+	if (trigger5_mode_buf_len(mode) > TRIGGER5_MAX_FRAME_SIZE)
+		return MODE_MEM;
+
+	err = trigger5_calculate_pll(&pll, mode->clock);
+	ppm = div64_u64(err * 1000, mode->clock);
+	if (ppm > 10000)
+		return MODE_CLOCK_RANGE;
+
+	return MODE_OK;
+}
+
+static const struct drm_mode_config_helper_funcs
+trigger5_mode_config_helper_funcs = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
+static const struct drm_crtc_helper_funcs trigger5_crtc_helper_funcs = {
+	.mode_valid = trigger5_crtc_mode_valid,
+	.atomic_disable = trigger5_crtc_atomic_disable,
+	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_enable = trigger5_crtc_atomic_enable,
+};
+
+static const struct drm_crtc_funcs trigger5_crtc_funcs = {
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs trigger5_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static int trigger5_read_edid(void *data, u8 *buf, unsigned int block,
+			      size_t len)
+{
+	struct trigger5_device *trigger5 = data;
+	struct usb_device *udev = interface_to_usbdev(trigger5->intf);
+	int idx, ret;
+
+	if (!drm_dev_enter(&trigger5->drm, &idx))
+		return -ENODEV;
+
+	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+			      TRIGGER5_REQUEST_GET_EDID,
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      block, 0, buf, len, USB_CTRL_GET_TIMEOUT);
+	drm_dev_exit(idx);
+
+	if (ret < 0)
+		return ret;
+	if (ret != len)
+		return -EIO;
+
+	return 0;
+}
+
+static int trigger5_connector_get_modes(struct drm_connector *connector)
+{
+	struct trigger5_device *trigger5 = to_trigger5(connector->dev);
+	const struct drm_edid *edid;
+	int count;
+
+	edid = drm_edid_read_custom(connector, trigger5_read_edid, trigger5);
+	drm_edid_connector_update(connector, edid);
+	count = drm_edid_connector_add_modes(connector);
+	drm_edid_free(edid);
+
+	return count;
+}
+
+static enum drm_connector_status
+trigger5_detect(struct drm_connector *connector, bool force)
+{
+	struct trigger5_device *trigger5 = to_trigger5(connector->dev);
+	struct usb_device *udev = interface_to_usbdev(trigger5->intf);
+	u8 status[2];
+	int idx, ret;
+
+	if (!drm_dev_enter(&trigger5->drm, &idx))
+		return connector_status_disconnected;
+
+	ret = usb_control_msg_recv(udev, 0, TRIGGER5_REQUEST_GET_STATUS,
+				   USB_DIR_IN | USB_TYPE_VENDOR |
+					   USB_RECIP_DEVICE,
+				   0xff, 0x3, status, sizeof(status),
+				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	drm_dev_exit(idx);
+
+	if (ret)
+		return connector_status_unknown;
+
+	return status[1] == 1 ? connector_status_connected :
+			     connector_status_disconnected;
+}
+
+static const struct drm_connector_helper_funcs trigger5_connector_helper_funcs = {
+	.get_modes = trigger5_connector_get_modes,
+};
+
+static const struct drm_connector_funcs trigger5_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.detect = trigger5_detect,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int trigger5_connector_init(struct trigger5_device *trigger5,
+				   int connector_type)
+{
+	int ret;
+
+	drm_connector_helper_add(&trigger5->connector,
+				 &trigger5_connector_helper_funcs);
+	ret = drm_connector_init(&trigger5->drm, &trigger5->connector,
+				 &trigger5_connector_funcs, connector_type);
+	trigger5->connector.polled =
+		DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
+	return ret;
+}
+
+static int trigger5_usb_probe(struct usb_interface *interface,
+			      const struct usb_device_id *id)
+{
+	int ret;
+	struct trigger5_device *trigger5;
+	struct usb_endpoint_descriptor *bulk_out;
+	struct drm_device *dev;
+	struct device *dma_dev;
+	struct usb_device *udev = interface_to_usbdev(interface);
+	/* Heuristic: Presence of audio interfaces indicates HDMI. */
+	bool is_hdmi = udev->actconfig->desc.bNumInterfaces > 1;
+	u8 data;
+
+	trigger5 = devm_drm_dev_alloc(&interface->dev, &trigger5_drm_driver,
+				      struct trigger5_device, drm);
+	if (IS_ERR(trigger5))
+		return PTR_ERR(trigger5);
+
+	trigger5->intf = interface;
+
+	ret = usb_find_bulk_out_endpoint(interface->cur_altsetting, &bulk_out);
+	if (ret)
+		return ret;
+	trigger5->bulk_pipe =
+		usb_sndbulkpipe(udev, usb_endpoint_num(bulk_out));
+
+	/* Disarm the keepalive */
+	usb_control_msg_recv(udev, 0, TRIGGER5_REQUEST_KEEPALIVE,
+			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			     0, 0, &data, 1, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+
+	dev = &trigger5->drm;
+
+	dma_dev = usb_intf_get_dma_device(interface);
+	if (dma_dev) {
+		drm_dev_set_dma_dev(dev, dma_dev);
+		put_device(dma_dev);
+	} else {
+		drm_warn(dev,
+			 "buffer sharing not supported"); /* not an error */
+	}
+
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * The device has a built-in mode list, however we ignore
+	 * the mode list because the device accepts custom modes
+	 */
+	dev->mode_config.min_width = 1;
+	dev->mode_config.max_width = 8191;
+	dev->mode_config.min_height = 1;
+	dev->mode_config.max_height = 8191;
+
+	dev->mode_config.funcs = &trigger5_mode_config_funcs;
+	dev->mode_config.helper_private = &trigger5_mode_config_helper_funcs;
+
+	ret = drm_universal_plane_init(dev, &trigger5->plane, 0,
+				       &trigger5_plane_funcs,
+				       trigger5_plane_formats,
+				       ARRAY_SIZE(trigger5_plane_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+
+	drm_plane_helper_add(&trigger5->plane, &trigger5_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(&trigger5->plane);
+
+	ret = drm_crtc_init_with_planes(dev, &trigger5->crtc, &trigger5->plane,
+					NULL, &trigger5_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&trigger5->crtc, &trigger5_crtc_helper_funcs);
+
+	ret = trigger5_connector_init(trigger5, is_hdmi ?
+					      DRM_MODE_CONNECTOR_HDMIA :
+					      DRM_MODE_CONNECTOR_VGA);
+	if (ret)
+		return ret;
+
+	ret = drm_encoder_init(dev, &trigger5->encoder, &trigger5_encoder_funcs,
+			       is_hdmi ? DRM_MODE_ENCODER_TMDS :
+					 DRM_MODE_ENCODER_DAC, NULL);
+	if (ret)
+		return ret;
+	trigger5->encoder.possible_crtcs = drm_crtc_mask(&trigger5->crtc);
+
+	ret = drm_connector_attach_encoder(&trigger5->connector,
+					   &trigger5->encoder);
+	if (ret)
+		return ret;
+
+	ret = trigger5_alloc_urbs(trigger5);
+	if (ret)
+		goto err_free_urbs;
+
+	drm_mode_config_reset(dev);
+
+	usb_set_intfdata(interface, trigger5);
+
+	drm_kms_helper_poll_init(dev);
+
+	ret = drm_dev_register(dev, 0);
+	if (ret)
+		goto err_poll_fini;
+
+	drm_client_setup(dev, NULL);
+
+	return 0;
+
+err_poll_fini:
+	drm_kms_helper_poll_fini(dev);
+	usb_set_intfdata(interface, NULL);
+err_free_urbs:
+	trigger5_free_urbs(trigger5);
+	return ret;
+}
+
+static void trigger5_usb_disconnect(struct usb_interface *interface)
+{
+	struct trigger5_device *trigger5 = usb_get_intfdata(interface);
+	struct drm_device *dev = &trigger5->drm;
+
+	drm_kms_helper_poll_fini(dev);
+	drm_dev_unplug(dev);
+	drm_atomic_helper_shutdown(dev);
+	trigger5_stop_io(trigger5);
+	trigger5_free_urbs(trigger5);
+}
+
+static const struct usb_device_id id_table[] = {
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5800, 0) }, /* HDMI */
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5801, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5802, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5803, 0) },
+	{ USB_DEVICE(0x0711, 0x5804) }, /* VGA */
+	{ USB_DEVICE(0x0711, 0x5805) },
+	{ USB_DEVICE(0x0711, 0x5806) },
+	{ USB_DEVICE(0x0711, 0x5807) },
+	{ USB_DEVICE(0x0711, 0x5808) },
+	{ USB_DEVICE(0x0711, 0x5809) },
+	{ USB_DEVICE(0x0711, 0x580A) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580B, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580C, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580D, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580E, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580F, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5810, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5811, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5812, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5813, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5814, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5815, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5816, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5817, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5818, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5819, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581A, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581B, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581C, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581D, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581E, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581F, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5820, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5821, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5822, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5823, 0) },
+	{ USB_DEVICE(0x0711, 0x5824) },
+	{ USB_DEVICE(0x0711, 0x5825) },
+	{ USB_DEVICE(0x0711, 0x5826) },
+	{ USB_DEVICE(0x0711, 0x5827) },
+	{ USB_DEVICE(0x0711, 0x5828) },
+	{ USB_DEVICE(0x0711, 0x5829) },
+	{ USB_DEVICE(0x0711, 0x582A) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582B, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582C, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582D, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582E, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582F, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5830, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5831, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5832, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5833, 0) },
+	{ USB_DEVICE(0x0711, 0x5834) },
+	{ USB_DEVICE(0x0711, 0x5835) },
+	{ USB_DEVICE(0x0711, 0x5836) },
+	{ USB_DEVICE(0x0711, 0x5837) },
+	{ USB_DEVICE(0x0711, 0x5838) },
+	{ USB_DEVICE(0x0711, 0x5839) },
+	{ USB_DEVICE(0x0711, 0x583A) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583B, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583C, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583D, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583E, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583F, 0) },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, id_table);
+
+static struct usb_driver trigger5_driver = {
+	.name = DRIVER_NAME,
+	.probe = trigger5_usb_probe,
+	.disconnect = trigger5_usb_disconnect,
+	.suspend = trigger5_usb_suspend,
+	.resume = trigger5_usb_resume,
+	.reset_resume = trigger5_usb_resume,
+	.id_table = id_table,
+};
+module_usb_driver(trigger5_driver);
+MODULE_AUTHOR("Ho Jie Feng <hjf3108@gmail.com>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
-- 
2.55.0

