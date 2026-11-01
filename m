Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3622606A33F
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjbIIX0e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D9B10EA4D;
	Sun,  1 Nov 2026 14:30:40 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3DA10EA4D
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 14:30:35 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so16483295e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793543433; x=1794148233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VsDtHDQeo9yaAAGX90Le6/Q23q/oZg9HWR3FqkNaI5Q=;
 b=sjbIIX0e8mpb6X0AlSC4sKN/UIBrdceLERRZZRe/6YGIHPkGTdbjs/Aea3R5C+44i5
 2PvXW4wASPdJFP1BKOTCUE8C1N52EGkC/Ab9h4S01ziSdbgm7UAH78VHq3Kk1JJU5Fmw
 fm2NUf0Yw+P48HSvAchlQCv6gZ1iKebrQgRL1B1IwcxVbbcqKcozvjNH/GV0LOSrCdxk
 nOMcmMrTpXn884hw427Io1uZmsPpMYwN9+8OSQKeXuRM0Se0PHk91TT9Ajbck9TIPg4x
 JGpRNegB0kC71gPX1hNfepKoL8xhIwEHhxNJHg/G3DNuvoYDjX627QjRVnmeSNbEgrcq
 Wsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793543433; x=1794148233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VsDtHDQeo9yaAAGX90Le6/Q23q/oZg9HWR3FqkNaI5Q=;
 b=IPHvydHXWNUwqyKPpY2G/Ixu6T2oMYky3gl5bFKDA4RaiXX+RZ3gKVvgpxkxlWpRUc
 eANFzPiBgxZEUSPHWRgR7rtzciUURDWfFCIdhZOepUZC/q8usXzJfm8NHi7mjDjbH18H
 CvRrBTR6ZVJaZdDi8PlzhAj41+3g/O+q1eTvIv71pXjcmzbgIXmxnJa23EieVSeKtarv
 hYQQcd6TqjpqA2RqmTIBTe2HtEK6I9hHsjVyuv2bzLFAOKBtGyIRDQUxnyb/WOy/7bF3
 ZguDgksh3DmSj9evNbuNA6xR97GcXYfGVMXm34bKRtDECgJ4IRj4el6IT1sUNjPd3ALX
 iBQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCHjuI5mPawAH+LhfZWGUQAxhzAc+LHoTtAuPa3YLEgtZn3GxGEo/jLnGJmYPyLTShnA+oZgB0fiU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLmIGyYo0wn4cYFh1cwyef8ohv5PALP4bFOP4fIam0/v/1z21KP
 IQ+9QzCBDD0WA51F5TY4WL08kx5JV7FqCsBYfelp4Lk5J1QDMQoTRzag
X-Gm-Gg: AYBFou2H+UwR7KhJXw7JgHEnrh+FxszyM0/Ow5KKC+dnMTr8k9wr6FwQp6/J1qvkKke
 FTu+2Mczu0fkCE0O/4XOAVrzy6nCcBmR0St3sgBobA7gzhhzZI32kmVoErJgzRiimeRX9RdYWLB
 gSHBH97KykbJQVrIgI7JJW7eq556a8QNdu8jgWaN+x/0sVqXHbOo/26zMvl1AdmOjuXp8wDyWo/
 7Gj6Tq2gvJipt4I3ug33HILAwfTODTbU4YznNSpOneJx9mP2SFzPqzCHvf9Ai/AEMl0QhHTqXHN
 SIbWdz6Dov514l5rMaJAS40Mh305g+f7Ba9lRdTVj5QyjH/mi7Nn8t0ZRRKUYmvYqmV4EgDgPZF
 4CcMdMkcLVzoc7pXVhmoLN51PeO0hkNQIRKIZUma4zpvj9HQg6qwUWXK6Oro1FqkXPx92lLE9wW
 avTQ5a5wo4077eCjs37FbVPl3IfTR1V5Qd1XPQWJShcOLHOfbyqcyliMeWvTUcO+bspx2KHCzAv
 sUzSMx9fgsz3i0qRYAioZIULZlk064GwUYH1P7xfS6AYH+N02SwGftN7ponBUabGZDvOZvRLa3N
 vriNoyGNaM+wocIkzuJYnhKq2RutWI9O7YHNWFe8uwdm3vEo8h6LAE55AuefHHWsAKW4yMQ0Y1C
 Qd0rGkGInxP+f+4KswpYIHkO93tiowu/EksZ8h2IuIekQ1A==
X-Received: by 2002:a05:600c:a30a:b0:4ac:b0b2:fa12 with SMTP id
 5b1f17b1804b1-4acb0b2fac0mr117941165e9.1.1793543433238; 
 Sun, 01 Nov 2026 06:30:33 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:849f:a468:4121:a85])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8011csm16223169f8f.31.2026.11.01.06.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 06:30:32 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Liu Ying <victor.liu@nxp.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: [PATCH v2] drm/bridge: dw-mipi-dsi: let the glue compute the
 hcomponent lbcc
Date: Sun,  1 Nov 2026 15:30:31 +0100
Message-ID: <20261101143031.880389-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit ac87d23694f4 ("drm/bridge: synopsys: dw-mipi-dsi: Use pixel clock
rate to calculate lbcc") counts HSA, HBP and HLINE from the pixel clock,
which is only right when the lanes run at the pixel bandwidth (pixel
clock * bpp / lanes). Commit 93e82bb4de01 ("drm/bridge: synopsys:
dw-mipi-dsi: Fix hcomponent lbcc for burst mode") went back to the lane
rate for burst mode, where the lanes are faster on purpose.

The Rockchip glue runs the lanes faster in every mode: at 1.25 times
(bpp / lanes, rounded down) times the pixel clock, or 1000 Mbps, above
the pixel bandwidth. In non-burst video mode the line programmed in lane
byte clocks is then shorter than the DPI line. On the GPD XD (RK3288,
ILI9881C panel, 4 lanes at 448 Mbps, 59.5 MHz pixel clock, htotal 747)
HLINE was 561 lane byte clocks (10.0 us) for a 12.55 us line, and the
panel shows garbage as soon as a client page-flips.

The glue picks the lane rate, so let it compute the lane byte clock
cycles too: add an optional get_hcomponent_lbcc() callback to
dw_mipi_dsi_plat_data, and implement it in the Rockchip glue from the
lane rate. Glues without it (i.MX93, Meson, STM) keep the current
computation, and so does Rockchip dual-DSI, which this hasn't been
tested on. On the GPD XD this gives HLINE 704, HSA 13 and HBP 4, and
the picture is stable.

Fixes: ac87d23694f4 ("drm/bridge: synopsys: dw-mipi-dsi: Use pixel clock rate to calculate lbcc")
Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
Changes in v2:
- Drop the 1/8 threshold: the glue now computes the lane byte clock
  cycles through a new optional get_hcomponent_lbcc() callback in
  dw_mipi_dsi_plat_data, and the Rockchip glue implements it from its
  lane rate (Chaoyi Chen). This also covers RGB666 packed on 4 lanes,
  which the 1/8 slack missed (Sashiko).
- Rockchip dual-DSI keeps the core computation: the lane rate would
  change the timing of the dual-DSI Gru Scarlet panels (innolux,p097pfg,
  non-burst, 4+4 lanes), which I can't test.
- Commit message: the Rockchip glue doesn't follow a panel rate in
  mainline, and the GPD XD numbers are now those of the rate it picks
  (448 Mbps).
- v1: https://lore.kernel.org/all/20261025142639.3454322-1-romain.tisserand@gmail.com/

Notes for reviewers (not for the changelog):
- The callback returns 0 to let the core compute the value, so a glue
  can implement it for some configurations only (Rockchip: single DSI).
- Testing: built with W=1 for arm (multi_v7) and arm64 (defconfig),
  DRM_DW_MIPI_DSI=y and =m, together with the Meson and i.MX93 glues, no
  warnings. Tested live on the GPD XD (RK3288, ILI9881C, non-burst with
  sync pulses, 4 lanes at 448 Mbps) on 6.18.54 with this exact change:
  without it HLINE 561, HSA 10, HBP 3 and garbage on screen as soon as
  the UI page-flips; with it HLINE 704, HSA 13, HBP 4 and a clean, stable
  picture in the UI and in games. Not tested on i.MX93, Meson, STM or
  Rockchip dual-DSI hardware; their computation is unchanged.
- Tool disclosure: this patch was prepared with Claude Opus 5.5
  (Anthropic) as a coding assistant, in an interactive session where I
  asked it to bring up the GPD XD display and then to prepare the fix
  for upstream. It located the cause from the DSI host registers, went
  through the history of the lbcc computation (ac87d23694f4,
  93e82bb4de01) and the lane rates of the other dw-mipi-dsi glues, and
  drafted the code change and the changelog; v2 follows the reviews of
  Chaoyi Chen and Sashiko. I reviewed and understand both, and tested
  the patch on the GPD XD as described above.

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 39 ++++++++++++-------
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 23 +++++++++++
 include/drm/bridge/dw_mipi_dsi.h              | 10 +++++
 3 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 22d1b8cbe1..b7578265ca 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -780,28 +780,37 @@ static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct dw_mipi_dsi *dsi,
 					   const struct drm_display_mode *mode,
 					   u32 hcomponent)
 {
+	const struct dw_mipi_dsi_plat_data *pdata = dsi->plat_data;
 	u32 frac, lbcc, minimum_lbcc;
 	int bpp;
 
-	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
-		/* lbcc based on lane_mbps */
-		lbcc = hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
-	} else {
-		/* lbcc based on pixel clock rate */
-		bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
-		if (bpp < 0) {
-			dev_err(dsi->dev, "failed to get bpp\n");
-			return 0;
+	lbcc = 0;
+	if (pdata->get_hcomponent_lbcc)
+		lbcc = pdata->get_hcomponent_lbcc(pdata->priv_data, mode,
+						  hcomponent);
+
+	if (!lbcc) {
+		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+			/* lbcc based on lane_mbps */
+			lbcc = hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
+		} else {
+			/* lbcc based on pixel clock rate */
+			bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+			if (bpp < 0) {
+				dev_err(dsi->dev, "failed to get bpp\n");
+				return 0;
+			}
+
+			lbcc = div_u64((u64)hcomponent * mode->clock * bpp,
+				       dsi->lanes * 8);
 		}
 
-		lbcc = div_u64((u64)hcomponent * mode->clock * bpp, dsi->lanes * 8);
+		frac = lbcc % mode->clock;
+		lbcc = lbcc / mode->clock;
+		if (frac)
+			lbcc++;
 	}
 
-	frac = lbcc % mode->clock;
-	lbcc = lbcc / mode->clock;
-	if (frac)
-		lbcc++;
-
 	minimum_lbcc = dw_mipi_dsi_get_minimum_lbcc(dsi);
 
 	if (lbcc < minimum_lbcc)
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index aab3353945..57ebb3a59f 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -771,6 +771,28 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
 	return dw_mipi_dsi_phy_px30_get_timing(dsi, lane_mbps, timing);
 }
 
+/*
+ * dw_mipi_dsi_get_lane_mbps() runs the lanes faster than the pixel bandwidth
+ * in every video mode, not only in burst mode: count the horizontal timings
+ * from the lane rate, or the line is shorter than the DPI line.
+ *
+ * Dual-DSI keeps the core computation (return 0): the lane rate would change
+ * the timing of the dual-DSI panels in use, and that hasn't been tested.
+ */
+static u32
+dw_mipi_dsi_rockchip_get_hcomponent_lbcc(void *priv_data,
+					 const struct drm_display_mode *mode,
+					 u32 hcomponent)
+{
+	struct dw_mipi_dsi_rockchip *dsi = priv_data;
+
+	if (dsi->slave || dsi->is_slave)
+		return 0;
+
+	return DIV_ROUND_UP_ULL((u64)hcomponent * dsi->lane_mbps *
+				MSEC_PER_SEC / 8, mode->clock);
+}
+
 static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_rockchip_phy_ops = {
 	.init = dw_mipi_dsi_phy_init,
 	.power_on = dw_mipi_dsi_phy_power_on,
@@ -1494,6 +1516,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 	dsi->dev = dev;
 	dsi->pdata.base = dsi->base;
 	dsi->pdata.max_data_lanes = dsi->cdata->max_data_lanes;
+	dsi->pdata.get_hcomponent_lbcc = dw_mipi_dsi_rockchip_get_hcomponent_lbcc;
 	dsi->pdata.phy_ops = &dw_mipi_dsi_rockchip_phy_ops;
 	dsi->pdata.host_ops = &dw_mipi_dsi_rockchip_host_ops;
 	dsi->pdata.priv_data = dsi;
diff --git a/include/drm/bridge/dw_mipi_dsi.h b/include/drm/bridge/dw_mipi_dsi.h
index 65d5e68065..6580c16d80 100644
--- a/include/drm/bridge/dw_mipi_dsi.h
+++ b/include/drm/bridge/dw_mipi_dsi.h
@@ -62,6 +62,16 @@ struct dw_mipi_dsi_plat_data {
 	bool (*mode_fixup)(void *priv_data, const struct drm_display_mode *mode,
 			   struct drm_display_mode *adjusted_mode);
 
+	/*
+	 * Optional: number of lane byte clock cycles for @hcomponent pixels
+	 * of @mode, for glues whose lanes don't run at the pixel bandwidth.
+	 * Without it, or when it returns 0, the core uses the lane rate in
+	 * burst mode and the pixel clock otherwise.
+	 */
+	u32 (*get_hcomponent_lbcc)(void *priv_data,
+				   const struct drm_display_mode *mode,
+				   u32 hcomponent);
+
 	u32 *(*get_input_bus_fmts)(void *priv_data,
 				   struct drm_bridge *bridge,
 				   struct drm_bridge_state *bridge_state,

base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
-- 
2.43.0

