Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075460A6C39
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nN3M0RQu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077F310F100;
	Mon,  2 Nov 2026 16:49:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8FF10F0B7;
 Mon,  2 Nov 2026 16:49:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B52C760ED9;
 Mon,  2 Nov 2026 16:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13011F00A16;
 Mon,  2 Nov 2026 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638180;
 bh=gm4ojsrTq/5JloeBdI2aBnQQnNmA9mtr/wCN2h4c++A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nN3M0RQu3zDkgG55INL2wRWm1zog1HM/xaYqJSv9uw3KI8OkjPLtjzyplt/QRG7jA
 Py/p+j1ChU7CZ98zvlqY7SHanXc72/NnTMksQTheLC80tvXn6ASmVXt8lGwNzSUZhp
 4x8CEM2cZn7EzoTrvx9AOdLD9WE6WdyC27GdZNzFsbKD3b4sZ5tRINDE3aELjnZoWV
 /vguOFTyquIBUJK948ZSaTk/yLFzKTAvLUbVtbrBNPF6v5npXgL173TTR0Nx01F9kD
 YE66H28/RBJLNAYsXw/NRxolGtdsn6R64ElVKFdOPA1FDgscF+5P++g4uqo7yC3eaA
 LKh/y+4QkOU/A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:22 -0600
Subject: [PATCH v10 06/15] drm/i915/display: add luminance property support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-6-b2a6f24131f5@kernel.org>
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

Expose the DRM LUMINANCE connector property for eDP, LVDS, and DSI panels
when CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing
backlight class device otherwise, preserving its userspace ABI.

Use the existing Intel brightness scaling and programming path from
connector helper callbacks. Apply atomic luminance after modeset enables
so updates made while a panel is inactive take effect when it is enabled
again. The shared display code provides the same behavior to i915 and Xe.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/i915/Kconfig                   |  2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c         |  1 +
 drivers/gpu/drm/i915/display/intel_backlight.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_backlight.h |  1 +
 drivers/gpu/drm/i915/display/intel_display.c   |  2 ++
 drivers/gpu/drm/i915/display/intel_dp.c        |  1 +
 drivers/gpu/drm/i915/display/intel_lvds.c      |  1 +
 drivers/gpu/drm/i915/display/intel_panel.c     |  8 +++++---
 drivers/gpu/drm/i915/display/vlv_dsi.c         |  1 +
 drivers/gpu/drm/xe/Kconfig                     |  2 +-
 10 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 71426b9c91f00..720191673a1e7 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -26,7 +26,7 @@ config DRM_I915
 	select IRQ_WORK
 	# i915 depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE
 	select INPUT if ACPI
 	select ACPI_WMI if ACPI
 	select ACPI_VIDEO if ACPI
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
index b128896cb1c2d..6d658c7b5d99f 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -9,6 +9,7 @@
 #include <linux/string_helpers.h>
 #include <acpi/video.h>
 
+#include <drm/drm_connector.h>
 #include <drm/drm_file.h>
 #include <drm/drm_print.h>
 #include <drm/intel/pci_config.h>
@@ -1670,6 +1671,9 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 {
 	struct intel_display *display = to_intel_display(connector);
 	struct intel_panel *panel = &connector->panel;
+	struct drm_connector *base = &connector->base;
+	u32 brightness;
+	u32 max;
 	int ret;
 
 	if (!connector->panel.vbt.backlight.present) {
@@ -1703,6 +1707,13 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 
 	panel->backlight.present = true;
 
+	max = panel->backlight.max;
+	brightness = scale_hw_to_user(connector, panel->backlight.level, max);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		ret = drm_connector_attach_luminance_property(base, 0, max, brightness);
+		drm_WARN_ON(display->drm, ret);
+	}
+
 	drm_dbg_kms(display->drm,
 		    "[CONNECTOR:%d:%s] backlight initialized, %s, brightness %u/%u\n",
 		    connector->base.base.id, connector->base.name,
@@ -1712,6 +1723,15 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 	return 0;
 }
 
+void intel_backlight_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct intel_connector *connector =
+		to_intel_connector(conn_state->connector);
+
+	intel_panel_set_backlight(conn_state, conn_state->luminance,
+				  connector->panel.backlight.max);
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
index d5d4453f283bb..3c81ed630c365 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7696,6 +7696,8 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 	/* Now enable the clocks, plane, pipe, and connectors that we set up. */
 	display->modeset.funcs->commit_modeset_enables(state);
 
+	drm_atomic_helper_commit_luminance_enables(&state->base);
+
 	intel_display_power_dc3co_compute(state);
 
 	/* FIXME probably need to sequence this properly */
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d8c0d9381471d..0b8ca17cc1152 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6883,6 +6883,7 @@ static const struct drm_connector_helper_funcs intel_dp_connector_helper_funcs =
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
index 81e638d0c7b33..501573a75b89c 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -610,9 +610,11 @@ int intel_panel_register(struct intel_connector *connector)
 	struct intel_panel *panel = &connector->panel;
 	int ret;
 
-	ret = intel_backlight_device_register(connector);
-	if (ret)
-		return ret;
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
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
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 502c7b3c1f16a..6418ccc8e3468 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -26,7 +26,7 @@ config DRM_XE
 	select IRQ_WORK
 	# xe depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
 	select ACPI_WMI if ACPI

-- 
2.53.0

