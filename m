Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8B606D812
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NuFdWfA2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEAF10F8D1;
	Tue,  3 Nov 2026 22:42:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CEAD10E9CF;
 Tue,  3 Nov 2026 22:42:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E72DA4029D;
 Tue,  3 Nov 2026 22:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254F51F0093A;
 Tue,  3 Nov 2026 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745744;
 bh=RYzRY6pUjO4vR+HoG7+wRVy0VRP9l+RugrUlV/NSiUU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NuFdWfA2tudkpMTd9GfNFj4OB4kkAnEEiRSgwJ9a+QjHepJxsKKG2V5zF8N+edLrp
 pOh6woA0/CYHq711JKsg9sQvfmeFQ1A0dl1OP4N4TWcnUJtGK6xgym0M/0y45wN34S
 UYDqfPdhUbCxNLtLbcjx2BUbQ2mNr/40pu8czVWPsEsIRDD6aRq8FGsgylHbYvxp1D
 NlZ1swLmsOt4se8W0CH2wvWAJM9oiLxiF7He5YrWZI2Vckbnk9zrO3kcvdpG5uS7mE
 w1h+B1VzsTe4NfVTx4ZPqAUv0vGF0vMMlHigFLnKrNVIUiVPpOgYsIBBkrhzKuyHwj
 2jeWyYQz9pQng==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:06 -0600
Subject: [PATCH v11 05/12] drm/i915/display: add luminance property support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-5-00cce7b2ba22@kernel.org>
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

Expose the DRM LUMINANCE connector property for eDP, LVDS, and DSI panels
when CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing
backlight class device otherwise, preserving its userspace ABI.

Use the existing Intel brightness scaling and programming path from
connector helper callbacks. Apply atomic luminance after modeset enables
so updates made while a panel is inactive take effect when it is enabled
again. The shared display code provides the same behavior to i915 and Xe.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Call acpi_video_backlight_use_native() before attaching LUMINANCE and
   leave the panel to acpi_video otherwise (Sashiko)
 * Enable the backlight at the committed LUMINANCE level (Sashiko)
 * Fix build with CONFIG_BACKLIGHT_CLASS_DEVICE=n (Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE if ACPI (Sashiko)
 * Fall back to the backlight class device if attaching LUMINANCE fails
---
 drivers/gpu/drm/i915/display/icl_dsi.c         |  1 +
 drivers/gpu/drm/i915/display/intel_backlight.c | 74 ++++++++++++++++++++++----
 drivers/gpu/drm/i915/display/intel_backlight.h |  1 +
 drivers/gpu/drm/i915/display/intel_display.c   |  2 +
 drivers/gpu/drm/i915/display/intel_dp.c        |  1 +
 drivers/gpu/drm/i915/display/intel_lvds.c      |  1 +
 drivers/gpu/drm/i915/display/intel_panel.c     |  8 +--
 drivers/gpu/drm/i915/display/vlv_dsi.c         |  1 +
 8 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index ea0cdb7822f39..37ff84c03ce05 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1801,6 +1801,7 @@ static const struct drm_connector_helper_funcs gen11_dsi_connector_helper_funcs
 	.get_modes = intel_dsi_get_modes,
 	.mode_valid = gen11_dsi_mode_valid,
 	.atomic_check = intel_digital_connector_atomic_check,
+	.set_luminance = intel_backlight_set_luminance,
 };
 
 static int gen11_dsi_host_attach(struct mipi_dsi_host *host,
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index b128896cb1c2d..f9e84d17d3fb0 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -9,6 +9,7 @@
 #include <linux/string_helpers.h>
 #include <acpi/video.h>
 
+#include <drm/drm_connector.h>
 #include <drm/drm_file.h>
 #include <drm/drm_print.h>
 #include <drm/intel/pci_config.h>
@@ -76,6 +77,16 @@ static u32 clamp_user_to_hw(struct intel_connector *connector,
 	return hw_level;
 }
 
+/* Scale user_level in range [0..user_max] to [hw_min..hw_max]. */
+static u32 scale_user_to_hw(struct intel_connector *connector,
+			    u32 user_level, u32 user_max)
+{
+	struct intel_panel *panel = &connector->panel;
+
+	return scale(user_level, 0, user_max,
+		     panel->backlight.min, panel->backlight.max);
+}
+
 /* Scale hw_level in range [hw_min..hw_max] to [0..user_max]. */
 static u32 scale_hw_to_user(struct intel_connector *connector,
 			    u32 hw_level, u32 user_max)
@@ -778,6 +789,16 @@ static void __intel_backlight_enable(const struct intel_crtc_state *crtc_state,
 
 	WARN_ON(panel->backlight.max == 0);
 
+	/*
+	 * Enable at the luminance committed in this atomic state, rather than
+	 * at a stale level which would only be corrected afterwards by
+	 * drm_atomic_helper_commit_luminance_enables().
+	 */
+	if (connector->base.luminance_property)
+		panel->backlight.level =
+			scale_user_to_hw(connector, conn_state->luminance,
+					 panel->backlight.max);
+
 	if (panel->backlight.level < panel->backlight.min) {
 		panel->backlight.level = panel->backlight.min;
 		if (panel->backlight.device)
@@ -831,16 +852,6 @@ static u32 intel_panel_get_backlight(struct intel_connector *connector)
 	return val;
 }
 
-/* Scale user_level in range [0..user_max] to [hw_min..hw_max]. */
-static u32 scale_user_to_hw(struct intel_connector *connector,
-			    u32 user_level, u32 user_max)
-{
-	struct intel_panel *panel = &connector->panel;
-
-	return scale(user_level, 0, user_max,
-		     panel->backlight.min, panel->backlight.max);
-}
-
 /* set backlight brightness to level in range [0..max], scaling wrt hw min */
 static void intel_panel_set_backlight(const struct drm_connector_state *conn_state,
 				      u32 user_level, u32 user_max)
@@ -1670,6 +1681,9 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 {
 	struct intel_display *display = to_intel_display(connector);
 	struct intel_panel *panel = &connector->panel;
+	struct drm_connector *base = &connector->base;
+	u32 brightness;
+	u32 max;
 	int ret;
 
 	if (!connector->panel.vbt.backlight.present) {
@@ -1703,6 +1717,19 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 
 	panel->backlight.present = true;
 
+	/*
+	 * acpi_video_backlight_use_native() also tells the ACPI video code that
+	 * a native backlight is available. If native control should not be
+	 * used, leave the backlight to acpi_video, which is registered later
+	 * from intel_acpi_video_register().
+	 */
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) && acpi_video_backlight_use_native()) {
+		max = panel->backlight.max;
+		brightness = scale_hw_to_user(connector, panel->backlight.level, max);
+		ret = drm_connector_attach_luminance_property(base, 0, max, brightness);
+		drm_WARN_ON(display->drm, ret);
+	}
+
 	drm_dbg_kms(display->drm,
 		    "[CONNECTOR:%d:%s] backlight initialized, %s, brightness %u/%u\n",
 		    connector->base.base.id, connector->base.name,
@@ -1712,6 +1739,33 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 	return 0;
 }
 
+void intel_backlight_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct intel_connector *connector =
+		to_intel_connector(conn_state->connector);
+	struct intel_display *display = to_intel_display(connector);
+	struct intel_panel *panel = &connector->panel;
+	u32 hw_level;
+
+	if (!panel->backlight.present)
+		return;
+
+	guard(mutex)(&display->backlight.lock);
+
+	/*
+	 * Nothing to do if __intel_backlight_enable() already programmed this
+	 * level as part of a modeset enable.
+	 */
+	hw_level = scale_user_to_hw(connector, conn_state->luminance,
+				    panel->backlight.max);
+	if (hw_level == panel->backlight.level)
+		return;
+
+	panel->backlight.level = hw_level;
+	if (panel->backlight.enabled)
+		intel_panel_actually_set_backlight(conn_state, hw_level);
+}
+
 void intel_backlight_destroy(struct intel_panel *panel)
 {
 	/* dispose of the pwm */
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.h b/drivers/gpu/drm/i915/display/intel_backlight.h
index 339643f638978..1634ce414695a 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.h
+++ b/drivers/gpu/drm/i915/display/intel_backlight.h
@@ -32,6 +32,7 @@ void intel_backlight_set_acpi(const struct drm_connector_state *conn_state,
 			      u32 level, u32 max);
 void intel_backlight_set_pwm_level(const struct drm_connector_state *conn_state,
 				   u32 level);
+void intel_backlight_set_luminance(const struct drm_connector_state *conn_state);
 u32 intel_backlight_invert_pwm_level(struct intel_connector *connector, u32 level);
 u32 intel_backlight_level_to_pwm(struct intel_connector *connector, u32 level);
 u32 intel_backlight_level_from_pwm(struct intel_connector *connector, u32 val);
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index c1c2b99cfb53b..f87c78e316a5d 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7845,6 +7845,8 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 	/* Now enable the clocks, plane, pipe, and connectors that we set up. */
 	display->modeset.funcs->commit_modeset_enables(state);
 
+	drm_atomic_helper_commit_luminance_enables(&state->base);
+
 	intel_display_power_dc3co_compute(state);
 
 	/* FIXME probably need to sequence this properly */
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ef164a7976187..905c8743a2a2b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7060,6 +7060,7 @@ static const struct drm_connector_helper_funcs intel_dp_connector_helper_funcs =
 	.get_modes = intel_dp_get_modes,
 	.mode_valid = intel_dp_mode_valid,
 	.atomic_check = intel_dp_connector_atomic_check,
+	.set_luminance = intel_backlight_set_luminance,
 };
 
 enum irqreturn
diff --git a/drivers/gpu/drm/i915/display/intel_lvds.c b/drivers/gpu/drm/i915/display/intel_lvds.c
index 872753478cf21..fa668b1debb21 100644
--- a/drivers/gpu/drm/i915/display/intel_lvds.c
+++ b/drivers/gpu/drm/i915/display/intel_lvds.c
@@ -502,6 +502,7 @@ static const struct drm_connector_helper_funcs intel_lvds_connector_helper_funcs
 	.get_modes = intel_lvds_get_modes,
 	.mode_valid = intel_lvds_mode_valid,
 	.atomic_check = intel_digital_connector_atomic_check,
+	.set_luminance = intel_backlight_set_luminance,
 };
 
 static const struct drm_connector_funcs intel_lvds_connector_funcs = {
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 81e638d0c7b33..9e2a53f300d39 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -610,9 +610,11 @@ int intel_panel_register(struct intel_connector *connector)
 	struct intel_panel *panel = &connector->panel;
 	int ret;
 
-	ret = intel_backlight_device_register(connector);
-	if (ret)
-		return ret;
+	if (!connector->base.luminance_property) {
+		ret = intel_backlight_device_register(connector);
+		if (ret)
+			return ret;
+	}
 
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_DSI ||
 	    connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 8829f365592ef..7e60407e0af4a 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -1555,6 +1555,7 @@ static const struct drm_connector_helper_funcs intel_dsi_connector_helper_funcs
 	.get_modes = intel_dsi_get_modes,
 	.mode_valid = vlv_dsi_mode_valid,
 	.atomic_check = intel_digital_connector_atomic_check,
+	.set_luminance = intel_backlight_set_luminance,
 };
 
 static const struct drm_connector_funcs intel_dsi_connector_funcs = {

-- 
2.53.0

