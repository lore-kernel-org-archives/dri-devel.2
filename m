Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80997C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D552910E82C;
	Mon,  7 Sep 2026 13:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jh94UfT5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C47F10E829
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:26:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5A3E60D87;
 Mon,  7 Sep 2026 13:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F701F00A3A;
 Mon,  7 Sep 2026 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787566;
 bh=ZWhSdChl57MWVRW/FLvjZQVvZM4mzl1OzVEFry/sjWk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jh94UfT54LVsw8+K7AogBVQg5wTsMfu73gQ1ejXOFYZ3yIiWic0I7sqJ5jKhMQa/K
 fti1Ag8AmuWKeQ9C/oNshMEINSKm9tEb7ti1fhkoQNxsd9KaQ/r02LLyDFHA0CCfEs
 47VnqCssFMPyMy4fVPzjLGQ3afzzQ/QrzQPuEK0EPK/Q1Uh42kDiz/WoABHpkVNQQK
 m1CricBgSDz4XzpK/FkZlKnK8c0qLJtxjJoq2+u3Tt3R0yMJ8Q+fPFsZjoWmfYz3pl
 y//QhciFwO/czSGIC+9U/00yj78z+IUDrVC/tHvQhtIZQJxP2f5s5NIZERzv1S7P7l
 QwNR8izM8d7BA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:24:09 +0200
Subject: [PATCH v5 33/33] drm/bridge: sii902x: Implement hw state readout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-33-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4709; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T51BAw/vW3kN3027yOk/9nu7VykzkQfHR5mrmSmr4UE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdr3R3qm7u31RzR7+YtO4t24Nc5XzalgeSvkpczitS
 bpty/G2YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEbhNjrVjyuq2dnZU2EkcP
 +6VM/H12kb1sZtazfnXZwEU7tgQ86m8MVCz9tmpW/BKT2QGes/68YKwP8vzRwicnV7FTa0vkzon
 rFCcu9FR7rXvrhc6kRa1PE0psbq+zUUue7JUUJlDt/vvBvm4A
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

Implement the hardware state readout for the sii902x bridge
now that all the infrastructure is in place.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 82 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 9aac44ed5b67..332945f3c9f7 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -20,10 +20,12 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro.h>
+#include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -535,20 +537,97 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
 
+static int
+sii902x_bridge_connector_readout(struct drm_bridge *bridge,
+				 struct drm_atomic_sro_state *state,
+				 struct drm_connector_state *conn_state)
+{
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	struct drm_crtc *crtc;
+
+	if (regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SYS_CTRL_PWR_DWN))
+		return 0;
+
+	encoder = bridge->encoder;
+	crtc = encoder->funcs->atomic_sro_get_current_crtc(encoder);
+	if (!crtc)
+		return -ENODEV;
+
+	crtc_state = drm_atomic_sro_get_crtc_state(state, crtc);
+	if (!crtc_state)
+		return -ENODEV;
+
+	crtc_state->encoder_mask |= drm_encoder_mask(encoder);
+	crtc_state->connector_mask |= drm_connector_mask(connector);
+
+	/*
+	 * drm_atomic_set_crtc_for_connector() takes a connector reference
+	 * when setting the crtc pointer, which is later released by
+	 * __drm_atomic_helper_connector_destroy_state(). SRO readout
+	 * bypasses that path, so take the reference explicitly.
+	 */
+	drm_connector_get(connector);
+	conn_state->crtc = crtc;
+	conn_state->best_encoder = encoder;
+
+	return 0;
+}
+
+static int sii902x_bridge_readout_state(struct drm_bridge *bridge,
+					struct drm_atomic_sro_state *state,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
+	u32 input_format;
+
+	if (regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SYS_CTRL_PWR_DWN))
+		return 0;
+
+	switch (sii902x->bus_width) {
+	case 16:
+		input_format = MEDIA_BUS_FMT_RGB565_1X16;
+		break;
+	case 18:
+		input_format = MEDIA_BUS_FMT_RGB666_1X18;
+		break;
+	case 24:
+		input_format = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	bridge_state->input_bus_cfg.format = input_format;
+	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	/* The sii902x is a passthrough transmitter, output format equals input. */
+	bridge_state->output_bus_cfg.format = input_format;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.attach = sii902x_bridge_attach,
 	.mode_set = sii902x_bridge_mode_set,
 	.atomic_disable = sii902x_bridge_atomic_disable,
 	.atomic_enable = sii902x_bridge_atomic_enable,
 	.detect = sii902x_bridge_detect,
 	.edid_read = sii902x_bridge_edid_read,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_sro_readout_state = sii902x_bridge_readout_state,
+	.atomic_sro_connector_readout = sii902x_bridge_connector_readout,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
 	.atomic_check = sii902x_bridge_atomic_check,
 	.mode_valid = sii902x_bridge_mode_valid,
 };
 
@@ -1131,11 +1210,12 @@ static int sii902x_init(struct sii902x *sii902x)
 	if (ret)
 		goto err_unreg_audio;
 
 	sii902x->bridge.of_node = dev->of_node;
 	sii902x->bridge.timings = &default_sii902x_timings;
-	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
+			      DRM_BRIDGE_OP_CONNECTOR_HW_READOUT;
 	sii902x->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 
 	if (sii902x->i2c->irq > 0)
 		sii902x->bridge.ops |= DRM_BRIDGE_OP_HPD;
 

-- 
2.55.0

