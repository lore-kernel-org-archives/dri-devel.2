Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD7606A33D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOG6rkEZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC2B11293E;
	Fri, 27 Nov 2026 09:55:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1193C11292C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEA0141AA5;
 Fri, 27 Nov 2026 09:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5C01F000C1;
 Fri, 27 Nov 2026 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773312;
 bh=pOMilnlDUuJkyqzgQLaC3h7/aQWZBlF0EIpoEkR1jJY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hOG6rkEZde4R5zGgFjfYPrIRLZN9FsgYc1VKRmYXa1Cko5nyNhUO6qMBM4npvWunc
 qRCij0lcvT0elb8m7ClzV9bB3W15KN+SLV9f2XxYGRVsSD1puXfWsqRTB7ygzkIvRD
 A+cSgxtn8+4b+psrPUkpMK27QkRqUeXTxl5qDjCg8/qZyK9/NVzahCkIdvxG71zbzC
 rvPdxBy7FQZIVzqtuxgyujCHB9hABiBktcVFIwi+PDmrID01NNI2Vb2SFjYPbWNCMG
 Bo3OcHGR1bFNd3vEhbJ0amXqsPxi9hiSoHS6kXsFe/PaJ4nZfO+kSXX0mHYKI/CBgV
 GqRPXStsdrosQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:15 +0100
Subject: [PATCH v10 33/36] drm/panel: Implement state readout support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-33-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8118; i=mripard@kernel.org;
 h=from:subject:message-id; bh=cPuqQtj7YFbFmLY2l1F94sQiU4eHSWp3HLxB9/MZrGY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwVzCVzNUZB/Z1XBZljLXNrBwuzTNW7d0WeV2XyfDV
 fZe9kYdU1kYhDkZZMUUWZ7IhJ1e3r64ysF+5Q+YOaxMIEMYuDgFYCK3FjDWZya9WmT87qhLuNTR
 2m4eDoV8/Z1bRB5Lv1UWivz6+q/9CdkYfa+yFTo1/Zcli/k/cGox1nAyb96wcrfEZyue7TE/lzx
 a+cFenTVgUzWr8O6vZcW/uwJYTtlkbq7KvrZB/lhKv6WYGgA=
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

A panel bridge has no state of its own to read out of the hardware:
neither the panel enable state nor the bus configuration is observable
through it.

The bus configuration the atomic helpers negotiate can however be
reconstructed: the panel bridge is always the last bridge of a chain, so
the negotiation picks the first connector display info format as its
output format, or MEDIA_BUS_FMT_FIXED when the display info has none,
passes it through to its input end, and propagates the display info
flags to both ends. The atomic_sro_readout_state hook reports that
configuration. The display info is only populated once the connector
modes have been read, after the initial state has been created: the
fixed format reported then matches what the negotiation would produce,
and is harmless as the initial state is never compared.

The atomic_sro_connector_readout hook reports the connector as bound to
the current CRTC of its encoder whenever that CRTC was read out as
active, the panel being assumed enabled whenever its pipeline is. A
panel bridge only carries DRM_BRIDGE_OP_CONNECTOR_HW_READOUT when no
bridge attached earlier in its chain provides a connector readout:
drm_bridge_connector_init() picks the last bridge carrying that op, and
earlier bridges may know the actual link state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_panel.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 26d9378563f5..ba5b0b0a8fad 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -7,14 +7,17 @@
 
 #include <linux/backlight.h>
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/of.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_managed.h>
@@ -74,12 +77,35 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 			       struct drm_encoder *encoder,
 			       enum drm_bridge_attach_flags flags)
 {
 	struct drm_panel *panel = drm_bridge_to_panel(bridge);
 	struct drm_connector *connector = &panel->connector;
+	bool upstream_readout = false;
 	int ret;
 
+	/*
+	 * drm_bridge_connector_init() picks the connector readout
+	 * provider from the last bridge of the chain carrying
+	 * DRM_BRIDGE_OP_CONNECTOR_HW_READOUT. Only provide the
+	 * fallback readout of a panel bridge when no bridge earlier
+	 * in the chain provides one, as those know the actual link
+	 * state while a panel bridge can only assume the panel is
+	 * enabled.
+	 */
+	drm_for_each_bridge_in_chain(encoder, iter) {
+		if (iter == bridge)
+			break;
+
+		if (iter->ops & DRM_BRIDGE_OP_CONNECTOR_HW_READOUT) {
+			upstream_readout = true;
+			break;
+		}
+	}
+
+	if (!upstream_readout)
+		bridge->ops |= DRM_BRIDGE_OP_CONNECTOR_HW_READOUT;
+
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
 	drm_connector_helper_add(connector,
 				 &panel_bridge_connector_helper_funcs);
@@ -217,10 +243,110 @@ static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
 	root = debugfs_create_dir("panel", root);
 	if (panel->funcs->debugfs_init)
 		panel->funcs->debugfs_init(panel, root);
 }
 
+/*
+ * A panel bridge has no state of its own to read out of the hardware:
+ * reconstruct the bus configuration the atomic helpers negotiate
+ * instead.
+ *
+ * The panel bridge is always the last bridge of a chain, and the
+ * negotiation picks the first connector display info format as its
+ * output format (or MEDIA_BUS_FMT_FIXED when the display info has
+ * none), which drm_atomic_helper_bridge_propagate_bus_fmt() passes
+ * through to its input. drm_atomic_bridge_propagate_bus_flags()
+ * similarly propagates the display info flags to both its output and
+ * input. This is also what happens when the display info has no
+ * formats yet, like during the initial state creation at probe time
+ * before any mode has been read: the bus configuration then reports
+ * a fixed format, which is harmless as the initial state is never
+ * compared, and every commit negotiates the bus configuration anew.
+ *
+ * The format the negotiation selects can only differ from the first
+ * display info format when the connector reports several formats and
+ * the rest of the bridge chain rejects it, which panel connectors
+ * don't do.
+ */
+static int
+panel_bridge_readout_state(struct drm_bridge *bridge,
+			   struct drm_atomic_sro_state *state,
+			   struct drm_bridge_state *bridge_state,
+			   struct drm_crtc_state *crtc_state,
+			   struct drm_connector_state *conn_state)
+{
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_display_info *info = &connector->display_info;
+	u32 format;
+
+	if (info->num_bus_formats)
+		format = info->bus_formats[0];
+	else
+		format = MEDIA_BUS_FMT_FIXED;
+
+	bridge_state->input_bus_cfg.format = format;
+	bridge_state->output_bus_cfg.format = format;
+
+	bridge_state->input_bus_cfg.flags = info->bus_flags;
+	bridge_state->output_bus_cfg.flags = info->bus_flags;
+
+	return 0;
+}
+
+/*
+ * A panel bridge has no way to read the panel state out of the
+ * hardware: assume the panel is enabled whenever its pipeline is.
+ */
+static int
+panel_bridge_connector_readout(struct drm_bridge *bridge,
+			       struct drm_atomic_sro_state *state,
+			       struct drm_connector_state *conn_state)
+{
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	struct drm_crtc *crtc;
+
+	encoder = bridge->encoder;
+	if (!encoder->funcs || !encoder->funcs->atomic_sro_get_current_crtc)
+		return -ENODEV;
+
+	/* The encoder is disabled, there is nothing to read out. */
+	crtc = encoder->funcs->atomic_sro_get_current_crtc(encoder);
+	if (!crtc)
+		return 0;
+
+	/*
+	 * A readout limited to the objects of a commit doesn't have a
+	 * state for a CRTC that isn't part of it, and a CRTC can't be
+	 * left out of a commit enabling it.
+	 */
+	crtc_state = drm_atomic_sro_get_crtc_state(state, crtc);
+	if (!crtc_state)
+		return 0;
+
+	/* The pipeline is off, there is nothing to read out. */
+	if (!crtc_state->active)
+		return 0;
+
+	crtc_state->encoder_mask |= drm_encoder_mask(encoder);
+	crtc_state->connector_mask |= drm_connector_mask(connector);
+
+	/*
+	 * drm_atomic_set_crtc_for_connector() takes a connector
+	 * reference when setting the crtc pointer, which is later
+	 * released by __drm_atomic_helper_connector_destroy_state().
+	 * The readout bypasses that path, so take the reference
+	 * explicitly.
+	 */
+	drm_connector_get(connector);
+	conn_state->crtc = crtc;
+	conn_state->best_encoder = encoder;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
 	.atomic_pre_enable = panel_bridge_atomic_pre_enable,
 	.atomic_enable = panel_bridge_atomic_enable,
@@ -230,10 +356,13 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.debugfs_init = panel_bridge_debugfs_init,
+	.atomic_sro_readout_state = panel_bridge_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_sro_connector_readout = panel_bridge_connector_readout,
 };
 
 /**
  * drm_bridge_is_panel - Checks if a drm_bridge is a panel_bridge.
  *

-- 
2.56.1

