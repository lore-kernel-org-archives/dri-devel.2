Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA210C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7D610E5F2;
	Mon, 10 Aug 2026 03:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="dRS99o+g";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B69310E5F1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1786333313;
 bh=C5tR/xZjU5Pjmrm51dDg8L9m7GNYl37L5TgCsOvaI4k=;
 h=From:To:Subject:Date:Message-Id;
 b=dRS99o+g8vD/obsNw4R7aYNWO/i+ydeI7v2OqDhYougwFRwkLmfTGTfuJdpC5rapJ
 hIIzYHX9iMdgl3luZ0k+JYR1cnyRSi11Js+M4bwP7fvmmrBM1XjWzguLgRz9SdkJTo
 NgX9evnZSfb0Ko9BPdqrf71fgMp3hSBUjiedVgas=
X-QQ-mid: esmtpgz11t1786333311t415aa3d0
X-QQ-Originating-IP: I7zcKriExk/3nyhItJweEb4li2giQHM0Lm/5oQJxjNQ=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 10 Aug 2026 11:41:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18107200135916440458
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v3 1/3] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
Date: Mon, 10 Aug 2026 11:41:37 +0800
Message-Id: <20260810034139.148-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260810034139.148-1-kernel@airkyi.com>
References: <20260810034139.148-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N5QhsOwzP0INdtBiy8KQCyGjOjliEqi8EZ8vyRnROOE7KlwmIMaQsqYJ
 RHnQi9Rude2L87GLcE7Bg62oXpHsUWFmDSVepM0WJu85CYrbECwIvEvZIuiqC0PTwfrNoba
 5wOBvqFHhOMoSHo/qLDwcvarJBtO4KYM7H04HZAHldt3iIK61Mr4RM33la+1BTScyB1PL/b
 HrZOf6wc9jpM/f6EX5PFTl3RRAdFBZbDzrfrPGT+IFSI0V7MwdZuelDant5zfesfKEr08R+
 36S4BkyllifJvilxY7KBTygBXn2cGZQd3o2xEc2VZOypAo1Ov4kf2T2+yOHlWEXehs4L47B
 rvt79G0MpwLsqWzYxRlJBxKiJ/6R6eWWxdK5iOB/QwdtQcMDMP6Tz4/h2vF0hXdqXsXMl/C
 RpB/yckWAjoug43VjPcjecsq5h49xtXHOL1VibzmSL3+Ey/zGL41o0nsZKeWpJcl2coyrWb
 jSY2cP3ehju7QSkHJX1QF2xhl22iauslRvhNK9R1ctSLpToPEGYN1uQw+QcpCoIQzeThaln
 jr6Rj3bS4jMCeBESAFOtUB+u8/ydu21OV5DXkT1ABFndEr5uUvmmyfAZK/Wgd2YxBCWehjq
 G0bvHHgrDFzpV/V6CvVjn2vzkhgbY3qB/z4adlY8C1x8zkAWWUZm0UNYynTcSk4TJrVtcEm
 fQEMFsjqL+RNYG48SL4xPKB2dYzSjJU/AjzBTGULMzkluj7w4vsnNt+ogtOTTrAK6EtJ8rG
 LQGWpdlmJ+d5Uwjihs1WLt/I1XlhRI1i9yOvgXaR6hD1pOL+BxsnFZTkPr59zUXrQu6YeTw
 mFGZIxBwLcIKmb4iBqXMTgdKbJoscfBpJbKsua/0hU2xUNYnDLKaMtSPjhar/nlraOrgc+9
 Vw1WmSBz7UmqLHLd6sTf0XCu2lzIFvaYLNgLnHcU2OwHgeP9/ayPgo9fRR2UITMEPItJwY4
 z38ZYde4/gwnG8iA1udbFunGS4W5MFa7JSqI1LJqtmS2Mkpvr4SW2U4xgCXTsp7h75H9Z28
 sY9IPS/Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
platforms.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
Changes in v3:
- Rebase to Linux v7.2

Changes in v2:
- Fix the unit conversion for max_mbps.
- Split the lane rate calculation into a separate patch.

---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..1060abec9f29 100644
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
 
+	max_mbps = dsi->cdata->max_bit_rate_per_lane / USEC_PER_SEC;
 	dsi->format = format;
 	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 	if (bpp < 0) {
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
2.53.0

