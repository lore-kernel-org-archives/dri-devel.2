Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A650606A33F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKBol3TP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA90E112935;
	Fri, 27 Nov 2026 09:55:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFB3112931
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1EDCF41502;
 Fri, 27 Nov 2026 09:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4971F00897;
 Fri, 27 Nov 2026 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773319;
 bh=H+q2FnyhjtBhlefTRTUJUjBUfAbxkIkbsgm7LBrETW8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kKBol3TPfB/dF7bPgOB3IU3fiFul51xTBNdZDWmQ83NfhFsx1q7rpIRlEpgaPvx7U
 6VkdRGNfJ5wg5wxiKbHe97zdXMRO/SEHUykENg7hC3DldKe5hAdc3cdxrMGUPv4NM3
 w0C83ryYZMAFV0yLcwUwnjFBwGo6EUP82mdUFsrpm2gId2drz2E8V9R5Tpzi8udAGA
 B8faUwUimT5ZAvL8CVGfgKwHaLTW2fluor0LaO1q42o1crBAc3vg8ppwKuToKiIE7C
 UWT1+RjIbqH3fEKKZRwvofvb04ACKWirRccYtT+faqrZxFHv3n1zfkQnefXc9IixV7
 bcTlUMorlu/ww==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:17 +0100
Subject: [PATCH DO NOT MERGE v10 35/36] drm/tidss: oldi: Implement hardware
 state readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-35-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8753; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sGYoRbNcPMnwwDvBAXI1gZ8lEdOsoZynUdNp3i7rz3E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwdz3xR+KZvPLi51LdNzP/iY4vZLp1e3vFkULNBsFG
 DaKvE/umMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABM5/Zmx4cbqTm/p2DsX+StW
 RnJdtrvzuDq3VdO/+PWhzJxLluvOZ2Q83v2xrYjfRyLQm89yv8gZxoYv5/cuO9ldVrBkrt+HIzN
 ML9c4cHzv55fNZX6zlXnVhommtfnOhsfe8F2srTiQcq7pYhoA
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

On the AM65x and the AM625, an OLDI transmitter sits between a video
port and the panel or the bridge it drives. Without a readout of the
transmitter, the bridge chain of a pipeline the firmware left running
has no state for it, and the first commit can't be matched against what
is programmed.

Implement the state readout hooks of the OLDI bridge. The
atomic_sro_readout_state hook reads the transmitter configuration
register through tidss_get_oldi_config(), and does nothing if the
transmitter is disabled. Otherwise, it looks up the bus format the LVDS
mapping and the width flag correspond to, since the most significant
bit of the mapping field carries the dual-link flag rather than the
mapping, and reconstructs the bus configuration the atomic helpers
negotiate: the transmitter takes the parallel RGB output of the video
port and serializes it. The DE polarity is the only flag the
transmitter stores, the sampling edges being hardcoded. The readout
fails when the mapping isn't recognized, so that the core falls back to
the regular initialization.

The atomic_sro_connector_readout hook binds the connector to the CRTC
the encoder is currently connected to, and takes the connector reference
that drm_atomic_set_crtc_for_connector() would have taken. Set
DRM_BRIDGE_OP_CONNECTOR_HW_READOUT so that drm_bridge_connector uses
it.

Use drm_atomic_helper_bridge_compare_state() to compare the readout
state with the committed one.

This hasn't been tested yet.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 157 +++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index f767b0c115ac..0ad4ef34ba64 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -3,20 +3,25 @@
  * Copyright (C) 2025 - Texas Instruments Incorporated
  *
  * Aradhya Bhatia <a-bhatia1@ti.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/mfd/syscon.h>
 #include <linux/media-bus-format.h>
 #include <linux/regmap.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include "tidss_dispc.h"
 #include "tidss_dispc_regs.h"
 #include "tidss_oldi.h"
 
@@ -348,20 +353,171 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
 		return MODE_CLOCK_RANGE;
 
 	return MODE_OK;
 }
 
+static u32 tidss_oldi_read_config(struct tidss_oldi *oldi)
+{
+	u32 cfg;
+
+	tidss_runtime_get(oldi->tidss);
+	cfg = tidss_get_oldi_config(oldi->tidss, oldi->parent_vp);
+	tidss_runtime_put(oldi->tidss);
+
+	return cfg;
+}
+
+static int
+tidss_oldi_bridge_readout_state(struct drm_bridge *bridge,
+				struct drm_atomic_sro_state *state,
+				struct drm_bridge_state *bridge_state,
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *conn_state)
+{
+	struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
+	const struct oldi_bus_format *bus_fmt = NULL;
+	unsigned int i;
+	u32 cfg, map, flags;
+
+	cfg = tidss_oldi_read_config(oldi);
+
+	/* The transmitter is off, there is nothing to read out. */
+	if (!(cfg & OLDI_ENABLE))
+		return 0;
+
+	/*
+	 * The most significant bit of the data mapping field carries
+	 * the dual-link flag rather than the LVDS mapping: mask it out
+	 * before looking for the bus format the mapping corresponds
+	 * to.
+	 */
+	map = cfg & (OLDI_MAP & ~BIT(3));
+
+	for (i = 0; i < ARRAY_SIZE(oldi_bus_formats); i++) {
+		if (oldi_bus_formats[i].oldi_mode_reg_val << 1 != map)
+			continue;
+
+		if ((cfg & OLDI_MSB) ?
+		    oldi_bus_formats[i].data_width != 24 :
+		    oldi_bus_formats[i].data_width != 18)
+			continue;
+
+		bus_fmt = &oldi_bus_formats[i];
+		break;
+	}
+
+	if (!bus_fmt) {
+		dev_err(oldi->dev,
+			"OLDI%u: unrecognised mapping in the config register\n",
+			oldi->oldi_instance);
+		return -EINVAL;
+	}
+
+	/*
+	 * Reconstruct the bus configuration the atomic helpers
+	 * negotiate: the OLDI transmitter takes the parallel RGB
+	 * output of the video port and serialises it with the LVDS
+	 * mapping found in the config register.
+	 */
+	bridge_state->input_bus_cfg.format = bus_fmt->input_bus_fmt;
+	bridge_state->output_bus_cfg.format = bus_fmt->bus_fmt;
+
+	/*
+	 * The transmitter only stores the DE polarity: OLDI_DEPOL is
+	 * set when the DE is active low, and the sampling edges are
+	 * hardcoded, the transmitter cannot configure them. TODO:
+	 * read them back from the hardware registers if a variant
+	 * makes them configurable.
+	 *
+	 * Everything else in the bus flags can't be read back, but the
+	 * atomic check leaves it untouched: the output flags are those
+	 * the next element of the chain expects, which are the display
+	 * info flags when the elements after the transmitter forward
+	 * them unmodified, and tidss_oldi_atomic_check() only replaces
+	 * the sampling edges of the input flags. Start from the display
+	 * info flags and only reconcile the DE polarity with what the
+	 * hardware reports, so that a DE polarity left unspecified is
+	 * not reported as an explicit one.
+	 */
+	flags = conn_state->connector->display_info.bus_flags;
+
+	if (cfg & OLDI_DEPOL) {
+		flags &= ~DRM_BUS_FLAG_DE_HIGH;
+		flags |= DRM_BUS_FLAG_DE_LOW;
+	} else if (flags & DRM_BUS_FLAG_DE_LOW) {
+		flags &= ~DRM_BUS_FLAG_DE_LOW;
+		flags |= DRM_BUS_FLAG_DE_HIGH;
+	}
+
+	bridge_state->output_bus_cfg.flags = flags;
+
+	flags &= ~(DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+		   DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE);
+	flags |= DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		 DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE;
+	bridge_state->input_bus_cfg.flags = flags;
+
+	return 0;
+}
+
+static int
+tidss_oldi_bridge_connector_readout(struct drm_bridge *bridge,
+				    struct drm_atomic_sro_state *state,
+				    struct drm_connector_state *conn_state)
+{
+	struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	struct drm_crtc *crtc;
+
+	/* The transmitter is off, there is nothing to read out. */
+	if (!(tidss_oldi_read_config(oldi) & OLDI_ENABLE))
+		return 0;
+
+	encoder = bridge->encoder;
+	if (!encoder->funcs || !encoder->funcs->atomic_sro_get_current_crtc)
+		return -ENODEV;
+
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
 static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.attach = tidss_oldi_bridge_attach,
 	.atomic_check = tidss_oldi_atomic_check,
 	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
 	.atomic_post_disable = tidss_oldi_atomic_post_disable,
 	.atomic_get_input_bus_fmts = tidss_oldi_atomic_get_input_bus_fmts,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.mode_valid = tidss_oldi_mode_valid,
+	.atomic_sro_readout_state = tidss_oldi_bridge_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_sro_connector_readout = tidss_oldi_bridge_connector_readout,
 };
 
 static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)
 {
 	struct device_node *companion;
@@ -610,10 +766,11 @@ static int tidss_oldi_init_one(struct tidss_device *tidss,
 	}
 
 	/* Register the bridge. */
 	oldi->bridge.of_node = oldi_tx;
 	oldi->bridge.driver_private = oldi;
+	oldi->bridge.ops |= DRM_BRIDGE_OP_CONNECTOR_HW_READOUT;
 
 	tidss->oldis[tidss->num_oldis++] = oldi;
 	tidss->is_ext_vp_clk[oldi->parent_vp] = true;
 	oldi->tidss = tidss;
 

-- 
2.56.1

