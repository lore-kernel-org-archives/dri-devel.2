Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D8606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERNW35KG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C37F10F8E0;
	Tue,  3 Nov 2026 22:42:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C3310F8A8;
 Tue,  3 Nov 2026 22:42:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 937FC41AE6;
 Tue,  3 Nov 2026 22:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BBC1F0093A;
 Tue,  3 Nov 2026 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745756;
 bh=JDOFP0lBfi8GeV67m9asGivOpxWxqXgZkhYHVbXSUTg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ERNW35KGsHiVym8/H0/iOko9whJ/J9EGYfN9IFD9bgM6VLE8FcAbzfOHRFKVTiHno
 nWEj6ogTZeJ6tXM22S+qUWMJlKfSNMa+RMaQzfsPCkjCLYO0m7vb8HpS49DhiwaA70
 8fOb2gTU6o09dPsLWNfOfsaZE48wJuMt1eMdJceMb2OCb0wgvs4ib8efRxrl0PJKcG
 FSoL8QhaXx9Gzo23mcNC+Jb4mPm+j0jEeh2S3NE45/gxa92u/3btja60PVh4Ip3+4c
 z/q7BPLvalkzh1p10d3J7TBrFjbmg78n6EmoHscHVndp8xxBLop7ZnjAb6SNukDls2
 TDwj1S6egLjDw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:12 -0600
Subject: [PATCH v11 11/12] drm/bridge: add PS8622 connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-11-00cce7b2ba22@kernel.org>
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

Expose PS8622 brightness through bridge luminance operations when
DRM_LUMINANCE is enabled. Keep registering the backlight class device
otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Track internal PWM mode explicitly so it is still configured with
   LUMINANCE (Sashiko)
 * Don't access I2C while the bridge is powered down (Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE (Sashiko)
 * Program the committed luminance in pre_enable
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 66 +++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 3a2ec482037df..c88bd7a97d4a4 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -45,6 +45,8 @@ struct ps8622_bridge {
 	struct drm_bridge *panel_bridge;
 	struct regulator *v12;
 	struct backlight_device *bl;
+	u8 brightness;
+	bool internal_pwm;
 
 	struct gpio_desc *gpio_slp;
 	struct gpio_desc *gpio_rst;
@@ -268,7 +270,7 @@ static int ps8622_send_config(struct ps8622_bridge *ps8622)
 		goto error;
 
 
-	if (ps8622->bl) {
+	if (ps8622->internal_pwm) {
 		/* DPCD720, internal PWM */
 		err = ps8622_set(cl, 0x01, 0xa5, 0xa0);
 		if (err)
@@ -276,7 +278,7 @@ static int ps8622_send_config(struct ps8622_bridge *ps8622)
 
 		/* FFh for 100% brightness, 0h for 0% brightness */
 		err = ps8622_set(cl, 0x01, 0xa7,
-				ps8622->bl->props.brightness);
+				ps8622->brightness);
 		if (err)
 			goto error;
 	} else {
@@ -324,6 +326,8 @@ static int ps8622_backlight_update(struct backlight_device *bl)
 	struct ps8622_bridge *ps8622 = dev_get_drvdata(&bl->dev);
 	int ret, brightness = backlight_get_brightness(bl);
 
+	ps8622->brightness = brightness;
+
 	if (!ps8622->enabled)
 		return -EINVAL;
 
@@ -332,6 +336,20 @@ static int ps8622_backlight_update(struct backlight_device *bl)
 	return ret;
 }
 
+static void ps8622_set_luminance(struct drm_bridge *bridge,
+				 unsigned int luminance)
+{
+	struct ps8622_bridge *ps8622 = bridge_to_ps8622(bridge);
+
+	ps8622->brightness = luminance;
+
+	/* Applied by ps8622_send_config() on the next pre_enable */
+	if (!ps8622->enabled)
+		return;
+
+	ps8622_set(ps8622->client, 0x01, 0xa7, luminance);
+}
+
 static const struct backlight_ops ps8622_backlight_ops = {
 	.update_status	= ps8622_backlight_update,
 };
@@ -340,11 +358,22 @@ static void ps8622_pre_enable(struct drm_bridge *bridge,
 			      struct drm_atomic_commit *commit)
 {
 	struct ps8622_bridge *ps8622 = bridge_to_ps8622(bridge);
+	struct drm_connector *connector;
 	int ret;
 
 	if (ps8622->enabled)
 		return;
 
+	/* Program the committed luminance from ps8622_send_config() */
+	connector = drm_atomic_get_new_connector_for_encoder(commit, bridge->encoder);
+	if (connector && connector->luminance_property) {
+		const struct drm_connector_state *conn_state =
+			drm_atomic_get_new_connector_state(commit, connector);
+
+		if (conn_state)
+			ps8622->brightness = conn_state->luminance;
+	}
+
 	gpiod_set_value(ps8622->gpio_rst, 0);
 
 	if (ps8622->v12) {
@@ -438,6 +467,7 @@ static const struct drm_bridge_funcs ps8622_bridge_funcs = {
 	.atomic_disable = ps8622_disable,
 	.atomic_post_disable = ps8622_post_disable,
 	.attach = ps8622_attach,
+	.set_luminance = ps8622_set_luminance,
 };
 
 static const struct of_device_id ps8622_devices[] = {
@@ -502,18 +532,28 @@ static int ps8622_probe(struct i2c_client *client)
 		ps8622->lane_count = ps8622->max_lane_count;
 	}
 
-	if (!of_property_read_bool(dev->of_node, "use-external-pwm")) {
-		ps8622->bl = backlight_device_register("ps8622-backlight",
-				dev, ps8622, &ps8622_backlight_ops,
-				NULL);
-		if (IS_ERR(ps8622->bl)) {
-			DRM_ERROR("failed to register backlight\n");
-			ret = PTR_ERR(ps8622->bl);
-			ps8622->bl = NULL;
-			return ret;
+	ps8622->brightness = PS8622_MAX_BRIGHTNESS;
+	ps8622->internal_pwm = !of_property_read_bool(dev->of_node,
+						      "use-external-pwm");
+	if (ps8622->internal_pwm) {
+		if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+			ps8622->bridge.ops |= DRM_BRIDGE_OP_LUMINANCE;
+			ps8622->bridge.luminance_max = PS8622_MAX_BRIGHTNESS;
+			ps8622->bridge.luminance = ps8622->brightness;
+		} else {
+			ps8622->bl = backlight_device_register("ps8622-backlight",
+							       dev, ps8622,
+							       &ps8622_backlight_ops,
+							       NULL);
+			if (IS_ERR(ps8622->bl)) {
+				DRM_ERROR("failed to register backlight\n");
+				ret = PTR_ERR(ps8622->bl);
+				ps8622->bl = NULL;
+				return ret;
+			}
+			ps8622->bl->props.max_brightness = PS8622_MAX_BRIGHTNESS;
+			ps8622->bl->props.brightness = ps8622->brightness;
 		}
-		ps8622->bl->props.max_brightness = PS8622_MAX_BRIGHTNESS;
-		ps8622->bl->props.brightness = PS8622_MAX_BRIGHTNESS;
 	}
 
 	ps8622->bridge.type = DRM_MODE_CONNECTOR_LVDS;

-- 
2.53.0

