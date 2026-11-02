Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1F608C25A
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S24The52
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C6610F0ED;
	Mon,  2 Nov 2026 16:49:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E5110F0D0;
 Mon,  2 Nov 2026 16:49:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6468060F42;
 Mon,  2 Nov 2026 16:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756331F0157E;
 Mon,  2 Nov 2026 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638186;
 bh=mN5kDy/x7cmwk8/ZEylaxE2t0zPl5PDlWnEUt4VPDBw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=S24The52tsRZ9x8Vm5e2ZXRrtJnM2qMgtDguBzGcs2Htu/RxAYy2NnQGRhHL4OU1V
 hQbNO2774U2HpkvwNGDLxkFJkk5zBCz7gxf+WFdMn81YG14GoNVvNHJe3EDEAepFj6
 YXk/yO483S6pzQxhzn5YCst3fOiuW5aHc1Oru3GzSsLO/mgCy+pHnm0dy/W7qDC4zD
 Ln1L/k8wTn88CplCPWQG3P72VEW52YEK4+puPKjFMTFmj8KD7VgzYSl41RJcZwLyOq
 GTuJUMNy5Y67tcCtzStb3FJ4GNgg4goUGMcc8C4cFy9Tkbg9conYWXwVJfItplQ3e6
 mF57Q5Ed5cV3Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:25 -0600
Subject: [PATCH v10 09/15] drm/bridge_connector: add luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-9-b2a6f24131f5@kernel.org>
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

Discover the last bridge in a chain that owns brightness control, attach
its relative luminance range to the connector, and forward atomic
luminance updates to it.

Do not infer panel luminance support from a terminal panel bridge. Panels
still have direct consumers, so their connector integration must remain
explicit.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10:
 * Split bridge connector integration into a separate patch
 * Do not special-case panels in the generic bridge connector
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 81f3e26f6fdf5..bf0a6d162a7d3 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -125,6 +125,12 @@ struct drm_bridge_connector {
 	 */
 	struct drm_bridge *bridge_hdmi_cec;
 
+	/**
+	 * @bridge_luminance:
+	 *
+	 * The last bridge in the chain that controls panel luminance.
+	 */
+	struct drm_bridge *bridge_luminance;
 	/**
 	 * @hdmi_funcs:
 	 *
@@ -421,6 +427,28 @@ static int drm_bridge_connector_atomic_check(struct drm_connector *connector,
 	return 0;
 }
 
+static void
+drm_bridge_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(conn_state->connector);
+	struct drm_bridge *bridge = bridge_connector->bridge_luminance;
+
+	if (bridge)
+		bridge->funcs->set_luminance(bridge, conn_state->luminance);
+}
+
+static void
+drm_bridge_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(conn_state->connector);
+	struct drm_bridge *bridge = bridge_connector->bridge_luminance;
+
+	if (bridge)
+		bridge->funcs->set_luminance(bridge, 0);
+}
+
 static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs = {
 	.get_modes = drm_bridge_connector_get_modes,
 	.detect_ctx = drm_bridge_connector_detect_ctx,
@@ -429,6 +457,8 @@ static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs
 	.enable_hpd = drm_bridge_connector_enable_hpd,
 	.disable_hpd = drm_bridge_connector_disable_hpd,
 	.atomic_check = drm_bridge_connector_atomic_check,
+	.set_luminance = drm_bridge_connector_set_luminance,
+	.disable_luminance = drm_bridge_connector_disable_luminance,
 };
 
 static enum drm_mode_status
@@ -835,6 +865,7 @@ static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
 	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
 	drm_bridge_put(bridge_connector->bridge_dp_audio);
 	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
+	drm_bridge_put(bridge_connector->bridge_luminance);
 }
 
 /**
@@ -918,6 +949,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			drm_bridge_put(bridge_connector->bridge_detect);
 			bridge_connector->bridge_detect = drm_bridge_get(bridge);
 		}
+		if (bridge->ops & DRM_BRIDGE_OP_LUMINANCE) {
+			if (!bridge->funcs->set_luminance)
+				return ERR_PTR(-EINVAL);
+
+			drm_bridge_put(bridge_connector->bridge_luminance);
+			bridge_connector->bridge_luminance = drm_bridge_get(bridge);
+		}
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
 			if (bridge_connector->bridge_hdmi)
 				return ERR_PTR(-EBUSY);
@@ -1144,6 +1182,16 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) && bridge_connector->bridge_luminance && !connector->luminance_property) {
+		struct drm_bridge *bridge = bridge_connector->bridge_luminance;
+
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      bridge->luminance_max,
+							     bridge->luminance);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
 	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
 		drm_connector_attach_content_protection_property(connector, true);

-- 
2.53.0

