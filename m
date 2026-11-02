Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF02606E038
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyGR+Gwk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C4710F0D6;
	Mon,  2 Nov 2026 16:50:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B8010F0C1;
 Mon,  2 Nov 2026 16:49:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A89564461D;
 Mon,  2 Nov 2026 16:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81231F00A18;
 Mon,  2 Nov 2026 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638197;
 bh=NmtGwAXlhFvD+UNjRl7M/VzNaxYayUxKSwqu5orOPA4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IyGR+GwkGhqjQTLBR/NJwZvOs6FGmvScpW3Rq+7H2H/MHSHy+5roOHnQw60fnorRU
 jJl6IYNXjrl+HOLld6xRVY1xcJEGnT3KP4/2XEaSvZYHlh98xxLVUPFi7Hh5fW91du
 tRKyKn+2AFyeQWQ8qr/fuJwI5VCQXrZGR2VH7My4YSOKlodD3sfpnK+8UGKVxz1LSe
 0dKJBTK6c0eM4pJb5uDs+M8zDstihk00NoRZyy0JLnn9KgC4fFyRumPyd+JY9nn2wI
 JDXGqdpXqfSOrVLrg3LFBK5lTLAYwVwa4PSAtQuzjOePQU+EFJdQBzE81OnIT/2WrK
 22FbdchWSp4xg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:31 -0600
Subject: [PATCH v10 15/15] drm/solomon: add SSD130x connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-15-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
In-Reply-To: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mario Limonciello <mario.limonciello@amd.com>

Expose SSD130x contrast through the connector LUMINANCE property when
DRM_LUMINANCE is enabled. Program contrast directly and retain the
backlight class interface when BACKLIGHT_CLASS_DEVICE is enabled.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10:
 * Guard the backlight operations and registration with
   BACKLIGHT_CLASS_DEVICE
 * Fix Kconfig recursive issue
 * Add the Reviewed-by tag
---
 drivers/gpu/drm/solomon/Kconfig   |  2 +-
 drivers/gpu/drm/solomon/ssd130x.c | 79 ++++++++++++++++++++++++++++++---------
 2 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 400a6cab3a671..76852246eb9c2 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -1,7 +1,7 @@
 config DRM_SSD130X
 	tristate "DRM support for Solomon SSD13xx OLED displays"
 	depends on DRM && MMU
-	select BACKLIGHT_CLASS_DEVICE
+	depends on DRM_LUMINANCE || BACKLIGHT_CLASS_DEVICE = y || !BACKLIGHT_CLASS_DEVICE
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index ee43cf0da8792..aaf2b194273ba 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1853,7 +1853,8 @@ static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
-	backlight_enable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_enable(ssd130x->bl_dev);
 
 	return;
 
@@ -1879,7 +1880,8 @@ static void ssd132x_encoder_atomic_enable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
-	backlight_enable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_enable(ssd130x->bl_dev);
 
 	return;
 
@@ -1904,7 +1906,8 @@ static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
-	backlight_enable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_enable(ssd130x->bl_dev);
 
 	return;
 
@@ -1929,7 +1932,8 @@ static void ssd135x_encoder_atomic_enable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
-	backlight_enable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_enable(ssd130x->bl_dev);
 
 	return;
 
@@ -1943,7 +1947,8 @@ static void ssd130x_encoder_atomic_disable(struct drm_encoder *encoder,
 	struct drm_device *drm = encoder->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 
-	backlight_disable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_disable(ssd130x->bl_dev);
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_OFF);
 
@@ -1980,8 +1985,44 @@ static int ssd130x_connector_get_modes(struct drm_connector *connector)
 	return drm_connector_helper_get_modes_fixed(connector, &ssd130x->mode);
 }
 
+static int ssd130x_set_luminance_value(struct ssd130x_device *ssd130x,
+				       unsigned int luminance)
+{
+	int ret;
+
+	ssd130x->contrast = luminance;
+
+	switch (ssd130x->device_info->family_id) {
+	case SSD133X_FAMILY:
+		return ssd133x_set_contrast(ssd130x, luminance);
+	case SSD135X_FAMILY:
+		return ssd135x_set_contrast(ssd130x, luminance);
+	default:
+		ret = ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
+		if (ret < 0)
+			return ret;
+		return ssd130x_write_cmd(ssd130x, 1, luminance);
+	}
+}
+
+static void ssd130x_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
+
+	ssd130x_set_luminance_value(ssd130x, conn_state->luminance);
+}
+
+static void ssd130x_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
+
+	ssd130x_set_luminance_value(ssd130x, 0);
+}
+
 static const struct drm_connector_helper_funcs ssd130x_connector_helper_funcs = {
 	.get_modes = ssd130x_connector_get_modes,
+	.set_luminance = ssd130x_connector_set_luminance,
+	.disable_luminance = ssd130x_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs ssd130x_connector_funcs = {
@@ -2015,23 +2056,13 @@ static const struct drm_driver ssd130x_drm_driver = {
 	.fops			= &ssd130x_fops,
 };
 
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 static int ssd130x_update_bl(struct backlight_device *bdev)
 {
 	struct ssd130x_device *ssd130x = bl_get_data(bdev);
-	int brightness = backlight_get_brightness(bdev);
-	int ret;
-
-	ssd130x->contrast = brightness;
-
-	ret = ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
-	if (ret < 0)
-		return ret;
 
-	ret = ssd130x_write_cmd(ssd130x, 1, ssd130x->contrast);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ssd130x_set_luminance_value(ssd130x,
+					  backlight_get_brightness(bdev));
 }
 
 static int ssd133x_update_bl(struct backlight_device *bdev)
@@ -2066,6 +2097,7 @@ static const struct backlight_ops ssd130xfb_bl_ops[] = {
 		.update_status	= ssd135x_update_bl,
 	},
 };
+#endif
 
 static void ssd130x_parse_properties(struct ssd130x_device *ssd130x)
 {
@@ -2213,6 +2245,13 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 	}
 
 	drm_connector_helper_add(connector, &ssd130x_connector_helper_funcs);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      MAX_CONTRAST,
+							     ssd130x->contrast);
+		if (ret)
+			return ret;
+	}
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
@@ -2245,7 +2284,9 @@ static int ssd130x_get_resources(struct ssd130x_device *ssd130x)
 struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 {
 	struct ssd130x_device *ssd130x;
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 	struct backlight_device *bl;
+#endif
 	struct drm_device *drm;
 	int ret;
 
@@ -2270,6 +2311,7 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ERR_PTR(ret);
 
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
 					    &ssd130xfb_bl_ops[ssd130x->device_info->family_id],
 					    NULL);
@@ -2280,6 +2322,7 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	bl->props.brightness = ssd130x->contrast;
 	bl->props.max_brightness = MAX_CONTRAST;
 	ssd130x->bl_dev = bl;
+#endif
 
 	ret = ssd130x_init_modeset(ssd130x);
 	if (ret)

-- 
2.53.0

