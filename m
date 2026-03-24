Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D0EF532F6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E04910E609;
	Tue, 24 Mar 2026 08:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="ucT86IgG";
	dkim-atps=neutral
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C86310E634
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1774342725;
 bh=DcslK22x8uIMZ4NZ9SMHxwNosHLFSTJar8KPj2od3LE=;
 h=From:To:Subject:Date:Message-Id;
 b=ucT86IgGibp7JHaUfMzWAmt5hUWm5ATcMPlHbxK8xsx6tpDXwhEEKu3gyYuvDMyG2
 5OvjycUJuaOiIfMks+GQAU7kU7RihcmFKi55ZrPH74Jls1Fkz6iMqwU5k0l5npx6e1
 mS2lu2yvlbwAuRLf6bR9EV7dIy6p+Ctpd7CgmIHo=
X-QQ-mid: zesmtpsz6t1774342723t5074b2cf
X-QQ-Originating-IP: 3BW32MPpKNZOC0WSTPe8fmwINEAek+lW4Gae60RRaDM=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 24 Mar 2026 16:58:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15759213222158354030
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Guochun Huang <hero.huang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 1/2] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
Date: Tue, 24 Mar 2026 16:58:37 +0800
Message-Id: <20260324085838.90-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OOmGXKi1H5WLXlv145egPUjD8SX2G/w1oKRn/r5DuurtQt521rRnnnU9
 LFJboQmwprBbkOW1fbFY/6KovaIfLBRPop/cVoKTv6KhZfaS2garMbenMdO2b2yq1gCThF9
 1X4NOSY8CtS2gZDH77es2zxkfD7yGrUApB3x1bCbRAGXbeN2Mokhzp0mMDWM+Gs/kXKogbZ
 SXzdiRX/rF6wXQIur2H/yyxEJg3XnzTrlcEIV8vIWDLSMlqHPxtIvJhHvXlsgG24UOPFEM+
 1mx/wiKronc9ZJ+zeO4M9Rc5AbJdloIR4lD3e2MdD/cTTiTMSnAEybRNKbUffxdyjfyCrwm
 J/AGRZ6Bf8k5eZXUaqX9hs5cWAdSf3/7koepZjDTdqzJjx+Ix8UCP8XLfQELO0Qen4cblpd
 7Jl0JKPfUYSuoeEa2RE2649P8N0vzJSGZlWXDcra0crpowJOdyBWGtcfm7iXPNA5SsBE6E7
 VR+6DDiqNVL2IpQiOfL6eFuwXjLf9pyff8ob/TtY+BzQd6ytsSZ1V8iqucmHPNmTnCWJcSu
 4MFn4wJZmi59OyW6wkWHRsJTLf5/UHrEnn60MJVx5augOXCGR0ympY4v2IZ8N9S5q0WHD5J
 5Hsk0JMtXpX9Lc62QuCEJcTFg+F0QrIyzCBUhYnfmax19IDh8n0ZHXEOoAm5+wI40sa2iow
 sBh8mEa1l40yXo5Peh3mD7jgvUrCA8DbXjesuub1BuvsGCDk5QMILQKvv0DkO3YvywT5IWQ
 4LLh5Mlo0RnGUJcGEzyNCBsTXKWxGmHLcoQvpXFkF7DQ7t8u3ViUWYIy90kgJCir5DwjZsK
 HnUa2WtjVFiDU4bjavsLltsSKb3+NuSeJsAjgcjGqOOas/gIdWf7fS1danjQGIciZ0WaqDO
 Pc4NVhISyXHdjtSmU14r/f/Im4UP1Lg3OE15Dha8kaOQAoTQVfLyDUc29Mv/kxDq5jna/f3
 cuZCQ8urIirgIVUWQzBp8sEVxkPbJL0Z3KsFZboutaQy9ssQ2jd6nY3nZ
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Different chips have varying support for the maximum bit rate per lane.

Add calculation for the maximum per lane bit rate for various chip
platforms, and relax the bandwidth margin requirements.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..d3bacfae174e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -268,6 +268,7 @@ struct rockchip_dw_dsi_chip_data {
 
 	unsigned int flags;
 	unsigned int max_data_lanes;
+	unsigned long max_bit_rate_per_lane;
 };
 
 struct dw_mipi_dsi_rockchip {
@@ -565,7 +566,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 	int bpp;
 	unsigned long mpclk, tmp;
 	unsigned int target_mbps = 1000;
-	unsigned int max_mbps = dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
+	unsigned int max_mbps;
 	unsigned long best_freq = 0;
 	unsigned long fvco_min, fvco_max, fin, fout;
 	unsigned int min_prediv, max_prediv;
@@ -573,6 +574,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 	unsigned long _fbdiv, best_fbdiv;
 	unsigned long min_delta = ULONG_MAX;
 
+	max_mbps = dsi->cdata->max_bit_rate_per_lane;
 	dsi->format = format;
 	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 	if (bpp < 0) {
@@ -584,8 +586,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
 	if (mpclk) {
-		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
-		tmp = mpclk * (bpp / lanes) * 10 / 8;
+		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
+		tmp = mpclk * (bpp / lanes) * 10 / 9;
 		if (tmp < max_mbps)
 			target_mbps = tmp;
 		else
@@ -595,7 +597,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 	/* for external phy only a the mipi_dphy_config is necessary */
 	if (dsi->phy) {
-		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
+		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 9,
 						 bpp, lanes,
 						 &dsi->phy_opts.mipi_dphy);
 		dsi->lane_mbps = target_mbps;
@@ -1503,6 +1505,7 @@ static const struct rockchip_dw_dsi_chip_data px30_chip_data[] = {
 						PX30_DSI_FORCETXSTOPMODE), 0),
 
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1000000000UL,
 	},
 	{ /* sentinel */ }
 };
@@ -1515,6 +1518,7 @@ static const struct rockchip_dw_dsi_chip_data rk3128_chip_data[] = {
 						RK3128_DSI_FORCERXMODE |
 						RK3128_DSI_FORCETXSTOPMODE), 0),
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1000000000UL,
 	},
 	{ /* sentinel */ }
 };
@@ -1527,6 +1531,7 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 		.lcdsel_lit = FIELD_PREP_WM16_CONST(RK3288_DSI0_LCDC_SEL, 1),
 
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1500000000UL,
 	},
 	{
 		.reg = 0xff964000,
@@ -1535,6 +1540,7 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 		.lcdsel_lit = FIELD_PREP_WM16_CONST(RK3288_DSI1_LCDC_SEL, 1),
 
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1500000000UL,
 	},
 	{ /* sentinel */ }
 };
@@ -1547,6 +1553,7 @@ static const struct rockchip_dw_dsi_chip_data rk3368_chip_data[] = {
 						RK3368_DSI_FORCETXSTOPMODE |
 						RK3368_DSI_FORCERXMODE), 0),
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1500000000UL,
 	},
 	{ /* sentinel */ }
 };
@@ -1634,6 +1641,7 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 
 		.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1500000000UL,
 	},
 	{
 		.reg = 0xff968000,
@@ -1658,6 +1666,7 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 
 		.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1500000000UL,
 
 		.dphy_rx_init = rk3399_dphy_tx1rx1_init,
 		.dphy_rx_power_on = rk3399_dphy_tx1rx1_power_on,
@@ -1674,6 +1683,7 @@ static const struct rockchip_dw_dsi_chip_data rk3506_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCERXMODE, 0) |
 			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCETXSTOPMODE, 0)),
 		.max_data_lanes = 2,
+		.max_bit_rate_per_lane = 1500000000UL,
 	},
 	{ /* sentinel */ }
 };
@@ -1687,6 +1697,7 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RK3568_DSI0_TURNDISABLE, 0) |
 			     FIELD_PREP_WM16_CONST(RK3568_DSI0_FORCERXMODE, 0)),
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1200000000UL,
 	},
 	{
 		.reg = 0xfe070000,
@@ -1696,6 +1707,7 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RK3568_DSI1_TURNDISABLE, 0) |
 			     FIELD_PREP_WM16_CONST(RK3568_DSI1_FORCERXMODE, 0)),
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1200000000UL,
 	},
 	{ /* sentinel */ }
 };
@@ -1708,6 +1720,7 @@ static const struct rockchip_dw_dsi_chip_data rv1126_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCERXMODE, 0) |
 			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCETXSTOPMODE, 0)),
 		.max_data_lanes = 4,
+		.max_bit_rate_per_lane = 1000000000UL,
 	},
 	{ /* sentinel */ }
 };
-- 
2.51.1

