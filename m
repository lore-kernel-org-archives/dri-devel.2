Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A4606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbpGCKDK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1E510F8F1;
	Tue,  3 Nov 2026 22:42:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31C010F8C6;
 Tue,  3 Nov 2026 22:42:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B70843AA5;
 Tue,  3 Nov 2026 22:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E4D1F00A1F;
 Tue,  3 Nov 2026 22:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745758;
 bh=qJz4Y3pmBhvfNKPCdS16oXtdOSx6Dt11DR2lDyz2UZg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PbpGCKDKxV5hlKimg1geLnJHi7WavKPOJXa+vAu62pVQIReLlYVMnDmyInxzVh8/s
 tkQD58PAC3Ao2qq7juLFFN/ziOrBHyyP/66tHsexB1fcrWoTyTNDqTllTuXLf4130n
 mbO0sqbRJuvOwlkLvuvtGtI/oCGHQQ7wihTCQR2xaQXyep/HL3wucEOXp0dan53v+p
 KsTfm72BNRE5N3RVYCYqZXUq4fNiQZpOopd0pPwI3swJGKdEnmMycwXsN3jnYxn5Pz
 C/hhQ+ST1Qt3ZbvyONUjAGq/Ay8Ikf1Uj9dqEgz275dL07Rb9DkcuNlAC6feSr+XzT
 ZDIbvvwZTNpqg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:13 -0600
Subject: [PATCH v11 12/12] drm/solomon: add SSD130x connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-12-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
In-Reply-To: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
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
DRM_LUMINANCE is enabled. Program contrast directly and register the
backlight class device only when DRM_LUMINANCE is disabled, so contrast
has a single owner.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Keep selecting BACKLIGHT_CLASS_DEVICE and drop the guards (Sashiko)
 * Register the backlight device only without DRM_LUMINANCE (Sashiko)
 * Initialise the controller with the committed luminance and don't
   clobber the saved contrast on disable (Sashiko)
 * Skip contrast writes while the controller is powered down (Sashiko)
 * Unify contrast dispatch and backlight ops (Sashiko)
 * Drop Reviewed-by due to the rework
v10:
 * Guard the backlight operations and registration with
   BACKLIGHT_CLASS_DEVICE
 * Fix Kconfig recursive issue
 * Add the Reviewed-by tag
---
 drivers/gpu/drm/solomon/ssd130x.c | 149 ++++++++++++++++++++++++--------------
 drivers/gpu/drm/solomon/ssd130x.h |   2 +
 2 files changed, 98 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index ee43cf0da8792..32e892194f578 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -627,7 +627,7 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 static int ssd132x_init(struct ssd130x_device *ssd130x)
 {
 	const u8 cmds[] = {
-		2, SSD13XX_CONTRAST, 0x80,
+		2, SSD13XX_CONTRAST, ssd130x->contrast,
 		3, SSD132X_SET_COL_RANGE, 0x00, ssd130x->width / SSD132X_SEGMENT_WIDTH - 1,
 		3, SSD132X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
 		/*
@@ -696,6 +696,18 @@ static int ssd135x_set_contrast(struct ssd130x_device *ssd130x, u32 brightness)
 	return ssd130x_write_cmd(ssd130x, 4, SSD135X_SET_CONTRAST, a, b, c);
 }
 
+static int ssd130x_set_contrast(struct ssd130x_device *ssd130x, u32 contrast)
+{
+	switch (ssd130x->device_info->family_id) {
+	case SSD133X_FAMILY:
+		return ssd133x_set_contrast(ssd130x, contrast);
+	case SSD135X_FAMILY:
+		return ssd135x_set_contrast(ssd130x, contrast);
+	default:
+		return ssd130x_write_cmd(ssd130x, 2, SSD13XX_CONTRAST, contrast);
+	}
+}
+
 static int ssd133x_init(struct ssd130x_device *ssd130x)
 {
 	int ret;
@@ -1836,6 +1848,23 @@ static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
 	.atomic_destroy_state = ssd130x_crtc_destroy_state,
 };
 
+/*
+ * With DRM_LUMINANCE, initialize the controller with the committed connector
+ * luminance, which may have changed while the display was disabled.
+ */
+static void ssd130x_load_luminance(struct ssd130x_device *ssd130x,
+				   struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *conn_state;
+
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE))
+		return;
+
+	conn_state = drm_atomic_get_new_connector_state(state, &ssd130x->connector);
+	if (conn_state)
+		ssd130x->contrast = conn_state->luminance;
+}
+
 static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
 					  struct drm_atomic_commit *state)
 {
@@ -1847,12 +1876,16 @@ static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ssd130x_load_luminance(ssd130x, state);
+
 	ret = ssd130x_init(ssd130x);
 	if (ret)
 		goto power_off;
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
+	ssd130x->enabled = true;
+
 	backlight_enable(ssd130x->bl_dev);
 
 	return;
@@ -1873,12 +1906,16 @@ static void ssd132x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ssd130x_load_luminance(ssd130x, state);
+
 	ret = ssd132x_init(ssd130x);
 	if (ret)
 		goto power_off;
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
+	ssd130x->enabled = true;
+
 	backlight_enable(ssd130x->bl_dev);
 
 	return;
@@ -1898,12 +1935,16 @@ static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ssd130x_load_luminance(ssd130x, state);
+
 	ret = ssd133x_init(ssd130x);
 	if (ret)
 		goto power_off;
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
+	ssd130x->enabled = true;
+
 	backlight_enable(ssd130x->bl_dev);
 
 	return;
@@ -1923,12 +1964,16 @@ static void ssd135x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ssd130x_load_luminance(ssd130x, state);
+
 	ret = ssd135x_init(ssd130x);
 	if (ret)
 		goto power_off;
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
+	ssd130x->enabled = true;
+
 	backlight_enable(ssd130x->bl_dev);
 
 	return;
@@ -1945,6 +1990,8 @@ static void ssd130x_encoder_atomic_disable(struct drm_encoder *encoder,
 
 	backlight_disable(ssd130x->bl_dev);
 
+	ssd130x->enabled = false;
+
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_OFF);
 
 	ssd130x_power_off(ssd130x);
@@ -1980,8 +2027,34 @@ static int ssd130x_connector_get_modes(struct drm_connector *connector)
 	return drm_connector_helper_get_modes_fixed(connector, &ssd130x->mode);
 }
 
+static void ssd130x_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
+
+	/*
+	 * The encoder enable already initialized the controller with the
+	 * committed luminance. Skip if it failed to power up the controller.
+	 */
+	if (!ssd130x->enabled || ssd130x->contrast == conn_state->luminance)
+		return;
+
+	ssd130x->contrast = conn_state->luminance;
+	ssd130x_set_contrast(ssd130x, ssd130x->contrast);
+}
+
+static void ssd130x_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
+
+	/* Keep ssd130x->contrast, it is restored when the encoder is enabled */
+	if (ssd130x->enabled)
+		ssd130x_set_contrast(ssd130x, 0);
+}
+
 static const struct drm_connector_helper_funcs ssd130x_connector_helper_funcs = {
 	.get_modes = ssd130x_connector_get_modes,
+	.set_luminance = ssd130x_connector_set_luminance,
+	.disable_luminance = ssd130x_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs ssd130x_connector_funcs = {
@@ -2016,55 +2089,16 @@ static const struct drm_driver ssd130x_drm_driver = {
 };
 
 static int ssd130x_update_bl(struct backlight_device *bdev)
-{
-	struct ssd130x_device *ssd130x = bl_get_data(bdev);
-	int brightness = backlight_get_brightness(bdev);
-	int ret;
-
-	ssd130x->contrast = brightness;
-
-	ret = ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd130x_write_cmd(ssd130x, 1, ssd130x->contrast);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int ssd133x_update_bl(struct backlight_device *bdev)
-{
-	struct ssd130x_device *ssd130x = bl_get_data(bdev);
-
-	ssd130x->contrast = backlight_get_brightness(bdev);
-
-	return ssd133x_set_contrast(ssd130x, ssd130x->contrast);
-}
-
-static int ssd135x_update_bl(struct backlight_device *bdev)
 {
 	struct ssd130x_device *ssd130x = bl_get_data(bdev);
 
 	ssd130x->contrast = backlight_get_brightness(bdev);
 
-	return ssd135x_set_contrast(ssd130x, ssd130x->contrast);
+	return ssd130x_set_contrast(ssd130x, ssd130x->contrast);
 }
 
-static const struct backlight_ops ssd130xfb_bl_ops[] = {
-	[SSD130X_FAMILY] = {
-		.update_status	= ssd130x_update_bl,
-	},
-	[SSD132X_FAMILY] = {
-		.update_status	= ssd130x_update_bl,
-	},
-	[SSD133X_FAMILY] = {
-		.update_status	= ssd133x_update_bl,
-	},
-	[SSD135X_FAMILY] = {
-		.update_status	= ssd135x_update_bl,
-	},
+static const struct backlight_ops ssd130xfb_bl_ops = {
+	.update_status	= ssd130x_update_bl,
 };
 
 static void ssd130x_parse_properties(struct ssd130x_device *ssd130x)
@@ -2213,6 +2247,13 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 	}
 
 	drm_connector_helper_add(connector, &ssd130x_connector_helper_funcs);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      MAX_CONTRAST,
+							      ssd130x->contrast);
+		if (ret)
+			return ret;
+	}
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
@@ -2270,16 +2311,18 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ERR_PTR(ret);
 
-	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
-					    &ssd130xfb_bl_ops[ssd130x->device_info->family_id],
-					    NULL);
-	if (IS_ERR(bl))
-		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
-					     "Unable to register backlight device\n"));
-
-	bl->props.brightness = ssd130x->contrast;
-	bl->props.max_brightness = MAX_CONTRAST;
-	ssd130x->bl_dev = bl;
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		bl = devm_backlight_device_register(dev, dev_name(dev), dev,
+						    ssd130x, &ssd130xfb_bl_ops,
+						    NULL);
+		if (IS_ERR(bl))
+			return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
+						     "Unable to register backlight device\n"));
+
+		bl->props.brightness = ssd130x->contrast;
+		bl->props.max_brightness = MAX_CONTRAST;
+		ssd130x->bl_dev = bl;
+	}
 
 	ret = ssd130x_init_modeset(ssd130x);
 	if (ret)
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index fd81262f2ceb9..536a5649edffc 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -100,6 +100,8 @@ struct ssd130x_device {
 	u32 prechargep2;
 
 	struct backlight_device *bl_dev;
+	/* Controller is powered and initialized, set from atomic commits */
+	bool enabled;
 	struct pwm_device *pwm;
 	struct gpio_desc *reset;
 	struct regulator *vcc_reg;

-- 
2.53.0

