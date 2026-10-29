Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EE606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqAHR3k/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944E310FFF4;
	Thu, 29 Oct 2026 07:37:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754E410FFED
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:36:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E96343D85;
 Thu, 29 Oct 2026 07:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C9A1F01828;
 Thu, 29 Oct 2026 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259388;
 bh=Yl3pr6Eobyegjz9P+f70i7o4gYXfZxqNCWeUAGaBEPU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bqAHR3k/NwMabH8uCEzb+OsyVCIN3oBCWaPG8YZGIU79LHLw1aBUqNfqOt5x71QpX
 L+QyzZCU+w2UgjrndgJtEVVN7NYQ1fKGFPNA/P+sMbKQGsMgFXcezGPj/UNBB1+IVz
 xPLTzwJLcw9oU+U+xrj7nz/Vi+kZ8YrgoWAHoCJ/oZFD4zyH/4jEqKy8DnpWDVhdnj
 dDNaKYl3BNMLrpgSRVey23lz6Frg5N+5YhjQMow3ccaY9MP+8E0m+soxQUDuVUVk3B
 ph4J7Cp/Ai+ycMPXR2YwgNzCgY2SYQ4cHMG9jq+UFHdS/TsQBHR/XODtUjX843OGIG
 8ElRvAnfRhSbw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:24 +0100
Subject: [PATCH v7 34/34] drm/bridge: sii902x: Implement hw state readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-34-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4407; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Je5P3Iu09DifxHWFM6fDYMDunp6l3UJAs11RSud++5s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvv3O61815U68b6XciXzexNVuwcV7Y2wsF52JD9urw
 3F3+aRLHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAimrMYG9qvhfKWFtlqMs6f
 oaE7/2/g9seWiuGytYlT5SZ0b9OoO51SV8hx9/jDnvmbUlkMoo8cZWy49EJutfCZF6rLxDgtzad
 KnV0wmfnzvJlTzBWvTvvIH3nRtv/HmXXSE3i0Vn0ouD5zue4qAA==
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

Implement the hardware state readout for the sii902x bridge
now that all the infrastructure is in place.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 91 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index e067c0636e7f..ab5ffcf6882f 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -23,4 +23,6 @@
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_drv.h>
@@ -538,4 +540,87 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
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
+	int ret;
+
+	ret = regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SYS_CTRL_PWR_DWN);
+	/* I2C error */
+	if (ret < 0)
+		return ret;
+	/* Device is powered down, nothing to read out */
+	if (ret)
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
@@ -548,4 +633,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_sro_readout_state = sii902x_bridge_readout_state,
+	.atomic_sro_connector_readout = sii902x_bridge_connector_readout,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
 	.atomic_check = sii902x_bridge_atomic_check,
@@ -1134,5 +1222,6 @@ static int sii902x_init(struct sii902x *sii902x)
 	sii902x->bridge.of_node = dev->of_node;
 	sii902x->bridge.timings = &default_sii902x_timings;
-	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
+			      DRM_BRIDGE_OP_CONNECTOR_HW_READOUT;
 	sii902x->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 

-- 
2.55.0

