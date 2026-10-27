Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F7606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ISpkccua
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA88B10F572;
	Tue, 27 Oct 2026 13:54:32 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A959B10F572
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:08 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so36753025e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109247; x=1793714047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6lxw1iuNNrtlMKIOLDxkCcdbesSM+n1C5OuxVBL0d7w=;
 b=ISpkccuae3uLBizbowUL9OJNHwf8WFFthhCQx+bhORfFFWe5WL4tgYy8dTqJ2LwEzw
 kZnm1nNLRVHTeqqtuQCZIS2mEv6ha/zKbiRMujaKWFABT22KI95Mrz++1RkzgQYwGhHj
 6PN+TD/9wC6/sTkTF/IYI5K/3ca/uyofV7id4pGUGsFYFuMrcOCA5D7s41bTFBuROPXU
 xhMvSwaC8ihMIVAJCcnEH9ghNta+DMr2azimLL03jsTJ5bsfkFGSH87TPqA6ZvU8jKHW
 4qhVyFeYtc1wURd02MYP/D+t/wVk1KbASRYV10n4xEg9uA+h78g/nfsTd+mJTUXSzfLk
 ARoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109247; x=1793714047;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6lxw1iuNNrtlMKIOLDxkCcdbesSM+n1C5OuxVBL0d7w=;
 b=yKaUYkOYB2L7sny9zU7JglcHokdtA+ya2hk2L+5C9lHVaxaOM7kZFt1cVQJUUgbsb1
 PHSJxxbTK+ZDCrc0f3WkGqDmhKKzbNhxiKhpl+lIOtOhe9F1wl5yLkDXdRnxjv0qx6Cv
 F+jnv+opGV2QR/F/LryVDBu22JgtHDSTEJQiO5eBLw5WPYCgu6/zN3XSQgPNJJ0Jl3Jz
 KbtJbh1J1lT59igC+y4YAGsP9ZSqc3jicp67qc7FLd8qtJVOb8LZqwqWzo/ztigvuqlI
 A5sPlnY/bIb9VU3utIy5gydGtHE+dd3hke9xr02xRipF6gQfCs+Eorn461RRso797H/0
 O7Pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/Jvg84KVNbZncD3kH4ZWdeArA/xE4G3fqZEhhuT+yxnK5N2EBNEE5MaHm+JWD89nYGG5LoUe1gWs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKejmXL1KwCZu+HZuCioTqOCsKyvHXzO4k2sVdRvqE3qYY7Y1BF
 Cp1WLE2S8qhfcfg0hhJBFnYMxHBtQ/twS/eYU6YY3Icoe6RQMZSgHZ37
X-Gm-Gg: AYBFou2aE8pFgdETl+ImOPt0l387xi/yT5Xe/1Cp6N1KqxULkErRFNX9RRjAD9Ltgsy
 3H1KJfLdnZzph2UTcQu0+Xdu4ky3UNonpMsWrXot7wj11terfz6YJIPnkGBnhFmSduOaAyFKWJS
 J2aAK5c/hM0kmxriczkn4LcZ/vboNFkbKukQ2awyw3ortTUyk9dhT2T7mCDtC1HSsI2/j9YxIU1
 MQ8dVwNsaZQosfKDRVht8e/+3oSZvv2IHXSjdQBs0hiHbynJW0C+iczPK+raVdRjWAjGSxupU7m
 2YSotM4fW6jBldBfB4oB7mzOBj+5BfyPm3QrFXwFvL10ZCox00kmqC8nuyQJcgDj3pNeShq2JwO
 H1YgD6MM0pcDCtL8rK7vaGlG9e2Swgd3qmxviLS6JhCQOfUXsikugG/14dfJZl3l/vpx7fvKqs4
 2U3ByizkgMaMZQPeEomR5ifSe9FjM93y7+VpTC3TVHEndRFmbFGHE7LQ6SKasAweyShe2MX4txd
 gbNUI8jgsd0HtVrHKZzpxojAKPs20BfoK+JQ0ZDC4OtqHTiWBN3QHV1jawgSVkpgnnqVs7bhKI7
 QFuf8PA=
X-Received: by 2002:a05:600c:4e87:b0:4a1:a2c0:7b73 with SMTP id
 5b1f17b1804b1-4a35acaa6c3mr197755335e9.30.1793109246811; 
 Tue, 27 Oct 2026 06:54:06 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:54:06 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/15] drm/client: splash: add a device tree image source
Date: Tue, 27 Oct 2026 14:53:36 +0100
Message-Id: <20261027135342.2003632-10-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Embedded products often share one kernel image and one board support
package across several models that differ in branding. The splash
client can show the firmware's BGRT image or a BMP loaded as firmware,
but a device tree system has no BGRT, and a BMP loaded as firmware is
either built into the kernel, which means one kernel per logo, or read
from a filesystem that is not there yet when the display comes up. With
U-Boot's Falcon mode the SPL starts the kernel directly, and the device
tree is the only thing that reaches it.

Add a source that takes the image from a "boot-logo" node under /chosen.
The BMP either sits in the node itself, in a "logo-image" property that
dtc fills in with /incbin/, or in a reserved memory region the
bootloader loaded it into, named by "memory-region". Exactly one of the
two must be present; a node with both or neither is ignored with a
warning.

The image in the node is used where it is, with nothing to copy; the
client holds the node, or keeps the region mapped, for as long as it is
there, so that an output plugged in later gets the image too. The region
is mapped like the BGRT image, and the BMP header is checked against its
size. The image is found when the source is picked: a node whose image
cannot be had, because its region does not resolve or cannot be mapped,
or because reading a region takes CONFIG_OF_RESERVED_MEM and it is not
there, is skipped with a warning, so that the other sources still get
their turn.

A node is only there if someone put it there for that board, so the
device tree goes first, then the BGRT, then the BMP loaded as firmware.

The source is built with CONFIG_DRM_CLIENT_SPLASH_SRC_DT, which needs
CONFIG_OF.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/Kconfig      |  15 +++
 drivers/gpu/drm/clients/drm_splash.c | 142 ++++++++++++++++++++++++++-
 2 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index 51ae6c6bd89b..172781bbc2d7 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -106,6 +106,21 @@ config DRM_CLIENT_SPLASH_BACKGROUND_COLOR
 	help
 	  The splash background color, in RGB888 format.
 
+config DRM_CLIENT_SPLASH_SRC_DT
+	bool "Device tree as splash source"
+	depends on DRM_CLIENT_SPLASH
+	depends on OF
+	select DRM_CLIENT_SPLASH_BMP_SUPPORT
+	help
+	  Use a BMP image described by a node compatible with "boot-logo"
+	  under /chosen in the device tree, either carried in the node itself
+	  or placed by the bootloader in a reserved memory region. This lets
+	  one kernel image show a different logo on each board or product,
+	  chosen by the device tree it boots with.
+
+	  When present, the device tree image is preferred over the other
+	  sources.
+
 config DRM_CLIENT_SPLASH_SRC_BGRT
 	bool "EFI BGRT as splash source"
 	depends on DRM_CLIENT_SPLASH
diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 911149b92a52..618c060f33d5 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -8,9 +8,12 @@
 #include <linux/efi-bgrt.h>
 #include <linux/firmware.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/iosys-map.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -45,6 +48,7 @@
  */
 enum drm_splash_source {
 	DRM_SPLASH_SRC_NONE,
+	DRM_SPLASH_SRC_DT,
 	DRM_SPLASH_SRC_BGRT,
 	DRM_SPLASH_SRC_BMP,
 };
@@ -96,6 +100,10 @@ struct drm_splash {
 	 */
 	const struct firmware *fw;
 	void *map_data;
+	/* The device tree node, and where in it or in its region the image is */
+	struct device_node *dt_np;
+	const u8 *dt_data;
+	size_t dt_len;
 
 	enum drm_splash_source src;
 };
@@ -185,6 +193,127 @@ static int drm_splash_fw_request_bmp(struct drm_splash *splash)
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
+	image = of_property_present(np, "logo-image");
+	region = of_property_present(np, "memory-region");
+	if (image == region) {
+		drm_warn(client->dev,
+			 "splash: %pOF needs exactly one of logo-image or memory-region\n",
+			 np);
+		goto out_put;
+	}
+
+	/* Without it the region can never be read: let the other sources go */
+	if (region && !IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
+		drm_warn(client->dev,
+			 "splash: %pOF needs CONFIG_OF_RESERVED_MEM for memory-region\n",
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
+/*
+ * Find the image when the source is picked, and keep it for the outputs
+ * plugged in later. A node whose image cannot be had leaves the other
+ * sources their turn.
+ */
+static bool drm_splash_dt_open(struct drm_splash *splash)
+{
+	struct drm_client_dev *client = &splash->client;
+	struct device_node *np;
+	struct resource res;
+	const void *prop;
+	int len, ret;
+
+	np = drm_splash_dt_node(splash);
+	if (!np)
+		return false;
+
+	/*
+	 * An image in the node is used in place, with nothing to copy: the
+	 * node is held until the image is cleaned up.
+	 */
+	prop = of_get_property(np, "logo-image", &len);
+	if (prop) {
+		splash->dt_data = prop;
+		splash->dt_len = len;
+		goto out_keep;
+	}
+
+	/* Otherwise the bootloader loaded it into a reserved region */
+	ret = of_reserved_mem_region_to_resource(np, 0, &res);
+	if (ret) {
+		drm_warn(client->dev, "splash: %pOF: no usable memory-region: %d\n",
+			 np, ret);
+		goto out_put;
+	}
+
+	splash->map_data = memremap(res.start, resource_size(&res),
+				    MEMREMAP_WB);
+	if (!splash->map_data) {
+		drm_warn(client->dev, "splash: failed to map %pR\n", &res);
+		goto out_put;
+	}
+
+	/* The BMP header, checked against this size, says how much is image */
+	splash->dt_data = splash->map_data;
+	splash->dt_len = resource_size(&res);
+
+out_keep:
+	splash->dt_np = np;
+	return true;
+
+out_put:
+	of_node_put(np);
+	return false;
+}
+
+static int drm_splash_dt_load(struct drm_splash *splash, const u8 **data,
+			      size_t *size)
+{
+	*data = splash->dt_data;
+	*size = splash->dt_len;
+	return 0;
+}
+#else
+static bool drm_splash_dt_open(struct drm_splash *splash)
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
@@ -509,6 +638,8 @@ static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
 				 size_t *img_data_len)
 {
 	switch (splash->src) {
+	case DRM_SPLASH_SRC_DT:
+		return drm_splash_dt_load(splash, img_data, img_data_len);
 	case DRM_SPLASH_SRC_BGRT:
 		return drm_splash_bgrt_load(splash, img_data, img_data_len);
 	case DRM_SPLASH_SRC_BMP:
@@ -521,12 +652,15 @@ static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
 }
 
 /*
- * Pick the one source the image will come from: the BGRT is whatever the
- * firmware shows, and the BMP loaded as firmware is the fallback. With
- * neither, only the background colour is drawn.
+ * Pick the one source the image will come from. A device tree node is only
+ * there if someone put it there for this board, so it goes first; the BGRT
+ * is whatever the firmware shows, and the BMP loaded as firmware is the
+ * fallback. With none of them, only the background colour is drawn.
  */
 static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 {
+	if (drm_splash_dt_open(splash))
+		return DRM_SPLASH_SRC_DT;
 	if (drm_splash_bgrt_available(splash))
 		return DRM_SPLASH_SRC_BGRT;
 	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
@@ -540,6 +674,8 @@ static void drm_splash_image_cleanup(struct drm_splash *splash)
 {
 	memunmap(splash->map_data);
 	splash->map_data = NULL;
+	of_node_put(splash->dt_np);
+	splash->dt_np = NULL;
 	release_firmware(splash->fw);
 	splash->fw = NULL;
 }
-- 
2.39.5

