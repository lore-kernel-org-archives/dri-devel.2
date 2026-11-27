Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC3606A333
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1codRF5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8967811292E;
	Fri, 27 Nov 2026 09:54:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7371411292B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB8C2611ED;
 Fri, 27 Nov 2026 09:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05CD1F008A0;
 Fri, 27 Nov 2026 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773278;
 bh=ZLSjPle1krVNVTgdP2NkfUZ3M9w3y+3WJPJHN8BJ7Jc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=H1codRF5zUb+d+A/yDdiSZjvYNJIEU4pXcv3BxiBbqLYtfeF90BnISesspYyK9B9t
 YPkolc3OxsCdSjMhB2ANtdnglU7ZbG11RJyEMZsnN8v8QcS8deeogBKw0eW050DNol
 UX2XArPcIzMWpG9CLljVUaHT3RCEEz6r4QcDMs2BCCtN48Nz7eKgA2ptamYer4honq
 icX/6/lbPTfzmozyYTOUV8g6+renKouenHjJo2L7oKsEU3yEmOV7KeIDeQxK0qaeYi
 zSqs60Kg957HQkk08ft0ewqj1c7rgKuq8CT0YZUtKVfU8HtKDaY+LfropO6oehgA+d
 EGL6mj/XEBm3Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:05 +0100
Subject: [PATCH v10 23/36] drm/bridge_connector: Implement hw readout for
 connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-23-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9509; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KEatr8kc12fyFC6e1G+OB7QebxgyU12DdexcuPRqgQY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwWyzOXYb60qXveaZwvzo+sr2vRp5HVfOFPB4z1bPr
 VXpYfzeMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbC7snY8LfqygqVyXdj2NLO
 zjrP8e0Fg2zpnsCySIfFuU5rdFv8gj78jlK+b5s5XyZBmPHq94dTGBt+OZS+btu/sFJxp6/Pl23
 9/uH5Jn8iil994u9V5L2jXqu7ZnbZvtuOn0/Yvfkt+HvPyeMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_bridge_connector allows to create a generic connector from a list of
bridges.

However, it's a somewhat virtual connector, and relies on the bridges to
implement its various capabilities.

What we actually want though is for the last bridge implementing
hardware readout to fill the connector state from its own state.

Thus, implement a new op for bridge_connector to allow just
that.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 65 +++++++++++++++++++++++++-
 include/drm/drm_bridge.h                       | 32 +++++++++++++
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 2202e6044444..c1c208abf75c 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -9,10 +9,11 @@
 #include <linux/of.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
 #include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
@@ -65,10 +66,18 @@ struct drm_bridge_connector {
 	 * @encoder:
 	 *
 	 * The encoder at the start of the bridges chain.
 	 */
 	struct drm_encoder *encoder;
+	/**
+	 * @bridge_connector_hw_readout:
+	 *
+	 * The last bridge in the chain (closest to the connector) that
+	 * provides hardware state readout support, if any (see
+	 * &DRM_BRIDGE_OP_CONNECTOR_HW_READOUT).
+	 */
+	struct drm_bridge *bridge_connector_hw_readout;
 	/**
 	 * @bridge_edid:
 	 *
 	 * The last bridge in the chain (closest to the connector) that provides
 	 * EDID read support, if any (see &DRM_BRIDGE_OP_EDID).
@@ -242,10 +251,30 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
 							      connector);
 
 	return conn_state;
 }
 
+static int
+drm_bridge_connector_readout_state(struct drm_connector *connector,
+				   struct drm_atomic_sro_state *state,
+				   struct drm_connector_state *conn_state)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *readout =
+		bridge_connector->bridge_connector_hw_readout;
+	int ret;
+
+	if (readout) {
+		ret = readout->funcs->atomic_sro_connector_readout(readout, state, conn_state);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static enum drm_connector_color_format
 drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(conn_state->connector);
@@ -275,10 +304,22 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.debugfs_init = drm_bridge_connector_debugfs_init,
 	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
 	.color_format = drm_bridge_connector_color_format,
 };
 
+static const struct drm_connector_funcs drm_bridge_connector_sro_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_create_state = drm_bridge_connector_create_state,
+	.atomic_sro_readout_state = drm_bridge_connector_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_connector_compare_state,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.debugfs_init = drm_bridge_connector_debugfs_init,
+	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
+	.color_format = drm_bridge_connector_color_format,
+};
+
 /* -----------------------------------------------------------------------------
  * Bridge Connector Helper Functions
  */
 
 static int drm_bridge_connector_detect_ctx(struct drm_connector *connector,
@@ -825,10 +866,11 @@ static const struct drm_connector_hdmi_cec_funcs drm_bridge_connector_hdmi_cec_f
 
 static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
 {
 	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)data;
 
+	drm_bridge_put(bridge_connector->bridge_connector_hw_readout);
 	drm_bridge_put(bridge_connector->bridge_edid);
 	drm_bridge_put(bridge_connector->bridge_hpd);
 	drm_bridge_put(bridge_connector->bridge_detect);
 	drm_bridge_put(bridge_connector->bridge_modes);
 	drm_bridge_put(bridge_connector->bridge_hdmi);
@@ -855,10 +897,11 @@ static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
  * pointer otherwise.
  */
 struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 						struct drm_encoder *encoder)
 {
+	const struct drm_connector_funcs *connector_funcs;
 	struct drm_bridge_connector *bridge_connector;
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
 	bool support_hdcp = false;
@@ -894,10 +937,17 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (!bridge->interlace_allowed)
 			connector->interlace_allowed = false;
 		if (!bridge->ycbcr_420_allowed)
 			connector->ycbcr_420_allowed = false;
 
+		if (bridge->ops & DRM_BRIDGE_OP_CONNECTOR_HW_READOUT) {
+			if (!bridge->funcs->atomic_sro_connector_readout)
+				return ERR_PTR(-EINVAL);
+
+			drm_bridge_put(bridge_connector->bridge_connector_hw_readout);
+			bridge_connector->bridge_connector_hw_readout = drm_bridge_get(bridge);
+		}
 		/*
 		 * Ensure the last bridge declares OP_EDID or OP_MODES or both.
 		 */
 		if (bridge->ops & DRM_BRIDGE_OP_EDID || bridge->ops & DRM_BRIDGE_OP_MODES) {
 			drm_bridge_put(bridge_connector->bridge_edid);
@@ -1026,10 +1076,21 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Only expose the hardware state readout hooks when a bridge in
+	 * the chain provides a connector readout implementation.
+	 * Otherwise, the readout would silently succeed with a
+	 * pristine, disconnected connector state.
+	 */
+	if (bridge_connector->bridge_connector_hw_readout)
+		connector_funcs = &drm_bridge_connector_sro_funcs;
+	else
+		connector_funcs = &drm_bridge_connector_funcs;
+
 	if (bridge_connector->bridge_hdmi) {
 		bridge_connector->hdmi_funcs = drm_bridge_connector_hdmi_funcs;
 
 		bridge_connector->hdmi_funcs.vendor = bridge_connector->bridge_hdmi->vendor;
 		bridge_connector->hdmi_funcs.product = bridge_connector->bridge_hdmi->product;
@@ -1072,18 +1133,18 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->hdmi_funcs.scrambler_disable =
 				drm_bridge_connector_scrambler_disable;
 		}
 
 		ret = drmm_connector_hdmi_init(drm, connector,
-					       &drm_bridge_connector_funcs,
+					       connector_funcs,
 					       &bridge_connector->hdmi_funcs,
 					       connector_type, ddc);
 		if (ret)
 			return ERR_PTR(ret);
 	} else {
 		ret = drmm_connector_init(drm, connector,
-					  &drm_bridge_connector_funcs,
+					  connector_funcs,
 					  connector_type, ddc);
 		if (ret)
 			return ERR_PTR(ret);
 	}
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index a74407ee5a9c..a1c953da0975 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -978,10 +978,35 @@ struct drm_bridge_funcs {
 	 */
 	int (*dp_audio_mute_stream)(struct drm_bridge *bridge,
 				    struct drm_connector *connector,
 				    bool enable, int direction);
 
+	/**
+	 * @atomic_sro_connector_readout:
+	 *
+	 * This optional hook initializes the &struct drm_connector_state
+	 * based on hardware state.
+	 *
+	 * It is implemented by bridges that set the
+	 * %DRM_BRIDGE_OP_CONNECTOR_HW_READOUT flag in their
+	 * &drm_bridge.ops. When using drm_bridge_connector, the last
+	 * bridge in the chain with this flag set will have its hook
+	 * called to fill the connector state.
+	 *
+	 * Drivers are expected to return a negative error code if the
+	 * hardware was programmed with a configuration they don't
+	 * support. The framework will then abort the readout and fall
+	 * back to the regular initialization path.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success, a negative error code otherwise.
+	 */
+	int (*atomic_sro_connector_readout)(struct drm_bridge *bridge,
+					    struct drm_atomic_sro_state *state,
+					    struct drm_connector_state *conn_state);
+
 	/**
 	 * @debugfs_init:
 	 *
 	 * Allows bridges to create bridge-specific debugfs files.
 	 */
@@ -1118,10 +1143,17 @@ enum drm_bridge_ops {
 	 * @DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME: The bridge supports
 	 * &drm_bridge_funcs->hdmi_write_spd_infoframe and
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+	/**
+	 * @DRM_BRIDGE_OP_CONNECTOR_HW_READOUT: The bridge supports the
+	 * &drm_bridge_funcs.atomic_sro_connector_readout callback to
+	 * fill the connector state from the bridge's own hardware state
+	 * during state readout.
+	 */
+	DRM_BRIDGE_OP_CONNECTOR_HW_READOUT = BIT(11),
 };
 
 /**
  * struct drm_bridge - central DRM bridge control structure
  */

-- 
2.56.1

