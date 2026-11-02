Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468D6072C7B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnmXVOH+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DEE10F102;
	Mon,  2 Nov 2026 16:49:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83BE10F0EE;
 Mon,  2 Nov 2026 16:49:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B21C60F1F;
 Mon,  2 Nov 2026 16:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F71F00A17;
 Mon,  2 Nov 2026 16:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638191;
 bh=CeLtMJy3R9kxJji/8niFyp2uHd5KpQJ0Wu7DMhAOnSE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RnmXVOH+rb1Uh8zAevN2KU4Btz7MUa1RKO1lUYYQ0G7KZwsHWAa4H2t3gHGWUIRpW
 wof6sw7RXawOXyqj0spbljNjs3aktMJoIzp2PVGTr7EnAR6WzVM72nGFcG3EW+dUdQ
 tN3NfI2gEd7lCD5Za/QknmqhO6iB0j8y9h26gTc8ULWhHk2dBvnYOh9yzQevRORYl2
 oyPR6BO2eZEerFlSv0jLsRweDs9BBUT2WxfgYjaAB1r0FAfd3DilWKiH05ppBJpdxP
 ShC9nJQpR2db7TIhmcVBzugy4i17FEAaTk3amPRdoUwvKRNmWpbpmGavYQxg2NPkCi
 PGiZwUk2dtY2Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:28 -0600
Subject: [PATCH v10 12/15] drm/radeon: add connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-12-b2a6f24131f5@kernel.org>
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

Expose Radeon panel brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled. Reuse the AtomBIOS and legacy hardware
programming paths and preserve the backlight class interface otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/Kconfig                  |  2 +-
 drivers/gpu/drm/radeon/atombios_encoders.c      | 32 ++++++++++++++--
 drivers/gpu/drm/radeon/radeon_connectors.c      | 34 +++++++++++++++++
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c | 49 ++++++++++++++++++++-----
 drivers/gpu/drm/radeon/radeon_mode.h            |  2 +
 5 files changed, 106 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
index 3cd70aef770e1..2ccad1f2f8cee 100644
--- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -17,7 +17,7 @@ config DRM_RADEON
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	select POWER_SUPPLY
 	select HWMON
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	select INTERVAL_TREE
 	select I2C
 	select I2C_ALGOBIT
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 5b9c72bf40994..e6f762625bf1a 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -227,6 +227,27 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	memset(&props, 0, sizeof(props));
 	props.max_brightness = RADEON_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
+	pdata->encoder = radeon_encoder;
+	pdata->atom = true;
+	radeon_encoder->backlight_priv = pdata;
+
+	dig = radeon_encoder->enc_priv;
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		props.brightness = atombios_get_backlight_level(radeon_encoder);
+		if (!props.brightness)
+			props.brightness = RADEON_MAX_BL_LEVEL;
+
+		if (drm_connector_attach_luminance_property(drm_connector, 0,
+							    props.max_brightness,
+							     props.brightness))
+			goto error;
+
+		atombios_set_backlight_level(radeon_encoder, props.brightness);
+		dig->bl_dev = NULL;
+		rdev->mode_info.bl_encoder = radeon_encoder;
+		return;
+	}
+
 	snprintf(bl_name, sizeof(bl_name),
 		 "radeon_bl%d", dev->primary->index);
 	bd = backlight_device_register(bl_name, drm_connector->kdev,
@@ -236,9 +257,6 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 		goto error;
 	}
 
-	pdata->encoder = radeon_encoder;
-
-	dig = radeon_encoder->enc_priv;
 	dig->bl_dev = bd;
 
 	bd->props.brightness = radeon_atom_backlight_get_brightness(bd);
@@ -258,6 +276,7 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	return;
 
 error:
+	radeon_encoder->backlight_priv = NULL;
 	kfree(pdata);
 	return;
 }
@@ -282,12 +301,19 @@ static void radeon_atom_backlight_exit(struct radeon_encoder *radeon_encoder)
 	bd = dig->bl_dev;
 	dig->bl_dev = NULL;
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		kfree(radeon_encoder->backlight_priv);
+		radeon_encoder->backlight_priv = NULL;
+		return;
+	}
+
 	if (bd) {
 		struct radeon_legacy_backlight_privdata *pdata;
 
 		pdata = bl_get_data(bd);
 		backlight_device_unregister(bd);
 		kfree(pdata);
+		radeon_encoder->backlight_priv = NULL;
 
 		DRM_INFO("radeon atom LVDS backlight unloaded\n");
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 16b048f58c9be..655361407b819 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -31,6 +31,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/radeon_drm.h>
 #include "radeon.h"
+#include "radeon_asic.h"
 #include "radeon_audio.h"
 #include "atom.h"
 
@@ -931,11 +932,44 @@ static int radeon_lvds_set_property(struct drm_connector *connector,
 	return 0;
 }
 
+static void radeon_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_encoder *encoder = radeon_best_single_encoder(conn_state->connector);
+	struct radeon_encoder *radeon_encoder;
+	struct radeon_backlight_privdata *pdata;
+	u8 level = conn_state->luminance;
+
+	if (!encoder)
+		return;
+
+	radeon_encoder = to_radeon_encoder(encoder);
+	pdata = radeon_encoder->backlight_priv;
+	if (!pdata)
+		return;
+
+	if (pdata->atom) {
+		atombios_set_backlight_level(radeon_encoder, level);
+	} else {
+		if (pdata->negative)
+			level = RADEON_MAX_BL_LEVEL - level;
+		radeon_legacy_set_backlight_level(radeon_encoder, level);
+	}
+}
+
+static void radeon_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_connector_state state = *conn_state;
+
+	state.luminance = 0;
+	radeon_set_luminance(&state);
+}
 
 static const struct drm_connector_helper_funcs radeon_lvds_connector_helper_funcs = {
 	.get_modes = radeon_lvds_get_modes,
 	.mode_valid = radeon_lvds_mode_valid,
 	.best_encoder = radeon_best_single_encoder,
+	.set_luminance = radeon_set_luminance,
+	.disable_luminance = radeon_disable_luminance,
 };
 
 static const struct drm_connector_funcs radeon_lvds_connector_funcs = {
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
index 1f82e2b57f5d5..96b0dfd8e3521 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
@@ -403,16 +403,9 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
 	memset(&props, 0, sizeof(props));
 	props.max_brightness = RADEON_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
-	snprintf(bl_name, sizeof(bl_name),
-		 "radeon_bl%d", dev->primary->index);
-	bd = backlight_device_register(bl_name, drm_connector->kdev,
-				       pdata, &radeon_backlight_ops, &props);
-	if (IS_ERR(bd)) {
-		DRM_ERROR("Backlight registration failed\n");
-		goto error;
-	}
-
 	pdata->encoder = radeon_encoder;
+	pdata->atom = false;
+	radeon_encoder->backlight_priv = pdata;
 
 	backlight_level = (RREG32(RADEON_LVDS_GEN_CNTL) >>
 			   RADEON_LVDS_BL_MOD_LEVEL_SHIFT) & 0xff;
@@ -441,6 +434,36 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
 #endif
 	}
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		props.brightness = pdata->negative ?
+			RADEON_MAX_BL_LEVEL - backlight_level : backlight_level;
+		if (drm_connector_attach_luminance_property(drm_connector, 0,
+							    props.max_brightness,
+							     props.brightness))
+			goto error;
+
+		if (rdev->is_atom_bios) {
+			struct radeon_encoder_atom_dig *lvds = radeon_encoder->enc_priv;
+
+			lvds->bl_dev = NULL;
+		} else {
+			struct radeon_encoder_lvds *lvds = radeon_encoder->enc_priv;
+
+			lvds->bl_dev = NULL;
+		}
+		rdev->mode_info.bl_encoder = radeon_encoder;
+		return;
+	}
+
+	snprintf(bl_name, sizeof(bl_name),
+		 "radeon_bl%d", dev->primary->index);
+	bd = backlight_device_register(bl_name, drm_connector->kdev,
+				       pdata, &radeon_backlight_ops, &props);
+	if (IS_ERR(bd)) {
+		DRM_ERROR("Backlight registration failed\n");
+		goto error;
+	}
+
 	if (rdev->is_atom_bios) {
 		struct radeon_encoder_atom_dig *lvds = radeon_encoder->enc_priv;
 		lvds->bl_dev = bd;
@@ -459,6 +482,7 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
 	return;
 
 error:
+	radeon_encoder->backlight_priv = NULL;
 	kfree(pdata);
 	return;
 }
@@ -482,12 +506,19 @@ static void radeon_legacy_backlight_exit(struct radeon_encoder *radeon_encoder)
 		lvds->bl_dev = NULL;
 	}
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		kfree(radeon_encoder->backlight_priv);
+		radeon_encoder->backlight_priv = NULL;
+		return;
+	}
+
 	if (bd) {
 		struct radeon_backlight_privdata *pdata;
 
 		pdata = bl_get_data(bd);
 		backlight_device_unregister(bd);
 		kfree(pdata);
+		radeon_encoder->backlight_priv = NULL;
 
 		DRM_INFO("radeon legacy LVDS backlight unloaded\n");
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeon/radeon_mode.h
index 6a16d821915d2..1c5b9ed0b6989 100644
--- a/drivers/gpu/drm/radeon/radeon_mode.h
+++ b/drivers/gpu/drm/radeon/radeon_mode.h
@@ -284,6 +284,7 @@ struct radeon_mode_info {
 struct radeon_backlight_privdata {
 	struct radeon_encoder *encoder;
 	uint8_t negative;
+	bool atom;
 };
 
 #define MAX_H_CODE_TIMING_LEN 32
@@ -456,6 +457,7 @@ struct radeon_encoder {
 	uint32_t underscan_vborder;
 	struct drm_display_mode native_mode;
 	void *enc_priv;
+	struct radeon_backlight_privdata *backlight_priv;
 	int audio_polling_active;
 	bool is_ext_encoder;
 	u16 caps;

-- 
2.53.0

