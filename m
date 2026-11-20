Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F946606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhgdGBS3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1466D1129F2;
	Fri, 20 Nov 2026 12:57:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9335A1129F2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:57:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BDC1441BD;
 Fri, 20 Nov 2026 12:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADE1F000CA;
 Fri, 20 Nov 2026 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179434;
 bh=rRPwfCddy4m/kWDBw2pfG0e/E3PpdAIO1MAvXL9/DsI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dhgdGBS3pbNh1n9Gsp3a8uSZhKxskSos9hwpfdAYumAmgwyaTrBJeTix3wcxIEgHD
 O0RpnDrIrS0qspkfWGq+/oYbNaL3uxLFUUq4SPGUb2YwfL877dj4+Slxe5UrMZFzQp
 iEjahI9AFyoJuoitCPK9UCaHOLKb56xz+p6c7tZrlPzgmsX9+XHleZUpOte+baZACp
 wrZjObo0MlAIyQ1aOd3j8He+A5oXb9biJKmATc2qOloFWf/PDQclfNT/fplmI3buFU
 gMHI7upg+4OeqZ/izfWuwproybzJ65ZO+IDOcO9C6SZVhjTUyyiQ6bpnwMBXcKNdYZ
 uqEdlup7Ldy9A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:25 +0100
Subject: [PATCH v9 33/42] drm/tidss: encoder: Implement hardware state readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-33-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4118; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IemACu0sfXJSvoasyPZjcgKAXLs5KOYHTwE7GpTkueI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzoYPPrHcFIwxn/aheMORgJ0CItP/bj0xq2nLxLufL
 t/p29G3t2MqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMpOISY0NP/JPi6I8V6g1H
 716vvXM0+4wll1eCcNyT/YV3Ivc8Yd2oxMk09WvUoX6mCf2yiyv/xjA2NNYlHpJtzCjOz2k903e
 671vA6mtfKn5ula3zZmxbedp/fbeERJ2s5InNze+TE2tjzz8CAA==
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

The tidss encoder is backed by a bridge that sits first in the bridge
chain, between the CRTC and the next bridge. Its state holds the bus
configuration that the atomic helpers negotiate when checking a commit.

However, drm_atomic_bridge_chain_select_bus_fmts() and
drm_atomic_bridge_propagate_bus_flags() don't run during a state
readout, so each bridge has to reconstruct its own bus configuration.

Implement the atomic_sro_readout_state hook for the tidss bridge,
taking the CRTC state as its source since the CRTCs are read out before
the bridges. The output bus format and the bus flags are taken from the
CRTC state, which tidss_bridge_atomic_check() sets from the format the
next bridge negotiated. The input bus format is MEDIA_BUS_FMT_FIXED
since the bridge doesn't implement atomic_get_input_bus_fmts.

Use drm_atomic_helper_bridge_compare_state() to compare the readout
state with the committed one.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 10dbcc6cdf6a..5034e601ac86 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -3,12 +3,14 @@
  * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
 #include <linux/export.h>
+#include <linux/media-bus-format.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_modeset_helper_vtables.h>
@@ -71,16 +73,56 @@ static int tidss_bridge_atomic_check(struct drm_bridge *bridge,
 	}
 
 	return 0;
 }
 
+static int tidss_readout_state(struct drm_bridge *bridge,
+			       struct drm_atomic_sro_state *state,
+			       struct drm_bridge_state *bridge_state,
+			       struct drm_crtc_state *crtc_state,
+			       struct drm_connector_state *conn_state)
+{
+	struct tidss_crtc_state *tcrtc_state = to_tidss_crtc_state(crtc_state);
+
+	/*
+	 * Reconstruct the bridge bus configuration from the CRTC readout state.
+	 *
+	 * During normal atomic check,
+	 * drm_atomic_bridge_chain_select_bus_fmts() and
+	 * drm_atomic_bridge_propagate_bus_flags() walk the bridge chain to
+	 * negotiate formats and propagate flags. During SRO readout, those
+	 * functions do not run, so each bridge must reconstruct its own
+	 * state.
+	 *
+	 * This bridge is the first in the chain, so the CRTC state (read out
+	 * before bridges) is used as the source. The output bus format is
+	 * taken from the CRTC's bus_format, which during normal atomic check
+	 * is set by tidss_bridge_atomic_check() to the next bridge's
+	 * negotiated input format. The input bus format is
+	 * MEDIA_BUS_FMT_FIXED since this bridge does not implement
+	 * atomic_get_input_bus_fmts. Bus flags are taken from the CRTC
+	 * state, which reads them from hardware registers during its own
+	 * readout.
+	 */
+
+	bridge_state->input_bus_cfg.format = MEDIA_BUS_FMT_FIXED;
+	bridge_state->output_bus_cfg.format = tcrtc_state->bus_format;
+
+	bridge_state->output_bus_cfg.flags = tcrtc_state->bus_flags;
+	bridge_state->input_bus_cfg.flags = tcrtc_state->bus_flags;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.attach				= tidss_bridge_attach,
 	.atomic_check			= tidss_bridge_atomic_check,
 	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
+	.atomic_sro_readout_state	= tidss_readout_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
 static const struct drm_encoder_funcs tidss_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };

-- 
2.56.1

