Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B68F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B569410F07E;
	Thu, 23 Apr 2026 10:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kr4OUHiy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9068410F07E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EE7506001A;
 Thu, 23 Apr 2026 10:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A234C2BCAF;
 Thu, 23 Apr 2026 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939584;
 bh=G8a4/RxqvYhJ32Zvjnps/GBqi3CLrOwLKFlOaXZzKn4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Kr4OUHiyzSg4Nrwy9BizIshwyhf5p1kSkOadgMi1zLARumWkRVfzi8zAndhW8ZAAE
 xqjSDJQDVBpWKPg4Styx8Qcno7fiinucbKrD+SObjwVfF5VYCEmK0ubU4Yteo27fc3
 EGnWO9AxbrBLAqxhqKlXy0vcOUDTUkJo5y5kp9IErBafAd/8JgQOmE9BmkibbWMs3N
 TITNSSqPPs4x8vvJ1tkjcNJXuZIcDQ3zu12WhJtExoVjFyEsN9akEIDtpRQUjceOHh
 Fot7YZIOTjqh0iB8c0gFu8jFubYJtpHpAye/SfQwK/miWDOz0zvkJMcFFOAdsgAzLD
 xRc5DyawnJsPQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:39 +0200
Subject: [PATCH v2 26/28] drm/tidss: Implement readout support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-26-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=27600; i=mripard@kernel.org;
 h=from:subject:message-id; bh=G8a4/RxqvYhJ32Zvjnps/GBqi3CLrOwLKFlOaXZzKn4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP35u6miJ7U/+IbW9LMIjlskh0bX1iki1ydIzbCVH5
 sxVuL66YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkuzJjw+flLBVn+pb2a+rJ
 rPfvKL533I956e5/kxI6yxaqs64OXPxs91KPXvbI+iK3pSlyuQHKjPVh39fFr1U/K7Hk1v3Ctu1
 Gq2fv7ekrM16Q45LzamvPGe6q3EVVL2cqvD48M3/6jXVh664AAA==
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

With the hardware readout infrastructure now in place in the KMS
framework, we can provide it for the tidss driver.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c    |  93 +++++++++++
 drivers/gpu/drm/tidss/tidss_dispc.c   | 287 ++++++++++++++++++++++++++++------
 drivers/gpu/drm/tidss/tidss_dispc.h   |  14 ++
 drivers/gpu/drm/tidss/tidss_encoder.c |  13 ++
 drivers/gpu/drm/tidss/tidss_kms.c     |   6 +-
 drivers/gpu/drm/tidss/tidss_plane.c   | 154 ++++++++++++++++++
 6 files changed, 518 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 66e3d161c60b..baf90c0f02d1 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -2,12 +2,16 @@
 /*
  * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
+#include <linux/clk.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
@@ -368,10 +372,96 @@ static struct drm_crtc_state *tidss_crtc_create_state(struct drm_crtc *crtc)
 	__drm_atomic_helper_crtc_create_state(crtc, &tstate->base);
 
 	return &tstate->base;
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
+	struct drm_display_mode mode;
+	int ret;
+
+	tidss_runtime_get(tidss);
+
+	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
+		goto out;
+
+	/*
+	 * The display is active, we need to enable our clock to have
+	 * proper reference count.
+	 */
+	WARN_ON(dispc_vp_enable_clk(tidss->dispc, tcrtc->hw_videoport));
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
+	tidss_runtime_get(tidss);
+
+	ret = dispc_vp_enable_clk(tidss->dispc, tcrtc->hw_videoport);
+	if (ret != 0)
+		return;
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
+	int ret = drm_atomic_helper_crtc_compare_state(crtc, p, expected, actual);
+
+	STATE_CHECK_U32_X(ret, p, crtc->name, t_expected, t_actual, bus_format);
+	STATE_CHECK_U32_X(ret, p, crtc->name, t_expected, t_actual, bus_flags);
+
+	return ret;
+}
+
 static struct drm_crtc_state *tidss_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct tidss_crtc_state *state, *current_state;
 
 	if (WARN_ON(!crtc->state))
@@ -404,10 +494,13 @@ static void tidss_crtc_destroy(struct drm_crtc *crtc)
 static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.destroy = tidss_crtc_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_create_state = tidss_crtc_create_state,
+	.atomic_sro_readout_state = tidss_crtc_readout_state,
+	.atomic_sro_install_state = tidss_crtc_install_state,
+	.atomic_sro_compare_state = tidss_crtc_compare_state,
 	.atomic_duplicate_state = tidss_crtc_duplicate_state,
 	.atomic_destroy_state = tidss_crtc_destroy_state,
 	.enable_vblank = tidss_crtc_enable_vblank,
 	.disable_vblank = tidss_crtc_disable_vblank,
 };
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c24c06cae10b..e6caf3c91a62 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1221,10 +1221,16 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
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
@@ -1474,10 +1480,161 @@ int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 		hw_videoport, clk_get_rate(dispc->vp_clk[hw_videoport]), rate);
 
 	return 0;
 }
 
+static unsigned long calc_pixel_clock_hz(unsigned int htotal,
+					 unsigned int vtotal,
+					 unsigned int refresh,
+					 unsigned int freq_div)
+{
+	unsigned long rate = (unsigned long)htotal * vtotal * refresh;
+
+	return (rate * 1000) / freq_div;
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
+u32 dispc_vp_get_bus_flags(struct dispc_device *dispc, u32 hw_videoport)
+{
+	u32 flags = 0;
+	u32 val;
+
+	val = dispc_vp_read(dispc, hw_videoport, DISPC_VP_POL_FREQ);
+	if (FIELD_GET(DISPC_VP_POL_FREQ_IPC_MASK, val))
+		flags |= DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE;
+
+	if (FIELD_GET(DISPC_VP_POL_FREQ_IEO_MASK, val))
+		flags |= DRM_BUS_FLAG_DE_LOW;
+
+	if (FIELD_GET(DISPC_VP_POL_FREQ_RF_MASK, val))
+		flags |= DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE;
+
+	return flags;
+}
+
 /* OVR */
 static void dispc_k2g_ovr_set_plane(struct dispc_device *dispc,
 				    u32 hw_plane, u32 hw_videoport,
 				    u32 x, u32 y, u32 layer)
 {
@@ -2119,10 +2276,21 @@ static const struct {
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
 
@@ -2316,16 +2484,87 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
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
@@ -2913,51 +3152,10 @@ static void dispc_init_errata(struct dispc_device *dispc)
 		dispc->errata.i2000 = true;
 		dev_info(dispc->dev, "WA for erratum i2000: YUV formats disabled\n");
 	}
 }
 
-/*
- * K2G display controller does not support soft reset, so we do a basic manual
- * reset here: make sure the IRQs are masked and VPs are disabled.
- */
-static void dispc_softreset_k2g(struct dispc_device *dispc)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&dispc->tidss->irq_lock, flags);
-	dispc_set_irqenable(dispc, 0);
-	dispc_read_and_clear_irqstatus(dispc);
-	spin_unlock_irqrestore(&dispc->tidss->irq_lock, flags);
-
-	for (unsigned int vp_idx = 0; vp_idx < dispc->feat->num_vps; ++vp_idx)
-		VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0,
-			       DISPC_VP_CONTROL_ENABLE_MASK);
-}
-
-static int dispc_softreset(struct dispc_device *dispc)
-{
-	u32 val;
-	int ret;
-
-	if (dispc->feat->subrev == DISPC_K2G) {
-		dispc_softreset_k2g(dispc);
-		return 0;
-	}
-
-	/* Soft reset */
-	REG_FLD_MOD(dispc, DSS_SYSCONFIG, 1, DSS_SYSCONFIG_SOFTRESET_MASK);
-	/* Wait for reset to complete */
-	ret = readl_poll_timeout(dispc->base_common + DSS_SYSSTATUS,
-				 val, val & 1, 100, 5000);
-	if (ret) {
-		dev_err(dispc->dev, "failed to reset dispc\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int dispc_init_hw(struct dispc_device *dispc)
 {
 	struct device *dev = dispc->dev;
 	int ret;
 
@@ -2971,26 +3169,19 @@ static int dispc_init_hw(struct dispc_device *dispc)
 	if (ret) {
 		dev_err(dev, "Failed to enable DSS fclk\n");
 		goto err_runtime_suspend;
 	}
 
-	ret = dispc_softreset(dispc);
-	if (ret)
-		goto err_clk_disable;
-
 	clk_disable_unprepare(dispc->fclk);
 	ret = pm_runtime_set_suspended(dev);
 	if (ret) {
 		dev_err(dev, "Failed to set DSS PM to suspended\n");
 		return ret;
 	}
 
 	return 0;
 
-err_clk_disable:
-	clk_disable_unprepare(dispc->fclk);
-
 err_runtime_suspend:
 	ret = pm_runtime_set_suspended(dev);
 	if (ret) {
 		dev_err(dev, "Failed to set DSS PM to suspended\n");
 		return ret;
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 739d211d0018..b549b84c4b89 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -115,10 +115,11 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
 			    u32 hw_videoport, u32 layer, bool enable);
 
 void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 		      const struct drm_crtc_state *state);
 void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport);
+bool dispc_vp_is_enabled(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport);
 bool dispc_vp_go_busy(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_go(struct dispc_device *dispc, u32 hw_videoport);
 int dispc_vp_bus_check(struct dispc_device *dispc, u32 hw_videoport,
@@ -130,21 +131,34 @@ int dispc_vp_enable_clk(struct dispc_device *dispc, u32 hw_videoport);
 void dispc_vp_disable_clk(struct dispc_device *dispc, u32 hw_videoport);
 int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 			  unsigned long rate);
 void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
 		    const struct drm_crtc_state *state, bool newmodeset);
+int dispc_vp_readout_mode(struct dispc_device *dispc,
+			  u32 hw_videoport,
+			  struct drm_display_mode *mode);
+u32 dispc_vp_get_bus_flags(struct dispc_device *dispc, u32 hw_videoport);
 
 int dispc_runtime_suspend(struct dispc_device *dispc);
 int dispc_runtime_resume(struct dispc_device *dispc);
 
 int dispc_plane_check(struct dispc_device *dispc, u32 hw_plane,
 		      const struct drm_plane_state *state,
 		      u32 hw_videoport);
 void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 		       const struct drm_plane_state *state,
 		       u32 hw_videoport);
+void dispc_plane_get_picture_size(struct dispc_device *dispc, u32 hw_plane,
+				  unsigned int *width, unsigned int *height);
+void dispc_plane_get_size(struct dispc_device *dispc, u32 hw_plane,
+			  unsigned int *width, unsigned int *height);
+const struct drm_format_info *
+dispc_plane_get_current_format(struct dispc_device *dispc, u32 hw_plane);
+u8 dispc_plane_get_global_alpha(struct dispc_device *dispc, u32 hw_plane);
+u16 dispc_plane_get_blend_mode(struct dispc_device *dispc, u32 hw_plane);
 void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
+bool dispc_plane_is_enabled(struct dispc_device *dispc, u32 hw_plane);
 const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);
 
 int dispc_init(struct tidss_device *tidss);
 void dispc_remove(struct tidss_device *tidss);
 
diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index db467bbcdb77..a20d7826e3cc 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -5,10 +5,11 @@
  */
 
 #include <linux/export.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
@@ -71,16 +72,28 @@ static int tidss_bridge_atomic_check(struct drm_bridge *bridge,
 	}
 
 	return 0;
 }
 
+static int tidss_readout_state(struct drm_bridge *bridge,
+			       struct drm_atomic_sro_state *state,
+			       struct drm_bridge_state *bridge_state,
+			       struct drm_crtc_state *crtc_state,
+			       struct drm_connector_state *conn_state)
+{
+	// TODO: Actually implement it
+	return 0;
+}
+
 static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.attach				= tidss_bridge_attach,
 	.atomic_check			= tidss_bridge_atomic_check,
 	.atomic_reset			= drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
+	.atomic_sro_readout_state	= tidss_readout_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,
 			 u32 encoder_type, u32 possible_crtcs)
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index b4779c09a1bf..ce656c193777 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -4,10 +4,12 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro.h>
+#include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_vblank.h>
@@ -61,11 +63,12 @@ static void tidss_atomic_commit_tail(struct drm_atomic_state *old_state)
 
 	tidss_runtime_put(tidss);
 }
 
 static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
-	.atomic_commit_tail = tidss_atomic_commit_tail,
+	.atomic_commit_tail	= tidss_atomic_commit_tail,
+	.atomic_sro_build_state = drm_atomic_helper_sro_build_state,
 };
 
 static int tidss_atomic_check(struct drm_device *ddev,
 			      struct drm_atomic_state *state)
 {
@@ -118,10 +121,11 @@ static int tidss_atomic_check(struct drm_device *ddev,
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.atomic_check = tidss_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_sro_readout_state = drm_atomic_helper_sro_readout_state,
 };
 
 static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 {
 	struct device *dev = tidss->dev;
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 518498d45765..39939c43ff72 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -4,16 +4,19 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro.h>
+#include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 
 #include "tidss_crtc.h"
 #include "tidss_dispc.h"
 #include "tidss_drv.h"
 #include "tidss_plane.h"
@@ -173,17 +176,168 @@ static const struct drm_plane_helper_funcs tidss_primary_plane_helper_funcs = {
 	.atomic_enable = tidss_plane_atomic_enable,
 	.atomic_disable = tidss_plane_atomic_disable,
 	.get_scanout_buffer = drm_fb_dma_get_scanout_buffer,
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
+	// TODO: Figure out YUV and multiplanar formats
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
+	 * TODO: Figure out what the row increment is about exactly and if we should
+	 * take it into account?
+	 */
+	fb->pitches[0] = fb->width * (drm_format_info_bpp(info, 0) / 8);
+
+	// TODO: Figure out the offsets
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
+static struct drm_crtc *tidss_plane_readout_crtc(struct drm_plane *plane)
+{
+	struct drm_device *dev = plane->dev;
+
+	if (dev->num_crtcs != 1)
+		return ERR_PTR(-EINVAL);
+
+	return list_first_entry(&dev->mode_config.crtc_list, struct drm_crtc, head);
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
+	crtc = tidss_plane_readout_crtc(plane);
+	if (IS_ERR(crtc)) {
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
+	// TODO: Handle crtc_x/crtc_x/src_x/src_y
+	// crtc_x/crtc_y are handled by DISPC_OVR_ATTRIBUTES / OVR1_DSS_ATTRIBUTES
+
+	// TODO: Handle zpos, see DISPC_OVR_ATTRIBUTES / OVR1_DSS_ATTRIBUTES
+
+	plane_state->src.x1 = 0;
+	plane_state->src.x2 = plane_state->src_w;
+	plane_state->src.y1 = 0;
+	plane_state->src.y2 = plane_state->src_h;
+	plane_state->dst.x1 = 0;
+	plane_state->dst.x2 = plane_state->crtc_w;
+	plane_state->dst.y1 = 0;
+	plane_state->dst.y2 = plane_state->crtc_h;
+
+	plane_state->alpha =
+		dispc_plane_get_global_alpha(dispc, tplane->hw_plane_id) << 16;
+	plane_state->pixel_blend_mode =
+		dispc_plane_get_blend_mode(dispc, tplane->hw_plane_id);
+
+	// TODO: If YUV, handle color encoding and range
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
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_destroy,
 	.atomic_create_state = drm_atomic_helper_plane_create_state,
+	.atomic_sro_compare_state = drm_atomic_helper_plane_compare_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	.atomic_sro_readout_state = tidss_plane_atomic_readout_state,
 };
 
 struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
 				       u32 hw_plane_id, u32 plane_type,
 				       u32 crtc_mask, const u32 *formats,

-- 
2.53.0

