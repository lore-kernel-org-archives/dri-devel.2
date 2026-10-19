Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59260882A9
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=deIqjo87
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596B110EEC4;
	Mon, 19 Oct 2026 15:48:56 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF9E10EEAD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:48:50 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso1226283a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792424930; x=1793029730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y8P248VAWa6oQ3dnRvNa88m3jub2X/2RJUo0EevicM8=;
 b=deIqjo87qqN6s0SCbKhqE02MUa9UdrqG6qK8wz+jm0KyntWE0ipNIiFIFr/qFOdmdu
 b+hotzClw/hdl2CAlnHq/Aw1H6y790ZG033lSgbqe2qmoI1yd8HDJEJfyg6wUi9fan85
 ULsiOm2SNaEXWJ73fAy5k04d+eSeXouwNzMed0GItKQvM2xG64ec5lgmDoCR6JwqhJtR
 vrdHUN78WwmaNlonQ0n6Qd6gXxlj7Cnvek3bvfhYrhNNB+vsiE3LquoZ3VMvQj9xUkR/
 /qT5MKuOI5yIQkQ8MCf1RdDBfiRcwDksMsRc6GpcU1UEnjRCkLz7ygq58j+RiDUiGl2U
 aw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424930; x=1793029730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y8P248VAWa6oQ3dnRvNa88m3jub2X/2RJUo0EevicM8=;
 b=BOp3KXaVFeGuQNXdZAdCPGiddwEEKTVepZMqjRTcxjhbgPmqZg9g3geTqxiQDkjQ9O
 lQr4zRZQhQ2dg6zG5fBzJek/9DJKEd+OqkBGJwOqu+02proh0L1v1LqqKExm9mjKcOUf
 5tsfzWaBUSjucrKBOz7bvr0jD1rl2RM3tIjX8kU2aTYCRfqkbshwMAwzGHvxSsI1f+m1
 Mgn9N72ENdJEOg/zFvI1CGZuBX6kCRANL7szvzyPxJzUJnMKydTCigC9zpDe6I/mgPFp
 piX1vSPPJ8CyENN5f16kLP7d7vgd45deGemo44P7cbMyQ7oz3v+x590hpjBuifF9sD5E
 ElVA==
X-Gm-Message-State: AFq9FYLI2bjQ/JIoYT7ApHCX7Cs4lXn9aSf7gyPxIM209Xc5BK1JphN5
 h7oq6G7CfyUd5KhU4DztCx1Fm9N5WzOUWEXdhsbP2OGFkEcaOEPpnTXB1zGt3bvS
X-Gm-Gg: AYBFou1+FpKeue0juRrANkykoIuNt8pRSYjLZ9+27Hyneblw7rgmVzbz0QZVr3nM97c
 hZwAYFUEGSFj5a+E+/1XGbKP7U2Xg98XD2ePjgsDqM9Pv6n4Gcc4l3uY5dKhuZDY1jm/UODLSeP
 zwkdd4XDWv+R0alzQpZkqhAFrfmBFXBmrEA+J1+aIA7XQgCkI+V1ejiDhRA3+g0OqR/ovHUNI3t
 YeNCiOfANiM3BlqMNf7OjZ1/eQu0bR2/r2R+CmAVC/LfQqzwSZLRLBQ391siyKGZnzXtjP9a6Rs
 WNOR9pIB/1gtu/hqFPyWwrOXXAj7HxtCfNrGDxOoc2gVHFdKPZRAH4V4hHO6oUatl5EGKkGHhwu
 7xR6hps30JHYCpgNJBPJ2PgSwseD0CRIy53AbD8Vplz8vAyXAi67cJdPvVa4xxz6XFuRZFbjGcZ
 jhKx4bAc7j6WFhKXW2dAW7lw8uLxIT2Akcpmy45mdTFomSvcWjIZyQ6nd66Zic750sBMp7p/Adj
 pD0QpqGuNaS7hHUyDWS0q8Kl6BnWSQaUnMzrIV+zZfcVV6K5A==
X-Received: by 2002:a17:90a:e7ca:b0:3ac:7872:d1b7 with SMTP id
 98e67ed59e1d1-3acef14859dmr7515894a91.32.1792424929719; 
 Mon, 19 Oct 2026 08:48:49 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:a144:150d:733a:5ba2])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3ad5cc13658sm63271a91.4.2026.10.19.08.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:48:49 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] drm/ms91xx: Add atomic modesetting and USB framebuffer
 transfers
Date: Mon, 19 Oct 2026 23:48:07 +0800
Message-ID: <20261019154820.68659-4-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019154820.68659-1-hjf3108@gmail.com>
References: <20261019154820.68659-1-hjf3108@gmail.com>
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
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implements:
- DRM core code
- Double buffered USB framebuffer transfers
- Pending-transfer replacement with the latest pixels and merged damage
- Cache maintenance for converted vmalloc transfer buffers
- USB driver matching

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/gpu/drm/ms91xx/ms91xx.h          | 217 ++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_drv.c      | 518 +++++++++++++++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_transfer.c | 218 ++++++++++
 3 files changed, 953 insertions(+)
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx.h
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_drv.c
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_transfer.c

diff --git a/drivers/gpu/drm/ms91xx/ms91xx.h b/drivers/gpu/drm/ms91xx/ms91xx.h
new file mode 100644
index 0000000000000..83d3ca96e7b22
--- /dev/null
+++ b/drivers/gpu/drm/ms91xx/ms91xx.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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
diff --git a/drivers/gpu/drm/ms91xx/ms91xx_drv.c b/drivers/gpu/drm/ms91xx/ms91xx_drv.c
new file mode 100644
index 0000000000000..2ca855f2363c8
--- /dev/null
+++ b/drivers/gpu/drm/ms91xx/ms91xx_drv.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/limits.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_file.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_mode_config.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_print.h>
+#include <drm/drm_rect.h>
+
+#include "ms91xx.h"
+
+static int ms91xx_usb_suspend(struct usb_interface *interface,
+			      pm_message_t message)
+{
+	struct ms91xx_device *ms91xx = usb_get_intfdata(interface);
+
+	return drm_mode_config_helper_suspend(&ms91xx->drm);
+}
+
+static int ms91xx_usb_resume(struct usb_interface *interface)
+{
+	struct ms91xx_device *ms91xx = usb_get_intfdata(interface);
+
+	return drm_mode_config_helper_resume(&ms91xx->drm);
+}
+
+DEFINE_DRM_GEM_FOPS(ms91xx_driver_fops);
+
+static const struct drm_driver ms91xx_drm_driver = {
+	.driver_features = DRIVER_ATOMIC | DRIVER_GEM | DRIVER_MODESET,
+
+	/* GEM hooks */
+	.fops = &ms91xx_driver_fops,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESC,
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+};
+
+static const struct drm_mode_config_funcs ms91xx_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static const struct drm_mode_config_helper_funcs
+ms91xx_mode_config_helper_funcs = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
+static const struct ms91xx_mode ms91xx_mode_list[] = {
+	/* Found in captures of the Windows driver and dumped from device */
+	MS91XX_MODE(720,   480, 60, 0x02), /* 60.00 Hz */
+	MS91XX_MODE(720,   576, 50, 0x11), /* 50.00 Hz */
+	MS91XX_MODE(1280,  720, 50, 0x13), /* 50.00 Hz */
+	MS91XX_MODE(1920, 1080, 50, 0x1f), /* 50.00 Hz */
+	MS91XX_MODE(1920, 1080, 30, 0x22), /* 30.00 Hz */
+	MS91XX_MODE(640,   480, 60, 0x40), /* 59.94 Hz */
+	MS91XX_MODE(800,   600, 60, 0x42), /* 60.32 Hz */
+	MS91XX_MODE(800,   600, 75, 0x44), /* 75.00 Hz */
+	MS91XX_MODE(1024,  768, 60, 0x47), /* 60.00 Hz */
+	MS91XX_MODE(1024,  768, 75, 0x49), /* 75.03 Hz */
+	MS91XX_MODE(1152,  864, 60, 0x4c), /* 60.00 Hz */
+	MS91XX_MODE(1280,  600, 60, 0x4e), /* 60.00 Hz */
+	MS91XX_MODE(1280,  720, 60, 0x4f), /* 60.00 Hz */
+	MS91XX_MODE(1280,  768, 60, 0x54), /* 59.87 Hz */
+	MS91XX_MODE(1280,  768, 75, 0x56), /* 74.89 Hz */
+	MS91XX_MODE(1280,  800, 60, 0x57), /* 59.81 Hz */
+	MS91XX_MODE(1280,  960, 60, 0x5b), /* 60.00 Hz */
+	MS91XX_MODE(1280, 1024, 60, 0x60), /* 60.02 Hz */
+	MS91XX_MODE(1280, 1024, 75, 0x61), /* 75.02 Hz */
+	MS91XX_MODE(1360,  768, 60, 0x64), /* 60.02 Hz */
+	MS91XX_MODE(1366,  768, 60, 0x66), /* 59.79 Hz */
+	MS91XX_MODE(1400, 1050, 60, 0x67), /* 59.98 Hz */
+	MS91XX_MODE(1440,  900, 60, 0x6b), /* 59.89 Hz */
+	MS91XX_MODE(1600, 1200, 60, 0x73), /* 60.00 Hz */
+	MS91XX_MODE(1680, 1050, 60, 0x78), /* 59.95 Hz */
+	MS91XX_MODE(1920, 1080, 60, 0x81), /* 60.00 Hz */
+};
+
+static const struct ms91xx_mode *
+ms91xx_get_mode(struct ms91xx_device *ms91xx,
+		const struct drm_display_mode *mode)
+{
+	unsigned int i;
+	int width = mode->hdisplay;
+	int height = mode->vdisplay;
+	int hz = drm_mode_vrefresh(mode);
+
+	for (i = 0; i < ms91xx->num_custom_modes; i++) {
+		const struct ms91xx_mode *custom_mode =
+			&ms91xx->custom_modes[i].mode;
+
+		if (custom_mode->width == width &&
+		    custom_mode->height == height &&
+		    custom_mode->hz == hz)
+			return custom_mode;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ms91xx_mode_list); i++) {
+		if (ms91xx_mode_list[i].width == width &&
+		    ms91xx_mode_list[i].height == height &&
+		    ms91xx_mode_list[i].hz == hz) {
+			return &ms91xx_mode_list[i];
+		}
+	}
+	return NULL;
+}
+
+static void ms91xx_crtc_atomic_enable(struct drm_crtc *crtc,
+				      struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_device *dev = crtc->dev;
+	struct ms91xx_device *ms91xx = to_ms91xx(dev);
+	const struct ms91xx_mode *ms_mode;
+	int ret;
+
+	ret = ms91xx_power_on(ms91xx);
+	if (ret) {
+		drm_err(dev, "failed to power on display: %d\n", ret);
+		return;
+	}
+
+	ms_mode = ms91xx_get_mode(ms91xx, &crtc_state->mode);
+	if (!ms_mode) {
+		drm_err(dev, "unsupported mode passed to CRTC enable\n");
+		return;
+	}
+
+	ret = ms91xx_set_resolution(ms91xx, ms_mode);
+	if (ret)
+		drm_err(dev, "failed to set display mode: %d\n", ret);
+}
+
+static void ms91xx_cancel_transfer_work(struct ms91xx_device *ms91xx)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ms91xx->requests); i++) {
+		struct ms91xx_usb_request *request = &ms91xx->requests[i];
+
+		if (cancel_work_sync(&request->work))
+			complete(&request->done);
+	}
+}
+
+static void ms91xx_crtc_atomic_disable(struct drm_crtc *crtc,
+				       struct drm_atomic_commit *state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct ms91xx_device *ms91xx = to_ms91xx(dev);
+	int ret;
+
+	ms91xx_cancel_transfer_work(ms91xx);
+	ret = ms91xx_power_off(ms91xx);
+	if (ret && ret != -ENODEV)
+		drm_err(dev, "failed to power off display: %d\n", ret);
+}
+
+static enum drm_mode_status
+ms91xx_crtc_mode_valid(struct drm_crtc *crtc,
+		       const struct drm_display_mode *mode)
+{
+	struct ms91xx_device *ms91xx = to_ms91xx(crtc->dev);
+	const struct ms91xx_mode *ms_mode = ms91xx_get_mode(ms91xx, mode);
+
+	if (!ms_mode)
+		return MODE_BAD;
+
+	return MODE_OK;
+}
+
+static int ms91xx_plane_atomic_check(struct drm_plane *plane,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *old_plane_state;
+	struct drm_plane_state *new_plane_state;
+	struct drm_crtc_state *crtc_state = NULL;
+
+	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	if (new_plane_state->crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state,
+							   new_plane_state->crtc);
+
+	/*
+	 * A mode set does change how the device interprets the framebuffer
+	 * so ask for a full plane update for the first frame after one.
+	 */
+	new_plane_state->ignore_damage_clips =
+		old_plane_state->fb != new_plane_state->fb ||
+		(crtc_state && drm_atomic_crtc_needs_modeset(crtc_state));
+
+	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+
+static void ms91xx_clear_rect(struct drm_rect *rect)
+{
+	rect->x1 = INT_MAX;
+	rect->y1 = INT_MAX;
+	rect->x2 = 0;
+	rect->y2 = 0;
+}
+
+static void ms91xx_merge_rects(struct drm_rect *dest, struct drm_rect *r1,
+			       struct drm_rect *r2)
+{
+	dest->x1 = min(r1->x1, r2->x1);
+	dest->y1 = min(r1->y1, r2->y1);
+	dest->x2 = max(r1->x2, r2->x2);
+	dest->y2 = max(r1->y2, r2->y2);
+}
+
+static void ms91xx_plane_atomic_update(struct drm_plane *plane,
+				       struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *old_plane_state;
+	struct drm_plane_state *new_plane_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_shadow_plane_state *shadow_plane_state;
+	struct ms91xx_device *ms91xx = to_ms91xx(plane->dev);
+	struct ms91xx_usb_request *current_request, *previous_request;
+	struct drm_rect current_rect, rect;
+
+	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+
+	if (!new_plane_state->fb)
+		return;
+	new_crtc_state = drm_atomic_get_new_crtc_state(state,
+						       new_plane_state->crtc);
+	shadow_plane_state = to_drm_shadow_plane_state(new_plane_state);
+
+	/* Damage from the previous mode may not fit the new framebuffer. */
+	if (drm_atomic_crtc_needs_modeset(new_crtc_state))
+		ms91xx_clear_rect(&ms91xx->update_rect);
+
+	if (drm_atomic_helper_damage_merged(old_plane_state, new_plane_state,
+					    &current_rect)) {
+		current_request = &ms91xx->requests[ms91xx->current_request];
+		previous_request = &ms91xx->requests[!ms91xx->current_request];
+
+		/* Latency reduction: requeue with the latest frame data. */
+		if (cancel_work(&previous_request->work)) {
+			complete(&previous_request->done);
+			ms91xx_merge_rects(&current_rect, &current_rect,
+					   &previous_request->transfer_rect);
+			current_request = previous_request;
+			ms91xx->current_request = !ms91xx->current_request;
+		}
+
+		current_request->transfer_rect = current_rect;
+
+		/*
+		 * The device double buffers, so we need to send the update
+		 * rects of the last two frames.
+		 */
+		ms91xx_merge_rects(&rect, &current_rect, &ms91xx->update_rect);
+		if (ms91xx_fb_send_rect(new_plane_state->fb,
+					&shadow_plane_state->data[0],
+					&shadow_plane_state->fmtcnv_state,
+					&rect)) {
+			/* In case of error, merge the rects to update later */
+			ms91xx_merge_rects(&ms91xx->update_rect,
+					   &ms91xx->update_rect, &rect);
+		} else {
+			ms91xx->update_rect = current_rect;
+		}
+	}
+}
+
+static const struct drm_crtc_helper_funcs ms91xx_crtc_helper_funcs = {
+	.mode_valid = ms91xx_crtc_mode_valid,
+	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_enable = ms91xx_crtc_atomic_enable,
+	.atomic_disable = ms91xx_crtc_atomic_disable,
+};
+
+static const struct drm_crtc_funcs ms91xx_crtc_funcs = {
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs ms91xx_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = ms91xx_plane_atomic_check,
+	.atomic_update = ms91xx_plane_atomic_update,
+};
+
+static const struct drm_plane_funcs ms91xx_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static const u32 ms91xx_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static const u8 ms91xx_bulk_out_endpoints[] = {
+	MS91XX_BULK_OUT_ENDPOINT, 0
+};
+
+static int ms91xx_usb_probe(struct usb_interface *interface,
+			    const struct usb_device_id *id)
+{
+	int ret;
+	unsigned int i;
+	struct ms91xx_device *ms91xx;
+	struct drm_device *dev;
+	struct device *dma_dev;
+	struct usb_device *usbdev;
+
+	ms91xx = devm_drm_dev_alloc(&interface->dev, &ms91xx_drm_driver,
+				    struct ms91xx_device, drm);
+	if (IS_ERR(ms91xx))
+		return PTR_ERR(ms91xx);
+
+	ms91xx->intf = interface;
+	ret = devm_mutex_init(&interface->dev, &ms91xx->ctrl_lock);
+	if (ret)
+		return ret;
+
+	if (!usb_check_bulk_endpoints(interface, ms91xx_bulk_out_endpoints))
+		return -ENXIO;
+
+	ret = ms91xx_read_custom_timing(ms91xx);
+	if (ret < 0) {
+		drm_warn(&ms91xx->drm,
+			 "failed to read custom timing: %d\n", ret);
+	}
+	for (i = 0; i < ms91xx->num_custom_modes; i++) {
+		const struct ms91xx_mode *mode = &ms91xx->custom_modes[i].mode;
+
+		drm_info(&ms91xx->drm,
+			 "custom mode %dx%d@%d uses mode 0x%02x\n",
+			 mode->width, mode->height, mode->hz, mode->mode);
+	}
+
+	usbdev = interface_to_usbdev(interface);
+	ms91xx->bulk_pipe =
+		usb_sndbulkpipe(usbdev, MS91XX_BULK_OUT_ENDPOINT);
+	dev = &ms91xx->drm;
+
+	dma_dev = usb_intf_get_dma_device(interface);
+	if (dma_dev) {
+		drm_dev_set_dma_dev(dev, dma_dev);
+		put_device(dma_dev);
+	} else {
+		drm_warn(dev,
+			 "buffer sharing not supported\n"); /* not an error */
+	}
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
+
+	dev->mode_config.min_width = 0;
+	dev->mode_config.max_width = MS91XX_MAX_WIDTH;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.max_height = MS91XX_MAX_HEIGHT;
+	dev->mode_config.funcs = &ms91xx_mode_config_funcs;
+	dev->mode_config.helper_private = &ms91xx_mode_config_helper_funcs;
+
+	/* This stops weird behavior in the device */
+	ret = ms91xx_set_resolution(ms91xx, &ms91xx_mode_list[0]);
+	if (ret)
+		return ret;
+
+	ms91xx->workqueue =
+		drmm_alloc_ordered_workqueue(dev, DRIVER_NAME, 0);
+	if (IS_ERR(ms91xx->workqueue))
+		return PTR_ERR(ms91xx->workqueue);
+
+	ret = ms91xx_init_request(ms91xx, &ms91xx->requests[0],
+				  MS91XX_MAX_TRANSFER_LEN);
+	if (ret)
+		return ret;
+
+	ret = ms91xx_init_request(ms91xx, &ms91xx->requests[1],
+				  MS91XX_MAX_TRANSFER_LEN);
+	if (ret)
+		goto err_free_request_0;
+
+	ret = drm_universal_plane_init(dev, &ms91xx->plane, 0,
+				       &ms91xx_plane_funcs,
+				       ms91xx_plane_formats,
+				       ARRAY_SIZE(ms91xx_plane_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		goto err_free_request_1;
+
+	drm_plane_helper_add(&ms91xx->plane, &ms91xx_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(&ms91xx->plane);
+	ms91xx_clear_rect(&ms91xx->update_rect);
+
+	ret = drm_crtc_init_with_planes(dev, &ms91xx->crtc, &ms91xx->plane,
+					NULL, &ms91xx_crtc_funcs, NULL);
+	if (ret)
+		goto err_free_request_1;
+
+	drm_crtc_helper_add(&ms91xx->crtc, &ms91xx_crtc_helper_funcs);
+
+	ret = ms91xx_connector_init(ms91xx);
+	if (ret)
+		goto err_free_request_1;
+
+	drm_mode_config_reset(dev);
+
+	usb_set_intfdata(interface, ms91xx);
+
+	drmm_kms_helper_poll_init(dev);
+
+	ret = drm_dev_register(dev, 0);
+	if (ret)
+		goto err_free_request_1;
+
+	drm_client_setup(dev, NULL);
+
+	return 0;
+
+err_free_request_1:
+	ms91xx_free_request(&ms91xx->requests[1]);
+err_free_request_0:
+	ms91xx_free_request(&ms91xx->requests[0]);
+	return ret;
+}
+
+static void ms91xx_usb_disconnect(struct usb_interface *interface)
+{
+	struct ms91xx_device *ms91xx = usb_get_intfdata(interface);
+	struct drm_device *dev = &ms91xx->drm;
+
+	drm_dev_unplug(dev);
+	drm_atomic_helper_shutdown(dev);
+	ms91xx_cancel_transfer_work(ms91xx);
+	ms91xx_free_request(&ms91xx->requests[0]);
+	ms91xx_free_request(&ms91xx->requests[1]);
+}
+
+static void ms91xx_usb_shutdown(struct usb_interface *interface)
+{
+	struct ms91xx_device *ms91xx = usb_get_intfdata(interface);
+
+	drm_atomic_helper_shutdown(&ms91xx->drm);
+}
+
+static const struct usb_device_id id_table[] = {
+	/* USB 2 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x534d, 0x6021, 0xff, 0x00, 0x00) },
+	/* USB 2 Sometimes this PID will pop up */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x534d, 0x0821, 0xff, 0x00, 0x00) },
+	/* USB 3 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x345f, 0x9132, 0xff, 0x00, 0x00) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x345f, 0x9133, 0xff, 0x00, 0x00) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x345f, 0x9135, 0xff, 0x00, 0x00) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, id_table);
+
+static struct usb_driver ms91xx_driver = {
+	.name = DRIVER_NAME,
+	.probe = ms91xx_usb_probe,
+	.disconnect = ms91xx_usb_disconnect,
+	.suspend = ms91xx_usb_suspend,
+	.resume = ms91xx_usb_resume,
+	.reset_resume = ms91xx_usb_resume,
+	.shutdown = ms91xx_usb_shutdown,
+	.id_table = id_table,
+};
+module_usb_driver(ms91xx_driver);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/ms91xx/ms91xx_transfer.c b/drivers/gpu/drm/ms91xx/ms91xx_transfer.c
new file mode 100644
index 0000000000000..8b88b2206ce3d
--- /dev/null
+++ b/drivers/gpu/drm/ms91xx/ms91xx_transfer.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/byteorder.h>
+#include <linux/align.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/dma-direction.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/iosys-map.h>
+#include <linux/jiffies.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/usb.h>
+#include <linux/vmalloc.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_print.h>
+#include <drm/drm_rect.h>
+
+#include "ms91xx.h"
+
+static void ms91xx_request_timeout(struct timer_list *t)
+{
+	struct ms91xx_usb_request *request = timer_container_of(request, t, timer);
+
+	usb_sg_cancel(&request->sgr);
+}
+
+static void ms91xx_request_work(struct work_struct *work)
+{
+	struct ms91xx_usb_request *request =
+		container_of(work, struct ms91xx_usb_request, work);
+	struct ms91xx_device *ms91xx = request->ms91xx;
+	struct usb_device *usbdev = interface_to_usbdev(ms91xx->intf);
+	struct usb_sg_request *sgr = &request->sgr;
+	struct sg_table *transfer_sgt = &request->transfer_sgt;
+	int idx, ret;
+
+	if (!drm_dev_enter(&ms91xx->drm, &idx)) {
+		ret = -ENODEV;
+		goto complete;
+	}
+
+	ret = usb_sg_init(sgr, usbdev, ms91xx->bulk_pipe, 0, transfer_sgt->sgl,
+			  transfer_sgt->nents, request->transfer_len,
+			  GFP_KERNEL);
+	if (ret)
+		goto dev_exit;
+
+	mod_timer(&request->timer, jiffies + msecs_to_jiffies(5000));
+	usb_sg_wait(sgr);
+
+	if (!timer_delete_sync(&request->timer))
+		ret = -ETIMEDOUT;
+	else if (sgr->status < 0)
+		ret = sgr->status;
+	else if (sgr->bytes != request->transfer_len)
+		ret = -EIO;
+
+dev_exit:
+	drm_dev_exit(idx);
+complete:
+	if (ret < 0 && ret != -ENODEV)
+		drm_err_ratelimited(&ms91xx->drm,
+				    "failed to send framebuffer: %d\n", ret);
+	complete(&request->done);
+}
+
+void ms91xx_free_request(struct ms91xx_usb_request *request)
+{
+	if (!request->transfer_buffer)
+		return;
+
+	timer_shutdown_sync(&request->timer);
+	sg_free_table(&request->transfer_sgt);
+	vfree(request->transfer_buffer);
+	request->transfer_buffer = NULL;
+}
+
+int ms91xx_init_request(struct ms91xx_device *ms91xx,
+			struct ms91xx_usb_request *request, size_t len)
+{
+	int ret;
+	unsigned int i, num_pages;
+	void *data;
+	struct page **pages;
+	void *ptr;
+
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
+
+	for (i = 0, ptr = data; i < num_pages; i++, ptr += PAGE_SIZE)
+		pages[i] = vmalloc_to_page(ptr);
+	ret = sg_alloc_table_from_pages(&request->transfer_sgt, pages,
+					num_pages, 0, len, GFP_KERNEL);
+	kfree(pages);
+	if (ret)
+		goto err_vfree;
+
+	request->transfer_buffer = data;
+	request->ms91xx = ms91xx;
+
+	init_completion(&request->done);
+	complete(&request->done);
+	timer_setup(&request->timer, ms91xx_request_timeout, 0);
+	INIT_WORK(&request->work, ms91xx_request_work);
+	return 0;
+
+err_vfree:
+	vfree(data);
+	return ret;
+}
+
+static const u8 ms91xx_end_of_buffer[] = { 0xff, 0xc0, 0x00, 0x00,
+				    0x00, 0x00, 0x00, 0x00 };
+
+static void ms91xx_fb_xrgb8888_to_yuv422(void *dst,
+					 const struct iosys_map *src,
+					 struct drm_framebuffer *fb,
+					 const struct drm_rect *rect,
+					 struct drm_format_conv_state *fmtcnv_state)
+{
+	struct ms91xx_frame_update_header *header = dst;
+	struct iosys_map dst_map;
+	u32 position, dimensions;
+	int x, y1, width;
+
+	y1 = rect->y1;
+	x = rect->x1;
+	width = drm_rect_width(rect);
+
+	header->marker = cpu_to_be16(0xff00);
+	position = ((x & 0xfff) << 12) | (y1 & 0xfff);
+	dimensions = ((width & 0xfff) << 12) |
+		     (drm_rect_height(rect) & 0xfff);
+	put_unaligned_be24(position, header->position);
+	put_unaligned_be24(dimensions, header->dimensions);
+	dst += sizeof(*header);
+
+	iosys_map_set_vaddr(&dst_map, dst);
+	drm_fb_xrgb8888_to_uyvy(&dst_map, NULL, src, fb, rect, fmtcnv_state);
+	dst += width * drm_rect_height(rect) * 2;
+
+	memcpy(dst, ms91xx_end_of_buffer, sizeof(ms91xx_end_of_buffer));
+}
+
+int ms91xx_fb_send_rect(struct drm_framebuffer *fb, const struct iosys_map *map,
+			struct drm_format_conv_state *fmtcnv_state,
+			struct drm_rect *rect)
+{
+	int ret = 0, idx;
+	struct ms91xx_device *ms91xx = to_ms91xx(fb->dev);
+	struct drm_device *drm = &ms91xx->drm;
+	struct ms91xx_usb_request *current_request;
+	int x, width;
+
+	/* UYVY stores pixels in pairs. Expand damage to a complete pair. */
+	x = ALIGN_DOWN(rect->x1, 2);
+	width = min_t(int, ALIGN(rect->x2, 2), fb->width) - x;
+	rect->x1 = x;
+	rect->x2 = x + width;
+	rect->y2 = min_t(unsigned int, rect->y2, fb->height);
+	current_request = &ms91xx->requests[ms91xx->current_request];
+
+	if (!drm_dev_enter(drm, &idx))
+		return -ENODEV;
+
+	/* Transfer buffer still in use, drop this frame. */
+	if (!wait_for_completion_timeout(&current_request->done,
+					 msecs_to_jiffies(10))) {
+		ret = -ETIMEDOUT;
+		goto dev_exit;
+	}
+
+	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
+	if (ret < 0)
+		goto request_complete;
+
+	ms91xx_fb_xrgb8888_to_yuv422(current_request->transfer_buffer,
+				     map, fb, rect, fmtcnv_state);
+	current_request->transfer_len =
+		width * 2 * drm_rect_height(rect) + MS91XX_FRAME_OVERHEAD;
+	flush_kernel_vmap_range(current_request->transfer_buffer,
+				current_request->transfer_len);
+
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
+	queue_work(ms91xx->workqueue, &current_request->work);
+	ms91xx->current_request = 1 - ms91xx->current_request;
+	goto dev_exit;
+
+request_complete:
+	complete(&current_request->done);
+dev_exit:
+	drm_dev_exit(idx);
+	return ret;
+}
-- 
2.55.0

