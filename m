Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E7606A687
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CR06v55c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBBA112939;
	Fri, 27 Nov 2026 09:55:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB0610E56B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97CEA43B6A;
 Fri, 27 Nov 2026 09:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F201F0089C;
 Fri, 27 Nov 2026 09:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773295;
 bh=rRPwfCddy4m/kWDBw2pfG0e/E3PpdAIO1MAvXL9/DsI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CR06v55ctQBAdNKeMCRL5vECWMAhVQmpttwkRQilYMkaiwzXOl5aA8cjczSjDDYOe
 7dQTnMshtXxnOziUMJ00PIQKQ3/Gm2cYbeToXYVbRHaw4Gfnj60rPaB9OER/1kFU71
 WXSG2lcKaIofptbk5EDcs2w7Y4yCwqrW/Rh8q3Rg+L3E1a/99C00gb2TBgpvFn4Lk3
 7d9QuZrSFlA1idrU7pAEJQWi7MYpAnJSW7qM+Tu9mr9lYtW1BpjyOlvAzZJLyT6gnF
 t5+muYAAV7UQ3zdIUB94aiISKIBgpdx34g5CywEJLcNc5hNoIJF0IxaQQTMIbdqDv3
 s/wp7QZV1ei0w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:10 +0100
Subject: [PATCH v10 28/36] drm/tidss: encoder: Implement hardware state readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-28-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4118; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IemACu0sfXJSvoasyPZjcgKAXLs5KOYHTwE7GpTkueI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwRytBcYHfHY7bMn7xhUi8ZFzXa737r91D86dWTbZY
 eM7NrYZHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi2kGMDS+2Ny6espPjpso8
 w5hjyYw31ban3WW5oxZyk2WqZe284vvz8lvnHFI0e93//kbWcwk9D8Ya3mtWcqn710p4i/IIHcv
 /Fcl7zZQ9LSdGZ+scY7H8c1npM16c1Kq4zKcbuGqjiKZD9WwA
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

