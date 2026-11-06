Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F7606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7EVnIoI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35BAA10F5D0;
	Fri,  6 Nov 2026 13:16:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D59A10F5D0
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76433402D8;
 Fri,  6 Nov 2026 13:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF0D1F008A6;
 Fri,  6 Nov 2026 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970994;
 bh=F3H1KuYRRSCw47gcSH12jTx+HaB+ejUFsDtxvfcp1W0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=V7EVnIoIBqCDNy1V0frKBBZ6nkIySz0DZPnUutZgCxJy1vrTJwf8rGjVApMQQWSI5
 tU83eSwjjYqVb3QhLkWkFvSx22AuarEfHwRmDHrYJNY5VRlQyccGzA4DN+cLu3ILYg
 9iLArWpamp8vN+MsdebpZOeATpo0uNN+G2KHfkcsPByknKsOl9bnB/5yAPjx8PYqQF
 yH6hFkPqujTanbysnriaIYxeJTTQ8jjnwEUBJQtyQE642trhIZAtSYeRo0EhKB21C+
 vJbOvUdkamCBDIQzRLzag8GRkfDpEieAP3HZETE3utbdjMzUciuHqonir8Rkt4RYOL
 +ZeEjphYOCnNw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:44 +0100
Subject: [PATCH v8 31/39] drm/bridge_connector: Implement hw readout for
 connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-31-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7203; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8uawM5F7Z+BMd3HDloOhPzu2bhKDStIR+XG7Uto4R1Q=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrt0rqg8Kz3ZUmWNhli1J2cfZwVCCLvhqpxETlf+esRH3uLi
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrt0roACgkQJ1/OGaI9vnYsGAGAkpVJ
 YZXNQyPWCcNf21vV+3h8BL9oz6h35ttzORxUCCbZlP1/yLMtCENzeAUoXK8+AYCOCYNC06SrxzL
 aur1JIMUAjfokm3AXCAZ8QrWAyH4W7UwacQxFMqnT+3tyK6BhE/Y=
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
@@ -12,4 +12,5 @@
 
 #include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
@@ -68,4 +69,12 @@ struct drm_bridge_connector {
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
@@ -245,4 +254,24 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
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
@@ -278,4 +307,16 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
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
@@ -828,4 +869,5 @@ static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
 	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)data;
 
+	drm_bridge_put(bridge_connector->bridge_connector_hw_readout);
 	drm_bridge_put(bridge_connector->bridge_edid);
 	drm_bridge_put(bridge_connector->bridge_hpd);
@@ -858,4 +900,5 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 						struct drm_encoder *encoder)
 {
+	const struct drm_connector_funcs *connector_funcs;
 	struct drm_bridge_connector *bridge_connector;
 	struct drm_connector *connector;
@@ -897,4 +940,11 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
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
@@ -1029,4 +1079,15 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
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
@@ -1075,5 +1136,5 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 		ret = drmm_connector_hdmi_init(drm, connector,
-					       &drm_bridge_connector_funcs,
+					       connector_funcs,
 					       &bridge_connector->hdmi_funcs,
 					       connector_type, ddc);
@@ -1082,5 +1143,5 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	} else {
 		ret = drmm_connector_init(drm, connector,
-					  &drm_bridge_connector_funcs,
+					  connector_funcs,
 					  connector_type, ddc);
 		if (ret)
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 436dfffb25ad..b73f3424ed62 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -943,4 +943,29 @@ struct drm_bridge_funcs {
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
@@ -1083,4 +1108,11 @@ enum drm_bridge_ops {
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
 

-- 
2.55.0

