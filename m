Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2A7C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4154210F524;
	Fri, 11 Sep 2026 07:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tApxJ+TG";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585AA10E28E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 17:17:29 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8692a856865so1611984b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789060649; x=1789665449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ArBFL6cn7KctgjgroHWdQwbsDFdSrRtdNgYBQC6QAoA=;
 b=tApxJ+TGGKYQkURWQlmV/elsfw4ozibIZBMAUPWCi8ZZH+rJDxIrDtPh1/MUY8Nuif
 CKCz7qLTb8LPcpeeRh0irKcy9hgNS0TEOhnx5ohGaqvkgP0qyrgfvr9R5G2cJGaXl56O
 bbhftMrSIIO91MhwGW7fQxyNblieMRxXYgnGHXshAN5lQRrDJu70qKcS2Jx+2UZdxc2Y
 oiHBfrZReZsM33VbBSQHlnZMvdF7Mc18hQo3awzyre3qancnkYidv+d45wAQ00gu8mZD
 ob8sfMknhGX55z9OwKAP469wsd9y1yfDy+GHu6QbHStMfCvXyJ2Rwr/vD3labn/dUJz3
 aQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789060649; x=1789665449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ArBFL6cn7KctgjgroHWdQwbsDFdSrRtdNgYBQC6QAoA=;
 b=PbFrjtgaTM6uxi7AT+vfn4352uycK9VtQsMMpS2ucE0i2nkuJG44kPD5hyDCkZ8Tm7
 VfigqOmeKP0wp36Dbl86MwyrHW0VEkE2hhDOGfKsLcPNQLsZ9dL1RkftAwOn2FZIaZBF
 G8UOGVFR75WOmjmIDpa0P6xZdtlLcReHZNoS43OPcbij03v6rkHDe4lgNUFFPX/CCeSr
 g6m9D2hEHGPcipsvmNue3ONzdcTRm+hpobGcb5pG/adnHnNBXsX4uOJ23p7h+BIKtqUT
 j01z05a6StHcDEurFbh6tiyVZUueOviLpKFeIRSkUH9AI8w7c377iRaQVxRkjmtB44qU
 ifXQ==
X-Gm-Message-State: AFuF++lz7mimOAz+U7DD3pF4icJ11S/ReO0BP+0ExY4WslDKhNh9xX3x
 agyhMpXRMfm/ydxntukvrZzzLc7n67WTXTVI7GgEOaG6ergyMruNOS1lA3IDftEyOyI=
X-Gm-Gg: AYBFou2+6J5OG0j5vI3XQRl03ReKI3c0pdVfMBHq66Rsp9Vuf+RdljHC17s64uqDuBb
 CB21VDR3wRzfJSZC+9suZ4UR/FW02FcCwMtKDxxVfiEkl1C/8elNVdmmKTi3malpHRm8akYMfUJ
 rmM6n+paHdk+Z+N6mpbg/XGIV9Jf3SGwuDWgiA6PBb2G9Biu4ihwo8oHHclpZjgE47ulyWvkoLm
 XPa21nU3XX8v1BNSTVn2wdz3gEBttG4BLRH1NyAnD6XCz5gjQORWsR7pUuszt/+hO8vm1iBo72y
 9RJZefH1Lq79MW/oe7Bgr9tS4h8OLcQCva3PYHAcJSrSQHUerwUKDxjlP0GsXNAgKffxEZZhFY4
 5V9rVbx/Zj1fDpQ0KEArK/hW2vr66+BIFTIMxlKjGmXdUP17jpLos/5twXNPGX03J7BniV2WgTp
 RjD55rXuq5iL5BgJQQ9aPK9vmM5pV0O7PQ4iTkwrCCja1/fPVHxQTtWN6nHPYxXcQ7SRhC8dMLj
 h3pLvmz/cu5FBkbAZfCL+hpijmOr/JHIyHTWLsboD5XttBal5+m
X-Received: by 2002:a05:6a00:3397:b0:857:72ba:ff0d with SMTP id
 d2e1a72fcca58-868434833e6mr16966950b3a.21.1789060648327; 
 Thu, 10 Sep 2026 10:17:28 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:63d1:a611:b433:d4e7:c402])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-86aa00a4c22sm718740b3a.41.2026.09.10.10.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 10:17:27 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: cyrozap@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/trigger5: Add MCT Trigger 5 USB display driver
Date: Fri, 11 Sep 2026 01:17:05 +0800
Message-ID: <20260910171709.396071-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

Add a DRM driver for MCT Trigger 5 USB display adapters. The driver
implements modesetting and USB framebuffer updates, connector detection,
and EDID retrieval.

The protocol is based on reverse-engineering work by Forest Crossman
(cyrozap) at: https://github.com/cyrozap/mct-usb-display-adapter-re
and usb packet captures between the Windows driver and the device.

Only the HDMI path has been tested. VGA selection is inferred from the
absence of USB audio interfaces.

Tested on JUA355. The list of USB device IDs are taken from the
Windows driver INF.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/trigger5/Kconfig              |  14 +
 drivers/gpu/drm/trigger5/Makefile             |   4 +
 drivers/gpu/drm/trigger5/trigger5.h           | 121 +++
 drivers/gpu/drm/trigger5/trigger5_connector.c | 102 ++
 drivers/gpu/drm/trigger5/trigger5_drv.c       | 904 ++++++++++++++++++
 8 files changed, 1154 insertions(+)
 create mode 100644 drivers/gpu/drm/trigger5/Kconfig
 create mode 100644 drivers/gpu/drm/trigger5/Makefile
 create mode 100644 drivers/gpu/drm/trigger5/trigger5.h
 create mode 100644 drivers/gpu/drm/trigger5/trigger5_connector.c
 create mode 100644 drivers/gpu/drm/trigger5/trigger5_drv.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b5a4e4b35cf4..f40a6fb9c3c2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8250,6 +8250,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
 F:	drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
 
+DRM DRIVER FOR MCT TRIGGER 5 USB DISPLAY ADAPTERS
+M:	Ho Jie Feng <hjf3108@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/trigger5/
+
 DRM DRIVER FOR MGA G200 GRAPHICS CHIPS
 M:	Dave Airlie <airlied@redhat.com>
 R:	Thomas Zimmermann <tzimmermann@suse.de>
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f6..75b5f5f4e94d4 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -350,6 +350,7 @@ source "drivers/gpu/drm/tegra/Kconfig"
 source "drivers/gpu/drm/tidss/Kconfig"
 source "drivers/gpu/drm/tilcdc/Kconfig"
 source "drivers/gpu/drm/tiny/Kconfig"
+source "drivers/gpu/drm/trigger5/Kconfig"
 source "drivers/gpu/drm/tve200/Kconfig"
 source "drivers/gpu/drm/tyr/Kconfig"
 source "drivers/gpu/drm/udl/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e635fcffd3790..85a2dbfa643d9 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -238,6 +238,7 @@ obj-$(CONFIG_DRM_SPRD) += sprd/
 obj-$(CONFIG_DRM_LOONGSON) += loongson/
 obj-$(CONFIG_DRM_POWERVR) += imagination/
 obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon/
+obj-$(CONFIG_DRM_TRIGGER5) += trigger5/
 
 # Ensure drm headers are self-contained and pass kernel-doc
 hdrtest-files := \
diff --git a/drivers/gpu/drm/trigger5/Kconfig b/drivers/gpu/drm/trigger5/Kconfig
new file mode 100644
index 0000000000000..e489db641f3e1
--- /dev/null
+++ b/drivers/gpu/drm/trigger5/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
diff --git a/drivers/gpu/drm/trigger5/Makefile b/drivers/gpu/drm/trigger5/Makefile
new file mode 100644
index 0000000000000..03b146e2fe813
--- /dev/null
+++ b/drivers/gpu/drm/trigger5/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+trigger5-y := trigger5_drv.o trigger5_connector.o
+obj-$(CONFIG_DRM_TRIGGER5) += trigger5.o
diff --git a/drivers/gpu/drm/trigger5/trigger5.h b/drivers/gpu/drm/trigger5/trigger5.h
new file mode 100644
index 0000000000000..1d2f87126c7dd
--- /dev/null
+++ b/drivers/gpu/drm/trigger5/trigger5.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __TRIGGER5_H__
+#define __TRIGGER5_H__
+
+#include <linux/completion.h>
+#include <linux/scatterlist.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_rect.h>
+
+#define DRIVER_NAME		"trigger5"
+#define DRIVER_DESC		"MCT Trigger 5 USB display adapter"
+
+#define DRIVER_MAJOR		1
+#define DRIVER_MINOR		0
+
+struct trigger5_transfer {
+	struct trigger5_device *trigger5;
+
+	void *frame_data;
+	size_t frame_len;
+	size_t frame_alloc_len;
+	struct drm_rect transfer_rect;
+
+	struct sg_table transfer_sgt;
+	struct timer_list timer;
+	struct usb_sg_request sgr;
+
+	struct work_struct transfer_work;
+	struct completion frame_complete;
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
+	int current_transfer;
+	struct drm_rect pending_rect;
+	struct workqueue_struct *transfer_wq;
+	bool display_enabled;
+	struct delayed_work keepalive_work;
+	struct trigger5_transfer transfers[2];
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
+#define TRIGGER5_KEEPALIVE_INTERVAL_MS	2000
+#define TRIGGER5_BULK_TIMEOUT_MS		5000
+
+#define to_trigger5(x) container_of(x, struct trigger5_device, drm)
+
+int trigger5_connector_init(struct trigger5_device *trigger5,
+			    int connector_type);
+#endif /* __TRIGGER5_H__ */
diff --git a/drivers/gpu/drm/trigger5/trigger5_connector.c b/drivers/gpu/drm/trigger5/trigger5_connector.c
new file mode 100644
index 0000000000000..a63e86fd74ab8
--- /dev/null
+++ b/drivers/gpu/drm/trigger5/trigger5_connector.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_probe_helper.h>
+
+#include "trigger5.h"
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
+	if (!count)
+		count = drm_add_modes_noedid(connector, 1920, 1200);
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
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+int trigger5_connector_init(struct trigger5_device *trigger5,
+			    int connector_type)
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
diff --git a/drivers/gpu/drm/trigger5/trigger5_drv.c b/drivers/gpu/drm/trigger5/trigger5_drv.c
new file mode 100644
index 0000000000000..f6754636768ac
--- /dev/null
+++ b/drivers/gpu/drm/trigger5/trigger5_drv.c
@@ -0,0 +1,904 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/iosys-map.h>
+#include <linux/jiffies.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/vmalloc.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+
+#include "trigger5.h"
+
+static void trigger5_stop_io(struct trigger5_device *trigger5)
+{
+	WRITE_ONCE(trigger5->display_enabled, false);
+	flush_workqueue(trigger5->transfer_wq);
+	cancel_delayed_work_sync(&trigger5->keepalive_work);
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
+static const struct drm_mode_config_helper_funcs
+trigger5_mode_config_helper_funcs = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
+static u64 trigger5_calculate_pll(struct trigger5_pll *pll, int clock)
+{
+	u64 ref_clock = 10000000;
+	u64 target_clock = (u64)clock * 1000;
+	u64 calculated_clock, calculated_err, best_err = U64_MAX;
+	int prediv, mul1, mul2, div1, div2;
+
+	/* Use values found in the capture */
+	for (prediv = 1; prediv <= 0x10; prediv <<= 1) {
+		for (mul1 = 1; mul1 <= 0x32; mul1++) {
+			for (mul2 = mul1; mul2 <= 0x32; mul2++) {
+				for (div1 = 1; div1 <= 0x32; div1++) {
+					for (div2 = 0x02; div2 <= 0x10;
+					     div2 <<= 1) {
+						if (!best_err)
+							break;
+						calculated_clock =
+							div_u64(ref_clock * mul1 * mul2,
+								prediv * div1 * div2);
+						calculated_err =
+							abs_diff(calculated_clock,
+								 target_clock);
+						if (calculated_err < best_err) {
+							best_err =
+								calculated_err;
+							pll->mul1 = mul1;
+							pll->mul2 = mul2;
+							pll->div1 = div1;
+							pll->div2 = div2;
+							pll->prediv = prediv;
+						}
+					}
+				}
+			}
+		}
+	}
+	return best_err;
+}
+
+static void trigger5_bulk_timeout(struct timer_list *t)
+{
+	struct trigger5_transfer *transfer =
+		timer_container_of(transfer, t, timer);
+
+	usb_sg_cancel(&transfer->sgr);
+}
+
+static void trigger5_transfer_work(struct work_struct *work)
+{
+	struct trigger5_transfer *transfer =
+		container_of(work, struct trigger5_transfer, transfer_work);
+	struct trigger5_device *trigger5 = transfer->trigger5;
+	struct usb_device *udev = interface_to_usbdev(trigger5->intf);
+	int idx, ret;
+
+	if (!drm_dev_enter(&trigger5->drm, &idx))
+		goto complete;
+
+	/* Submit bulk transfer with a five-second timeout. */
+	ret = usb_sg_init(&transfer->sgr, udev, trigger5->bulk_pipe, 0,
+			  transfer->transfer_sgt.sgl,
+			  transfer->transfer_sgt.nents, transfer->frame_len,
+			  GFP_KERNEL);
+	if (ret) {
+		drm_err_ratelimited(&trigger5->drm,
+				    "failed to initialize USB transfer: %d\n",
+				    ret);
+		goto exit;
+	}
+
+	mod_timer(&transfer->timer,
+		  jiffies + msecs_to_jiffies(TRIGGER5_BULK_TIMEOUT_MS));
+	usb_sg_wait(&transfer->sgr);
+	timer_delete_sync(&transfer->timer);
+
+	if (transfer->sgr.status)
+		drm_err_ratelimited(&trigger5->drm,
+				    "USB transfer failed: %d\n",
+				    transfer->sgr.status);
+	else if (transfer->sgr.bytes != transfer->frame_len)
+		drm_err_ratelimited(&trigger5->drm,
+				    "short USB transfer: %zu/%zu bytes\n",
+				    transfer->sgr.bytes, transfer->frame_len);
+	else if (READ_ONCE(trigger5->display_enabled))
+		/* Keepalive must only be sent after a frame has been sent */
+		queue_delayed_work(trigger5->transfer_wq,
+				   &trigger5->keepalive_work,
+				   msecs_to_jiffies(TRIGGER5_KEEPALIVE_INTERVAL_MS));
+
+exit:
+	drm_dev_exit(idx);
+complete:
+	complete(&transfer->frame_complete);
+}
+
+static void trigger5_keepalive_work(struct work_struct *work)
+{
+	struct trigger5_device *trigger5 =
+		container_of(to_delayed_work(work), struct trigger5_device,
+			     keepalive_work);
+	struct usb_device *udev = interface_to_usbdev(trigger5->intf);
+	u8 response;
+	int idx, ret;
+
+	if (!READ_ONCE(trigger5->display_enabled))
+		return;
+
+	if (!drm_dev_enter(&trigger5->drm, &idx))
+		return;
+
+	ret = usb_control_msg_recv(udev, 0, TRIGGER5_REQUEST_KEEPALIVE,
+				   USB_DIR_IN | USB_TYPE_VENDOR |
+					   USB_RECIP_DEVICE,
+				   0x0002, 0x0000, &response,
+				   sizeof(response), USB_CTRL_GET_TIMEOUT,
+				   GFP_KERNEL);
+	if (ret)
+		drm_err_ratelimited(&trigger5->drm,
+				    "keepalive request failed: %d\n", ret);
+
+	if (READ_ONCE(trigger5->display_enabled))
+		mod_delayed_work(trigger5->transfer_wq,
+				 &trigger5->keepalive_work,
+				 msecs_to_jiffies(TRIGGER5_KEEPALIVE_INTERVAL_MS));
+
+	drm_dev_exit(idx);
+}
+
+static void trigger5_free_bulk_buffer(struct trigger5_transfer *transfer)
+{
+	if (!transfer->frame_data)
+		return;
+	sg_free_table(&transfer->transfer_sgt);
+	vfree(transfer->frame_data);
+	transfer->frame_data = NULL;
+	transfer->frame_len = 0;
+	transfer->frame_alloc_len = 0;
+}
+
+static int trigger5_resize_bulk_buffer(struct trigger5_transfer *transfer,
+				       size_t len)
+{
+	unsigned int num_pages;
+	struct sg_table transfer_sgt;
+	int ret, i;
+	struct page **pages;
+	u8 *data;
+	void *ptr;
+
+	/* Large transfer buffer requires vmalloc and a scatterlist. */
+	data = vmalloc_32(len);
+	if (!data)
+		return -ENOMEM;
+
+	num_pages = DIV_ROUND_UP(len, PAGE_SIZE);
+	pages = kmalloc_array(num_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages) {
+		ret = -ENOMEM;
+		goto err_vfree;
+	}
+	for (i = 0, ptr = data; i < num_pages; i++, ptr += PAGE_SIZE)
+		pages[i] = vmalloc_to_page(ptr);
+	ret = sg_alloc_table_from_pages(&transfer_sgt, pages,
+					num_pages, 0, len, GFP_KERNEL);
+	kfree(pages);
+	if (ret)
+		goto err_vfree;
+
+	/* Allocate a replacement before releasing the current buffer. */
+	sg_free_table(&transfer->transfer_sgt);
+	transfer->transfer_sgt = transfer_sgt;
+	vfree(transfer->frame_data);
+	transfer->frame_data = data;
+	transfer->frame_alloc_len = len;
+
+	return 0;
+err_vfree:
+	vfree(data);
+	return ret;
+}
+
+static void trigger5_init_transfer(struct trigger5_device *trigger5,
+				   struct trigger5_transfer *transfer)
+{
+	init_completion(&transfer->frame_complete);
+	complete(&transfer->frame_complete);
+	timer_setup(&transfer->timer, trigger5_bulk_timeout, 0);
+	INIT_WORK(&transfer->transfer_work, trigger5_transfer_work);
+	transfer->trigger5 = trigger5;
+}
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
+	drm_dbg_kms(&trigger5->drm,
+		    "pll: %02x %02x %02x %02x %02x -> %llu kHz (want %d kHz)\n",
+		    request.pll.prediv, request.pll.mul1, request.pll.mul2,
+		    request.pll.div1, request.pll.div2, clk, mode->clock);
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
+	WRITE_ONCE(trigger5->display_enabled, true);
+
+	goto exit;
+
+err:
+	drm_err(&trigger5->drm, "failed to configure display mode: %d\n", ret);
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
+		drm_err(&trigger5->drm, "failed to disable display: %d\n", ret);
+
+	drm_dev_exit(idx);
+}
+
+static enum drm_mode_status
+trigger5_crtc_mode_valid(struct drm_crtc *crtc,
+			 const struct drm_display_mode *mode)
+{
+	struct trigger5_pll pll;
+	size_t frame_len, payload_len;
+	u64 err, ppm;
+
+	/*
+	 * The protocol stores totals, sync pulses, and back porches minus one
+	 * in 16-bit fields.
+	 */
+	if (mode->hsync_end <= mode->hsync_start ||
+	    mode->htotal <= mode->hsync_end ||
+	    mode->htotal > U16_MAX + 1)
+		return MODE_H_ILLEGAL;
+
+	if (mode->vsync_end <= mode->vsync_start ||
+	    mode->vtotal <= mode->vsync_end ||
+	    mode->vtotal > U16_MAX + 1)
+		return MODE_V_ILLEGAL;
+
+	payload_len = array3_size(mode->hdisplay, mode->vdisplay, 3);
+	frame_len = size_add(payload_len, sizeof(struct trigger5_bulk_header));
+	if (frame_len > SZ_16M)
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
+static int trigger5_plane_atomic_check(struct drm_plane *plane,
+				       struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = new_plane_state->crtc;
+	struct drm_crtc_state *new_crtc_state;
+
+	if (!new_plane_state->fb)
+		return 0;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	return drm_atomic_helper_check_plane_state(new_plane_state,
+						   new_crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
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
+static void trigger5_clear_rect(struct drm_rect *rect)
+{
+	rect->x1 = INT_MAX;
+	rect->y1 = INT_MAX;
+	rect->x2 = 0;
+	rect->y2 = 0;
+}
+
+static void trigger5_merge_rect(struct drm_rect *r1, const struct drm_rect *r2)
+{
+	r1->x1 = min(r1->x1, r2->x1);
+	r1->y1 = min(r1->y1, r2->y1);
+	r1->x2 = max(r1->x2, r2->x2);
+	r1->y2 = max(r1->y2, r2->y2);
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
+	struct trigger5_transfer *current_transfer, *previous_transfer;
+	struct trigger5_bulk_header *header;
+	struct drm_rect current_rect, src_rect;
+	struct iosys_map data_map;
+	size_t frame_len, payload_len, max_len;
+	int width, height;
+	int idx, ret;
+
+	if (!drm_atomic_helper_damage_merged(old_state, state, &current_rect))
+		return;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
+
+	current_transfer =
+		&trigger5->transfers[trigger5->current_transfer];
+	previous_transfer = &trigger5->transfers[1 - trigger5->current_transfer];
+
+	src_rect = drm_plane_state_src(state);
+
+	/* Match drm_atomic_helper_damage_iter_init() rounding. */
+	src_rect.x1 >>= 16;
+	src_rect.y1 >>= 16;
+	src_rect.x2 = (src_rect.x2 >> 16) + !!(src_rect.x2 & 0xffff);
+	src_rect.y2 = (src_rect.y2 >> 16) + !!(src_rect.y2 & 0xffff);
+
+	/* Latency reduction: requeue with the latest frame data. */
+	if (cancel_work(&previous_transfer->transfer_work)) {
+		complete(&previous_transfer->frame_complete);
+
+		trigger5_merge_rect(&current_rect, &previous_transfer->transfer_rect);
+
+		current_transfer = previous_transfer;
+		trigger5->current_transfer = !trigger5->current_transfer;
+	}
+
+	/* Damage deferred by an earlier failed update. */
+	trigger5_merge_rect(&current_rect, &trigger5->pending_rect);
+	trigger5_clear_rect(&trigger5->pending_rect);
+
+	/* Clip merged damage to the new resolution. */
+	if (!drm_rect_intersect(&current_rect, &src_rect))
+		goto exit;
+
+	width = drm_rect_width(&current_rect);
+	height = drm_rect_height(&current_rect);
+	payload_len = array3_size(width, height, 3);
+	frame_len = size_add(payload_len, sizeof(*header));
+
+	/*
+	 * This should almost never wait because we have should have a
+	 * pending transfer ready to be de-queued above in case the transfer
+	 * hasn't finished, but do a bounded wait just in case it gets stuck
+	 */
+	if (!wait_for_completion_timeout(&current_transfer->frame_complete,
+					 msecs_to_jiffies(20)))
+		goto exit_save_pending;
+
+	current_transfer->transfer_rect = current_rect;
+
+	/* Resize buffer to the current resolution for lower memory footprint */
+	max_len = array3_size(drm_rect_width(&src_rect),
+			      drm_rect_height(&src_rect), 3);
+	max_len = size_add(max_len, sizeof(*header));
+
+	/*
+	 * Allocation failure leaves the old buffer available for smaller
+	 * partial updates.
+	 */
+	if (max_len != current_transfer->frame_alloc_len)
+		trigger5_resize_bulk_buffer(current_transfer, max_len);
+
+	if (frame_len > current_transfer->frame_alloc_len) {
+		complete(&current_transfer->frame_complete);
+		goto exit_save_pending;
+	}
+
+	current_transfer->frame_len = frame_len;
+	header = current_transfer->frame_data;
+	header->magic = 0xfb;
+	header->length = 0x14;
+	/* flags 0: uncompressed 24-bit RGB888. */
+	header->counter =
+		cpu_to_le16((trigger5->frame_counter++) & 0xfff);
+	header->horizontal_offset = cpu_to_le16(current_rect.x1);
+	header->vertical_offset = cpu_to_le16(current_rect.y1);
+	header->width = cpu_to_le16(width);
+	header->height = cpu_to_le16(height);
+	header->payload_length = cpu_to_le32((u32)payload_len);
+	header->flags = 0x1;
+	header->unknown1 = 0;
+	header->unknown2 = 0;
+	header->checksum = trigger5_bulk_header_checksum(header);
+
+	iosys_map_set_vaddr(&data_map,
+			    current_transfer->frame_data + sizeof(*header));
+
+	ret = drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);
+	if (ret < 0) {
+		complete(&current_transfer->frame_complete);
+		goto exit_save_pending;
+	}
+
+	drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
+				  &shadow_plane_state->data[0],
+				  state->fb, &current_rect,
+				  &shadow_plane_state->fmtcnv_state);
+
+	drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);
+
+	queue_work(trigger5->transfer_wq, &current_transfer->transfer_work);
+	trigger5->current_transfer = !trigger5->current_transfer;
+	goto exit;
+
+	/* Retry the dropped damage on the next update. */
+exit_save_pending:
+	trigger5->pending_rect = current_rect;
+exit:
+	drm_dev_exit(idx);
+}
+
+static const struct drm_crtc_helper_funcs trigger5_crtc_helper_funcs = {
+	.mode_valid = trigger5_crtc_mode_valid,
+	.atomic_disable = trigger5_crtc_atomic_disable,
+	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_enable = trigger5_crtc_atomic_enable,
+};
+
+static const struct drm_crtc_funcs trigger5_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
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
+static const struct drm_encoder_funcs trigger5_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const u32 trigger5_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
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
+	trigger5_clear_rect(&trigger5->pending_rect);
+	trigger5_init_transfer(trigger5, &trigger5->transfers[0]);
+	trigger5_init_transfer(trigger5, &trigger5->transfers[1]);
+
+	/* The first transfer resizes them for the active mode. */
+	ret = trigger5_resize_bulk_buffer(&trigger5->transfers[0], SZ_64K);
+	if (ret)
+		return ret;
+
+	ret = trigger5_resize_bulk_buffer(&trigger5->transfers[1], SZ_64K);
+	if (ret)
+		goto err_alloc_0;
+
+	ret = drm_universal_plane_init(dev, &trigger5->plane, 0,
+				       &trigger5_plane_funcs,
+				       trigger5_plane_formats,
+				       ARRAY_SIZE(trigger5_plane_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		goto err_alloc_1;
+
+	drm_plane_helper_add(&trigger5->plane, &trigger5_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(&trigger5->plane);
+
+	ret = drm_crtc_init_with_planes(dev, &trigger5->crtc, &trigger5->plane,
+					NULL, &trigger5_crtc_funcs, NULL);
+	if (ret)
+		goto err_alloc_1;
+
+	drm_crtc_helper_add(&trigger5->crtc, &trigger5_crtc_helper_funcs);
+
+	ret = trigger5_connector_init(trigger5, is_hdmi ?
+					      DRM_MODE_CONNECTOR_HDMIA :
+					      DRM_MODE_CONNECTOR_VGA);
+	if (ret)
+		goto err_alloc_1;
+
+	ret = drm_encoder_init(dev, &trigger5->encoder, &trigger5_encoder_funcs,
+			       is_hdmi ? DRM_MODE_ENCODER_TMDS :
+					 DRM_MODE_ENCODER_DAC, NULL);
+	if (ret)
+		goto err_alloc_1;
+	trigger5->encoder.possible_crtcs = drm_crtc_mask(&trigger5->crtc);
+
+	ret = drm_connector_attach_encoder(&trigger5->connector,
+					   &trigger5->encoder);
+	if (ret)
+		goto err_alloc_1;
+
+	trigger5->transfer_wq = alloc_ordered_workqueue(DRIVER_NAME, 0);
+	if (!trigger5->transfer_wq) {
+		ret = -ENOMEM;
+		goto err_alloc_1;
+	}
+
+	INIT_DELAYED_WORK(&trigger5->keepalive_work,
+			  trigger5_keepalive_work);
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
+	destroy_workqueue(trigger5->transfer_wq);
+err_alloc_1:
+	trigger5_free_bulk_buffer(&trigger5->transfers[1]);
+err_alloc_0:
+	trigger5_free_bulk_buffer(&trigger5->transfers[0]);
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
+	destroy_workqueue(trigger5->transfer_wq);
+	trigger5_free_bulk_buffer(&trigger5->transfers[0]);
+	trigger5_free_bulk_buffer(&trigger5->transfers[1]);
+}
+
+static const struct usb_device_id id_table[] = {
+	/* From Windows driver INF file */
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

base-commit: 3ab04dcce43cd4fdaed94f08f4e6289be4921ea4
-- 
2.55.0

