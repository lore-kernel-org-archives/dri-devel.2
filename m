Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E5606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nb+ibHK9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9771B10F8EC;
	Tue,  3 Nov 2026 22:42:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8249E10F8C0;
 Tue,  3 Nov 2026 22:42:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F399460416;
 Tue,  3 Nov 2026 22:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A721F00A20;
 Tue,  3 Nov 2026 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745748;
 bh=Qcm7dNlNC7FzVRWrzrfVIhHJC+ShPSNQpQhZi/uhkcQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nb+ibHK9JAbh82K8ggyPNssRjvJVzwveQFWZXv0a6pINFTUP9tD8cpX/SWEYHwTog
 QsXQXWHwCtwI+KuFNafJV8v26GgOnqBaPaBlML5QTISqcWa3+bkPovQkgjKppwT3nr
 yQafEg9epQjd087eDFrxSaxDWT9tnzbpncSnNpjns3978frYMaqIGG9H/fiXtOlsOi
 S/5cVXD4TprlJoxO0wYTbAYxX/UtBMq+CyLJU3idwcC1zQPIThYORvDsLCoGtbov2n
 G/U0tBu3xDouJyq6uRXCCxwOg0CwPrXGezP0lbdR9csd5P/xaFU9ENpAyWnplOmQzB
 q1V97y6YhhdYQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:08 -0600
Subject: [PATCH v11 07/12] drm/panel: add connector luminance forwarding
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-7-00cce7b2ba22@kernel.org>
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

Add helpers that expose a panel backlight through the connector
LUMINANCE property and forward connector updates to the backlight
backend.

Hook the helpers into panel bridges that create their own connector.
Panels consumed directly, or by a panel bridge attached with
DRM_BRIDGE_ATTACH_NO_CONNECTOR, remain unchanged. Turning the backlight
on and off is left to drm_panel_enable() and drm_panel_disable(), which
already honour self refresh.

The panel backlight remains the hardware backend and keeps its
/sys/class/backlight device, which is owned by the backlight driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Don't remove drm_panel.h stubs (rebase artifact, Sashiko)
 * Use drm_connector_to_panel() rather than an invalid panel_bridge
   container_of() (Sashiko)
 * Clean up the connector if attaching the property fails (Sashiko)
 * Drop .disable_luminance and program the committed level before
   drm_panel_enable() (Sashiko)
 * Don't attach the property when the panel bridge is attached after the
   device is registered, which would WARN
 * Update brightness under the backlight ops_lock
v10:
 * Split panel support out of the combined panel and bridge patch
 * Limit integration to panel bridges that own their connector
---
 drivers/gpu/drm/drm_panel.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_panel.h     |  4 ++
 2 files changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 74c96da45b7a5..bbd0e14401c18 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -64,9 +64,18 @@ static int panel_bridge_connector_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(panel, connector);
 }
 
+static void
+panel_bridge_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_panel *panel = drm_connector_to_panel(conn_state->connector);
+
+	drm_panel_set_luminance(panel, conn_state->luminance);
+}
+
 static const struct drm_connector_helper_funcs
 panel_bridge_connector_helper_funcs = {
 	.get_modes = panel_bridge_connector_get_modes,
+	.set_luminance = panel_bridge_connector_set_luminance,
 };
 
 static const struct drm_connector_funcs panel_bridge_connector_funcs = {
@@ -101,6 +110,12 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 	drm_panel_bridge_set_orientation(connector, bridge);
 
+	ret = drm_panel_attach_luminance_property(panel, connector);
+	if (ret) {
+		drm_connector_cleanup(connector);
+		return ret;
+	}
+
 	drm_connector_attach_encoder(connector, encoder);
 
 	if (bridge->dev->registered) {
@@ -169,6 +184,19 @@ static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
+	/*
+	 * Program the committed luminance before drm_panel_enable() turns the
+	 * backlight on, so the panel does not light up at a stale level.
+	 */
+	if (panel->connector.luminance_property) {
+		const struct drm_connector_state *conn_state =
+			drm_atomic_get_new_connector_state(atomic_state,
+							   &panel->connector);
+
+		if (conn_state)
+			drm_panel_set_luminance(panel, conn_state->luminance);
+	}
+
 	drm_panel_enable(panel);
 }
 
@@ -873,6 +901,71 @@ void drm_panel_disable(struct drm_panel *panel)
 }
 EXPORT_SYMBOL(drm_panel_disable);
 
+/**
+ * drm_panel_attach_luminance_property - expose a panel backlight through DRM
+ * @panel: panel whose backlight is controlled
+ * @connector: connector on which to expose the property
+ *
+ * The backlight class device remains the internal hardware backend. When the
+ * luminance UAPI is enabled, userspace controls that backend through the DRM
+ * connector property instead.
+ *
+ * Return: 0 on success or a negative error code
+ */
+int drm_panel_attach_luminance_property(struct drm_panel *panel,
+					struct drm_connector *connector)
+{
+	struct backlight_device *backlight;
+
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) || !panel)
+		return 0;
+
+	backlight = panel->backlight;
+	if (!backlight)
+		return 0;
+
+	/* Properties can't be created once the device is visible to userspace */
+	if (connector->dev->registered) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] registered, not exposing luminance\n",
+			    connector->base.id, connector->name);
+		return 0;
+	}
+
+	return drm_connector_attach_luminance_property(connector, 0,
+					backlight->props.max_brightness,
+					backlight->props.brightness);
+}
+EXPORT_SYMBOL(drm_panel_attach_luminance_property);
+
+/**
+ * drm_panel_set_luminance - set a panel backlight's relative luminance
+ * @panel: panel whose backlight is controlled
+ * @luminance: relative luminance level
+ *
+ * Updates the backlight brightness without changing its power state, under
+ * the same lock as brightness changes made through sysfs. Turning
+ * the backlight on and off is left to drm_panel_enable() and
+ * drm_panel_disable(), so a level set while the panel is disabled is applied
+ * when the panel is enabled again.
+ */
+void drm_panel_set_luminance(struct drm_panel *panel, unsigned int luminance)
+{
+	struct backlight_device *backlight;
+
+	if (!panel || !panel->backlight)
+		return;
+
+	backlight = panel->backlight;
+	guard(mutex)(&backlight->ops_lock);
+	if (!backlight->ops || luminance > backlight->props.max_brightness)
+		return;
+
+	backlight->props.brightness = luminance;
+	backlight_update_status(backlight);
+}
+EXPORT_SYMBOL(drm_panel_set_luminance);
+
 /**
  * drm_panel_get_modes - probe the available display modes of a panel
  * @panel: DRM panel
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 58113ea7d63a0..233d30dd2e182 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -342,6 +342,10 @@ void drm_panel_unprepare(struct drm_panel *panel);
 void drm_panel_enable(struct drm_panel *panel);
 void drm_panel_disable(struct drm_panel *panel);
 
+int drm_panel_attach_luminance_property(struct drm_panel *panel,
+					struct drm_connector *connector);
+void drm_panel_set_luminance(struct drm_panel *panel, unsigned int luminance);
+
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
 
 #if defined(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL)

-- 
2.53.0

