Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8200606D826
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0Znr8UJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3318510FCAE;
	Wed,  4 Nov 2026 15:19:05 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B377310FCAE
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:18:59 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8a05da1cc1fso407069b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793805539; x=1794410339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yhBtSNsyIwrm4LrFf/4zBy7lQS8IR81juBM+N+p1p2Q=;
 b=t0Znr8UJSCrohXynWpTowY0aaXNlP2TzzAegSZBY35f1Ll1+9Gbl7dFk8Pz1AcMLCf
 fPyHRHg8dMMxnumiBLsOuA6IFGGaAjHwx8mRx8R1n75V6WIH9Sa0RQlamdqUcTZrarsq
 1CM+qwXvWfvgtkdRcsY046ISytNHiC6NCOJ/2XHr0EjijQcIDsAhQ7/Mcqi9PY1VBgeb
 LDeL+IJWVhPetDGVEJcALmTj9O11OYI4+CMkWax6Z9HCNnFnThlmLf9qPykmfo9BCdep
 91hSFbBJVb93f8QAGAUJxyF+kmsAOxaXrtFav4vmQYDdNk5F3lm9BAZFYHRYQI/qMEFO
 jAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793805539; x=1794410339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yhBtSNsyIwrm4LrFf/4zBy7lQS8IR81juBM+N+p1p2Q=;
 b=M1wNVebvyqtwmwSE1nEvz1M4YbPFx+gnbTdmpzZ9sLpX2yLiTTP1DlJJT79jxkC4bH
 2KY6LTRgnNsYFgUr44fEtNkLH8hS3Lv4B5PtIV9vjZQhAoSb9sIEIKWjYFrXFlOyS5/j
 YgpwtHe9Ih0WOjRe7INrrzCOAX4V5AJA6AfrV4/evgYpz+EyhS8TUMS6WOAUGtRvfsTn
 ltfipmGP0TBiJxbBiYXmZBDeeonCMy1pw4bsAX3RSIuJDmJy7k6JNzl9OClOrPBF6Fu2
 9OD1YI5S9dry4qW3GlLUzOK5eCNrZgCy3Kt6+ENXH6IzXufrUgKZ7BbFJWzUR34Egr8/
 3Ufg==
X-Gm-Message-State: APuU4Z/69So+yMYDNq1WWUFNcFrfkm/isd/MpEJjlYOkU3+vfS1dcS36
 QZmcXxGwDL7NNLQw7xbsbpBGx+N3yVUkiziQOCBPvLo5Tg6zR8O+gUMw2ANhUsdN
X-Gm-Gg: AYBFou3CW6WbcF+525Q2snF+mAK4YSI2Jn2GS0G+jmv+NrY0GNSyuEB356rItYxJ2+j
 c4g1VbC+j9vl7QxTQxRfBNbl5d6Hd6DYh+NVYFkzUiklkBCU7mWNfkr8iWZ99ZPBTfNlGtJoorm
 YIs0S+5dagS3XH9NN0dd1H0cq2OvOteCoW91NtsHJN5ealaQ99A75mpqNDZLxQ4wlwO2XTw1hse
 LF/fwW/nGeKbaiv7iJxok3gF8p7qD/8flo3IewpPHM0NOCP5Rr9AA9Cek4Is6JRjQQXZEHRfRZX
 MmBiyUbKQdf+TxZMJr3pM9ATjQMBvwjlu+ls9u4UDRLge6k0zYCCCqjLbxA5rDyYEeeBU63adCZ
 O+qo41lVbiSo3MFtXC08kJhUzaCIic0XOP/vRxrmAHb4YAy0JRfysTLvo6Z/essbC+uitxzBIa/
 eiIhtBaFPYQad5ixposjy91PNpOI3M5/9HRZd8GjLFDh3AFTdV/HXXdH6qPWMzXKYgu6vuBcu9a
 jRVds4VELJdq1BOownsJ0y35NRddcUdd+ebtv+2St3n69sguKLnwxMEvw4SONOEyMiK1jB5MDif
 gA0ZxFf53WfZfci9eB8iQbwoIlb1DbvwrkX+EHEYgBk0T6kZU8kzxfzMMOxj1TXdrQD7w/7OU6k
 H0fty
X-Received: by 2002:a05:6a20:a108:b0:3e2:729c:9bcb with SMTP id
 adf61e73a8af0-3e928e26848mr16541510637.65.1793805538965; 
 Wed, 04 Nov 2026 07:18:58 -0800 (PST)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:65cc:625f:9c43:1e88])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8b097fdf9bdsm1110555b3a.7.2026.11.04.07.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:18:58 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] drm/ms91xx: Add register access and connector support
Date: Wed,  4 Nov 2026 23:16:48 +0800
Message-ID: <20261104151652.59135-3-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104151652.59135-1-hjf3108@gmail.com>
References: <20261104151652.59135-1-hjf3108@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add HID register and flash access, decode custom device timings, and enumerate connector modes for MacroSilicon MS912x/MS913x adapters.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/gpu/drm/ms91xx/ms91xx.h           | 221 ++++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_connector.c | 267 +++++++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_registers.c | 393 ++++++++++++++++++++++
 3 files changed, 881 insertions(+)
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx.h
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_connector.c
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_registers.c

diff --git a/drivers/gpu/drm/ms91xx/ms91xx.h b/drivers/gpu/drm/ms91xx/ms91xx.h
new file mode 100644
index 000000000..6e8c4d64a
--- /dev/null
+++ b/drivers/gpu/drm/ms91xx/ms91xx.h
@@ -0,0 +1,221 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022-2026 Ho Jie Feng <hjf3108@gmail.com>
+ * Copyright (C) 2023 MacroSilicon Technology Co., Ltd.
+ */
+
+#ifndef MS91XX_H
+#define MS91XX_H
+
+#include <linux/bits.h>
+#include <linux/compiler_attributes.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/mutex.h>
+#include <linux/scatterlist.h>
+#include <linux/timer_types.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_rect.h>
+
+struct drm_format_conv_state;
+struct drm_framebuffer;
+struct iosys_map;
+
+#define DRIVER_NAME "ms91xx"
+#define DRIVER_DESC "MacroSilicon USB to VGA/HDMI"
+
+#define DRIVER_MAJOR 1
+#define DRIVER_MINOR 0
+
+#define MS91XX_BULK_OUT_ENDPOINT	4
+
+#define MS91XX_REQ_TYPE_WRITE_6_BYTES	0xa6
+#define MS91XX_REQ_TYPE_READ_BYTE	0xb5
+#define MS91XX_REQ_TYPE_READ_FLASH	0xf5
+
+#define MS91XX_REG_VIDEO_PORT		0x0031
+#define MS91XX_REG_DISPLAY_STATUS	0x0032
+#define MS91XX_REG_EDID_BASE		0xc000
+
+#define MS91XX_REG_MODE_SEQUENCE_0	0x0030
+#define MS91XX_REG_MODE_SEQUENCE_1	0x0033
+#define MS91XX_REG_MODE_SEQUENCE_2	0xc620
+
+#define MS91XX_CMD_RESOLUTION		0x01
+#define MS91XX_CMD_MODE			0x02
+#define MS91XX_CMD_UNKNOWN1		0x03
+#define MS91XX_CMD_UNKNOWN2		0x04
+#define MS91XX_CMD_OUTPUT_ENABLE	0x05
+#define MS91XX_CMD_POWER		0x07
+
+#define MS913X_REG_CHIP_ID			0xff00
+#define MS912X_REG_CHIP_ID			0xf000
+#define MS913X_CHIP_ID_SIGNATURE_MSB		0x13
+#define MS912X_CHIP_ID_SIGNATURE_MSB		0x16
+#define MS91XX_CHIP_ID_SIGNATURE_LSB		0x0a
+#define MS913X_CUSTOM_TIMING_BASE		0xfc50
+#define MS912X_CUSTOM_TIMING_BASE		0x1c00
+#define MS91XX_CUSTOM_TIMING_OFFSET		0x10
+#define MS91XX_CUSTOM_TIMING_STRIDE		0x20
+
+#define MS91XX_TIMING_PROGRESSIVE		BIT(0)
+#define MS91XX_TIMING_POSITIVE_HSYNC		BIT(1)
+#define MS91XX_TIMING_POSITIVE_VSYNC		BIT(2)
+
+enum ms91xx_video_port {
+	MS91XX_VIDEO_PORT_CVBS = 0,
+	MS91XX_VIDEO_PORT_SVIDEO = 1,
+	MS91XX_VIDEO_PORT_VGA = 2,
+	MS91XX_VIDEO_PORT_YPBPR = 3,
+	MS91XX_VIDEO_PORT_CVBS_SVIDEO = 4,
+	MS91XX_VIDEO_PORT_HDMI = 5,
+	MS91XX_VIDEO_PORT_DIGITAL = 6,
+	MS91XX_VIDEO_PORT_UNKNOWN = 0xff,
+};
+
+struct ms91xx_usb_request {
+	void *transfer_buffer;
+	struct ms91xx_device *ms91xx;
+	size_t transfer_len;
+	struct drm_rect transfer_rect;
+	struct sg_table transfer_sgt;
+	struct usb_sg_request sgr;
+	struct work_struct work;
+	struct timer_list timer;
+	struct completion done;
+};
+
+struct ms91xx_mode {
+	int width;
+	int height;
+	int hz;
+	int mode;
+};
+
+struct ms91xx_custom_mode {
+	struct ms91xx_mode mode;
+	struct drm_display_mode display_mode;
+};
+
+#define MS91XX_PIXFMT_RGB888		0x11
+#define MS91XX_PIXFMT_UYVY		0x22
+#define MS91XX_BYTE_SELECT_UYVY		0x00
+
+#define MS91XX_MODE(w, h, z, m)                                               \
+	{                                                                      \
+		.width = w, .height = h, .hz = z, .mode = m                    \
+	}
+
+struct ms91xx_device {
+	struct drm_device drm;
+	struct usb_interface *intf;
+	unsigned int bulk_pipe;
+	enum ms91xx_video_port port_type;
+	struct workqueue_struct *workqueue;
+	/* Serializes HID control request/response sequences */
+	struct mutex ctrl_lock;
+
+	struct drm_connector connector;
+	struct drm_encoder encoder;
+	struct drm_crtc crtc;
+	struct drm_plane plane;
+
+	struct ms91xx_custom_mode custom_modes[2];
+	unsigned int num_custom_modes;
+
+	struct drm_rect update_rect;
+
+	/* Double buffer to allow memcpy and transfer
+	 * to happen in parallel
+	 */
+	int current_request;
+	struct ms91xx_usb_request requests[2];
+};
+
+struct ms91xx_request {
+	u8 type;
+	__be16 addr;
+	u8 data[5];
+} __packed;
+
+struct ms91xx_write_request {
+	u8 type;
+	u8 addr;
+	u8 data[6];
+} __packed;
+
+struct ms91xx_resolution_request {
+	__be16 width;
+	__be16 height;
+	u8 pixel_format;
+	u8 byte_select;
+} __packed;
+
+struct ms91xx_mode_request {
+	u8 mode;
+	u8 pixel_format;
+	__be16 width;
+	__be16 height;
+} __packed;
+
+struct ms91xx_frame_update_header {
+	__be16 marker;
+	u8 position[3]; /* x:y, packed 12-bit big-endian values */
+	u8 dimensions[3]; /* width:height, packed 12-bit big-endian values */
+} __packed;
+
+struct ms91xx_flash_read_request {
+	u8 type;
+	u8 addr[3];
+	u8 reserved[4];
+} __packed;
+
+struct ms91xx_custom_timing_record {
+	u8 vic;
+	u8 polarity;
+	__le16 htotal;
+	__le16 vtotal;
+	__le16 hactive;
+	__le16 vactive;
+	__le16 pixclk;
+	__le16 vfreq;
+	__le16 hoffset;
+	__le16 voffset;
+	__le16 hsyncwidth;
+	__le16 vsyncwidth;
+} __packed;
+
+#define MS91XX_FRAME_OVERHEAD 16
+#define MS91XX_MAX_WIDTH 1920
+#define MS91XX_MAX_HEIGHT 1200
+#define MS91XX_MAX_TRANSFER_LEN \
+	(MS91XX_MAX_WIDTH * MS91XX_MAX_HEIGHT * 2 + MS91XX_FRAME_OVERHEAD)
+
+#define to_ms91xx(x) container_of(x, struct ms91xx_device, drm)
+
+int ms91xx_read_byte(struct ms91xx_device *ms91xx, u16 address);
+int ms91xx_read_custom_timing(struct ms91xx_device *ms91xx);
+int ms91xx_connector_init(struct ms91xx_device *ms91xx);
+int ms91xx_set_resolution(struct ms91xx_device *ms91xx,
+			  const struct ms91xx_mode *mode);
+
+int ms91xx_power_on(struct ms91xx_device *ms91xx);
+int ms91xx_power_off(struct ms91xx_device *ms91xx);
+
+int ms91xx_fb_send_rect(struct drm_framebuffer *fb, const struct iosys_map *map,
+			struct drm_format_conv_state *fmtcnv_state,
+			struct drm_rect *rect);
+
+void ms91xx_free_request(struct ms91xx_usb_request *request);
+int ms91xx_init_request(struct ms91xx_device *ms91xx,
+			struct ms91xx_usb_request *request, size_t len);
+#endif
diff --git a/drivers/gpu/drm/ms91xx/ms91xx_connector.c b/drivers/gpu/drm/ms91xx/ms91xx_connector.c
new file mode 100644
index 000000000..08371d121
--- /dev/null
+++ b/drivers/gpu/drm/ms91xx/ms91xx_connector.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2026 Ho Jie Feng <hjf3108@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_mode_config.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_print.h>
+
+#include "ms91xx.h"
+
+static int ms91xx_get_connector_type(struct ms91xx_device *ms91xx)
+{
+	int port_type;
+
+	port_type = ms91xx_read_byte(ms91xx, MS91XX_REG_VIDEO_PORT);
+	if (port_type < 0) {
+		drm_warn(&ms91xx->drm,
+			 "failed to read video port type: %d\n", port_type);
+		ms91xx->port_type = MS91XX_VIDEO_PORT_UNKNOWN;
+		return DRM_MODE_CONNECTOR_Unknown;
+	}
+
+	ms91xx->port_type = port_type;
+
+	switch (ms91xx->port_type) {
+	case MS91XX_VIDEO_PORT_CVBS:
+		return DRM_MODE_CONNECTOR_Composite;
+	case MS91XX_VIDEO_PORT_VGA:
+		return DRM_MODE_CONNECTOR_VGA;
+	case MS91XX_VIDEO_PORT_YPBPR:
+		return DRM_MODE_CONNECTOR_Component;
+	/*
+	 * Combo VGA+HDMI device seems to report this as connector type
+	 * Since there doesn't seem to be any S-Video devices out there,
+	 * set this to HDMI instead.
+	 */
+	case MS91XX_VIDEO_PORT_SVIDEO:
+	case MS91XX_VIDEO_PORT_HDMI:
+		return DRM_MODE_CONNECTOR_HDMIA;
+	case MS91XX_VIDEO_PORT_DIGITAL:
+		return DRM_MODE_CONNECTOR_DPI;
+	case MS91XX_VIDEO_PORT_CVBS_SVIDEO:
+		return DRM_MODE_CONNECTOR_9PinDIN;
+	default:
+		drm_warn(&ms91xx->drm,
+			 "unknown video port type: %d\n", port_type);
+		ms91xx->port_type = MS91XX_VIDEO_PORT_UNKNOWN;
+		return DRM_MODE_CONNECTOR_Unknown;
+	}
+}
+
+static int
+ms91xx_get_encoder_type(enum ms91xx_video_port port_type)
+{
+	switch (port_type) {
+	case MS91XX_VIDEO_PORT_VGA:
+		return DRM_MODE_ENCODER_DAC;
+	case MS91XX_VIDEO_PORT_CVBS:
+	case MS91XX_VIDEO_PORT_YPBPR:
+	case MS91XX_VIDEO_PORT_CVBS_SVIDEO:
+		return DRM_MODE_ENCODER_TVDAC;
+	/* See above comment */
+	case MS91XX_VIDEO_PORT_SVIDEO:
+	case MS91XX_VIDEO_PORT_HDMI:
+		return DRM_MODE_ENCODER_TMDS;
+	case MS91XX_VIDEO_PORT_DIGITAL:
+		return DRM_MODE_ENCODER_DPI;
+	case MS91XX_VIDEO_PORT_UNKNOWN:
+	default:
+		return DRM_MODE_ENCODER_NONE;
+	}
+}
+
+static int ms91xx_read_edid(void *data, u8 *buf, unsigned int block, size_t len)
+{
+	struct ms91xx_device *ms91xx = data;
+	int offset = block * EDID_LENGTH;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < len; i++) {
+		u16 address = MS91XX_REG_EDID_BASE + offset + i;
+
+		ret = ms91xx_read_byte(ms91xx, address);
+		if (ret < 0)
+			return ret;
+		buf[i] = ret;
+	}
+	return 0;
+}
+
+static int ms91xx_add_cea_modes(struct drm_connector *connector,
+				const u8 *vics, size_t num_vics)
+{
+	struct drm_display_mode *mode;
+	unsigned int i;
+	int count = 0;
+
+	drm_edid_connector_update(connector, NULL);
+
+	for (i = 0; i < num_vics; i++) {
+		mode = drm_display_mode_from_cea_vic(connector->dev, vics[i]);
+		if (!mode)
+			continue;
+
+		if (!count)
+			mode->type |= DRM_MODE_TYPE_PREFERRED;
+		drm_mode_probed_add(connector, mode);
+		count++;
+	}
+
+	return count;
+}
+
+static int ms91xx_add_cvbs_svideo_modes(struct drm_connector *connector)
+{
+	static const u8 vics[] = {
+		2,  /* 720x480p60 */
+		17, /* 720x576p50 */
+	};
+
+	return ms91xx_add_cea_modes(connector, vics, ARRAY_SIZE(vics));
+}
+
+static int ms91xx_add_ypbpr_modes(struct drm_connector *connector)
+{
+	static const u8 vics[] = {
+		4,  /* 1280x720p60 */
+		16, /* 1920x1080p60 */
+		2,  /* 720x480p60 */
+		17, /* 720x576p50 */
+	};
+
+	return ms91xx_add_cea_modes(connector, vics, ARRAY_SIZE(vics));
+}
+
+static int
+ms91xx_add_default_hdmi_vga_modes(struct drm_connector *connector)
+{
+	struct drm_mode_config *mode_config = &connector->dev->mode_config;
+	int count;
+
+	drm_edid_connector_update(connector, NULL);
+	count = drm_add_modes_noedid(connector, mode_config->max_width,
+				     mode_config->max_height);
+	if (count)
+		drm_set_preferred_mode(connector, 1024, 768);
+
+	return count;
+}
+
+static int ms91xx_add_custom_mode(struct drm_connector *connector)
+{
+	struct ms91xx_device *ms91xx = to_ms91xx(connector->dev);
+	struct drm_display_mode *mode;
+	unsigned int i;
+	int count = 0;
+
+	for (i = 0; i < ms91xx->num_custom_modes; i++) {
+		mode = drm_mode_duplicate(
+			connector->dev,
+			&ms91xx->custom_modes[i].display_mode);
+		if (!mode)
+			continue;
+
+		drm_mode_probed_add(connector, mode);
+		count++;
+	}
+
+	return count;
+}
+
+static int ms91xx_connector_get_modes(struct drm_connector *connector)
+{
+	struct ms91xx_device *ms91xx = to_ms91xx(connector->dev);
+	const struct drm_edid *edid;
+	int ret = ms91xx_add_custom_mode(connector);
+
+	if (ms91xx->port_type == MS91XX_VIDEO_PORT_CVBS ||
+	    ms91xx->port_type == MS91XX_VIDEO_PORT_CVBS_SVIDEO ||
+	    ms91xx->port_type == MS91XX_VIDEO_PORT_UNKNOWN)
+		return ret + ms91xx_add_cvbs_svideo_modes(connector);
+
+	if (ms91xx->port_type == MS91XX_VIDEO_PORT_YPBPR)
+		return ret + ms91xx_add_ypbpr_modes(connector);
+
+	edid = drm_edid_read_custom(connector, ms91xx_read_edid, ms91xx);
+	if (!edid)
+		return ret + ms91xx_add_default_hdmi_vga_modes(connector);
+
+	if (drm_edid_connector_update(connector, edid) >= 0)
+		ret += drm_edid_connector_add_modes(connector);
+	drm_edid_free(edid);
+	return ret;
+}
+
+static enum drm_connector_status ms91xx_detect(struct drm_connector *connector,
+					       bool force)
+{
+	struct ms91xx_device *ms91xx = to_ms91xx(connector->dev);
+	int status = ms91xx_read_byte(ms91xx, MS91XX_REG_DISPLAY_STATUS);
+
+	if (status < 0)
+		return connector_status_unknown;
+
+	return status == 1 ? connector_status_connected :
+			     connector_status_disconnected;
+}
+
+static const struct drm_encoder_funcs ms91xx_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct drm_connector_helper_funcs ms91xx_connector_helper_funcs = {
+	.get_modes = ms91xx_connector_get_modes,
+};
+
+static const struct drm_connector_funcs ms91xx_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.detect = ms91xx_detect,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+int ms91xx_connector_init(struct ms91xx_device *ms91xx)
+{
+	int ret;
+	int connector_type;
+	int encoder_type;
+
+	connector_type = ms91xx_get_connector_type(ms91xx);
+	encoder_type = ms91xx_get_encoder_type(ms91xx->port_type);
+
+	ret = drm_encoder_init(&ms91xx->drm, &ms91xx->encoder,
+			       &ms91xx_encoder_funcs, encoder_type, NULL);
+	if (ret)
+		return ret;
+	ms91xx->encoder.possible_crtcs = drm_crtc_mask(&ms91xx->crtc);
+
+	drm_connector_helper_add(&ms91xx->connector,
+				 &ms91xx_connector_helper_funcs);
+	ret = drm_connector_init(&ms91xx->drm, &ms91xx->connector,
+				 &ms91xx_connector_funcs, connector_type);
+	if (ret)
+		return ret;
+
+	ms91xx->connector.polled =
+		DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
+	ms91xx->connector.interlace_allowed = true;
+
+	return drm_connector_attach_encoder(&ms91xx->connector,
+					    &ms91xx->encoder);
+}
diff --git a/drivers/gpu/drm/ms91xx/ms91xx_registers.c b/drivers/gpu/drm/ms91xx/ms91xx_registers.c
new file mode 100644
index 000000000..2a45ebc86
--- /dev/null
+++ b/drivers/gpu/drm/ms91xx/ms91xx_registers.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2026 Ho Jie Feng <hjf3108@gmail.com>
+ * Copyright (C) 2023 MacroSilicon Technology Co., Ltd.
+ */
+
+#include <asm/byteorder.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/hid.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_modes.h>
+
+#include "ms91xx.h"
+
+int ms91xx_read_byte(struct ms91xx_device *ms91xx, u16 address)
+{
+	struct ms91xx_request request;
+	struct usb_device *usb_dev;
+	int idx, ret;
+
+	if (!drm_dev_enter(&ms91xx->drm, &idx))
+		return -ENODEV;
+
+	mutex_lock(&ms91xx->ctrl_lock);
+
+	usb_dev = interface_to_usbdev(ms91xx->intf);
+	memset(&request, 0, sizeof(request));
+	request.type = MS91XX_REQ_TYPE_READ_BYTE;
+	request.addr = cpu_to_be16(address);
+
+	ret = usb_control_msg_send(usb_dev, 0, HID_REQ_SET_REPORT,
+				   USB_DIR_OUT | USB_TYPE_CLASS |
+					   USB_RECIP_INTERFACE,
+				   0x0300, 0, &request, sizeof(request),
+				   USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	if (ret)
+		goto ctrl_unlock;
+
+	ret = usb_control_msg_recv(usb_dev, 0, HID_REQ_GET_REPORT,
+				   USB_DIR_IN | USB_TYPE_CLASS |
+					   USB_RECIP_INTERFACE,
+				   0x0300, 0, &request, sizeof(request),
+				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	if (!ret)
+		ret = request.data[0];
+
+ctrl_unlock:
+	mutex_unlock(&ms91xx->ctrl_lock);
+	drm_dev_exit(idx);
+	return ret;
+}
+
+static int ms91xx_read_flash(struct ms91xx_device *ms91xx, u32 address,
+			     void *data, size_t len)
+{
+	struct ms91xx_flash_read_request request;
+	struct usb_device *usb_dev;
+	size_t offset = 0;
+	u8 *dst = data;
+	int idx, ret = 0;
+
+	if (address > 0xffffff || len > 0x1000000 - address)
+		return -ERANGE;
+
+	if (!drm_dev_enter(&ms91xx->drm, &idx))
+		return -ENODEV;
+
+	mutex_lock(&ms91xx->ctrl_lock);
+	usb_dev = interface_to_usbdev(ms91xx->intf);
+
+	while (offset < len) {
+		size_t chunk = min_t(size_t, len - offset, sizeof(request));
+		u32 current_address = address + offset;
+
+		memset(&request, 0, sizeof(request));
+		request.type = MS91XX_REQ_TYPE_READ_FLASH;
+		request.addr[0] = current_address >> 16;
+		request.addr[1] = current_address >> 8;
+		request.addr[2] = current_address;
+
+		ret = usb_control_msg_send(usb_dev, 0, HID_REQ_SET_REPORT,
+					   USB_DIR_OUT | USB_TYPE_CLASS |
+						   USB_RECIP_INTERFACE,
+					   0x0300, 0, &request,
+					   sizeof(request),
+					   USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+		if (ret)
+			goto ctrl_unlock;
+
+		ret = usb_control_msg_recv(usb_dev, 0, HID_REQ_GET_REPORT,
+					   USB_DIR_IN | USB_TYPE_CLASS |
+						   USB_RECIP_INTERFACE,
+					   0x0300, 0, &request,
+					   sizeof(request),
+					   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+		if (ret)
+			goto ctrl_unlock;
+
+		memcpy(dst + offset, &request, chunk);
+		offset += chunk;
+	}
+
+ctrl_unlock:
+	mutex_unlock(&ms91xx->ctrl_lock);
+	drm_dev_exit(idx);
+	return ret;
+}
+
+static int ms91xx_custom_timing_base(struct ms91xx_device *ms91xx)
+{
+	u8 signature[3];
+	int ret;
+
+	/* Read chip signature */
+	ret = ms91xx_read_byte(ms91xx, MS913X_REG_CHIP_ID);
+	if (ret < 0)
+		return ret;
+	signature[0] = ret;
+
+	ret = ms91xx_read_byte(ms91xx, MS913X_REG_CHIP_ID + 1);
+	if (ret < 0)
+		return ret;
+	signature[1] = ret;
+
+	ret = ms91xx_read_byte(ms91xx, MS913X_REG_CHIP_ID + 2);
+	if (ret < 0)
+		return ret;
+	signature[2] = ret;
+
+	if (signature[1] == MS913X_CHIP_ID_SIGNATURE_MSB &&
+	    signature[2] == MS91XX_CHIP_ID_SIGNATURE_LSB)
+		return MS913X_CUSTOM_TIMING_BASE;
+
+	ret = ms91xx_read_byte(ms91xx, MS912X_REG_CHIP_ID);
+	if (ret < 0)
+		return ret;
+	signature[0] = ret;
+
+	ret = ms91xx_read_byte(ms91xx, MS912X_REG_CHIP_ID + 1);
+	if (ret < 0)
+		return ret;
+	signature[1] = ret;
+
+	ret = ms91xx_read_byte(ms91xx, MS912X_REG_CHIP_ID + 2);
+	if (ret < 0)
+		return ret;
+	signature[2] = ret;
+
+	if (signature[1] == MS912X_CHIP_ID_SIGNATURE_MSB &&
+	    signature[2] == MS91XX_CHIP_ID_SIGNATURE_LSB)
+		return MS912X_CUSTOM_TIMING_BASE;
+
+	return -ENODEV;
+}
+
+static int
+ms91xx_decode_custom_timing(struct ms91xx_custom_mode *custom_mode,
+			    const struct ms91xx_custom_timing_record *record)
+{
+	struct drm_display_mode *display_mode = &custom_mode->display_mode;
+	u16 hsyncwidth = le16_to_cpu(record->hsyncwidth);
+	u16 vsyncwidth = le16_to_cpu(record->vsyncwidth);
+	u16 hoffset = le16_to_cpu(record->hoffset);
+	u16 voffset = le16_to_cpu(record->voffset);
+	u16 hactive = le16_to_cpu(record->hactive);
+	u16 vactive = le16_to_cpu(record->vactive);
+	u16 htotal = le16_to_cpu(record->htotal);
+	u16 vtotal = le16_to_cpu(record->vtotal);
+	u16 pixclk = le16_to_cpu(record->pixclk);
+	u16 vfreq = le16_to_cpu(record->vfreq);
+	unsigned int hblank, vblank;
+	int refresh;
+
+	if (!hactive || hactive > MS91XX_MAX_WIDTH || (hactive & 1) ||
+	    !vactive || vactive > MS91XX_MAX_HEIGHT ||
+	    htotal <= hactive || vtotal <= vactive || !pixclk || !vfreq)
+		return -EINVAL;
+
+	hblank = htotal - hactive;
+	vblank = vtotal - vactive;
+	if (!hsyncwidth || hsyncwidth > hoffset || hoffset > hblank ||
+	    !vsyncwidth || vsyncwidth > voffset || voffset > vblank)
+		return -EINVAL;
+
+	memset(display_mode, 0, sizeof(*display_mode));
+	display_mode->clock = pixclk * 10;
+	display_mode->hdisplay = hactive;
+	display_mode->hsync_start = htotal - hoffset;
+	display_mode->hsync_end = display_mode->hsync_start + hsyncwidth;
+	display_mode->htotal = htotal;
+	display_mode->vdisplay = vactive;
+	display_mode->vsync_start = vtotal - voffset;
+	display_mode->vsync_end = display_mode->vsync_start + vsyncwidth;
+	display_mode->vtotal = vtotal;
+	display_mode->type = DRM_MODE_TYPE_DRIVER;
+	display_mode->flags =
+		record->polarity & MS91XX_TIMING_POSITIVE_HSYNC ?
+			DRM_MODE_FLAG_PHSYNC : DRM_MODE_FLAG_NHSYNC;
+	display_mode->flags |=
+		record->polarity & MS91XX_TIMING_POSITIVE_VSYNC ?
+			DRM_MODE_FLAG_PVSYNC : DRM_MODE_FLAG_NVSYNC;
+	if (!(record->polarity & MS91XX_TIMING_PROGRESSIVE))
+		display_mode->flags |= DRM_MODE_FLAG_INTERLACE;
+
+	refresh = DIV_ROUND_CLOSEST(vfreq, 100);
+	if (!refresh || drm_mode_vrefresh(display_mode) != refresh)
+		return -EINVAL;
+
+	drm_mode_set_name(display_mode);
+	custom_mode->mode.width = hactive;
+	custom_mode->mode.height = vactive;
+	custom_mode->mode.hz = refresh;
+	custom_mode->mode.mode = record->vic;
+
+	return 0;
+}
+
+int ms91xx_read_custom_timing(struct ms91xx_device *ms91xx)
+{
+	struct ms91xx_custom_timing_record record;
+	unsigned int num_records, i;
+	int error = 0;
+	u8 marker[7];
+	int base, ret;
+
+	ms91xx->num_custom_modes = 0;
+
+	base = ms91xx_custom_timing_base(ms91xx);
+	if (base < 0)
+		return base;
+
+	ret = ms91xx_read_flash(ms91xx, base, marker, sizeof(marker));
+	if (ret)
+		return ret;
+
+	if (!memcmp(marker, "modify1", sizeof(marker)))
+		num_records = 1;
+	else if (!memcmp(marker, "modify2", sizeof(marker)))
+		num_records = 2;
+	else
+		return 0;
+
+	for (i = 0; i < num_records; i++) {
+		ret = ms91xx_read_flash(ms91xx,
+					base + MS91XX_CUSTOM_TIMING_OFFSET +
+						i * MS91XX_CUSTOM_TIMING_STRIDE,
+					&record, sizeof(record));
+		if (ret) {
+			error = ret;
+			continue;
+		}
+
+		ret = ms91xx_decode_custom_timing(
+			&ms91xx->custom_modes[ms91xx->num_custom_modes],
+			&record);
+		if (ret) {
+			error = ret;
+			continue;
+		}
+
+		ms91xx->num_custom_modes++;
+	}
+
+	if (ms91xx->num_custom_modes)
+		ms91xx->custom_modes[0].display_mode.type |= DRM_MODE_TYPE_PREFERRED;
+
+	return ms91xx->num_custom_modes ? ms91xx->num_custom_modes : error;
+}
+
+static int ms91xx_write_6_bytes(struct ms91xx_device *ms91xx,
+				u8 address, const void *data)
+{
+	struct ms91xx_write_request request;
+	struct usb_device *usb_dev;
+	int idx, ret;
+
+	if (!drm_dev_enter(&ms91xx->drm, &idx))
+		return -ENODEV;
+
+	mutex_lock(&ms91xx->ctrl_lock);
+
+	usb_dev = interface_to_usbdev(ms91xx->intf);
+	request.type = MS91XX_REQ_TYPE_WRITE_6_BYTES;
+	request.addr = address;
+	memcpy(request.data, data, sizeof(request.data));
+
+	ret = usb_control_msg_send(usb_dev, 0, HID_REQ_SET_REPORT,
+				   USB_DIR_OUT | USB_TYPE_CLASS |
+					   USB_RECIP_INTERFACE,
+				   0x0300, 0, &request, sizeof(request),
+				   USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	mutex_unlock(&ms91xx->ctrl_lock);
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
+int ms91xx_power_on(struct ms91xx_device *ms91xx)
+{
+	u8 data[6];
+
+	memset(data, 0, sizeof(data));
+	data[0] = 0x01;
+	data[1] = 0x02;
+
+	return ms91xx_write_6_bytes(ms91xx, MS91XX_CMD_POWER, data);
+}
+
+int ms91xx_power_off(struct ms91xx_device *ms91xx)
+{
+	u8 data[6];
+
+	memset(data, 0, sizeof(data));
+
+	return ms91xx_write_6_bytes(ms91xx, MS91XX_CMD_POWER, data);
+}
+
+int ms91xx_set_resolution(struct ms91xx_device *ms91xx,
+			  const struct ms91xx_mode *mode)
+{
+	int ret;
+	u8 data[6];
+	struct ms91xx_resolution_request resolution_request;
+	struct ms91xx_mode_request mode_request;
+
+	int width = mode->width;
+	int height = mode->height;
+	int mode_num = mode->mode;
+
+	/* Sequence obtained from Windows USB captures */
+	memset(data, 0, sizeof(data));
+	data[0] = 0;
+	ret = ms91xx_write_6_bytes(ms91xx, MS91XX_CMD_UNKNOWN2, data);
+	if (ret < 0)
+		return ret;
+
+	ret = ms91xx_read_byte(ms91xx, MS91XX_REG_MODE_SEQUENCE_0);
+	if (ret < 0)
+		return ret;
+	ret = ms91xx_read_byte(ms91xx, MS91XX_REG_MODE_SEQUENCE_1);
+	if (ret < 0)
+		return ret;
+	ret = ms91xx_read_byte(ms91xx, MS91XX_REG_MODE_SEQUENCE_2);
+	if (ret < 0)
+		return ret;
+
+	memset(data, 0, sizeof(data));
+	data[0] = 0x03;
+	ret = ms91xx_write_6_bytes(ms91xx, MS91XX_CMD_UNKNOWN1, data);
+	if (ret < 0)
+		return ret;
+
+	/* Write resolution */
+	resolution_request.width = cpu_to_be16(width);
+	resolution_request.height = cpu_to_be16(height);
+	resolution_request.pixel_format = MS91XX_PIXFMT_UYVY;
+	resolution_request.byte_select = MS91XX_BYTE_SELECT_UYVY;
+	ret = ms91xx_write_6_bytes(ms91xx, MS91XX_CMD_RESOLUTION,
+				   &resolution_request);
+	if (ret < 0)
+		return ret;
+
+	/* Write mode */
+	mode_request.mode = mode_num;
+	mode_request.pixel_format = 0x01;
+	mode_request.width = cpu_to_be16(width);
+	mode_request.height = cpu_to_be16(height);
+	ret = ms91xx_write_6_bytes(ms91xx, MS91XX_CMD_MODE, &mode_request);
+	if (ret < 0)
+		return ret;
+
+	memset(data, 0, sizeof(data));
+	data[0] = 1;
+	ret = ms91xx_write_6_bytes(ms91xx, MS91XX_CMD_UNKNOWN2, data);
+	if (ret < 0)
+		return ret;
+
+	memset(data, 0, sizeof(data));
+	data[0] = 1;
+	ret = ms91xx_write_6_bytes(ms91xx, MS91XX_CMD_OUTPUT_ENABLE, data);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
-- 
2.55.0

