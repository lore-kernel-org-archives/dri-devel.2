Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0872AC43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E577F10E765;
	Mon, 29 Jun 2026 08:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kE3pyiCg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1641C10E738
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:18:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3CD443E9A;
 Mon, 29 Jun 2026 08:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2591F000E9;
 Mon, 29 Jun 2026 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721099;
 bh=mLizhfoUDd0KlC8SrPah2IQcOPD2ePaB5wU+GZe8OcA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kE3pyiCgt4p3ux1RcRGZxym1cHcHEjPpa3TCdIagtVuqQUGmqw2UFnQUegFBkxwnH
 Ed4HT+TiSjMzYAUmUSsX08goa/nFbB11CYiJQhC3LkvDSwpQRZymPixf3bxMoJkoYX
 0MLKJEwVzAyxslzTpxoxe1CIA32HAo3/309brnMs7Wg5U2x34fnEMC45iSoEqSBfBJ
 7IdpCW9wLrmAiNjQ93WnwcQg5DlL73eYjNGqhgkv4RYJtnO6DVK3PpVTsNG+PEKQ5g
 8sLqIxFXGA75Mt/WRa0NBGhCA0DF7IviGJ2uSFh6dnINVTB8a8ohgbaGBtpW2WsivW
 nyWTdhrjAaDTA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:23 +0200
Subject: [PATCH v4 25/30] drm/bridge_connector: Implement hw readout for
 connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-25-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6069; i=mripard@kernel.org;
 h=from:subject:message-id; bh=I4l3um8F3zvseJf2tHcKIEM3MXWiXbS7XxOUOxASAJE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWtycVf++Oem4cCaxJt5v6L1VE34zkyHu1M2F7HLvd
 a5nhFZ2TGFhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInc72UsD2Qojvg9RXx9sMEX
 xZ7i9WHzY3+rl6xicdBw/5ew/atNovre89kHPyZxXWr7HJv0bA9jvdc11lXM0xTPlEbKGM9bxCL
 Be+lMhniZxB61wOK0Bd9e8c750tXRsL0uUqb9QStTtmUNAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

drm_bridge_connector allows to create a generic connector from a list of
bridges.

However, it's a somewhat virtual connector, and relies on the bridges to
implement its various capabilities.

What we actually want though is for the last bridge implementing
hardware readout to fill the connector state from its own state.

Thus, implement a new op for bridge_connector to allow just
that.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 31 ++++++++++++++++++++++++++
 include/drm/drm_bridge.h                       | 27 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 92f8a2d7aab4..598063d2c6a5 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -8,10 +8,11 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
+#include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
@@ -64,10 +65,18 @@ struct drm_bridge_connector {
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
@@ -281,10 +290,26 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
 							      conn_state);
 
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
+
+	if (readout)
+		readout->funcs->atomic_sro_connector_readout(readout, state, conn_state);
+
+	return 0;
+}
+
 static enum drm_connector_color_format
 drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(conn_state->connector);
@@ -309,10 +334,12 @@ drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.detect = drm_bridge_connector_detect,
 	.force = drm_bridge_connector_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_create_state = drm_bridge_connector_create_state,
+	.atomic_sro_readout_state = drm_bridge_connector_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_connector_compare_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.debugfs_init = drm_bridge_connector_debugfs_init,
 	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
 	.color_format = drm_bridge_connector_color_format,
@@ -858,10 +885,14 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (!bridge->interlace_allowed)
 			connector->interlace_allowed = false;
 		if (!bridge->ycbcr_420_allowed)
 			connector->ycbcr_420_allowed = false;
 
+		if (bridge->ops & DRM_BRIDGE_OP_CONNECTOR_HW_READOUT) {
+			drm_bridge_put(bridge_connector->bridge_connector_hw_readout);
+			bridge_connector->bridge_connector_hw_readout = drm_bridge_get(bridge);
+		}
 		/*
 		 * Ensure the last bridge declares OP_EDID or OP_MODES or both.
 		 */
 		if (bridge->ops & DRM_BRIDGE_OP_EDID || bridge->ops & DRM_BRIDGE_OP_MODES) {
 			drm_bridge_put(bridge_connector->bridge_edid);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 397218a5ebcf..630cfe769065 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1006,10 +1006,30 @@ struct drm_bridge_funcs {
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
@@ -1146,10 +1166,17 @@ enum drm_bridge_ops {
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
2.54.0

