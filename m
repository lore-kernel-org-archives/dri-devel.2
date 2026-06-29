Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5AAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8FD10E76C;
	Mon, 29 Jun 2026 08:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OL3GntTp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133E810E738
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:18:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BB7660125;
 Mon, 29 Jun 2026 08:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1F71F000E9;
 Mon, 29 Jun 2026 08:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721102;
 bh=+gTvhPL0rxbZRq3HFlG3zPkrF98GaAi045vRxv1DceA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OL3GntTp8A3ozqWHv49oplscO5yXPDACKWxB5ep5rfSbC8KOExanwFhmYBixtve9l
 C7ul9SonN1VLABRsqqdJ9VNuxUFnyLcFc94TX16flbTmhZ7St+ialIBDW1JJS2SDzn
 4BT+atE/xvc08qujaM8HVb9ecGw2DCVvjZVCXlMe06sBRHU8m+c7ncKJwP/Fyj20H6
 JytuK2Ior4PXXDS783snkhvn/KV/Q/sncImZGAFlPoSZ5OuKzD4I++y+XxBo4al4Rz
 3Ta+bFx+W2I5bFAzM2bcEJNy9lNUfHIv7dZfWuddzCMSigauPx+HavZ9nreS1hq8d0
 IsA344N8k3Smw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:24 +0200
Subject: [PATCH v4 26/30] drm/tidss: dispc: Improve mode checking logs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-26-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4777; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jyYNz3ktaTNngAFRhg/DloYqro+3DNiIeelnzXMBfRc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWtwHO6o2farkO/ck7ZjKwl9anuJHyqK+rbLNbOETY
 L6fnSnQMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZi483YcNa0+qb08f07wtdE
 qZzd3sLWa5dQ2B+93c7GYapLtuai91rnK9ZFcAgImXfkzw3j213B2DCned/tTV6rUk7Y7LMrPnv
 A9c+Xw5KbVb3n/Jl10GS6nNGktSplGh+8OOdW9W2ckXwsORcA
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

The dispc_vp_mode_valid() function checks whether a mode can be handled
by the display controller.

There's a whole bunch of criteria, and it's not clear when a rejection
happens why it did. Add logs on each rejection criterion to make it
clearer.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 45 +++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 58d5eb033bdb..4cda3824864b 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1302,10 +1302,12 @@ unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_rate)
 }
 
 static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
 			     unsigned long clock)
 {
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
 	unsigned long round_clock;
 
 	/*
 	 * For VP's with external clocking, clock operations must be
 	 * delegated to respective driver, so we skip the check here.
@@ -1316,51 +1318,65 @@ static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
 	round_clock = clk_round_rate(dispc->vp_clk[hw_videoport], clock);
 	/*
 	 * To keep the check consistent with dispc_vp_set_clk_rate(), we
 	 * use the same 5% check here.
 	 */
-	if (dispc_pclk_diff(clock, round_clock) > 5)
+	if (dispc_pclk_diff(clock, round_clock) > 5) {
+		drm_dbg(dev, "Mode pixel clock below hardware minimum pixel clock.");
 		return -EINVAL;
+	}
 
 	return 0;
 }
 
 enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 u32 hw_videoport,
 					 const struct drm_display_mode *mode)
 {
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
 	enum dispc_vp_bus_type bus_type;
 
 	bus_type = dispc->feat->vp_bus_type[hw_videoport];
 
-	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF))
+	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF)) {
+		drm_dbg(dev, "Invalid bus type.");
 		return MODE_BAD;
+	}
 
-	if (mode->hdisplay > 4096)
+	if (mode->hdisplay > 4096) {
+		drm_dbg(dev, "Number of active horizontal pixels above hardware limits.");
 		return MODE_BAD;
+	}
 
-	if (mode->vdisplay > 4096)
+	if (mode->vdisplay > 4096) {
+		drm_dbg(dev, "Number of active vertical lines above hardware limits.");
 		return MODE_BAD;
+	}
 
 	if (check_pixel_clock(dispc, hw_videoport, mode->clock * 1000))
 		return MODE_CLOCK_RANGE;
 
 	/* TODO: add interlace support */
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
+		drm_dbg(dev, "Interlace modes not supported.");
 		return MODE_NO_INTERLACE;
+	}
 
 	/*
 	 * Enforce the output width is divisible by 2. Actually this
 	 * is only needed in following cases:
 	 * - YUV output selected (BT656, BT1120)
 	 * - Dithering enabled
 	 * - TDM with TDMCycleFormat == 3
 	 * But for simplicity we enforce that always.
 	 */
-	if ((mode->hdisplay % 2) != 0)
+	if ((mode->hdisplay % 2) != 0) {
+		drm_dbg(dev, "Number of active horizontal pixels must be even.");
 		return MODE_BAD_HVALUE;
+	}
 
 	hfp = mode->hsync_start - mode->hdisplay;
 	hsw = mode->hsync_end - mode->hsync_start;
 	hbp = mode->htotal - mode->hsync_end;
 
@@ -1368,29 +1384,40 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 	vsw = mode->vsync_end - mode->vsync_start;
 	vbp = mode->vtotal - mode->vsync_end;
 
 	if (hsw < 1 || hsw > 256 ||
 	    hfp < 1 || hfp > 4096 ||
-	    hbp < 1 || hbp > 4096)
+	    hbp < 1 || hbp > 4096) {
+		drm_dbg(dev,
+			"Horizontal blanking or sync outside of hardware limits (fp: %u, sw: %u, bp: %u).",
+			hfp, hsw, hbp);
 		return MODE_BAD_HVALUE;
+	}
 
 	if (vsw < 1 || vsw > 256 ||
-	    vfp > 4095 || vbp > 4095)
+	    vfp > 4095 || vbp > 4095) {
+		drm_dbg(dev,
+			"Vertical blanking or sync outside of hardware limits (fp: %u, sw: %u, bp: %u).",
+			vfp, vsw, vbp);
 		return MODE_BAD_VVALUE;
+	}
 
 	if (dispc->memory_bandwidth_limit) {
 		const unsigned int bpp = 4;
 		u64 bandwidth;
 
 		bandwidth = 1000 * mode->clock;
 		bandwidth = bandwidth * mode->hdisplay * mode->vdisplay * bpp;
 		bandwidth = div_u64(bandwidth, mode->htotal * mode->vtotal);
 
-		if (dispc->memory_bandwidth_limit < bandwidth)
+		if (dispc->memory_bandwidth_limit < bandwidth) {
+			drm_dbg(dev, "Required memory bandwidth outside of hardware limits.");
 			return MODE_BAD;
+		}
 	}
 
+	drm_dbg(dev, "Mode is valid.");
 	return MODE_OK;
 }
 
 int dispc_vp_enable_clk(struct dispc_device *dispc, u32 hw_videoport)
 {

-- 
2.54.0

