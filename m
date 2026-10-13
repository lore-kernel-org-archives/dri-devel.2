Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B622ACC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8A310F682;
	Tue, 13 Oct 2026 09:33:13 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB9D10F67F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:33:06 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1892240f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883985; x=1792488785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xsGsod/8Ns3+BDNQx7Seu3RbdQl0ClLIgl4wgQX5q9E=;
 b=s2NdG7WvRv94upO4tCFKUjusbjJK+VNtZ94StjH+6Pb7tsd9MOCm2GWeUr4JwNLyxb
 QmKb/dGSqQu+AU0n+0VabgDRzVHE6b4D68ccG/jnJ2VzWkxes9qBT1TeY2UZvHLS+Iaq
 6bdWuuG54fv9fghUyqAohQSwx7ShLfasNBM4vSz7V4xZPIDbEjLt2sAg8Zx4iAcjwxnE
 ZSN7FhSJ/Jfvv8P3TpVoEpL4Xg6e7RsAOeOI30yiyHbzDN42BReFMpSmyFFaQhANX6LR
 Kf8gEBIResp4AEEBlOl7aygoLRzCrsfveygL2fS/4OCN6SmrldiAGccDJnaQG8rYeEnn
 h/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883985; x=1792488785;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xsGsod/8Ns3+BDNQx7Seu3RbdQl0ClLIgl4wgQX5q9E=;
 b=rVaKcanZ6Vody4fp5/AU863h4DL8A1x9KygpytwALX3IsibGqiMo+0vyESUyOUrori
 3iEwz5iYFjp5mvvfzJ6MyLMcHLvJ0ux0dBE6jE84b4i922v4lMI5DKTCmN09rBSNEBeN
 ZPD76lM3Zc4DQ3C6iBXjVzvOpNyWoUKZPaX3waz/vh5N+Rw9DYVq7vChFcOfal80LduT
 Shil7STt5asbo02a2VkarGKOJhP/pbAfrM7JkyuW4gpQ+8Adq6Rmz4T8B7pa38b6UzUU
 QPc2YUNzKHSOAimqz7Hf3ncXiVGWhAFxI/6MZ1KsNKYJep6whaEZ1/EJ8W1/gjIGQRpo
 Gqrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLlUsdmji0Y3ZsGA9t4MMBlolas0q+UvirSgE5Lk2gcbuBL5V/SROuOC4P7IBZgRaTAFbq/60BmlI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxBO75f6HqFrEjaXONiCHLjzo8CyD0tRB9pPhV9QMzflYfYu1o
 +Z6lufVRjoGCE7Y1ERB1cfgEjmetmQFbVMoN/g9TSfLxDk+Av/nZewMS
X-Gm-Gg: AYBFou29oMbvrS/UK8EqnLH3ST7fKvm9jaTzfRBbwssEgaENvLhrzlGpcJAJo6amL5K
 VxLX7rYecB00cr4Illx+ksCVH8iIS/9oyrpB/iu0Q0dWHJ0xaeJv+Dj5yuVkupNLbcd9tx7dDhQ
 9XSIsyjeZAf+MDBKa0oyHnzq6WOb6YlNb4UvDgLqgY/29isyi3RynNc6Cl89EocawTZYZmZJIKH
 EOWobZs4CD08i+2WDXznhaMHvmwMSy+YuX4+KbFCsiD5qNGCqSq1bTS1kIsPChzJZfitfzAh2EH
 lRkJujca4fP27Xrwa1E6YwyEai1HRIKgQw+QZwE6R4hhlQ3GXlZ1ogkMZDawj10P9TrWdkxC9VJ
 l1z6YvZWMLgumE8qwebRrOYw/OuSUvFiwoC/z1fVfTVNASyThcKeFDMeZ6OFUs1qZCuhTYgpOML
 hu3j/UyV4wAIsnKfDPJmqyX6B/Ct8tukXEQKpp7tiYLjynmh/GLZBDwmI2Akx5vrolP9BBmisEi
 5Gru/cQ59/mDeP1+xtRyeAS
X-Received: by 2002:a5d:420f:0:b0:48c:4553:790b with SMTP id
 ffacd0b85a97d-48dbacf46e9mr16300132f8f.48.1791883984846; 
 Tue, 13 Oct 2026 02:33:04 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:33:04 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/13] drm/client: splash: add a device tree image source
Date: Tue, 13 Oct 2026 11:32:37 +0200
Message-Id: <20261013093243.505776-8-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261013093243.505776-1-maximpedraza@gmail.com>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Embedded products often share one kernel image and one board support
package across several models that differ in branding. The splash
client can show the firmware's BGRT image or a BMP loaded as firmware,
but a device tree system has no BGRT, and a BMP loaded as firmware is
either built into the kernel, which means one kernel per logo, or read
from a filesystem that is not there yet when the display comes up. With
U-Boot's Falcon mode the SPL starts the kernel directly, and the device
tree is the only thing that reaches it.

Add a source that takes the image from a "boot-logo" node under /chosen.
The BMP either sits in the node itself, in an "image" property that dtc
fills in with /incbin/, or in a reserved memory region the bootloader
loaded it into, named by "memory-region". Exactly one of the two must be
present; a node with both or neither is ignored with a warning.

The image in the node is used where it is: the device tree stays in
memory, so there is nothing to copy or release. The region is mapped
like the BGRT image, and the BMP header is checked against its size.

A node is only there if someone put it there for that board, so the
device tree goes first, then the BGRT, then the BMP loaded as firmware.
The boolean that chose between the latter two becomes an enum naming
the one source in use.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/Kconfig      |  15 +++
 drivers/gpu/drm/clients/drm_splash.c | 166 ++++++++++++++++++++++++---
 2 files changed, 165 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index cbe271c3a23f..aef3781cc110 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -108,6 +108,21 @@ config DRM_CLIENT_SPLASH_BACKGROUND_COLOR
 	  The color can be overridden through the drm_client_lib.splash_color
 	  kernel command line parameter.
 
+config DRM_CLIENT_SPLASH_SRC_DT
+	bool "Device tree as splash source"
+	depends on DRM_CLIENT_SPLASH
+	depends on OF
+	select DRM_CLIENT_SPLASH_BMP_SUPPORT
+	help
+	  Use a BMP image described by a "boot-logo" node under /chosen in
+	  the device tree, either carried in the node itself or placed by the
+	  bootloader in a reserved memory region. This lets one kernel image
+	  show a different logo on each board or product, chosen by the
+	  device tree it boots with.
+
+	  When present, the device tree image is preferred over the other
+	  sources.
+
 config DRM_CLIENT_SPLASH_SRC_BGRT
 	bool "EFI BGRT as splash source"
 	depends on DRM_CLIENT_SPLASH
diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index a7d627954158..50842922a7f8 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -9,9 +9,12 @@
 #include <linux/efi-bgrt.h>
 #include <linux/firmware.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/iosys-map.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -71,6 +74,14 @@ struct bmp_dib_header {
 	__le32 colors_important;
 } __packed;
 
+/* Where the image comes from, in order of preference */
+enum drm_splash_source {
+	DRM_SPLASH_SRC_NONE,
+	DRM_SPLASH_SRC_DT,
+	DRM_SPLASH_SRC_BGRT,
+	DRM_SPLASH_SRC_BMP,
+};
+
 struct drm_splash_scanout {
 	int id;
 	/* Modesets scanning this buffer out, by position in the list */
@@ -110,7 +121,7 @@ struct drm_splash {
 	bool render_done;
 	void *map_data;
 
-	bool use_bgrt;
+	enum drm_splash_source src;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -212,6 +223,114 @@ static int drm_splash_fw_request_bmp(struct drm_splash *splash)
 }
 #endif // CONFIG_DRM_CLIENT_SPLASH_SRC_BMP
 
+#if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_DT)
+#define DRM_SPLASH_DT_COMPATIBLE "boot-logo"
+
+/*
+ * The boot logo node, if the device tree has a usable one. Only a child of
+ * /chosen is considered, not anything compatible anywhere in the tree: the
+ * image is configuration handed over by the firmware, not a device.
+ */
+static struct device_node *drm_splash_dt_node(struct drm_splash *splash)
+{
+	struct drm_client_dev *client = &splash->client;
+	struct device_node *np;
+	bool image, region;
+
+	np = of_get_compatible_child(of_chosen, DRM_SPLASH_DT_COMPATIBLE);
+	if (!np)
+		return NULL;
+
+	if (!of_device_is_available(np))
+		goto out_put;
+
+	image = of_property_present(np, "image");
+	region = of_property_present(np, "memory-region");
+	if (image == region) {
+		drm_warn(client->dev,
+			 "splash: %pOF needs exactly one of image or memory-region",
+			 np);
+		goto out_put;
+	}
+
+	return np;
+
+out_put:
+	of_node_put(np);
+	return NULL;
+}
+
+static bool drm_splash_dt_available(struct drm_splash *splash)
+{
+	struct device_node *np = drm_splash_dt_node(splash);
+
+	of_node_put(np);
+
+	return np;
+}
+
+static int drm_splash_dt_load(struct drm_splash *splash, const u8 **data,
+			      size_t *size)
+{
+	struct drm_client_dev *client = &splash->client;
+	struct device_node *np;
+	struct resource res;
+	const void *prop;
+	int len, ret = 0;
+
+	np = drm_splash_dt_node(splash);
+	if (!np)
+		return -ENOENT;
+
+	/*
+	 * An image in the node is used in place: the device tree stays in
+	 * memory for as long as the system runs, so there is nothing to copy
+	 * and nothing to release.
+	 */
+	prop = of_get_property(np, "image", &len);
+	if (prop) {
+		*data = prop;
+		*size = len;
+		goto out_put;
+	}
+
+	/* Otherwise the bootloader loaded it into a reserved region */
+	ret = of_reserved_mem_region_to_resource(np, 0, &res);
+	if (ret) {
+		drm_warn(client->dev, "splash: %pOF: no usable memory-region: %d",
+			 np, ret);
+		goto out_put;
+	}
+
+	splash->map_data = memremap(res.start, resource_size(&res),
+				    MEMREMAP_WB);
+	if (!splash->map_data) {
+		drm_warn(client->dev, "splash: failed to map %pR", &res);
+		ret = -ENOMEM;
+		goto out_put;
+	}
+
+	/* The BMP header, checked against this size, says how much is image */
+	*data = splash->map_data;
+	*size = resource_size(&res);
+
+out_put:
+	of_node_put(np);
+	return ret;
+}
+#else
+static bool drm_splash_dt_available(struct drm_splash *splash)
+{
+	return false;
+}
+
+static int drm_splash_dt_load(struct drm_splash *splash,
+			      const u8 **data, size_t *size)
+{
+	return -EOPNOTSUPP;
+}
+#endif // CONFIG_DRM_CLIENT_SPLASH_SRC_DT
+
 static bool drm_splash_bgrt_available(struct drm_splash *splash)
 {
 	struct drm_client_dev *client = &splash->client;
@@ -489,7 +608,7 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		return -EINVAL;
 	}
 
-	if (splash->use_bgrt) {
+	if (splash->src == DRM_SPLASH_SRC_BGRT) {
 		x_pad = efi_bgrt_image_offset_x();
 		y_pad = efi_bgrt_image_offset_y();
 
@@ -582,19 +701,34 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
 				 size_t *img_data_len)
 {
-	int ret = 0;
-
-	if (splash->use_bgrt) {
-		ret = drm_splash_bgrt_load(splash, img_data, img_data_len);
-		if (ret)
-			splash->use_bgrt = false;
+	switch (splash->src) {
+	case DRM_SPLASH_SRC_DT:
+		return drm_splash_dt_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_BGRT:
+		return drm_splash_bgrt_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_BMP:
+		return drm_splash_fw_load(splash, img_data, img_data_len);
+	default:
+		return -ENOENT;
 	}
+}
 
-	/* BGRT failed to load */
-	if (!splash->use_bgrt)
-		ret = drm_splash_fw_load(splash, img_data, img_data_len);
-
-	return ret;
+/*
+ * Pick the one source the image will come from. A device tree node is only
+ * there if someone put it there for this board, so it goes first; the BGRT
+ * is whatever the firmware shows, and the BMP loaded as firmware is the
+ * fallback. With none of them, only the background colour is drawn.
+ */
+static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
+{
+	if (drm_splash_dt_available(splash))
+		return DRM_SPLASH_SRC_DT;
+	if (drm_splash_bgrt_available(splash))
+		return DRM_SPLASH_SRC_BGRT;
+	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
+		return DRM_SPLASH_SRC_BMP;
+
+	return DRM_SPLASH_SRC_NONE;
 }
 
 static void drm_splash_image_cleanup(struct drm_splash *splash)
@@ -909,10 +1043,10 @@ static int drm_splash_client_hotplug(struct drm_client_dev *client)
 	get_task_struct(thread);
 	splash->thread = thread;
 
-	splash->use_bgrt = drm_splash_bgrt_available(splash);
+	splash->src = drm_splash_pick_source(splash);
 
-	/* If no other image has been loaded, try to load a BMP as firmware */
-	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP) && !splash->use_bgrt) {
+	/* The BMP loaded as firmware is the only source that arrives later */
+	if (splash->src == DRM_SPLASH_SRC_BMP) {
 		WRITE_ONCE(splash->fw_pending, true);
 		ret = drm_splash_fw_request_bmp(splash);
 		splash->fw_requested = !ret;
-- 
2.39.5

