Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D725CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A369010E24C;
	Sun, 10 May 2026 22:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="C4FVk8n9";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="eMFOKsms";
	dkim-atps=neutral
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D161610E24C
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:26:56 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778452016; 
 b=jwpD4BngQkxoFUQM49jmLLsUdqmpUyCLRtQCdOw4Hcf5AzQnJLZaBGIrmI1gC5tsEoeclS3uWO
 PKdSyyscR3FcheviaZhHqYBjVR/KJulJiiYlPeJrFi1IfWlycZO/HBc+1cFUKazCNC5urSAk4v
 8kNd4krnS7G+Hw1Q8H0Xq6AqriLGO2ViFZditgQC4DtIibB2mZ/5oIJe5JGXC59E0hj6NOg96I
 L7/1gUtLyZwT9o3W3KG0dd2jRPHQ3RAt4LC3mFhMyQN3f2Um5GlhljdrujazygEy4ZmBEH3Vjt
 G/ngxvL/SpRwpFi0Hp+pv3vJi3gus7ttS/ph+BMO1hzIqA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778452016; 
 bh=1EPtfKI8XpSx3zi+yaFQVU5+lukeYvFeE01XQs5RiZ4=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=qj7QA3+bhDRzqxrnrPYwCRfITAdWroR3i1xepBCizTDB+C94cXk6SdzV9sALstXDlDyElyrYA7
 Pn/d/wyj/+kL0KDQ8alQ870WQbVsbfKfnnGGrD3gGE3cV9I+vMa0bVKtWChyofI0oXHoPwxcvr
 s1AWlfEdc/L2VHPray8+hXlnZ9RDDKxMIYXmwyCnGqs7JCeFoianvRqutG8zr5tKJydTThiATL
 QL0ZQWMuJCWjxylRuctCPGuj30/xAGBftfnj7h64W6Io3oaNalcSHyNkhcdXayvRuzOw1vr3Gy
 DGbEcxl4ESDNnlJ5eUmDCgJ9W0Z4Ah4p2Sq/ZOwKQOJhfQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=FzT0HX1au2On/YSIb/qf1Uzijm4hzfKZl3j/x0l1uhU=; b=C4FVk8n9MKjagJPuO09ARhQQ2w
 pTBhSS29pxVBhk0eTDwhZfw9H/PYPJMsikwtWsUpM1EXqXXfNbDCN5aHPAlh/8dpbh6wXafQWQ/jt
 SCZjnT0ERUvBczEaiVAu0pS1CZPDWb784TY/OmpoesBdFFoBYSkYRqJsij9XX08FYUMU=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wMCbt-000000070WH-0jIO
 for dri-devel@lists.freedesktop.org; Sun, 10 May 2026 22:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=FzT0HX1au2On/YSIb/qf1Uzijm4hzfKZl3j/x0l1uhU=; b=eMFOKsmsKwNBJ19bBcjZasPGdB
 HoeQ0Q7IwCJ6sWNswuz8K4gjRPDWFe0BZb3Sv+R6qRZc/ZxU8MRWlim+CnaIgbwX/la7VKYDX2XCC
 NcDZlvtKvLk1Zvny67yPkYlstqIdz9pgB244d4rjJWAe4EVlyarNnAYuzusc7RGp3zP8=;
Received: from [95.232.18.244] (port=61481 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wMBim-00000000PdN-0Xpj; Sun, 10 May 2026 21:29:56 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 10 May 2026 23:29:38 +0200
Subject: [PATCH RFC v3 1/3] drm: client: add splash client
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-drm_client_splash-v3-1-a9aee9f0b2fc@valla.it>
References: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
In-Reply-To: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-embedded@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=32899; i=francesco@valla.it;
 h=from:subject:message-id; bh=1EPtfKI8XpSx3zi+yaFQVU5+lukeYvFeE01XQs5RiZ4=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkMPy5tm7VjFZ/e3wkOK3q66wWsvxdY/fwXnr7ly9ITR
 +9qb3x2p6OUhUGMi0FWTJElZN2Ne3vmmn9L28D4CGYOKxPIEAYuTgGYiMN/RoZZdQHqk1of33Vk
 8VcIMzqVu/qX4MWvPg2uKovi5bedrQliZDijs/l81TXR+TPClacc1VyTrCC0abVD34R7MZ//dM3
 6J8cGAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 5bb86839c9705ad6d02f107a8458ad6c
X-AntiAbuse: ID - 5bb86839c9705ad6d02f107a8458ad6c
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wMCbt-000000070WH-0jIO-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Add a DRM client that draws a simple splash, with possibility to show:

  - the logo provided by EFI BGRT;
  - a static BMP image (loaded as firmware);
  - a colored background.

The client is not meant to replace a full-featured bootsplash, but
rather to remove some complexity (and hopefully boot time) on small
embedded platforms or on systems with a limited scope (e.g: recovery
or manufacturing images).

The background color can be set either at build time from a dedicated
config option or at runtime through the drm_client_lib.splash_color
command line parameter. Any color in RGB888 format can be used.

If enabled, the static BMP image is loaded using the kernel firmware
infrastructure; a valid BMP image with 24bpp color and no compression
is expected. The name of the image can be set through the
drm_client_lib.splash_bmp kernel command line parameter, with the
default being 'drm_splash.bmp'.

Just like the existing DRM clients, the splash can be enabled from the
kernel command line using drm_client_lib.active=splash.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/gpu/drm/clients/Kconfig               |  63 +-
 drivers/gpu/drm/clients/Makefile              |   1 +
 drivers/gpu/drm/clients/drm_client_internal.h |   9 +
 drivers/gpu/drm/clients/drm_client_setup.c    |   8 +
 drivers/gpu/drm/clients/drm_splash.c          | 932 ++++++++++++++++++++++++++
 5 files changed, 1012 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index 6096c623d9d5..dc114429c1f1 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -12,6 +12,7 @@ config DRM_CLIENT_LIB
 config DRM_CLIENT_SELECTION
 	tristate
 	depends on DRM
+	select DRM_CLIENT_LIB if DRM_CLIENT_SPLASH
 	select DRM_CLIENT_LIB if DRM_CLIENT_LOG
 	select DRM_CLIENT_LIB if DRM_FBDEV_EMULATION
 	help
@@ -85,10 +86,63 @@ config DRM_CLIENT_LOG
 	  If you only need logs, but no terminal, or if you prefer userspace
 	  terminal, say "Y".
 
+config DRM_CLIENT_SPLASH
+	bool "Display graphic splash"
+	depends on DRM_CLIENT_SELECTION
+	select DRM_CLIENT
+	select DRM_CLIENT_SETUP
+	select DRM_DRAW
+	help
+	  This enables a splash drm client, able to display either a plain
+	  color or a static image until the userspace is ready to take over.
+	  The splash will be displayed on all screens available at boot, if
+	  any, or on the ones part of the first hotplug event.
+
+config DRM_CLIENT_SPLASH_BACKGROUND_COLOR
+	hex "Splash background color"
+	depends on DRM_CLIENT_SPLASH
+	default 0x000000
+	help
+	  The default splash background color, in RGB888 format.
+
+	  The color can be overridden through the drm_client_lib.splash_color
+	  kernel command line parameter.
+
+config DRM_CLIENT_SPLASH_SRC_BGRT
+	bool "EFI BGRT as splash source"
+	depends on DRM_CLIENT_SPLASH
+	depends on ACPI_BGRT
+	select DRM_CLIENT_SPLASH_BMP_SUPPORT
+	help
+	  Use the BGRT image provided by the EFI bootloader. If the image is
+	  smaller than the display(s), it will be centered and the color
+	  specified through the DRM_CLIENT_SPLASH_BACKGROUND_COLOR config
+	  option will be used as background.
+
+config DRM_CLIENT_SPLASH_SRC_BMP
+	bool "BMP image as splash source"
+	depends on DRM_CLIENT_SPLASH
+	select DRM_CLIENT_SPLASH_BMP_SUPPORT
+	select FW_LOADER
+	help
+	  Use a BMP (bitmap) image as splash. If the image is smaller than the
+	  display(s), it will be centered and the color specified through the
+	  DRM_CLIENT_SPLASH_BACKGROUND_COLOR config option will be used as
+	  background.
+
+	  The image will be loaded using the firmware loading facility the
+	  kernel provides; it shall use 24 bits per pixel and shall not be
+	  compressed. The name of the file can be set through the
+	  drm_client_lib.splash_bmp command line parameter, with the default
+	  being 'drm_splash.bmp'.
+
+config DRM_CLIENT_SPLASH_BMP_SUPPORT
+	bool
+
 choice
 	prompt "Default DRM Client"
 	depends on DRM_CLIENT_SELECTION
-	depends on DRM_FBDEV_EMULATION || DRM_CLIENT_LOG
+	depends on DRM_FBDEV_EMULATION || DRM_CLIENT_LOG || DRM_CLIENT_SPLASH
 	default DRM_CLIENT_DEFAULT_FBDEV
 	help
 	  Selects the default drm client.
@@ -111,6 +165,12 @@ config DRM_CLIENT_DEFAULT_LOG
 	  screen, but doesn't implement a full terminal. For that you will need
 	  a userspace terminal using drm/kms.
 
+config DRM_CLIENT_DEFAULT_SPLASH
+	bool "splash"
+	depends on DRM_CLIENT_SPLASH
+	help
+	  Use splash as default drm client.
+
 endchoice
 
 config DRM_CLIENT_DEFAULT
@@ -118,6 +178,7 @@ config DRM_CLIENT_DEFAULT
        depends on DRM_CLIENT
        default "fbdev" if DRM_CLIENT_DEFAULT_FBDEV
        default "log" if DRM_CLIENT_DEFAULT_LOG
+       default "splash" if DRM_CLIENT_DEFAULT_SPLASH
        default ""
 
 endmenu
diff --git a/drivers/gpu/drm/clients/Makefile b/drivers/gpu/drm/clients/Makefile
index c16addbc327f..3df02d10cd18 100644
--- a/drivers/gpu/drm/clients/Makefile
+++ b/drivers/gpu/drm/clients/Makefile
@@ -5,4 +5,5 @@ subdir-ccflags-y += -I$(src)/..
 drm_client_lib-y := drm_client_setup.o
 drm_client_lib-$(CONFIG_DRM_CLIENT_LOG) += drm_log.o
 drm_client_lib-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_client.o
+drm_client_lib-$(CONFIG_DRM_CLIENT_SPLASH) += drm_splash.o
 obj-$(CONFIG_DRM_CLIENT_LIB) += drm_client_lib.o
diff --git a/drivers/gpu/drm/clients/drm_client_internal.h b/drivers/gpu/drm/clients/drm_client_internal.h
index 6dc078bf6503..48ee0c1c2529 100644
--- a/drivers/gpu/drm/clients/drm_client_internal.h
+++ b/drivers/gpu/drm/clients/drm_client_internal.h
@@ -22,4 +22,13 @@ void drm_log_register(struct drm_device *dev);
 static inline void drm_log_register(struct drm_device *dev) {}
 #endif
 
+#ifdef CONFIG_DRM_CLIENT_SPLASH
+void drm_splash_register(struct drm_device *dev,
+			 const struct drm_format_info *format);
+#else
+static inline void drm_splash_register(struct drm_device *dev,
+				       const struct drm_format_info *format)
+{}
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/clients/drm_client_setup.c b/drivers/gpu/drm/clients/drm_client_setup.c
index 515aceac22b1..c19498938ee3 100644
--- a/drivers/gpu/drm/clients/drm_client_setup.c
+++ b/drivers/gpu/drm/clients/drm_client_setup.c
@@ -56,6 +56,14 @@ void drm_client_setup(struct drm_device *dev, const struct drm_format_info *form
 		return;
 	}
 #endif
+
+#ifdef CONFIG_DRM_CLIENT_SPLASH
+	if (!strcmp(drm_client_default, "splash")) {
+		drm_splash_register(dev, format);
+		return;
+	}
+#endif
+
 	if (strcmp(drm_client_default, ""))
 		drm_warn(dev, "Unknown DRM client %s\n", drm_client_default);
 }
diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
new file mode 100644
index 000000000000..a038807019c0
--- /dev/null
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -0,0 +1,932 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/*
+ * Copyright (c) 2025-2026 Francesco Valla <francesco@valla.it>
+ */
+
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/efi-bgrt.h>
+#include <linux/firmware.h>
+#include <linux/init.h>
+#include <linux/iosys-map.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include <acpi/actbl1.h>
+
+#include <drm/drm_client.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_print.h>
+
+#include "drm_client_internal.h"
+#include "drm_draw_internal.h"
+#include "drm_internal.h"
+
+/**
+ * DOC: overview
+ *
+ * This is a simple graphic bootsplash, able to display either a plain color or
+ * a static image.
+ */
+
+static unsigned int splash_color = CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR;
+module_param(splash_color, uint, 0400);
+MODULE_PARM_DESC(splash_color, "Splash background color (RGB888)");
+
+#if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP)
+#define DEFAULT_SPLASH_BMP "drm_splash.bmp"
+static char *splash_bmp = DEFAULT_SPLASH_BMP;
+module_param(splash_bmp, charp, 0400);
+MODULE_PARM_DESC(splash_bmp, "Name of splash image (default: \"" DEFAULT_SPLASH_BMP "\")");
+#endif // CONFIG_DRM_CLIENT_SPLASH_SRC_BMP
+
+#define BMP_FILE_MAGIC_ID 0x4d42
+
+/* BMP header structures copied from drivers/video/fbdev/efifb.c */
+struct bmp_file_header {
+	__le16 id;
+	__le32 file_size;
+	__le32 reserved;
+	__le32 bitmap_offset;
+} __packed;
+
+struct bmp_dib_header {
+	__le32 dib_header_size;
+	__le32 width;
+	__le32 height;
+	__le16 planes;
+	__le16 bpp;
+	__le32 compression;
+	__le32 bitmap_size;
+	__le32 horz_resolution;
+	__le32 vert_resolution;
+	__le32 colors_used;
+	__le32 colors_important;
+} __packed;
+
+struct drm_splash_scanout {
+	int id;
+	u32 format;
+	unsigned int width;
+	unsigned int height;
+	struct drm_client_buffer *buffer;
+	bool bg_drawn;
+	bool img_drawn;
+};
+
+struct drm_splash {
+	struct drm_client_dev client;
+	u32 preferred_format;
+	struct device dev;
+
+	struct task_struct *thread;
+	atomic_t pending;
+
+	struct mutex hotplug_lock;
+	bool initialized;
+
+	u32 n_scanout;
+	struct drm_splash_scanout *scanout;
+
+	spinlock_t fw_lock;
+	const struct firmware *fw;
+	void *map_data;
+
+	bool use_bgrt;
+};
+
+static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
+{
+	return container_of_const(client, struct drm_splash, client);
+}
+
+static struct drm_splash_scanout *
+get_scanout_from_tile_group(struct drm_splash *splash, int id)
+{
+	int j;
+
+	for (j = 0; j < splash->n_scanout; j++)
+		if (splash->scanout[j].id == id)
+			return &splash->scanout[j];
+
+	return NULL;
+}
+
+static inline void drm_splash_wake_render_thread(struct drm_splash *splash)
+{
+	wake_up_process(splash->thread);
+}
+
+#if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP)
+static int drm_splash_fw_load(struct drm_splash *splash, const u8 **data,
+			      size_t *size)
+{
+	const struct firmware *fw;
+
+	scoped_guard(spinlock, &splash->fw_lock)
+		fw = splash->fw;
+
+	if (!fw)
+		return -ENOENT;
+
+	*data = fw->data;
+	*size = fw->size;
+
+	return 0;
+}
+
+static void drm_splash_fw_callback(const struct firmware *fw, void *context)
+{
+	struct drm_splash *splash = context;
+	struct drm_client_dev *client = &splash->client;
+
+	if (!fw || !fw->data) {
+		drm_err(client->dev, "splash: no firmware");
+		return;
+	}
+
+	scoped_guard(spinlock, &splash->fw_lock)
+		splash->fw = fw;
+
+	/* Wake the render thread */
+	drm_dbg(client->dev, "splash: firmware loaded, wake up drawing thread");
+	atomic_set(&splash->pending, 1);
+	drm_splash_wake_render_thread(splash);
+}
+
+static int drm_splash_fw_request_bmp(struct drm_splash *splash)
+{
+	struct drm_client_dev *client = &splash->client;
+
+	drm_info(client->dev, "splash: request %s as firmware", splash_bmp);
+
+	return request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+				       splash_bmp, client->dev->dev, GFP_KERNEL,
+				       splash, drm_splash_fw_callback);
+}
+#else
+static inline int drm_splash_fw_load(struct drm_splash *splash, const u8 **data,
+				     size_t *size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int drm_splash_fw_request_bmp(struct drm_splash *splash)
+{
+	return -EOPNOTSUPP;
+}
+#endif // CONFIG_DRM_CLIENT_SPLASH_SRC_BMP
+
+#if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BGRT)
+static bool drm_splash_bgrt_available(struct drm_splash *splash)
+{
+	struct drm_client_dev *client = &splash->client;
+
+	if (!bgrt_tab.image_address) {
+		drm_info(client->dev, "splash: no BGRT found");
+		return false;
+	}
+
+	if (bgrt_tab.status & ACPI_BGRT_ORIENTATION_OFFSET) {
+		drm_info(client->dev, "splash: BGRT rotation bits set, skipping");
+		return false;
+	}
+
+	return true;
+}
+
+static inline unsigned int drm_splash_bgrt_get_xoffset(void)
+{
+	return bgrt_tab.image_offset_x;
+}
+
+static inline unsigned int drm_splash_bgrt_get_yoffset(void)
+{
+	return bgrt_tab.image_offset_y;
+}
+
+static int drm_splash_bgrt_load(struct drm_splash *splash, const u8 **data,
+				size_t *size)
+{
+	struct drm_client_dev *client = &splash->client;
+
+	if (!drm_splash_bgrt_available(splash))
+		return -ENOENT;
+
+	drm_dbg(client->dev, "splash: BGRT image is at 0x%016llx, size=%zX",
+		bgrt_tab.image_address, bgrt_image_size);
+
+	splash->map_data = memremap(bgrt_tab.image_address, bgrt_image_size,
+				    MEMREMAP_WB);
+	if (!splash->map_data) {
+		drm_warn(client->dev, "splash: failed to map BGRT image memory");
+		return -ENOMEM;
+	}
+
+	*data = splash->map_data;
+	*size = bgrt_image_size;
+
+	return 0;
+}
+#else
+static inline bool drm_splash_bgrt_available(struct drm_splash *splash)
+{
+	return false;
+}
+
+static inline unsigned int drm_splash_bgrt_get_xoffset(void)
+{
+	return 0;
+}
+
+static inline unsigned int drm_splash_bgrt_get_yoffset(void)
+{
+	return 0;
+}
+
+static inline int drm_splash_bgrt_load(struct drm_splash *splash,
+				       const u8 **data, size_t *size)
+{
+	return -EOPNOTSUPP;
+}
+#endif // CONFIG_DRM_CLIENT_SPLASH_SRC_BGRT
+
+static u32 drm_splash_find_usable_format(struct drm_plane *plane,
+					 u32 preferred_format)
+{
+	int i;
+
+	/* Check if the preferred format can be used */
+	for (i = 0; i < plane->format_count; i++)
+		if (plane->format_types[i] == preferred_format)
+			return preferred_format;
+
+	/* Otherwise, find the first format that can be converted from XRGB8888 */
+	for (i = 0; i < plane->format_count; i++)
+		if (drm_draw_can_convert_from_xrgb8888(plane->format_types[i]))
+			return plane->format_types[i];
+
+	return DRM_FORMAT_INVALID;
+}
+
+static void drm_splash_fill(struct iosys_map *map, unsigned int dst_pitch,
+			    unsigned int height, unsigned int width,
+			    u32 px_width, u32 color)
+{
+	switch (px_width) {
+	case 2:
+		drm_draw_fill16(map, dst_pitch, height, width, color);
+		break;
+	case 3:
+		drm_draw_fill24(map, dst_pitch, height, width, color);
+		break;
+	case 4:
+		drm_draw_fill32(map, dst_pitch, height, width, color);
+		break;
+	default:
+		WARN_ONCE(1, "Can't fill with pixel width %d", px_width);
+	}
+}
+
+static int drm_splash_fill_solid_color(struct drm_client_buffer *buffer,
+				       u32 color)
+{
+	struct drm_client_dev *client = buffer->client;
+	struct drm_framebuffer *fb = buffer->fb;
+	struct drm_rect r = DRM_RECT_INIT(0, 0, fb->width, fb->height);
+	u32 px_width = fb->format->cpp[0];
+	struct iosys_map map;
+	int ret;
+
+	ret = drm_client_buffer_vmap_local(buffer, &map);
+	if (ret) {
+		drm_err(client->dev, "splash: cannot vmap buffer: %d", ret);
+		return ret;
+	}
+
+	drm_splash_fill(&map, fb->pitches[0], drm_rect_height(&r),
+			drm_rect_width(&r), px_width, color);
+
+	drm_client_buffer_vunmap_local(buffer);
+
+	return drm_client_buffer_flush(buffer, &r);
+}
+
+#if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_BMP_SUPPORT)
+static void drm_splash_blit_pix16(struct iosys_map *map, unsigned int dpitch,
+				  unsigned int x_pad, unsigned int y_pad,
+				  const u8 *sbuf8, unsigned int spitch,
+				  unsigned int width, unsigned int height,
+				  bool invert_y, u32 format)
+{
+	unsigned int x, y, src_offset, dst_offset;
+	u32 scolor, dcolor, wr_off;
+
+	for (y = 0; y < height; y++) {
+		src_offset = (invert_y ? (height - y - 1) : y) * spitch;
+		dst_offset = (y_pad + y) * dpitch;
+
+		for (x = 0; x < width; x++) {
+			scolor = *(const u32 *)(&sbuf8[src_offset + 3 * x]);
+			dcolor = drm_draw_color_from_xrgb8888(scolor, format);
+			wr_off = dst_offset + (x_pad + x) * sizeof(u16);
+
+			iosys_map_wr(map, wr_off, u16, dcolor);
+		}
+	}
+}
+
+static void drm_splash_blit_pix24(struct iosys_map *map, unsigned int dpitch,
+				  unsigned int x_pad, unsigned int y_pad,
+				  const u8 *sbuf8, unsigned int spitch,
+				  unsigned int width, unsigned int height,
+				  bool invert_y, u32 format)
+{
+	unsigned int x, y, src_offset, dst_offset;
+	u32 scolor, dcolor, wr_off;
+
+	for (y = 0; y < height; y++) {
+		src_offset = (invert_y ? (height - y - 1) : y) * spitch;
+		dst_offset = (y_pad + y) * dpitch;
+
+		for (x = 0; x < width; x++) {
+			scolor = *(const u32 *)(&sbuf8[src_offset + 3 * x]);
+			dcolor = drm_draw_color_from_xrgb8888(scolor, format);
+			wr_off = dst_offset + (x_pad + x) * 3;
+
+			iosys_map_wr(map, wr_off, u8, (dcolor & 0x000000FF) >> 0);
+			iosys_map_wr(map, wr_off + 1, u8, (dcolor & 0x0000FF00) >> 8);
+			iosys_map_wr(map, wr_off + 2, u8, (dcolor & 0x00FF0000) >> 16);
+		}
+	}
+}
+
+static void drm_splash_blit_pix32(struct iosys_map *map, unsigned int dpitch,
+				  unsigned int x_pad, unsigned int y_pad,
+				  const u8 *sbuf8, unsigned int spitch,
+				  unsigned int width, unsigned int height,
+				  bool invert_y, u32 format)
+{
+	unsigned int x, y, src_offset, dst_offset;
+	u32 scolor, dcolor, wr_off;
+
+	for (y = 0; y < height; y++) {
+		src_offset = (invert_y ? (height - y - 1) : y) * spitch;
+		dst_offset = (y_pad + y) * dpitch;
+
+		for (x = 0; x < width; x++) {
+			scolor = *(const u32 *)(&sbuf8[src_offset + 3 * x]);
+			dcolor = drm_draw_color_from_xrgb8888(scolor, format);
+			wr_off = dst_offset + (x_pad + x) * sizeof(u32);
+
+			iosys_map_wr(map, wr_off, u32, dcolor);
+		}
+	}
+}
+
+static void drm_splash_blit_rgb888(struct iosys_map *map, unsigned int dpitch,
+				   unsigned int x_pad, unsigned int y_pad,
+				   const u8 *sbuf8, unsigned int spitch,
+				   unsigned int width, unsigned int height,
+				   bool invert_y)
+{
+	unsigned int y, src_offset, dst_offset;
+
+	for (y = 0; y < height; y++) {
+		src_offset = (invert_y ? (height - y - 1) : y) * spitch;
+		dst_offset = (y_pad + y) * dpitch + x_pad * 3;
+
+		iosys_map_memcpy_to(map, dst_offset, &sbuf8[src_offset], width * 3);
+	}
+}
+
+static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
+				     struct drm_splash_scanout *scanout,
+				     const u8 *data, size_t data_len)
+
+{
+	struct drm_client_buffer *buffer = scanout->buffer;
+	struct drm_client_dev *client = buffer->client;
+	struct drm_framebuffer *fb = buffer->fb;
+	u32 px_width = fb->format->cpp[0];
+	const struct bmp_file_header *file_header;
+	const struct bmp_dib_header *dib_header;
+	u32 dib_header_size;
+	u16 bmp_id, bmp_bpp, bmp_planes;
+	u32 bmp_compression, bmp_pitch;
+	s32 bmp_width, bmp_height;
+	bool bmp_invert_y;
+	u32 bitmap_offset;
+	unsigned int x_pad, y_pad;
+	const u8 *image_data;
+	struct iosys_map map;
+	struct drm_rect r;
+	int ret;
+
+	if (data_len < (sizeof(*file_header) + sizeof(*dib_header))) {
+		drm_err(client->dev, "splash: BMP file too short");
+		return -EINVAL;
+	}
+
+	file_header = (const struct bmp_file_header *)data;
+
+	bmp_id = get_unaligned_le16(&file_header->id);
+	if (bmp_id != BMP_FILE_MAGIC_ID) {
+		drm_err(client->dev, "splash: invalid BMP magic 0x%04X", bmp_id);
+		return -EINVAL;
+	}
+
+	bitmap_offset = get_unaligned_le32(&file_header->bitmap_offset);
+
+	dib_header = (const struct bmp_dib_header *)(data + sizeof(*file_header));
+
+	dib_header_size = get_unaligned_le32(&dib_header->dib_header_size);
+
+	bmp_width = (s32)get_unaligned_le32(&dib_header->width);
+	bmp_height = (s32)get_unaligned_le32(&dib_header->height);
+	bmp_planes = get_unaligned_le16(&dib_header->planes);
+	bmp_bpp = get_unaligned_le16(&dib_header->bpp);
+	bmp_compression = get_unaligned_le32(&dib_header->compression);
+
+	/* Restrict supported format to uncompressed, 24bit RGB888 */
+	if (dib_header_size != 40 || bmp_width < 0 || bmp_planes != 1 ||
+	    bmp_compression != 0 || bmp_bpp != 24) {
+		drm_err(client->dev, "splash: invalid BMP format");
+		return -EINVAL;
+	}
+
+	bmp_pitch = round_up(3 * bmp_width, 4);
+
+	/* A positive height means bottom-to-top scan direction */
+	bmp_invert_y = (bmp_height > 0);
+	bmp_height = abs(bmp_height);
+
+	if ((bitmap_offset + bmp_pitch * bmp_height) > data_len) {
+		drm_err(client->dev, "splash: invalid BMP size");
+		return -EINVAL;
+	}
+
+	if (bmp_width > scanout->width || bmp_height > scanout->height) {
+		drm_err(client->dev, "splash: BMP image is too big for the screen");
+		return -EINVAL;
+	}
+
+	if (splash->use_bgrt) {
+		x_pad = drm_splash_bgrt_get_xoffset();
+		y_pad = drm_splash_bgrt_get_yoffset();
+
+		if ((x_pad + bmp_width) > scanout->width ||
+		    (y_pad + bmp_height) > scanout->height) {
+			drm_err(client->dev, "splash: BGRT image would overflow");
+			return -EINVAL;
+		}
+
+#ifdef CONFIG_X86
+		/*
+		 * BGRT sanity check, taken from efifb.c:
+		 *
+		 * On x86 some firmwares use a low non native resolution for
+		 * the display when they have shown some text messages. While
+		 * keeping the bgrt filled with info for the native resolution.
+		 * If the bgrt image intended for the native resolution still
+		 * fits, it will be displayed very close to the right edge of
+		 * the display looking quite bad.
+		 */
+
+		if (x_pad != (scanout->width - bmp_width) / 2) {
+			drm_err(client->dev, "splash: BGRT sanity check failed");
+			return -EINVAL;
+		}
+#endif
+	} else {
+		/* Center X and Y */
+		x_pad = (scanout->width - bmp_width) / 2;
+		y_pad = (scanout->height - bmp_height) / 2;
+	}
+
+	image_data = data + bitmap_offset;
+
+	ret = drm_client_buffer_vmap_local(buffer, &map);
+	if (ret) {
+		drm_err(client->dev, "splash: cannot vmap buffer: %d", ret);
+		return ret;
+	}
+
+	r = DRM_RECT_INIT(x_pad, y_pad, bmp_width, bmp_height);
+
+	/* In case the target format is RGB888, source data can be copied to
+	 * the video buffer line by line, avoiding some overhead.
+	 */
+	if (scanout->format == DRM_FORMAT_RGB888) {
+		drm_splash_blit_rgb888(&map, fb->pitches[0], x_pad, y_pad,
+				       image_data, bmp_pitch, bmp_width,
+				       bmp_height, bmp_invert_y);
+	} else {
+		switch (px_width) {
+		case 2:
+			drm_splash_blit_pix16(&map, fb->pitches[0], x_pad,
+					      y_pad, image_data, bmp_pitch,
+					      bmp_width, bmp_height,
+					      bmp_invert_y, scanout->format);
+			break;
+		case 3:
+			drm_splash_blit_pix24(&map, fb->pitches[0], x_pad,
+					      y_pad, image_data, bmp_pitch,
+					      bmp_width, bmp_height,
+					      bmp_invert_y, scanout->format);
+			break;
+		case 4:
+			drm_splash_blit_pix32(&map, fb->pitches[0], x_pad,
+					      y_pad, image_data, bmp_pitch,
+					      bmp_width, bmp_height,
+					      bmp_invert_y, scanout->format);
+			break;
+		default:
+			drm_warn_once(client->dev,
+				      "splash: can't blit with pixel width %d",
+				      px_width);
+		}
+	}
+
+	drm_client_buffer_vunmap_local(buffer);
+
+	return drm_client_buffer_flush(buffer, &r);
+}
+#else
+static inline int drm_splash_bmp_to_scanout(struct drm_splash *splash,
+					    struct drm_splash_scanout *scanout,
+					    const u8 *data, size_t data_len)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
+				 size_t *img_data_len)
+{
+	int ret = 0;
+
+	if (splash->use_bgrt) {
+		ret = drm_splash_bgrt_load(splash, img_data, img_data_len);
+		if (ret)
+			splash->use_bgrt = false;
+	}
+
+	/* BGRT failed to load */
+	if (!splash->use_bgrt)
+		ret = drm_splash_fw_load(splash, img_data, img_data_len);
+
+	return ret;
+}
+
+static void drm_splash_image_cleanup(struct drm_splash *splash)
+{
+	const struct firmware *fw = NULL;
+
+	memunmap(splash->map_data);
+
+	scoped_guard(spinlock, &splash->fw_lock) {
+		fw = splash->fw;
+		splash->fw = NULL;
+	}
+
+	release_firmware(fw);
+}
+
+static int drm_splash_render_thread(void *data)
+{
+	struct drm_splash *splash = data;
+	struct drm_client_dev *client = &splash->client;
+
+	while (!kthread_should_stop()) {
+		unsigned int draw_count = 0;
+		const u8 *img_data = NULL;
+		size_t img_data_len = 0;
+		bool img_loaded;
+		int i, ret;
+
+		drm_dbg(client->dev, "splash: run render thread...");
+
+		ret = drm_splash_image_load(splash, &img_data, &img_data_len);
+		img_loaded = (ret == 0);
+
+		for (i = 0; i < splash->n_scanout; i++) {
+			struct drm_splash_scanout *scanout = &splash->scanout[i];
+
+			if (!scanout->buffer) {
+				drm_err(client->dev,
+					"splash: no buffer for scanout %d", i);
+				continue;
+			}
+
+			if (!scanout->bg_drawn) {
+				drm_dbg(client->dev, "draw background for scanout %d", i);
+				u32 color = drm_draw_color_from_xrgb8888(splash_color,
+									 scanout->format);
+				drm_splash_fill_solid_color(scanout->buffer, color);
+				scanout->bg_drawn = true;
+			}
+
+			if (img_loaded && !scanout->img_drawn) {
+				drm_dbg(client->dev, "draw image for scanout %d", i);
+				/* Ignore the return value, since the solid
+				 * color has already been drawn to screen.
+				 */
+				ret = drm_splash_bmp_to_scanout(splash, scanout,
+								img_data,
+								img_data_len);
+				scanout->img_drawn = (ret == 0);
+			}
+
+			draw_count++;
+		}
+
+		if (img_loaded)
+			drm_splash_image_cleanup(splash);
+
+		if (draw_count > 0) {
+			ret = drm_client_modeset_commit(client);
+			/* If commit returns EBUSY, another master showed up.
+			 * This means that the splash is no more required.
+			 */
+			if (ret == -EBUSY) {
+				drm_info(client->dev,
+					"splash: not master anymore, exiting");
+				break;
+			}
+		}
+
+		if (img_loaded)
+			break;
+
+		/* If no changes arrived in the mean time, wait to be awaken,
+		 * e.g.by a firmware callback.
+		 */
+		if (atomic_xchg(&splash->pending, 0) == 0)
+			set_current_state(TASK_UNINTERRUPTIBLE);
+
+		schedule();
+	}
+
+	return 0;
+}
+
+static int drm_splash_init_client(struct drm_splash *splash)
+{
+	struct drm_client_dev *client = &splash->client;
+	struct drm_mode_set *modeset;
+	unsigned int modeset_mask = 0;
+	unsigned int fb_count = 0;
+	int j;
+
+	if (drm_client_modeset_probe(client, 0, 0))
+		return -1;
+
+	j = 0;
+	drm_client_for_each_modeset(modeset, client) {
+		struct drm_splash_scanout *tmp;
+		struct drm_splash_scanout *scanout;
+		u32 format;
+		int id = -1;
+
+		/* Skip modesets without a mode */
+		if (!modeset->mode)
+			continue;
+
+		if (modeset->connectors[0]->has_tile) {
+			struct drm_splash_scanout *tiled;
+			int new_id = modeset->connectors[0]->tile_group->id;
+
+			/* Tiled modesets contribute to a single framebuffer,
+			 * check if this tiled group has already been seen.
+			 */
+			tiled = get_scanout_from_tile_group(splash, new_id);
+			if (tiled != NULL) {
+				if (!modeset->x)
+					tiled->width += modeset->mode->vdisplay;
+				if (!modeset->y)
+					tiled->height += modeset->mode->hdisplay;
+				modeset->fb = tiled->buffer->fb;
+				continue;
+			}
+
+			/* New tile group, save its ID for later */
+			id = new_id;
+		}
+
+		format = drm_splash_find_usable_format(modeset->crtc->primary,
+						       splash->preferred_format);
+		if (format == DRM_FORMAT_INVALID) {
+			drm_warn(client->dev,
+				 "splash: can't find a usable format for modeset");
+			continue;
+		}
+
+		tmp = krealloc(splash->scanout,
+			       (splash->n_scanout + 1) * sizeof(*splash->scanout),
+			       GFP_KERNEL);
+		if (!tmp) {
+			drm_warn(client->dev,
+				 "splash: can't reallocate the scanout array");
+			break;
+		}
+
+		splash->scanout = tmp;
+		scanout = &splash->scanout[splash->n_scanout];
+		splash->n_scanout++;
+
+		memset(scanout, 0, sizeof(*scanout));
+		scanout->id = id;
+		scanout->format = format;
+		scanout->width = modeset->mode->hdisplay;
+		scanout->height = modeset->mode->vdisplay;
+
+		modeset_mask |= BIT(j);
+		j++;
+	}
+
+	/* Now that all sensible modesets have been collected, allocate buffers */
+	j = 0;
+	drm_client_for_each_modeset(modeset, client) {
+		struct drm_splash_scanout *scanout;
+
+		if (!(modeset_mask & BIT(j)))
+			continue;
+
+		scanout = &splash->scanout[j];
+		j++;
+
+		scanout->buffer = drm_client_buffer_create_dumb(client,
+								scanout->width,
+								scanout->height,
+								scanout->format);
+		if (IS_ERR(scanout->buffer)) {
+			drm_warn(client->dev,
+				 "splash: can't create dumb buffer %d %d %p4cc",
+				 scanout->width, scanout->height, &scanout->format);
+			continue;
+		}
+
+		drm_info(client->dev, "splash: created dumb buffer %d %d %p4cc",
+			 scanout->width, scanout->height, &scanout->format);
+
+		modeset->fb = scanout->buffer->fb;
+		fb_count++;
+	}
+
+	return (fb_count == 0) ? -ENODEV : 0;
+}
+
+static void drm_splash_free_scanout(struct drm_client_dev *client)
+{
+	struct drm_splash *splash = client_to_drm_splash(client);
+	int i;
+
+	if (splash->n_scanout) {
+		for (i = 0; i < splash->n_scanout; i++)
+			drm_client_buffer_delete(splash->scanout[i].buffer);
+
+		splash->n_scanout = 0;
+		kfree(splash->scanout);
+		splash->scanout = NULL;
+	}
+}
+
+static int drm_splash_client_hotplug(struct drm_client_dev *client)
+{
+	struct drm_splash *splash = client_to_drm_splash(client);
+	int ret = 0;
+
+	guard(mutex)(&splash->hotplug_lock);
+
+	/* The modesets that get a splash are defined at first hotplug event */
+	if (splash->initialized)
+		return 0;
+
+	ret = drm_splash_init_client(splash);
+	if (ret == -ENODEV) {
+		drm_info(client->dev, "splash: no modeset found");
+		return 0;
+	} else if (ret) {
+		drm_err(client->dev,
+			"splash: failed to init client: %d", ret);
+		return ret;
+	}
+
+	/* Create the render thread, waken later */
+	splash->thread = kthread_create(drm_splash_render_thread,
+					splash, "drm_splash_%s",
+					client->dev->unique);
+	if (IS_ERR(splash->thread)) {
+		ret = PTR_ERR(splash->thread);
+		drm_err(client->dev,
+			"splash: failed to create render thread: %d", ret);
+		drm_splash_free_scanout(client);
+		return ret;
+	}
+
+	splash->use_bgrt = drm_splash_bgrt_available(splash);
+
+	/* If no other image has been loaded, try to load a BMP as firmware */
+	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP) && !splash->use_bgrt) {
+		ret = drm_splash_fw_request_bmp(splash);
+		if (ret) {
+			drm_err(client->dev,
+				"splash: failed to kick image load: %d", ret);
+			kthread_stop(splash->thread);
+			drm_splash_free_scanout(client);
+			return ret;
+		}
+	}
+
+	/* Wake the render thread to show initial contents */
+	drm_splash_wake_render_thread(splash);
+
+	splash->initialized = true;
+
+	return 0;
+}
+
+static int drm_splash_client_restore(struct drm_client_dev *client, bool force)
+{
+	int ret;
+
+	if (force)
+		ret = drm_client_modeset_commit_locked(client);
+	else
+		ret = drm_client_modeset_commit(client);
+
+	return ret;
+}
+
+static void drm_splash_client_unregister(struct drm_client_dev *client)
+{
+	struct drm_splash *splash = client_to_drm_splash(client);
+
+	kthread_stop(splash->thread);
+	drm_splash_free_scanout(client);
+	drm_client_release(client);
+
+	drm_splash_image_cleanup(splash);
+}
+
+static void drm_splash_client_free(struct drm_client_dev *client)
+{
+	struct drm_splash *splash = client_to_drm_splash(client);
+	struct drm_device *dev = client->dev;
+
+	mutex_destroy(&splash->hotplug_lock);
+	kfree(splash);
+
+	drm_dbg(dev, "Unregistered with drm splash");
+}
+
+static const struct drm_client_funcs drm_splash_client_funcs = {
+	.owner		= THIS_MODULE,
+	.hotplug	= drm_splash_client_hotplug,
+	.restore	= drm_splash_client_restore,
+	.unregister	= drm_splash_client_unregister,
+	.free		= drm_splash_client_free,
+};
+
+/**
+ * drm_splash_register() - Register a drm device to drm_splash
+ * @dev: the drm device to register.
+ * @format: drm device preferred format.
+ */
+void drm_splash_register(struct drm_device *dev,
+			 const struct drm_format_info *format)
+{
+	struct drm_splash *splash;
+
+	splash = kzalloc_obj(*splash);
+	if (!splash)
+		goto err_warn;
+
+	mutex_init(&splash->hotplug_lock);
+	spin_lock_init(&splash->fw_lock);
+
+	if (format && format->num_planes == 1)
+		splash->preferred_format = format->format;
+	else
+		splash->preferred_format = DRM_FORMAT_RGB888;
+
+	if (drm_client_init(dev, &splash->client, "drm_splash",
+			    &drm_splash_client_funcs))
+		goto err_free;
+
+	drm_client_register(&splash->client);
+	drm_dbg(dev, "Registered with drm splash");
+
+	return;
+
+err_free:
+	kfree(splash);
+err_warn:
+	drm_warn(dev, "Failed to register with drm splash");
+}

-- 
2.54.0

