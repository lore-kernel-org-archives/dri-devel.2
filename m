Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B148CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BDE10F777;
	Thu,  1 Oct 2026 19:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sq6I/1mj";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F91B10F777
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:59:05 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso71436525e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884744; x=1791489544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aTfvnUNIzM8o9ImrwTX2VwP7Iz2lghOuvTLklapkuB0=;
 b=sq6I/1mjZdAv4j0s9h3OmLSLt+fd+x4n8caT7DwKjiaUNArGMBY9BzRKXRK15rWCh9
 C5jX9f/QDnqtEsVrzHHjijF68LF0TV+IoWCkd9yUTmWcLFHPYgaTVEaBc8Sd6uD9fTZP
 DrqWeIHca43kQQszRC7ah0QO/djMFqnxp8TowMNIyc9jSz/AcHTBxM+H2vOh+6B+5B+s
 MGsbHwNjf5cvzhiyaHL5HJEpic5pC5tp31BSxl5Adh3oYIUL7/QJnbk45RwpLpp5daL6
 8MKpU4kgtKS20vN0UIbSg9VcdKnAXgB1qvbI+UozLHxrGDZHWyGwt5BaxiAdgw0UoAne
 RI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884744; x=1791489544;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aTfvnUNIzM8o9ImrwTX2VwP7Iz2lghOuvTLklapkuB0=;
 b=sf73xggjc4tLPinBQoG/KBN+WkwgloWyV9lH1PZodc4LeTh63i3AxpaycLK6HXEXqu
 HzaFUqDbCZkpqz35WOhoqmKC/P6cpjKwSwJ+1ZY4FOnHjWL84ZKP7qBFwQhfykJ6oJsG
 dW+fcq7wmZeMTYg/4r9MfTnB/FWv/nJGtQEy7+3D/YapmZfEiL2zkekckdWqU0ixoj/n
 z99ineI0ANE/9wSg4ijD3DabK4v9hSQoFxMYLK2jp0MAJsnHy1IFvz/Dmge/uaWjRZ26
 +C1m5WqGjpSw157vr2l2tqMwiWZC5U5Zkm7OaF4luP0GxG4wLoOySdYjK+4j0voW33UE
 fypw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdMo+cg8ScjvdFWHEqYtBmkDy8ZtEPm/c0rVJyJnRjJbYGqPAoCBysO/GNvng2emaMH/fDD/wKiyw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nYHXvehiRIR86Oqt0C2DtG6HqcEqdS9ncz/y7Yk9xMAXSP6V8v
 PZieNy7W5nFpAJc364WAlDXWCnmHojjEKSzRz0GXSwxwzGa6bFvXlyoR
X-Gm-Gg: AYBFou3v61SZoagwTHutGeWDf0/Hxq9DLQU8qMZHRy0nKOYm1ENdcSzKrUgaNTiclk/
 xrV/xNzLMx5uUmao2ojgCUYtB7VqircNSAbgBTDaPTkn7099EXOe+e7NjN59/gcPgvyxQRygp20
 G2SmsU3jeh/Po9edbUh/nSOOADQAXoiEZHXV47oL/H8nccTnBke/tXh0pa+l8YDrRZij50IenWa
 pDD98FqHHcnVLV9Fy5/VefoHRy/GDzwQ0XQqJA4kie9Skz+4gkMYGWrQR5jQeLN3z1U5NTikNEb
 etwyZVRHIqusbmy0Gmd3Nz5atcEJlBAsBQ1L4fk+cYeNL3Qn07mztgeyXVQjpSxVlSfp9RjBIxi
 SPbNg4smZlGBNq+b/E6QLn/RhGtztS7SO1+hlwp28iUMtaxqLLEIr2y9JNYKKmtvN+WeEAMSaW9
 0NJzFoYBY/DGa0Fqws3vM7WcAq5npH0+FSBvjR/mWrpz05T3S6SDq+iY1DCTR5o327otSJObZ2s
 /Z40D/FN9Ka0p2izOsL4TP3vg==
X-Received: by 2002:a05:600c:6089:b0:49e:6c27:d093 with SMTP id
 5b1f17b1804b1-4a02757a74dmr9949315e9.15.1790884743696; 
 Thu, 01 Oct 2026 12:59:03 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:59:03 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 07/13] drm/client: splash: add a device tree image
 source
Date: Thu,  1 Oct 2026 21:58:41 +0200
Message-Id: <20261001195847.141192-8-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001195847.141192-1-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
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
index 66c192139d9c..444f612c48ac 100644
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
@@ -108,7 +119,7 @@ struct drm_splash {
 	const struct firmware *fw;
 	void *map_data;
 
-	bool use_bgrt;
+	enum drm_splash_source src;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -204,6 +215,114 @@ static inline int drm_splash_fw_request_bmp(struct drm_splash *splash)
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
+static inline bool drm_splash_dt_available(struct drm_splash *splash)
+{
+	return false;
+}
+
+static inline int drm_splash_dt_load(struct drm_splash *splash,
+				     const u8 **data, size_t *size)
+{
+	return -EOPNOTSUPP;
+}
+#endif // CONFIG_DRM_CLIENT_SPLASH_SRC_DT
+
 #if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BGRT)
 static bool drm_splash_bgrt_available(struct drm_splash *splash)
 {
@@ -510,7 +629,7 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		return -EINVAL;
 	}
 
-	if (splash->use_bgrt) {
+	if (splash->src == DRM_SPLASH_SRC_BGRT) {
 		x_pad = drm_splash_bgrt_get_xoffset();
 		y_pad = drm_splash_bgrt_get_yoffset();
 
@@ -603,19 +722,34 @@ static inline int drm_splash_bmp_to_scanout(struct drm_splash *splash,
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
@@ -911,10 +1045,10 @@ static int drm_splash_client_hotplug(struct drm_client_dev *client)
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

