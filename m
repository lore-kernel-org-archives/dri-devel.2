Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97C606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNjodFXE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC5C10FBF7;
	Fri,  6 Nov 2026 13:16:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E47210FBF7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5130341FA1;
 Fri,  6 Nov 2026 13:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9891F0089F;
 Fri,  6 Nov 2026 13:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971009;
 bh=9spQzJTBSY2E5vAo0ySGDvnJZ4t9oSKQTMnM59V3Zac=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eNjodFXErp0TVOlRbevOShFObymHk74ivhWfx0vop91LGTLHWfVbizIuEr4nGUFfT
 KTbRKojqI4ZfJRTuQlYdXpwRd4/jP2dLzsprPGBJc5M7Xxsklw5OG4sB1oCFcI557k
 2iAbpYSvAB5uMxtSViZ265dwIj3XCPsvwjKh2fj2MZpkxWtC9Qhmg0Gh3VVOWVmWz/
 ZJKomqT/eF4omEd5RftlOFF20nYJ1DquBvbwACQPMm0J1DkqX1UbvPJ5wnOKFDX9R5
 9vHXHLN07+uR9kBpAFFZxds8Yw0vVZdZsJMgPmdo66iBqiQ3/JlfsGRfxDRyjFZJ7/
 k50fT046Cubkg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:48 +0100
Subject: [PATCH v8 35/39] drm/tidss: Implement readout support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-35-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=33042; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4yrhFvY0ht3fpYNbnaDhHc43xv6tNDmxRxmSISeIQoI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+1xLFFI2j5HotS5reDMZhN/DakXb7wWL1skPyl43
 UXNlfF7O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBENGUYG/Zov13wxj5Yq7bu
 SuK2iIU8ZtuuLvwwa83MHd3x0y59LNVdqXG4uftj0D6uk6e4NvrxWjI2XGJY/jxr6bavtpO7Pja
 +1gn8cSDc+/mTriInxSvLNK2OTBCZfz7uYAXPg4BeP6ugMNnJAA==
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

With the hardware readout infrastructure now in place in the KMS
framework, we can provide it for the tidss driver.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c    | 109 +++++++++
 drivers/gpu/drm/tidss/tidss_dispc.c   | 427 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h   |  20 ++
 drivers/gpu/drm/tidss/tidss_encoder.c |  42 ++++
 drivers/gpu/drm/tidss/tidss_kms.c     |   6 +-
 drivers/gpu/drm/tidss/tidss_plane.c   | 205 ++++++++++++++++
 6 files changed, 803 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index d2664bda53a9..38d7a5dfe4f3 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -5,6 +5,10 @@
  */
 
+#include <linux/clk.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_gem_dma_helper.h>
@@ -373,4 +377,106 @@ static struct drm_crtc_state *tidss_crtc_create_state(struct drm_crtc *crtc)
 }
 
+static int tidss_crtc_readout_state(struct drm_crtc *crtc,
+				    struct drm_atomic_sro_state *state,
+				    struct drm_crtc_state *crtc_state)
+{
+	struct drm_device *ddev = crtc->dev;
+	struct tidss_device *tidss = to_tidss(ddev);
+	struct dispc_device *dispc = tidss->dispc;
+	struct tidss_crtc_state *tstate = to_tidss_crtc_state(crtc_state);
+	struct tidss_crtc *tcrtc =
+		to_tidss_crtc(crtc);
+	struct drm_display_mode mode = {};
+	int ret;
+
+	tidss_runtime_get(tidss);
+
+	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
+		goto out;
+
+	tstate->base.active = 1;
+	tstate->base.enable = 1;
+
+	ret = dispc_vp_readout_mode(dispc, tcrtc->hw_videoport, &mode);
+	if (ret)
+		goto err_runtime_put;
+
+	ret = drm_atomic_set_mode_for_crtc(&tstate->base, &mode);
+	if (WARN_ON(ret))
+		goto err_runtime_put;
+
+	drm_mode_copy(&tstate->base.adjusted_mode, &mode);
+
+	tstate->bus_flags = dispc_vp_get_bus_flags(dispc, tcrtc->hw_videoport);
+	ret = dispc_vp_get_bus_format(dispc, tcrtc->hw_videoport,
+				      &tstate->bus_format);
+	if (ret)
+		goto err_runtime_put;
+
+	/*
+	 * The active connectors and planes will be filled by their
+	 * respective readout callbacks.
+	 */
+
+out:
+	tidss_runtime_put(tidss);
+	return 0;
+
+err_runtime_put:
+	tidss_runtime_put(tidss);
+	return ret;
+}
+
+static void tidss_crtc_install_state(struct drm_crtc *crtc,
+				     struct drm_crtc_state *crtc_state)
+{
+	struct tidss_crtc *tcrtc = to_tidss_crtc(crtc);
+	struct drm_device *ddev = crtc->dev;
+	struct tidss_device *tidss = to_tidss(ddev);
+	int ret;
+
+	/*
+	 * The video port wasn't enabled in hardware: nothing to take
+	 * over for it, and enabling the clock and the vblank reporting
+	 * would leak their reference for a CRTC that no disable will
+	 * ever release.
+	 */
+	if (!crtc_state->active)
+		return;
+
+	tidss_runtime_get(tidss);
+
+	ret = dispc_vp_enable_clk(tidss->dispc, tcrtc->hw_videoport);
+	if (ret != 0) {
+		tidss_runtime_put(tidss);
+		return;
+	}
+
+	/* Turn vertical blanking interrupt reporting on. */
+	drm_crtc_vblank_on(crtc);
+}
+
+static bool tidss_crtc_compare_state(struct drm_crtc *crtc,
+				     struct drm_printer *p,
+				     struct drm_crtc_state *expected,
+				     struct drm_crtc_state *actual)
+{
+	struct tidss_crtc_state *t_expected = to_tidss_crtc_state(expected);
+	struct tidss_crtc_state *t_actual = to_tidss_crtc_state(actual);
+	bool ret = drm_atomic_helper_crtc_compare_state(crtc, p, expected, actual);
+
+	/*
+	 * Both inactive: the bus configuration wasn't read out from the
+	 * disabled pipeline, and the committed one is stale anyway.
+	 */
+	if (!expected->active && !actual->active)
+		return ret;
+
+	STATE_CHECK_U32_X(ret, p, crtc->name, t_expected, t_actual, bus_format);
+	STATE_CHECK_U32_X(ret, p, crtc->name, t_expected, t_actual, bus_flags);
+
+	return ret;
+}
+
 static struct drm_crtc_state *tidss_crtc_duplicate_state(struct drm_crtc *crtc)
 {
@@ -418,4 +524,7 @@ static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_create_state = tidss_crtc_create_state,
+	.atomic_sro_readout_state = tidss_crtc_readout_state,
+	.atomic_sro_install_state = tidss_crtc_install_state,
+	.atomic_sro_compare_state = tidss_crtc_compare_state,
 	.atomic_duplicate_state = tidss_crtc_duplicate_state,
 	.atomic_destroy_state = tidss_crtc_destroy_state,
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 8720403af9ed..c3117745965b 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1217,4 +1217,10 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
 }
 
+bool dispc_vp_is_enabled(struct dispc_device *dispc, u32 hw_videoport)
+{
+	return FIELD_GET(DISPC_VP_CONTROL_ENABLE_MASK,
+			 dispc_vp_read(dispc, hw_videoport, DISPC_VP_CONTROL));
+}
+
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
 {
@@ -1475,4 +1481,226 @@ int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 }
 
+static unsigned long calc_pixel_clock_hz(unsigned int htotal,
+					 unsigned int vtotal,
+					 unsigned int refresh,
+					 unsigned int freq_div)
+{
+	u64 rate = (u64)htotal * vtotal * refresh;
+
+	return div_u64(rate * 1000, freq_div);
+}
+
+static const unsigned int refresh_tries[] = {30, 50, 60};
+static const unsigned int refresh_factors_tries[] = {1000, 1001};
+
+static unsigned int dispc_find_closest_refresh_rate_from_clk(struct drm_device *dev,
+							     struct clk *clk,
+							     unsigned int htotal,
+							     unsigned int vtotal,
+							     unsigned long *pixel_clock_hz)
+{
+	unsigned long actual_clk_rate = clk_get_rate(clk);
+	unsigned long best_clk_rate = 0;
+	unsigned long best_rate_diff = ULONG_MAX;
+	unsigned int best_refresh = 0;
+	unsigned int i, j;
+
+	drm_dbg(dev, "Actual clock rate is %lu\n", actual_clk_rate);
+
+	for (i = 0; i < ARRAY_SIZE(refresh_tries); i++) {
+		for (j = 0; j < ARRAY_SIZE(refresh_factors_tries); j++) {
+			unsigned int try_refresh = refresh_tries[i];
+			unsigned int try_factor = refresh_factors_tries[j];
+			unsigned long try_clk_rate = calc_pixel_clock_hz(htotal,
+									 vtotal,
+									 try_refresh,
+									 try_factor);
+			unsigned long diff;
+
+			drm_dbg(dev, "Evaluating refresh %u, factor %u, rate %lu\n",
+				try_refresh, try_factor, try_clk_rate);
+
+			if (try_clk_rate == actual_clk_rate) {
+				drm_dbg(dev, "Found exact match. Stopping.\n");
+				best_refresh = try_refresh;
+				best_clk_rate = try_clk_rate;
+				goto out;
+			}
+
+
+			diff = abs_diff(actual_clk_rate, try_clk_rate);
+			if (diff < best_rate_diff) {
+				drm_dbg(dev, "Found new candidate. Difference is %lu\n", diff);
+				best_refresh = try_refresh;
+				best_clk_rate = try_clk_rate;
+				best_rate_diff = diff;
+			}
+		}
+	}
+
+	/*
+	 * The video port clock doesn't match any standard refresh rate,
+	 * so the mode we would report would be plain wrong. Report the
+	 * configuration as unsupported by returning 0, so that the
+	 * caller falls back on the regular initialization path.
+	 *
+	 * We tolerate the same 5% difference that
+	 * dispc_vp_set_clk_rate() accepts when programming the clock.
+	 */
+	if (dispc_pclk_diff(best_clk_rate, actual_clk_rate) > 5) {
+		drm_dbg(dev, "Clock rate %lu doesn't match any standard refresh rate\n",
+			actual_clk_rate);
+		return 0;
+	}
+
+out:
+	drm_dbg(dev, "Best candidate is %u Hz, pixel clock rate %lu Hz",
+		best_refresh, best_clk_rate);
+
+	if (pixel_clock_hz)
+		*pixel_clock_hz = best_clk_rate;
+
+	return best_refresh;
+}
+
+int dispc_vp_readout_mode(struct dispc_device *dispc,
+			  u32 hw_videoport,
+			  struct drm_display_mode *mode)
+{
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
+	unsigned long pixel_clock;
+	unsigned int refresh;
+	u16 hdisplay, hfp, hsw, hbp;
+	u16 vdisplay, vfp, vsw, vbp;
+	u32 val;
+
+	val = dispc_vp_read(dispc, hw_videoport, DISPC_VP_SIZE_SCREEN);
+	hdisplay = FIELD_GET(DISPC_VP_SIZE_SCREEN_HDISPLAY_MASK, val) + 1;
+	vdisplay = FIELD_GET(DISPC_VP_SIZE_SCREEN_VDISPLAY_MASK, val) + 1;
+
+	mode->hdisplay = hdisplay;
+	mode->vdisplay = vdisplay;
+
+	val = dispc_vp_read(dispc, hw_videoport, DISPC_VP_TIMING_H);
+	hsw = FIELD_GET(DISPC_VP_TIMING_H_SYNC_PULSE_MASK, val) + 1;
+	hfp = FIELD_GET(DISPC_VP_TIMING_H_FRONT_PORCH_MASK, val) + 1;
+	hbp = FIELD_GET(DISPC_VP_TIMING_H_BACK_PORCH_MASK, val) + 1;
+
+	mode->hsync_start = hdisplay + hfp;
+	mode->hsync_end = hdisplay + hfp + hsw;
+	mode->htotal = hdisplay + hfp + hsw + hbp;
+
+	val = dispc_vp_read(dispc, hw_videoport, DISPC_VP_TIMING_V);
+	vsw = FIELD_GET(DISPC_VP_TIMING_V_SYNC_PULSE_MASK, val) + 1;
+	vfp = FIELD_GET(DISPC_VP_TIMING_V_FRONT_PORCH_MASK, val);
+	vbp = FIELD_GET(DISPC_VP_TIMING_V_BACK_PORCH_MASK, val);
+
+	mode->vsync_start = vdisplay + vfp;
+	mode->vsync_end = vdisplay + vfp + vsw;
+	mode->vtotal = vdisplay + vfp + vsw + vbp;
+
+	refresh = dispc_find_closest_refresh_rate_from_clk(dev,
+							   dispc->vp_clk[hw_videoport],
+							   mode->htotal,
+							   mode->vtotal,
+							   &pixel_clock);
+	if (!refresh)
+		return -EINVAL;
+
+	mode->clock = pixel_clock / 1000;
+
+	val = dispc_vp_read(dispc, hw_videoport, DISPC_VP_POL_FREQ);
+	if (FIELD_GET(DISPC_VP_POL_FREQ_IVS_MASK, val))
+		mode->flags |= DRM_MODE_FLAG_NVSYNC;
+	else
+		mode->flags |= DRM_MODE_FLAG_PVSYNC;
+
+	if (FIELD_GET(DISPC_VP_POL_FREQ_IHS_MASK, val))
+		mode->flags |= DRM_MODE_FLAG_NHSYNC;
+	else
+		mode->flags |= DRM_MODE_FLAG_PHSYNC;
+
+	mode->type |= DRM_MODE_TYPE_DRIVER;
+	drm_mode_set_name(mode);
+	drm_mode_set_crtcinfo(mode, 0);
+
+	return 0;
+}
+
+int dispc_vp_get_bus_format(struct dispc_device *dispc, u32 hw_videoport,
+			    u32 *bus_fmt)
+{
+	static const u32 datalines_to_width[] = { 12, 16, 18, 24, 30, 36 };
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
+	u32 datalines, data_width;
+	unsigned int i;
+
+	datalines = VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL,
+			       DISPC_VP_CONTROL_DATALINES_MASK);
+
+	if (datalines < ARRAY_SIZE(datalines_to_width)) {
+		data_width = datalines_to_width[datalines];
+	} else {
+		drm_dbg(dev, "Unknown DATALINES encoding %u on %s\n",
+			datalines, dispc->feat->vp_name[hw_videoport]);
+		return -EINVAL;
+	}
+
+	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X) {
+		u32 oldi_cfg = dispc_vp_read(dispc, hw_videoport,
+					     DISPC_VP_DSS_OLDI_CFG);
+		u32 map = FIELD_GET(DISPC_VP_DSS_OLDI_CFG_MAP_MASK, oldi_cfg);
+
+		for (i = 0; i < ARRAY_SIZE(dispc_bus_formats); i++) {
+			if (dispc_bus_formats[i].is_oldi_fmt &&
+			    dispc_bus_formats[i].data_width == data_width &&
+			    dispc_bus_formats[i].am65x_oldi_mode_reg_val == map) {
+				*bus_fmt = dispc_bus_formats[i].bus_fmt;
+				return 0;
+			}
+		}
+
+		drm_dbg(dev, "Unknown OLDI mapping %u on %s\n", map,
+			dispc->feat->vp_name[hw_videoport]);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dispc_bus_formats); i++) {
+		if (!dispc_bus_formats[i].is_oldi_fmt &&
+		    dispc_bus_formats[i].data_width == data_width) {
+			*bus_fmt = dispc_bus_formats[i].bus_fmt;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+u32 dispc_vp_get_bus_flags(struct dispc_device *dispc, u32 hw_videoport)
+{
+	u32 flags = 0;
+	u32 val;
+
+	val = dispc_vp_read(dispc, hw_videoport, DISPC_VP_POL_FREQ);
+	if (FIELD_GET(DISPC_VP_POL_FREQ_IPC_MASK, val))
+		flags |= DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE;
+	else
+		flags |= DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE;
+
+	if (FIELD_GET(DISPC_VP_POL_FREQ_IEO_MASK, val))
+		flags |= DRM_BUS_FLAG_DE_LOW;
+	else
+		flags |= DRM_BUS_FLAG_DE_HIGH;
+
+	if (FIELD_GET(DISPC_VP_POL_FREQ_RF_MASK, val))
+		flags |= DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE;
+	else
+		flags |= DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE;
+
+	return flags;
+}
+
 /* OVR */
 static void dispc_k2g_ovr_set_plane(struct dispc_device *dispc,
@@ -1548,4 +1776,92 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
 }
 
+/**
+ * dispc_ovr_get_plane - find the overlay layer a plane is routed to
+ * @dispc: the dispc
+ * @hw_plane: the plane to look for
+ * @hw_videoport: returned video port the plane is routed to
+ * @x: returned X position of the plane
+ * @y: returned Y position of the plane
+ * @layer: returned overlay layer index the plane is routed to
+ *
+ * Reads the overlay manager registers to find which video port, at
+ * which position and in which layer, a plane is currently routed to.
+ * The layer index matches the normalized zpos the plane was committed
+ * with, as that is what dispc_ovr_set_plane() uses as the layer index.
+ *
+ * The CHANNELIN field of a disabled layer keeps its stale value, so
+ * only the enabled layers are considered.
+ *
+ * RETURNS:
+ *
+ * 0 on success, -ENODEV if the plane is not routed to any enabled
+ * overlay layer.
+ */
+int dispc_ovr_get_plane(struct dispc_device *dispc, u32 hw_plane,
+			u32 *hw_videoport, int *x, int *y, u32 *layer)
+{
+	u32 vp, l;
+
+	switch (dispc->feat->subrev) {
+	case DISPC_K2G: {
+		u32 val;
+
+		/*
+		 * On K2G there is only one plane and no overlay
+		 * manager: the position is programmed in the VID
+		 * pipeline registers.
+		 */
+		val = dispc_vid_read(dispc, hw_plane, DISPC_VID_K2G_POSITION);
+		*hw_videoport = 0;
+		*layer = 0;
+		*x = val & 0xffff;
+		*y = val >> 16;
+		return 0;
+	}
+	case DISPC_AM625:
+	case DISPC_AM62A7:
+	case DISPC_AM62L:
+	case DISPC_AM65X:
+	case DISPC_J721E:
+		for (vp = 0; vp < dispc->feat->num_vps; vp++) {
+			for (l = 0; l < dispc->feat->num_vids; l++) {
+				u32 attrs = dispc_ovr_read(dispc, vp,
+							   DISPC_OVR_ATTRIBUTES(l));
+
+				if (!(attrs & DISPC_OVR_ATTRIBUTES_ENABLE_MASK))
+					continue;
+
+				if (FIELD_GET(DISPC_OVR_ATTRIBUTES_CHANNELIN_MASK,
+					      attrs) != hw_plane)
+					continue;
+
+				*hw_videoport = vp;
+				*layer = l;
+
+				if (dispc->feat->subrev == DISPC_J721E) {
+					u32 attrs2 = dispc_ovr_read(dispc, vp,
+								    DISPC_OVR_ATTRIBUTES2(l));
+
+					*x = FIELD_GET(DISPC_OVR_ATTRIBUTES2_POSX_MASK,
+						       attrs2);
+					*y = FIELD_GET(DISPC_OVR_ATTRIBUTES2_POSY_MASK,
+						       attrs2);
+				} else {
+					*x = FIELD_GET(DISPC_OVR_ATTRIBUTES_POSX_MASK,
+						       attrs);
+					*y = FIELD_GET(DISPC_OVR_ATTRIBUTES_POSY_MASK,
+						       attrs);
+				}
+
+				return 0;
+			}
+		}
+
+		return -ENODEV;
+	default:
+		return -ENODEV;
+	}
+}
+
 /* CSC */
 enum csc_ctm {
@@ -2120,4 +2436,15 @@ static const struct {
 };
 
+static u32 dispc_plane_find_fourcc_by_dss_code(u8 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dispc_color_formats); ++i)
+		if (dispc_color_formats[i].dss_code == code)
+			return dispc_color_formats[i].fourcc;
+
+	return 0;
+}
+
 static void dispc_plane_set_pixel_format(struct dispc_device *dispc,
 					 u32 hw_plane, u32 fourcc)
@@ -2206,5 +2533,4 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 	u16 cpp = state->fb->format->cpp[0];
 	u32 fb_width = state->fb->pitches[0] / cpp;
-	dma_addr_t dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, 0);
 	struct dispc_scaling_params scale;
 
@@ -2213,8 +2539,18 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 	dispc_plane_set_pixel_format(dispc, hw_plane, fourcc);
 
-	dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_0, dma_addr & 0xffffffff);
-	dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_EXT_0, (u64)dma_addr >> 32);
-	dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_1, dma_addr & 0xffffffff);
-	dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_EXT_1, (u64)dma_addr >> 32);
+	/*
+	 * A framebuffer reconstructed from a hardware state readout has
+	 * no GEM object to derive the DMA address from. The hardware is
+	 * already scanning out that buffer, so keep the address the
+	 * firmware programmed.
+	 */
+	if (state->fb->obj[0]) {
+		dma_addr_t dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, 0);
+
+		dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_0, dma_addr & 0xffffffff);
+		dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_EXT_0, (u64)dma_addr >> 32);
+		dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_1, dma_addr & 0xffffffff);
+		dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_EXT_1, (u64)dma_addr >> 32);
+	}
 
 	dispc_vid_write(dispc, hw_plane, DISPC_VID_PICTURE_SIZE,
@@ -2285,4 +2621,79 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 }
 
+void dispc_plane_get_picture_size(struct dispc_device *dispc, u32 hw_plane,
+				  unsigned int *width, unsigned int *height)
+{
+	u32 val;
+	u16 w, h;
+
+	val = dispc_vid_read(dispc, hw_plane, DISPC_VID_PICTURE_SIZE);
+	w = FIELD_GET(DISPC_VID_PICTURE_SIZE_MEMSIZEX_MASK, val);
+	h = FIELD_GET(DISPC_VID_PICTURE_SIZE_MEMSIZEY_MASK, val);
+
+	*width = w + 1;
+	*height = h + 1;
+}
+
+void dispc_plane_get_size(struct dispc_device *dispc, u32 hw_plane,
+			  unsigned int *width, unsigned int *height)
+{
+	bool lite = dispc->feat->vid_info[hw_plane].is_lite;
+
+	if (!lite) {
+		u32 val = dispc_vid_read(dispc, hw_plane, DISPC_VID_SIZE);
+		*width = FIELD_GET(DISPC_VID_SIZE_SIZEX_MASK, val) + 1;
+		*height = FIELD_GET(DISPC_VID_SIZE_SIZEY_MASK, val) + 1;
+	} else {
+		dispc_plane_get_picture_size(dispc, hw_plane, width, height);
+	}
+}
+
+const struct drm_format_info *
+dispc_plane_get_current_format(struct dispc_device *dispc, u32 hw_plane)
+{
+	const struct drm_format_info *info;
+	u32 fourcc;
+	u32 val;
+
+	val = dispc_vid_read(dispc, hw_plane, DISPC_VID_ATTRIBUTES);
+	fourcc = dispc_plane_find_fourcc_by_dss_code(
+		FIELD_GET(DISPC_VID_ATTRIBUTES_FORMAT_MASK, val));
+	if (!fourcc)
+		return ERR_PTR(-EINVAL);
+
+	info = drm_format_info(fourcc);
+	if (!info)
+		return ERR_PTR(-EINVAL);
+
+	return info;
+}
+
+u8 dispc_plane_get_global_alpha(struct dispc_device *dispc, u32 hw_plane)
+{
+	return FIELD_GET(DISPC_VID_GLOBAL_ALPHA_GLOBALALPHA_MASK,
+			 dispc_vid_read(dispc, hw_plane,
+					DISPC_VID_GLOBAL_ALPHA));
+}
+
+u32 dispc_plane_get_pixel_inc(struct dispc_device *dispc, u32 hw_plane)
+{
+	return dispc_vid_read(dispc, hw_plane, DISPC_VID_PIXEL_INC);
+}
+
+u32 dispc_plane_get_row_inc(struct dispc_device *dispc, u32 hw_plane)
+{
+	return dispc_vid_read(dispc, hw_plane, DISPC_VID_ROW_INC);
+}
+
+u16 dispc_plane_get_blend_mode(struct dispc_device *dispc, u32 hw_plane)
+{
+	u32 val = dispc_vid_read(dispc, hw_plane, DISPC_VID_ATTRIBUTES);
+
+	if (FIELD_GET(DISPC_VID_ATTRIBUTES_PREMULTIPLYALPHA_MASK, val))
+		return DRM_MODE_BLEND_PREMULTI;
+	else
+		return DRM_MODE_BLEND_COVERAGE;
+}
+
 void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable)
 {
@@ -2291,4 +2702,10 @@ void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable)
 }
 
+bool dispc_plane_is_enabled(struct dispc_device *dispc, u32 hw_plane)
+{
+	return FIELD_GET(DISPC_VID_ATTRIBUTES_ENABLE_MASK,
+			 dispc_vid_read(dispc, hw_plane, DISPC_VID_ATTRIBUTES));
+}
+
 static u32 dispc_vid_get_fifo_size(struct dispc_device *dispc, u32 hw_plane)
 {
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index caf0f8c58739..159fe3b94b0a 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -116,8 +116,11 @@ void dispc_ovr_set_plane(struct dispc_device *dispc, u32 hw_plane,
 void dispc_ovr_enable_layer(struct dispc_device *dispc,
 			    u32 hw_videoport, u32 layer, bool enable);
+int dispc_ovr_get_plane(struct dispc_device *dispc, u32 hw_plane,
+			u32 *hw_videoport, int *x, int *y, u32 *layer);
 
 void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 		      const struct drm_crtc_state *state);
 void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport);
+bool dispc_vp_is_enabled(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport);
@@ -136,4 +139,10 @@ void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
 		    const struct drm_crtc_state *state, bool newmodeset,
 		    bool dpi_output);
+int dispc_vp_readout_mode(struct dispc_device *dispc,
+			  u32 hw_videoport,
+			  struct drm_display_mode *mode);
+int dispc_vp_get_bus_format(struct dispc_device *dispc, u32 hw_videoport,
+			    u32 *bus_fmt);
+u32 dispc_vp_get_bus_flags(struct dispc_device *dispc, u32 hw_videoport);
 
 int dispc_runtime_suspend(struct dispc_device *dispc);
@@ -146,5 +155,16 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 		       struct drm_plane_state *state,
 		       u32 hw_videoport);
+void dispc_plane_get_picture_size(struct dispc_device *dispc, u32 hw_plane,
+				  unsigned int *width, unsigned int *height);
+void dispc_plane_get_size(struct dispc_device *dispc, u32 hw_plane,
+			  unsigned int *width, unsigned int *height);
+const struct drm_format_info *
+dispc_plane_get_current_format(struct dispc_device *dispc, u32 hw_plane);
+u8 dispc_plane_get_global_alpha(struct dispc_device *dispc, u32 hw_plane);
+u32 dispc_plane_get_pixel_inc(struct dispc_device *dispc, u32 hw_plane);
+u32 dispc_plane_get_row_inc(struct dispc_device *dispc, u32 hw_plane);
+u16 dispc_plane_get_blend_mode(struct dispc_device *dispc, u32 hw_plane);
 void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
+bool dispc_plane_is_enabled(struct dispc_device *dispc, u32 hw_plane);
 const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);
 
diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 10dbcc6cdf6a..5034e601ac86 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -6,6 +6,8 @@
 
 #include <linux/export.h>
+#include <linux/media-bus-format.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
@@ -74,4 +76,42 @@ static int tidss_bridge_atomic_check(struct drm_bridge *bridge,
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
@@ -80,4 +120,6 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
+	.atomic_sro_readout_state	= tidss_readout_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index a3bf94e56fcb..967cef33d191 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -7,4 +7,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -65,5 +67,6 @@ static void tidss_atomic_commit_tail(struct drm_atomic_commit *old_state)
 
 static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
-	.atomic_commit_tail = tidss_atomic_commit_tail,
+	.atomic_commit_tail	= tidss_atomic_commit_tail,
+	.atomic_sro_build_state = drm_atomic_helper_sro_build_state,
 };
 
@@ -134,4 +137,5 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 	.atomic_check = tidss_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_sro_readout_state = drm_atomic_helper_sro_readout_state,
 	.hw_reset = tidss_hw_reset,
 };
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index b0d5d6959b88..94824cff77f9 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -7,4 +7,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_crtc.h>
@@ -13,4 +15,5 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_panic_helper.h>
 
@@ -177,4 +180,204 @@ static const struct drm_plane_helper_funcs tidss_primary_plane_helper_funcs = {
 };
 
+static const struct drm_framebuffer_funcs tidss_plane_readout_fb_funcs = {
+	.destroy	= drm_gem_fb_destroy,
+};
+
+static struct drm_framebuffer *tidss_plane_readout_fb(struct drm_plane *plane)
+{
+	struct drm_device *ddev = plane->dev;
+	struct tidss_device *tidss = to_tidss(ddev);
+	struct dispc_device *dispc = tidss->dispc;
+	struct tidss_plane *tplane = to_tidss_plane(plane);
+	const struct drm_format_info *info;
+	struct drm_framebuffer *fb;
+	int ret;
+
+	fb = kzalloc_obj(*fb);
+	if (!fb)
+		return ERR_PTR(-ENOMEM);
+
+	fb->dev = plane->dev;
+
+	info = dispc_plane_get_current_format(dispc, tplane->hw_plane_id);
+	if (IS_ERR(info)) {
+		ret = PTR_ERR(info);
+		goto err_free_fb;
+	}
+
+	// TODO: Figure out YUV and multiplanar formats, along with
+	// the color encoding and range
+	if (info->is_yuv) {
+		ret = -EINVAL;
+		goto err_free_fb;
+	}
+
+	fb->format = info;
+
+	dispc_plane_get_picture_size(dispc, tplane->hw_plane_id, &fb->width,
+				     &fb->height);
+
+	/*
+	 * A pixel increment of 1 means that the DMA engine fetches every
+	 * pixel of the source buffer. Any other value means that
+	 * horizontal decimation is enabled, and the buffer geometry
+	 * cannot be reconstructed from the registers.
+	 */
+	if (dispc_plane_get_pixel_inc(dispc, tplane->hw_plane_id) != 1) {
+		ret = -EINVAL;
+		goto err_free_fb;
+	}
+
+	/*
+	 * The row increment register holds the extra bytes between the
+	 * end of a row of the picture and the beginning of the next one,
+	 * which includes any padding the firmware might have programmed.
+	 */
+	fb->pitches[0] = fb->width * (drm_format_info_bpp(info, 0) / 8) +
+			 dispc_plane_get_row_inc(dispc, tplane->hw_plane_id) - 1;
+
+	/*
+	 * TODO: The DMA base address has the offsets baked in, and there
+	 * is no backing buffer to recover them from.
+	 */
+	fb->offsets[0] = 0;
+
+	ret = drm_framebuffer_init(plane->dev, fb, &tidss_plane_readout_fb_funcs);
+	if (ret) {
+		kfree(fb);
+		return ERR_PTR(ret);
+	}
+
+	return fb;
+
+err_free_fb:
+	kfree(fb);
+	return ERR_PTR(ret);
+}
+
+static struct drm_crtc *tidss_plane_readout_crtc(struct drm_plane *plane,
+						 int *crtc_x, int *crtc_y,
+						 u32 *normalized_zpos)
+{
+	struct drm_device *dev = plane->dev;
+	struct tidss_device *tidss = to_tidss(dev);
+	struct tidss_plane *tplane = to_tidss_plane(plane);
+	struct drm_crtc *crtc;
+	u32 hw_videoport, layer;
+	int ret;
+
+	ret = dispc_ovr_get_plane(tidss->dispc, tplane->hw_plane_id,
+				  &hw_videoport, crtc_x, crtc_y, &layer);
+	if (ret)
+		return ERR_PTR(ret);
+
+	*normalized_zpos = layer;
+
+	drm_for_each_crtc(crtc, dev) {
+		if (to_tidss_crtc(crtc)->hw_videoport == hw_videoport)
+			return crtc;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static int tidss_plane_atomic_readout_state(struct drm_plane *plane,
+					    struct drm_atomic_sro_state *state,
+					    struct drm_plane_state *plane_state)
+{
+	struct drm_device *ddev = plane->dev;
+	struct tidss_device *tidss = to_tidss(ddev);
+	struct dispc_device *dispc = tidss->dispc;
+	struct tidss_plane *tplane = to_tidss_plane(plane);
+	struct drm_crtc_state *crtc_state;
+	struct drm_framebuffer *fb;
+	struct drm_crtc *crtc;
+	unsigned int in_w, in_h;
+	int crtc_x, crtc_y;
+	u32 normalized_zpos;
+	int ret;
+
+	tidss_runtime_get(tidss);
+
+	if (!dispc_plane_is_enabled(dispc, tplane->hw_plane_id))
+		goto out;
+
+	fb = tidss_plane_readout_fb(plane);
+	if (IS_ERR(fb)) {
+		ret = PTR_ERR(fb);
+		goto err_runtime_pm;
+	}
+
+	crtc = tidss_plane_readout_crtc(plane, &crtc_x, &crtc_y,
+					&normalized_zpos);
+	if (IS_ERR(crtc)) {
+		drm_framebuffer_put(fb);
+		ret = PTR_ERR(crtc);
+		goto err_runtime_pm;
+	}
+
+	plane_state->fb = fb;
+	plane_state->crtc = crtc;
+	plane_state->visible = true;
+
+	dispc_plane_get_picture_size(dispc, tplane->hw_plane_id, &in_w, &in_h);
+	plane_state->src_w = in_w << 16;
+	plane_state->src_h = in_h << 16;
+
+	dispc_plane_get_size(dispc, tplane->hw_plane_id, &plane_state->crtc_w,
+			     &plane_state->crtc_h);
+
+	plane_state->crtc_x = crtc_x;
+	plane_state->crtc_y = crtc_y;
+
+	/*
+	 * The overlay layer index a plane is routed to is its
+	 * normalized zpos, as that is what the atomic update uses as
+	 * the layer index. The raw zpos property userspace set
+	 * cannot be recovered from the hardware.
+	 */
+	plane_state->normalized_zpos = normalized_zpos;
+	plane_state->zpos = normalized_zpos;
+
+	// TODO: Handle src_x/src_y, see DISPC_VID_BA_0
+
+	plane_state->src.x1 = 0;
+	plane_state->src.x2 = plane_state->src_w;
+	plane_state->src.y1 = 0;
+	plane_state->src.y2 = plane_state->src_h;
+	plane_state->dst.x1 = crtc_x;
+	plane_state->dst.x2 = crtc_x + plane_state->crtc_w;
+	plane_state->dst.y1 = crtc_y;
+	plane_state->dst.y2 = crtc_y + plane_state->crtc_h;
+
+	/*
+	 * The global alpha register is 8 bits wide and is programmed
+	 * from the high byte of the 16 bits alpha property.
+	 * Replicating the byte is the only inverse that preserves the
+	 * fraction of full opacity (0x00 -> 0x0000, 0xff -> 0xffff)
+	 * and round-trips through a program-then-readout cycle.
+	 */
+	plane_state->alpha =
+		dispc_plane_get_global_alpha(dispc, tplane->hw_plane_id) * 0x0101;
+	plane_state->pixel_blend_mode =
+		dispc_plane_get_blend_mode(dispc, tplane->hw_plane_id);
+
+	crtc_state = drm_atomic_sro_get_crtc_state(state, crtc);
+	if (!crtc_state) {
+		ret = -ENODEV;
+		goto err_runtime_pm;
+	}
+
+	crtc_state->plane_mask |= drm_plane_mask(plane);
+
+out:
+	tidss_runtime_put(tidss);
+	return 0;
+
+err_runtime_pm:
+	tidss_runtime_put(tidss);
+	return ret;
+}
+
 static const struct drm_plane_funcs tidss_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
@@ -182,4 +385,6 @@ static const struct drm_plane_funcs tidss_plane_funcs = {
 	.destroy = drm_plane_destroy,
 	.atomic_create_state = drm_atomic_helper_plane_create_state,
+	.atomic_sro_readout_state = tidss_plane_atomic_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_plane_compare_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,

-- 
2.55.0

