Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E128608B7C8
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRJ4yx6U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC76010F0CF;
	Mon,  2 Nov 2026 16:49:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A3E10F077;
 Mon,  2 Nov 2026 16:49:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CE8F402E3;
 Mon,  2 Nov 2026 16:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D7D1F00A16;
 Mon,  2 Nov 2026 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638174;
 bh=YSyMvnh/7lb6iIhsEElFmAfEW3SO6FDM4FmQHRrqxFA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eRJ4yx6UHsDnxv2oMuOahrSAyviWROYksewf8e4zNB3ESIqmyZnmCwYsmSF4lGsHE
 Ja0TMyP05GMpwwd9rlYjnVAm9jv+3bqNNz6wjCo+gT04/v38C3MM4oDACp9FWg35Ho
 S+v8IATOECnWheDNyhzUFFSyCOkC8TDGQX6ezwdXQySkdZ/srWvYqd4HseiXU3vv7v
 wMSkKsXDASh8dT5ttO8PnJ1TqUvzyst3RYnnDcgQYiO4n5ItwxYTyTShDjO8Me0W9O
 7ceZF/42b8myLOmUr8G/7cWmTJ80oje4lyEkDFXAJRqSFY/1Nc9eOPHuGasswjVbIv
 9jUGAufgZ0Ysg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:19 -0600
Subject: [PATCH v10 03/15] drm/amd: add luminance property support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-3-b2a6f24131f5@kernel.org>
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

Expose the DRM LUMINANCE connector property for internal panels when
CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing backlight
class device otherwise, preserving its userspace ABI.

Use the existing brightness scaling and programming paths from connector
helper callbacks in both Display Core and legacy display. Apply atomic
luminance after the display pipeline is enabled so changes made while a
connector is inactive take effect on the next enable.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig                 |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     | 20 +++++++++++
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     | 17 +++++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 22 +++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 42 ++++++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |  2 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  7 ++--
 7 files changed, 96 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 50305630f5335..7a6a049aa6e90 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -20,7 +20,7 @@ config DRM_AMDGPU
 	select I2C
 	select I2C_ALGOBIT
 	select CRC16
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	select INTERVAL_TREE
 	select DRM_BUDDY
 	select DRM_SUBALLOC_HELPER
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 92c98e999efe9..209a7a6c246db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -798,11 +798,31 @@ static int amdgpu_connector_set_lcd_property(struct drm_connector *connector,
 	return 0;
 }
 
+static void amdgpu_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_encoder *encoder =
+		amdgpu_connector_best_single_encoder(conn_state->connector);
+
+	if (encoder)
+		amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder),
+							    conn_state->luminance);
+}
+
+static void amdgpu_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_encoder *encoder =
+		amdgpu_connector_best_single_encoder(conn_state->connector);
+
+	if (encoder)
+		amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder), 0);
+}
 
 static const struct drm_connector_helper_funcs amdgpu_connector_lvds_helper_funcs = {
 	.get_modes = amdgpu_connector_lvds_get_modes,
 	.mode_valid = amdgpu_connector_lvds_mode_valid,
 	.best_encoder = amdgpu_connector_best_single_encoder,
+	.set_luminance = amdgpu_connector_set_luminance,
+	.disable_luminance = amdgpu_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs amdgpu_connector_lvds_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index a1d05df0ac99b..dbff532ac1bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -191,6 +191,21 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 		goto register_acpi_backlight;
 	}
 
+	dig = amdgpu_encoder->enc_priv;
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		unsigned int brightness;
+
+		brightness = amdgpu_atombios_encoder_get_backlight_level(amdgpu_encoder);
+		if (drm_connector_attach_luminance_property(drm_connector, 0,
+							    AMDGPU_MAX_BL_LEVEL,
+							     brightness))
+			return;
+
+		dig->backlight_level = brightness;
+		dig->bl_dev = NULL;
+		return;
+	}
+
 	pdata = kmalloc_obj(struct amdgpu_backlight_privdata);
 	if (!pdata) {
 		DRM_ERROR("Memory allocation failed\n");
@@ -211,7 +226,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 
 	pdata->encoder = amdgpu_encoder;
 
-	dig = amdgpu_encoder->enc_priv;
 	dig->bl_dev = bd;
 
 	bd->props.brightness = amdgpu_atombios_encoder_get_backlight_brightness(bd);
@@ -2123,4 +2137,3 @@ amdgpu_atombios_encoder_get_dig_info(struct amdgpu_encoder *amdgpu_encoder)
 
 	return dig;
 }
-
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0ea45ab12119c..53ff9a55c3a8e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5191,9 +5191,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		}
 
 		/* Skip any modesets/resets */
-		if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
+		if (!acrtc || !new_crtc_state ||
+		    drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+		drm_connector_update_privacy_screen(new_con_state);
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
@@ -5273,8 +5276,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 		kfree(dummy_updates);
-
-		drm_connector_update_privacy_screen(new_con_state);
 	}
 
 	/**
@@ -5397,11 +5398,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 	/* Update audio instances for each connector. */
 	amdgpu_dm_commit_audio(dev, state);
 
-	/* restore the backlight level */
-	for (i = 0; i < dm->num_of_edps; i++) {
-		if (dm->backlight_dev[i] &&
-		    (dm->actual_brightness[i] != dm->brightness[i]))
-			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		/* Apply brightness after the display pipeline is enabled. */
+		drm_atomic_helper_commit_luminance_enables(state);
+	} else {
+		/* Restore the legacy backlight level. */
+		for (i = 0; i < dm->num_of_edps; i++) {
+			if (dm->backlight_dev[i] &&
+			    dm->actual_brightness[i] != dm->brightness[i])
+				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+		}
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 0f664c658a127..0857354e7327e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -41,6 +41,7 @@
 #include <linux/backlight.h>
 #include <linux/minmax.h>
 #include <linux/power_supply.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_panel_quirks.h>
 
@@ -296,13 +297,17 @@ struct dc_stream_state *dm_find_stream_with_link(
 	struct amdgpu_display_manager *dm,
 	struct dc_link *link)
 {
-	struct dc_state *cur_dc_state = dm->dc->current_state;
+	struct dc_state *cur_dc_state;
 	struct dc_stream_state *stream = NULL;
 	int i;
 
+	if (!dm || !dm->dc || !dm->dc->current_state || !link)
+		return NULL;
+
+	cur_dc_state = dm->dc->current_state;
 	for (i = 0; i < cur_dc_state->stream_count; i++) {
 		stream = cur_dc_state->streams[i];
-		if (stream->link == link)
+		if (stream && stream->link == link)
 			return stream;
 	}
 
@@ -356,7 +361,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 
 	dm->brightness[bl_idx] = user_brightness;
 	/* update scratch register */
-	if (bl_idx == 0)
+	if (bl_idx == 0 && dm->adev && dm->adev->rmmio && dm->adev->bios_scratch_reg_offset)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
 
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
@@ -657,6 +662,10 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 {
 	struct dc_link *link = aconnector->dc_link;
 	int bl_idx = dm->num_of_edps;
+	struct backlight_properties props = { 0 };
+	struct amdgpu_dm_backlight_caps *caps;
+	struct drm_connector *connector = &aconnector->base;
+	int ret;
 
 	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
 	    link->type == dc_connection_none)
@@ -675,6 +684,19 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 
 	amdgpu_dm_update_connector_ext_caps(aconnector);
 
+	caps = &dm->backlight_caps[bl_idx];
+	amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() > 0,
+				       !(amdgpu_dc_debug_mask &
+					 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
+				       &props);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		unsigned int max = props.max_brightness;
+		unsigned int value = props.brightness;
+
+		ret = drm_connector_attach_luminance_property(connector, 0, max, value);
+		drm_WARN_ON(adev_to_drm(dm->adev), ret);
+	}
+
 	/* Offer ABM property when user didn't turn off by module parameter.
 	 * OLED panels are included to support CACP (Content Adaptive
 	 * Contrast and Power) feature via set_abm_level.
@@ -686,6 +708,20 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
 
+void amdgpu_dm_set_luminance(const struct drm_connector_state *state)
+{
+	struct amdgpu_dm_connector *aconnector =
+		to_amdgpu_dm_connector(state->connector);
+	struct amdgpu_display_manager *dm =
+		&drm_to_adev(state->connector->dev)->dm;
+
+	if (aconnector->bl_idx < 0)
+		return;
+
+	amdgpu_dm_backlight_set_level(dm, aconnector->bl_idx,
+				      state->luminance);
+}
+
 /**
  * DOC: panel power savings
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 891749322191c..859224cb37988 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -33,6 +33,7 @@ struct dc_stream_state;
 struct device;
 struct device_attribute;
 struct drm_connector;
+struct drm_connector_state;
 struct attribute_group;
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
@@ -47,6 +48,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 void amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 			    struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_set_luminance(const struct drm_connector_state *state);
 void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector);
 bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index b498fc5fbb140..f2c2a2e730d3e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1944,7 +1944,8 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 	}
 
 	if (aconnector->bl_idx != -1) {
-		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
+		if (dm->backlight_dev[aconnector->bl_idx])
+			backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
 	}
 
@@ -2038,7 +2039,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 			return r;
 	}
 
-	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE))
+		amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
@@ -2701,6 +2703,7 @@ amdgpu_dm_connector_helper_funcs = {
 	.get_modes = get_modes,
 	.mode_valid = amdgpu_dm_connector_mode_valid,
 	.atomic_check = amdgpu_dm_connector_atomic_check,
+	.set_luminance = amdgpu_dm_set_luminance,
 };
 
 int amdgpu_dm_convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)

-- 
2.53.0

