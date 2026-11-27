Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF941606A681
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmxQrgM9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC4011293F;
	Fri, 27 Nov 2026 09:55:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4620810E56B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FEFA44E78;
 Fri, 27 Nov 2026 09:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7901F00926;
 Fri, 27 Nov 2026 09:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773323;
 bh=+VvMVWKeyNhX3O9dTL2BiQJfZBJmRoptclpeDRb4IKM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nmxQrgM9swOlAjX0M+EY8+Eq/uIzpSg6+JDABQdZ6QHUzod+HgHzqpy+ngcVbYm3M
 Fze4s/XC908xo5oi3BpcpUGSg9TuHgWfvPt2ldW3/5UM3PZfeHQtyZlE/V/PKdWZ8I
 4PgpvU6FxoCdwZpKGGqZPA+vpGlvz3UJIM2rI/A98ZUU+hx51LjgdEU9sx7SU5jI0p
 mtoRI8uBqJIsNqADHdgdto9vuDR8l3zd9R85IptdIopfknMQGaSWlyg8Bc+tVLNxTu
 GWJL3fDGKu+8ojjKS0HvXQBgWmT+JHVPfFQ2ck018ONulILLlHEFmZiLJ+U0BvBhtq
 EQA8F9AYlAx3w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:18 +0100
Subject: [PATCH HACK v10 36/36] drm/panel: Prepare and enable panels read
 out as active
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-36-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; i=mripard@kernel.org;
 h=from:subject:message-id; bh=RoFRDL29OGy99Nzl88A/RNBWdNQJ9Gsy1fc2FhGEMZM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwTxLGtiW37waYmvHsvOXJN+b1s7jW0I010zuKJpcc
 Ojr+vIrHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiC18xNnxffF5DcdqWu/9U
 qmYUXr7ZqT5PNzCGf36rlpZW893Y9uZpAtKRj9QiLW52bzs1V5tXnbFhgfbiM684viw467t/a8L
 Ug6nzTxRsrew52n/o24yeX5eeX/lryrBK89YWpjK1mx9PdjhdAAA=
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

The panel bridge assumes the panel is enabled whenever its pipeline
was read out as active, since a panel has no state that can be read
out of the hardware.

However, the drm_panel itself still considers the panel powered down.
The next commit won't prepare and enable it if it doesn't need a
modeset, so the panel driver never acquires its supplies, GPIOs or
backlight, and the next disable of the pipeline skips the panel
teardown with a warning since the panel was never prepared.

Implement the bridge atomic_sro_install_state hook to call
drm_panel_prepare() and drm_panel_enable() for those panels, so that
the drm_panel state matches the hardware state.

This is a hack: drm_panel_prepare() and drm_panel_enable() don't take
over a running panel, they run the full power up sequence of the panel
driver on a panel the firmware has already lit. Depending on the
driver, that can mean toggling the reset GPIO, waiting for the
power-up delays, or sending the whole DSI initialization sequence
again, which might blank or glitch the display, and thus defeats the
purpose of the state readout. It also notifies the panel followers as
if the panel had just been powered up.

Doing this properly requires a drm_panel operation to take over a panel
that is already running, acquiring its resources without reprogramming
it, which doesn't exist yet.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_panel.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index ba5b0b0a8fad..ad521b6894ca 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -343,10 +343,32 @@ panel_bridge_connector_readout(struct drm_bridge *bridge,
 	conn_state->best_encoder = encoder;
 
 	return 0;
 }
 
+/*
+ * The pipeline was read out as active, so the firmware left the panel
+ * powered up and enabled. Prepare and enable it so that the panel
+ * driver acquires its resources and its state matches the hardware,
+ * since the next commit won't do it if it doesn't need a modeset, and
+ * the next disable of the pipeline will release them.
+ */
+static void
+panel_bridge_install_state(struct drm_bridge *bridge,
+			   struct drm_bridge_state *bridge_state,
+			   struct drm_crtc_state *crtc_state,
+			   struct drm_connector_state *conn_state)
+{
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+
+	if (!panel->prepared)
+		drm_panel_prepare(panel);
+
+	if (!panel->enabled)
+		drm_panel_enable(panel);
+}
+
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
 	.atomic_pre_enable = panel_bridge_atomic_pre_enable,
 	.atomic_enable = panel_bridge_atomic_enable,
@@ -358,10 +380,11 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.debugfs_init = panel_bridge_debugfs_init,
 	.atomic_sro_readout_state = panel_bridge_readout_state,
 	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_sro_install_state = panel_bridge_install_state,
 	.atomic_sro_connector_readout = panel_bridge_connector_readout,
 };
 
 /**
  * drm_bridge_is_panel - Checks if a drm_bridge is a panel_bridge.

-- 
2.56.1

