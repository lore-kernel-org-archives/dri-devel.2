Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE1606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVoDWz3a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87E4112322;
	Fri,  6 Nov 2026 13:17:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C05610FF1B
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:17:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 148E5401CE;
 Fri,  6 Nov 2026 13:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FD51F0089F;
 Fri,  6 Nov 2026 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971024;
 bh=GqUbyL0AozZl+ozFoNV2MVYgqmN4SKFBbniYapI+VZg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LVoDWz3aRbw5aV6gkkJ/Uylw6agHVsR7OahPzIL2VolYLriIL2JH13+QmZh4FnX3w
 8dP9X3JmkwPbI6aLR9WWtU1KCrc8PoRNMhetdhWrg5/QpXA6G64+9KtwCjFlqTV9Wo
 UeFliO2lXCu4XvVdpOI+bIFgik+Ezm40G3v2PnBthisJwj6DDjMl5tSTO1G1zXKSD5
 Y79AlOH5Ta4KOMIhx46wiUoJALfI7OMJE5sKlu/egVzItSf7Az/CoEX+da+SUpw8CZ
 YW+J22PYBe9SZ4V1gKjxpi/HbtEXsuEmDuLSTo2HIB9kgVh2uzWjlEkGGzFMxLvkks
 Pl/S7HbJHqXvA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:52 +0100
Subject: [PATCH v8 39/39] fixup! drm/tidss: Implement readout support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-39-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6771; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7eUwX8IHKJZgj3+zfa9sQdoKkzblka6+mBAl+wLlw40=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+27fvaZN2e5Wr7zRfW5l6ezLmefe/KvzdJlO1aE9
 P112Sac1TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmMrWCsVZim37RAt7Lv51b
 oiXLJdOO3Wms71t90+Hmi9QYj4+7Nt2bG7Xd6snEqDczsiturbmqy8NYK7KZp15oV2VsbcdNnyO
 npEOPRXkyT0tgSLbbUHVeTLVy+SPJ2ad4+5l+2z740yHYcGQ5AA==
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

This has not been tested, but if it works should be squashed.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c |   5 ++
 drivers/gpu/drm/tidss/tidss_dispc.h |   1 +
 drivers/gpu/drm/tidss/tidss_oldi.c  | 138 ++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c3117745965b..023dd6135cd8 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -561,4 +561,9 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 }
 
+u32 tidss_get_oldi_config(struct tidss_device *tidss, u32 hw_videoport)
+{
+	return dispc_vp_read(tidss->dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG);
+}
+
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 159fe3b94b0a..2322abd1c181 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -107,4 +107,5 @@ int tidss_configure_oldi(struct tidss_device *tidss, u32 hw_videoport,
 			 u32 oldi_cfg);
 void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport);
+u32 tidss_get_oldi_config(struct tidss_device *tidss, u32 hw_videoport);
 unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_rate);
 
diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 82b059f85244..7dbfbb380205 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -6,4 +6,5 @@
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/of.h>
@@ -14,6 +15,10 @@
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include "tidss_dispc.h"
@@ -352,4 +357,133 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
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
+	u32 cfg, map;
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
+	 * tidss_oldi_atomic_check() forces positive edge sampling on
+	 * the input side, and the DE polarity is programmed from the
+	 * negotiated flags: OLDI_DEPOL is set when the DE is active
+	 * low.
+	 */
+	bridge_state->input_bus_cfg.flags =
+		DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE |
+		((cfg & OLDI_DEPOL) ? DRM_BUS_FLAG_DE_LOW :
+				      DRM_BUS_FLAG_DE_HIGH);
+
+	bridge_state->output_bus_cfg.flags =
+		(cfg & OLDI_DEPOL) ? DRM_BUS_FLAG_DE_LOW :
+				     DRM_BUS_FLAG_DE_HIGH;
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
@@ -362,4 +496,7 @@ static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.mode_valid = tidss_oldi_mode_valid,
+	.atomic_sro_readout_state = tidss_oldi_bridge_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_sro_connector_readout = tidss_oldi_bridge_connector_readout,
 };
 
@@ -622,4 +759,5 @@ int tidss_oldi_init(struct tidss_device *tidss)
 		oldi->bridge.of_node = child;
 		oldi->bridge.driver_private = oldi;
+		oldi->bridge.ops |= DRM_BRIDGE_OP_CONNECTOR_HW_READOUT;
 
 		tidss->oldis[tidss->num_oldis++] = oldi;

-- 
2.55.0

