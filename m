Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9807CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D555110F812;
	Thu, 15 Oct 2026 15:10:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4244D10F469
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8098F60234;
 Thu, 15 Oct 2026 15:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B571F000C6;
 Thu, 15 Oct 2026 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077031;
 bh=6ikx2OWKkrVw7GBRzTpZyB2XeBozlcFB3obfA7Nuu60=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XDscxUa4KGIN73nuEouYvR5m5FdgkyBen72akIIcsgyBnLNu53K1m+YpG3Ze1336J
 HbD7nBoRQ0BM5gM1i+T2N6lQL/6zEQPju66g/NhgiQcb8xcPjtCCQxPIAfD6uFYeF7
 o3q2LqS2Vdt/+T060n1b/YyZptlib8R9kZZzRSDjEXHjd/kvImiBHDaDow5e9Up3mV
 dxqmPgzeh83FQcN9mvrCKGvzYahJRkY7mEzmgqd6z3CwhMat5GAPJ9LejMeXR4WYum
 CEre6/7JSO3u6+M9IyjbA+VzVazgu6g5tVOcb4cyEyMt3jL1f4zPviOHFqXAxLlVUr
 jnCMohQpe+BdA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:13 +0200
Subject: [PATCH v6 21/28] drm/bridge: display-connector: Implement readout
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-21-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4632; i=mripard@kernel.org;
 h=from:subject:message-id; bh=AADsVvjOUKqu0fChcN5y7MelADtafp3NqVPbvn50PwQ=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrQ7JPIVGeAER18I8Wg1R2qgFhvk95cw0vKl808uTCLhTZV1
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrQ7JMACgkQJ1/OGaI9vnYabwGA4OOh
 KJwdBWvMLi7ey41tJ+8iQtiOTI3avSTRNmmsC8plSpZavP3Gx8Da4AdxLypiAYCqlJW2QSP8gZF
 W7KMNQEXm4gT+AFwxwA6zhzjXGW/i3h4azXoSRueDw+SU2z/0P9s=
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

The display-connector bridge is the last bridge in the chain on
platforms using drm_bridge_connector, and is responsible for the
physical connector interface.

Implement the atomic_sro_readout_state hook and wire up the default
drm_atomic_helper_bridge_compare_state() as the compare hook.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/display-connector.c | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index eb3412ec30a0..7f285b7c1e84 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -12,11 +12,14 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/workqueue.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro.h>
+#include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
 
 struct display_connector {
 	struct drm_bridge	bridge;
@@ -211,10 +214,69 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 	return prev_bridge->funcs->atomic_get_input_bus_fmts(prev_bridge, prev_bridge_state,
 							     crtc_state, conn_state, output_fmt,
 							     num_input_fmts);
 }
 
+/*
+ * Reconstruct the bridge bus configuration from the previous bridge's
+ * readout state and the connector's display_info.
+ *
+ * During normal atomic check, drm_atomic_bridge_chain_select_bus_fmts()
+ * and drm_atomic_bridge_propagate_bus_flags() walk the bridge chain to
+ * negotiate formats and propagate flags. During SRO readout, those
+ * functions do not run, so each bridge must reconstruct its own state.
+ *
+ * The SRO infrastructure traverses bridges from first to last, so the
+ * previous bridge's state is already available. The input bus
+ * configuration is taken from the previous bridge's output. The output
+ * bus format comes from the connector's display_info, since this bridge
+ * is the last in the chain and acts as a passthrough to the connector.
+ * Bus flags are also taken from display_info, matching the default
+ * propagation behavior of drm_atomic_bridge_propagate_bus_flags().
+ */
+static int
+display_connector_readout_state(struct drm_bridge *bridge,
+				struct drm_atomic_sro_state *state,
+				struct drm_bridge_state *bridge_state,
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *conn_state)
+{
+	struct drm_display_info *di = &conn_state->connector->display_info;
+	struct drm_bridge *prev_bridge __free(drm_bridge_put) =
+		drm_bridge_get_prev_bridge(bridge);
+
+	if (prev_bridge) {
+		struct drm_private_state *prev_priv_state =
+			drm_atomic_sro_get_private_obj_state(state,
+							     &prev_bridge->base);
+		struct drm_bridge_state *prev_bridge_state;
+
+		if (!prev_priv_state)
+			return -ENODEV;
+
+		prev_bridge_state =
+			drm_priv_to_bridge_state(prev_priv_state);
+
+		bridge_state->input_bus_cfg.format =
+			prev_bridge_state->output_bus_cfg.format;
+		bridge_state->input_bus_cfg.flags =
+			prev_bridge_state->output_bus_cfg.flags;
+	} else {
+		bridge_state->input_bus_cfg.format = MEDIA_BUS_FMT_FIXED;
+		bridge_state->input_bus_cfg.flags = di->bus_flags;
+	}
+
+	if (di->num_bus_formats && di->bus_formats)
+		bridge_state->output_bus_cfg.format = di->bus_formats[0];
+	else
+		bridge_state->output_bus_cfg.format = MEDIA_BUS_FMT_FIXED;
+
+	bridge_state->output_bus_cfg.flags = di->bus_flags;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
 	.destroy = display_connector_destroy,
 	.detect = display_connector_bridge_detect,
 	.hpd_enable = display_connector_hpd_enable,
@@ -223,10 +285,12 @@ static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+	.atomic_sro_readout_state	= display_connector_readout_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
 static irqreturn_t display_connector_hpd_irq(int irq, void *arg)
 {
 	struct display_connector *conn = arg;

-- 
2.55.0

