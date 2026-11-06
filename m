Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8B606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCTXCK8E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C2910F702;
	Fri,  6 Nov 2026 13:16:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDA410EE4D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8A0443440;
 Fri,  6 Nov 2026 13:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA861F008A1;
 Fri,  6 Nov 2026 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970990;
 bh=nHzC0cRMuWjf+vbrjfqF6GbX5kxd2igbBLEnYgBSfjw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mCTXCK8EVPA6pmD6ewfRyKxaOZYMm0DayYm/fHBS/4SA2IKKAyCQWkcsKPp8+7Sdu
 0s3gf5bnjCybHFcd2jH7V+t/RsjYkCHKh/0BSRT3pcRUgGaT/UYTQXF3gnC8VUn0Vf
 P0yU72SPObMkGL+uH0F0KIUZ5uVQkNwytloxg9Q2IK6wO2WSQ8C/qFMqceqvQ30WZR
 JUf6o9IDADW4fFGWwyNtnZ9cmc92q7cFlNTLRMpTni4m0fL1IBmh/xPN2AeY8NuJOP
 yySgRx0hnYF98E2fkKpOg18MohezCoPj2V9O81Kyy2k9a+PbauHQqSPWXfY3efTLPz
 zTFBRGscaY7CQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:43 +0100
Subject: [PATCH v8 30/39] drm/bridge: display-connector: Implement readout
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-30-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4041; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5W+9G56bSAJObhkQIyc0pn6ptdzjRhDML2J7Q2uFMi0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+3yvXuMw2bRl88KVd08Ztebn71p8j2922rvhJPTK
 t9MnOp6omMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwDc5BjG+pwcT9vLSV17VJki
 fPsEN1YJMnLNWai7fKNY6hau1Zxzr/rseeb8dUXgyocT0qvXTQ0+yVjvP8VR3MPC5N6yVzysm/M
 dD+VEBm1Lf9axbHe3zPvDweyZsktkc442TdthJBjs5LXB7BgA
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

The display-connector bridge is the last bridge in the chain on
platforms using drm_bridge_connector, and is responsible for the
physical connector interface.

Implement the atomic_sro_readout_state hook and wire up the default
drm_atomic_helper_bridge_compare_state() as the compare hook.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/display-connector.c | 69 ++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index eb3412ec30a0..781684da1da4 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -15,5 +15,8 @@
 #include <linux/workqueue.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
@@ -214,4 +217,68 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
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
+
+		if (prev_priv_state) {
+			struct drm_bridge_state *prev_bridge_state =
+				drm_priv_to_bridge_state(prev_priv_state);
+
+			bridge_state->input_bus_cfg.format =
+				prev_bridge_state->output_bus_cfg.format;
+			bridge_state->input_bus_cfg.flags =
+				prev_bridge_state->output_bus_cfg.flags;
+			goto out_input;
+		}
+	}
+
+	/*
+	 * The previous bridge might not have readout support, so we
+	 * can't treat a missing state as an error.
+	 */
+	bridge_state->input_bus_cfg.format = MEDIA_BUS_FMT_FIXED;
+	bridge_state->input_bus_cfg.flags = di->bus_flags;
+
+out_input:
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
@@ -226,4 +293,6 @@ static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+	.atomic_sro_readout_state	= display_connector_readout_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 

-- 
2.55.0

