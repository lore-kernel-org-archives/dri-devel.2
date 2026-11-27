Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25256606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmPAAaGl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527A5112950;
	Fri, 27 Nov 2026 09:56:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4CA112926
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B38764140F;
 Fri, 27 Nov 2026 09:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD63B1F0089A;
 Fri, 27 Nov 2026 09:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773288;
 bh=sphPB3cuwJVbWG4YWo9BchcRQm78g29gn14T7i4Mxns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BmPAAaGl8z71mdbjEqnFE8fX5tGjc53LAPHaxUps1GAegailInlnZMMnUet3utvKS
 qzApfQqf7b7nZ/65+OggSTJeXNLC5FHXXk4gEr80kmyqvVK7NGmaJEk1I1NL4IEL2d
 EZav4u4bRM8ae9uTR7BPfBnQ3ScrJHEsGukVj53NOnoOZihMk/jndJsEKON1QhdeIX
 ErowWrg4YGDsERb6khJ29D5TAD4kkU8qKwKxa2+FHyR7KtdIj7nAJ6Z62NdAT2PXoa
 h8i9d4CF/21V4/g7lLhmgqWWZL6OQp56gqPBVW/FvoKx3eqGdGMh5U88JSmKsN/fX4
 Yz7SyhfTSq+oQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:08 +0100
Subject: [PATCH v10 26/36] drm/tidss: dispc: Add hardware state readout helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-26-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19804; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wzcdoPETtZFSNSlX7F2TwHSB6f+NkJ5u/ClU0YPEFMY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwewxk3zyv7ySeiX+1LG3aufB//OOybhuENKLtRULE
 T94NqejYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzk7ATGOhV/xxdpXEs3NG03
 vnog8OqnWXoSsVNOpRzZyv6s+pG88uZTXaG7th68cEfl/iOuukMrljM2PP6i8GTmkTTdxhsvi+u
 PxLvNYMkWnV43+fWaPQodm9lyLFVbbp71uNd58wZvSN6mT2VPAQ==
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
don't hold the refresh rate, so dispc_vp_readout_mode() derives it from
the video port clock rate with
drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance(), and fails
if the rate isn't within 5% of a standard one, like
dispc_vp_set_clk_rate(). The bus format is decoded from the DATALINES
field, along with the OLDI mapping on the AM65x video ports that drive
an OLDI transmitter.

Add helpers to read out the planes: whether one is enabled, the video
port, overlay layer and position it is routed to with
dispc_ovr_get_plane(), its picture and output sizes, its format, global
alpha and blend mode, its pixel and row increments, and the DMA address
it fetches from.

dispc_vp_init() also disables DPIENABLE for every video port, which
would shut down a pipeline the firmware left running. Skip the ones
that are enabled, so that their output keeps running until it is read
out.

Finally, split dispc_vp_set_dpi_output() out of dispc_vp_setup(), so
that the CRTC can record the DPI output state of a video port it takes
over without going through a full setup.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 357 +++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h |  23 +++
 2 files changed, 376 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index e186c63ba5fb..15395e06f3f8 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -19,10 +19,11 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/sys_soc.h>
 
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_dma_helper.h>
@@ -1149,10 +1150,16 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
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
@@ -1399,10 +1406,155 @@ int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 		hw_videoport, clk_get_rate(dispc->vp_clk[hw_videoport]), rate);
 
 	return 0;
 }
 
+int dispc_vp_readout_mode(struct dispc_device *dispc,
+			  u32 hw_videoport,
+			  struct drm_display_mode *mode)
+{
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
+	struct clk *clk = dispc->vp_clk[hw_videoport];
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
+	/*
+	 * Tolerate the same 5% difference that dispc_vp_set_clk_rate()
+	 * accepts when programming the clock.
+	 */
+	refresh = drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance(dev,
+									     clk,
+									     mode->htotal,
+									     mode->vtotal,
+									     50,
+									     &pixel_clock);
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
@@ -1471,10 +1623,97 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
 
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
@@ -2043,10 +2282,21 @@ static const struct {
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
 
@@ -2208,16 +2458,105 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
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
+dma_addr_t dispc_plane_get_dma_addr(struct dispc_device *dispc, u32 hw_plane)
+{
+	u64 lo = dispc_vid_read(dispc, hw_plane, DISPC_VID_BA_0);
+	u64 hi = dispc_vid_read(dispc, hw_plane, DISPC_VID_BA_EXT_0);
+
+	return (hi << 32) | lo;
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
@@ -2371,15 +2710,19 @@ static void dispc_vp_init(struct dispc_device *dispc)
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
@@ -2706,15 +3049,21 @@ static void dispc_vp_set_color_mgmt(struct dispc_device *dispc,
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
index dcd4d3b18ef4..ce48c75b19ad 100644
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
@@ -126,24 +129,44 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
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
+dma_addr_t dispc_plane_get_dma_addr(struct dispc_device *dispc, u32 hw_plane);
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

