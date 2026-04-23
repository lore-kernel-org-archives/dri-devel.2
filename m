Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F82F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8E410F081;
	Thu, 23 Apr 2026 10:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UcCqf2Zy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CB810F07A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5707D6013B;
 Thu, 23 Apr 2026 10:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC84C2BCB5;
 Thu, 23 Apr 2026 10:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939579;
 bh=7oGv+KuomC0hME+fdl3tZpg638rIcvWxxi9tscwETuA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UcCqf2Zy7ktDDCPU0P3b4VbBQ6Gci2B5bfnqF7SnhYyaAts9MjS+ZQZCUVQ/KhPsH
 18MorZjugSCAWpDXVSwn296RNNPoIOZL1EyEyzK0FnoxsK+iFHB31YWAU9IUpzj/b5
 EySGnWXx6pqVX5ZLGXu4em2gnb9ht0lHMafrW0BddB0Vpl0g5cfx9Qn/+NTFtHUxin
 oegU1MpDLmBqfvgum3Rb+3rDiBh+XGcRUbQ/6TvtWlQa9/t1ufcrR8tP6bN/Ws0mNV
 adk1hEyFvhgGCIBcYJBaPrV7+6Wc7KDJ2Vpe2OD6UVjhQSHNaD8bztqa9y2WUNYEJD
 5/qRefepPS2NQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:37 +0200
Subject: [PATCH v2 24/28] drm/bridge_connector: Implement hw readout for
 connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-24-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5687; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7oGv+KuomC0hME+fdl3tZpg638rIcvWxxi9tscwETuA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP356nmd5bNKKuPSLTP5dYksZ+U4s4nsiUr+w8NPUc
 yWZLmnyHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAic18y1gqePjYj4sGGjsmZ
 GYxy3w8p/2LI/Gqz4UBSwu5nnr0tMmyrvf2fNURsVji9Mu3unI+7bzPWh3Wlv3LZEOW3dV7wdCV
 h9ZuhR58uPKnaXR7yQarErejvMT/Z49vvqfScjNOfsn3vTBE5AA==
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
index 4b310fe505b4..43f6de5c1295 100644
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
@@ -281,15 +290,33 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
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
 };
@@ -831,10 +858,14 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
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
index 36d558a5cd4d..17c863da5d6d 100644
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
2.53.0

