Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786DE606A326
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahvVHxJd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1A9112A12;
	Fri, 20 Nov 2026 12:59:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF6C89FCE
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:57:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6C14429E7;
 Fri, 20 Nov 2026 12:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAF31F000C6;
 Fri, 20 Nov 2026 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179445;
 bh=NHYcpAm0ldLDIWibpwStqIf4s+lsWpLqsA0O9cS8LFA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ahvVHxJdIqwOKpJ9/L3bqiHq+kifpagSVzwQ6qyaNXfWIG7MbEFZV0Bdgdw/ZJjH7
 i6WpfO0ySpw9Vw4sFXtSFeT1QjjjmgYfpHyTZFYoPm28mypD9RtAAxKjtNOZpqwjOn
 KfRgoLz/Mg59K/43ppRoJJI3OkvlhEt8J8HRYxSU1jK020a0FLp4xIWvbLOom+fhR5
 yKRBQAXcXt396dFEWve2ladcZ1QtjmnpKqPElTsU1Dn5d1CY0uzlRGllowZccBzLzy
 Tw/M/5ne8pgg674P9rw9Ii/nhyt3/Z6uKou2uxiZJSXCm2uwZYavaHc7kLKxACfMMr
 AHinb4lzJoxEw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:28 +0100
Subject: [PATCH v9 36/42] drm/tidss: dispc: Add hardware state readout helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-36-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23468; i=mripard@kernel.org;
 h=from:subject:message-id; bh=46NTbKlBGxH0SSZmbDNTj017fRZjQJVyfpkNM9GhtP4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzkbLHReluP36tGSb9swWO+Xm0l2he9alqab+c9ryq
 CB2e5Bwx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI9HLGhgkFp5X3eb2UPcif
 +/TJ/FVyOQK7rkw+48d4aLblTKf+zPNMhw9dreNP7frDf/rBZVnXiYz1QXUspztK126YEPv/muz
 f6rj29eGM905dcRfgsZX5/vnmU9uEw195fsQ3rc35t2D37hsKAA==
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

The state readout of the tidss CRTCs, planes and OLDI transmitters has
to decode what the firmware programmed in the DISPC registers back into
KMS state. However, the driver only has helpers to program those
registers.

Add helpers to read out the video ports: whether one is enabled, its
display mode, its bus format and its bus flags. The timing registers
don't hold the refresh rate, so dispc_vp_readout_mode() derives it by
matching the video port clock rate against the 30, 50 and 60 Hz
standard refresh rates, with and without the 1000/1001 factor, and
fails if none of them is close enough. The bus format is decoded from
the DATALINES field, along with the OLDI mapping on the AM65x video
ports that drive an OLDI transmitter.

Add helpers to read out the planes: whether one is enabled, the video
port, overlay layer and position it is routed to with
dispc_ovr_get_plane(), its picture and output sizes, its format, global
alpha and blend mode, and its pixel and row increments.

Two existing paths also need to cope with a pipeline the firmware left
running:

 - dispc_vp_init() disables DPIENABLE for every video port. Skip the
   ones that are enabled, so that their output keeps running until it
   is read out.

 - dispc_plane_setup() programs the DMA address of the framebuffer. A
   framebuffer reconstructed from a readout has no GEM object to
   derive it from, and the hardware is already scanning out that
   buffer, so keep the address the firmware programmed.

Finally, split dispc_vp_set_dpi_output() out of dispc_vp_setup(), so
that the CRTC can record the DPI output state of a video port it takes
over without going through a full setup.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 444 +++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h |  22 ++
 2 files changed, 457 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index e186c63ba5fb..8e61216d4532 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1149,10 +1149,16 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
 {
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
 		       DISPC_VP_CONTROL_ENABLE_MASK);
 }
 
+bool dispc_vp_is_enabled(struct dispc_device *dispc, u32 hw_videoport)
+{
+	return FIELD_GET(DISPC_VP_CONTROL_ENABLE_MASK,
+			 dispc_vp_read(dispc, hw_videoport, DISPC_VP_CONTROL));
+}
+
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
 {
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
 		       DISPC_VP_CONTROL_ENABLE_MASK);
 }
@@ -1399,10 +1405,232 @@ int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 		hw_videoport, clk_get_rate(dispc->vp_clk[hw_videoport]), rate);
 
 	return 0;
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
+	if (dispc_vp_is_am65x_oldi(dispc->feat, hw_videoport)) {
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
 				    u32 hw_plane, u32 hw_videoport,
 				    u32 x, u32 y, u32 layer)
 {
@@ -1471,10 +1699,97 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
 
 	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
 			!!enable, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
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
+					      attrs) != dispc->feat->vid_info[hw_plane].hw_id)
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
 	CSC_RR, CSC_RG, CSC_RB,
 	CSC_GR, CSC_GG, CSC_GB,
 	CSC_BR, CSC_BG, CSC_BB,
@@ -2043,10 +2358,21 @@ static const struct {
 	{ DRM_FORMAT_UYVY, 0x3f, },
 
 	{ DRM_FORMAT_NV12, 0x3d, },
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
 {
 	unsigned int i;
 
@@ -2129,21 +2455,30 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 {
 	bool lite = dispc->feat->vid_info[hw_plane].is_lite;
 	u32 fourcc = state->fb->format->format;
 	u16 cpp = state->fb->format->cpp[0];
 	u32 fb_width = state->fb->pitches[0] / cpp;
-	dma_addr_t dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, 0);
 	struct dispc_scaling_params scale;
 
 	dispc_vid_calc_scaling(dispc, state, &scale, lite);
 
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
 			FIELD_PREP(DISPC_VID_PICTURE_SIZE_MEMSIZEY_MASK, scale.in_h - 1) |
 			FIELD_PREP(DISPC_VID_PICTURE_SIZE_MEMSIZEX_MASK, scale.in_w - 1));
 
@@ -2208,16 +2543,97 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 	else
 		VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, 0,
 				DISPC_VID_ATTRIBUTES_PREMULTIPLYALPHA_MASK);
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
 	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, !!enable,
 			DISPC_VID_ATTRIBUTES_ENABLE_MASK);
 }
 
+bool dispc_plane_is_enabled(struct dispc_device *dispc, u32 hw_plane)
+{
+	return FIELD_GET(DISPC_VID_ATTRIBUTES_ENABLE_MASK,
+			 dispc_vid_read(dispc, hw_plane, DISPC_VID_ATTRIBUTES));
+}
+
 static u32 dispc_vid_get_fifo_size(struct dispc_device *dispc, u32 hw_plane)
 {
 	return VID_REG_GET(dispc, hw_plane, DISPC_VID_BUF_SIZE_STATUS,
 			   DISPC_VID_BUF_SIZE_STATUS_BUFSIZE_MASK);
 }
@@ -2371,15 +2787,19 @@ static void dispc_vp_init(struct dispc_device *dispc)
 	for (i = 0; i < dispc->feat->num_vps; i++) {
 		/* Enable the gamma Shadow bit-field for all VPs*/
 		VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONFIG, 1,
 			       DISPC_VP_CONFIG_GAMMAENABLE_MASK);
 
-		if (dispc->feat->has_vp_control_dpienable) {
-			/* Disable DPIENABLE for all VPs */
+		/*
+		 * Disable DPIENABLE for all VPs, but the ones left
+		 * enabled, by the firmware for example, so that their
+		 * output keeps running and can be read out.
+		 */
+		if (dispc->feat->has_vp_control_dpienable &&
+		    !dispc_vp_is_enabled(dispc, i))
 			VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONTROL, 0,
 				       DISPC_VP_CONTROL_DPIENABLE_MASK);
-		}
 	}
 }
 
 static void dispc_initial_config(struct dispc_device *dispc)
 {
@@ -2706,15 +3126,21 @@ static void dispc_vp_set_color_mgmt(struct dispc_device *dispc,
 		dispc_k2g_vp_set_ctm(dispc, hw_videoport, ctm);
 	else
 		dispc_k3_vp_set_ctm(dispc, hw_videoport, ctm);
 }
 
+void dispc_vp_set_dpi_output(struct dispc_device *dispc, u32 hw_videoport,
+			     bool dpi_output)
+{
+	dispc->vp_data[hw_videoport].dpi_output = dpi_output;
+}
+
 void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
 		    const struct drm_crtc_state *state, bool newmodeset,
 		    bool dpi_output)
 {
-	dispc->vp_data[hw_videoport].dpi_output = dpi_output;
+	dispc_vp_set_dpi_output(dispc, hw_videoport, dpi_output);
 	dispc_vp_set_default_color(dispc, hw_videoport, 0);
 	dispc_vp_set_color_mgmt(dispc, hw_videoport, state, newmodeset);
 }
 
 int dispc_runtime_suspend(struct dispc_device *dispc)
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index dcd4d3b18ef4..4abcb9e679ac 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -109,14 +109,17 @@ dispc_irq_t dispc_read_and_clear_irqstatus(struct dispc_device *dispc);
 
 void dispc_ovr_set_plane(struct dispc_device *dispc, u32 hw_plane,
 			 u32 hw_videoport, u32 x, u32 y, u32 layer);
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
 bool dispc_vp_go_busy(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_go(struct dispc_device *dispc, u32 hw_videoport);
 int dispc_vp_bus_check(struct dispc_device *dispc, u32 hw_videoport,
@@ -126,24 +129,43 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 const struct drm_display_mode *mode);
 int dispc_vp_enable_clk(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_disable_clk(struct dispc_device *dispc, u32 hw_videoport);
 int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 			  unsigned long rate);
+void dispc_vp_set_dpi_output(struct dispc_device *dispc, u32 hw_videoport,
+			     bool dpi_output);
 void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
 		    const struct drm_crtc_state *state, bool newmodeset,
 		    bool dpi_output);
+int dispc_vp_readout_mode(struct dispc_device *dispc,
+			  u32 hw_videoport,
+			  struct drm_display_mode *mode);
+int dispc_vp_get_bus_format(struct dispc_device *dispc, u32 hw_videoport,
+			    u32 *bus_fmt);
+u32 dispc_vp_get_bus_flags(struct dispc_device *dispc, u32 hw_videoport);
 
 int dispc_runtime_suspend(struct dispc_device *dispc);
 int dispc_runtime_resume(struct dispc_device *dispc);
 
 int dispc_plane_check(struct dispc_device *dispc, u32 hw_plane,
 		      const struct drm_plane_state *state,
 		      u32 hw_videoport);
 void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
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
 
 int dispc_reset_hw(struct dispc_device *dispc);
 int dispc_init(struct tidss_device *tidss);
 void dispc_remove(struct tidss_device *tidss);

-- 
2.56.1

