Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF60DCD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3631310F80F;
	Wed,  3 Jun 2026 03:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="gvJSlXfD";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC83610F80F
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 03:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1780457751;
 bh=3osqFgBIrekk0aasLKdM5b2OMYUqCjmmQPGJNM+Bp4I=;
 h=From:To:Subject:Date:Message-Id;
 b=gvJSlXfD+PsAsdJHkgL9ttFyxaR0I/ZEEd8dENvWyqZHqAifjIfvX9jeJHNXes5hi
 4IGmFdQcEpA4FMSjD4j809rccid/N2Uux5E2ic7YoxJfcsBwi7gbWHRYqi6PM8of8j
 c1yLNSYF2vXOvVfU6pLxpN/519TxuoyJfIUha5Cs=
X-QQ-mid: zesmtpsz3t1780457749t34a776f7
X-QQ-Originating-IP: CPrpKAdSZ/ltdFjp1z8IAthR2uE4Y8wFlpZ9Tj6q6XI=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 03 Jun 2026 11:35:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2992502231679952474
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
Subject: [PATCH v2 2/3] drm/rockchip: dsi: Add dphy_get_timing support for
 multiple PHY types
Date: Wed,  3 Jun 2026 11:35:31 +0800
Message-Id: <20260603033532.164-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260603033532.164-1-kernel@airkyi.com>
References: <20260603033532.164-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M3vv73qU6a4uywa5T2AnRL6EIQAHH/XOu9LDGz7BOSmPu1DEwe4Uv/X9
 Ja5mH1RQ4kXo+G1fFvwGs+jg+duS9pzC5mfEZ8BtBg08AqTI7QfZ4kNCBoljEHvwI2E9qpt
 /9+Fx6kehX0j1Mj7DD630FMXJe2INVUlcuWu0PsXum8aaguOI+i4e6+m5BavFApuCG0PUU7
 abP6pf/e00vrDUdqDSVJJFMxHHTwEDsXjYw24+PT05JfRD9IhfDmOJvbhiZm73d+EfDYjCy
 Kmwgm8oNuGYat7CZ3UKf7SIZh46kWX/o9F8tBWwTt9njh8y4fa/WlgbbdarLEtCp2BcadDR
 gVk9+OaM8raWFdHlLwRQA9excKKbo+bRZb5EnsIshgIklFQXJT6i3Ulb0VkYrXaxpdn6www
 cBbElRRpY5lIMj9zXDp3IATuK+nNGGzqv12Cyfz/hkU/2oF9Z8sumTnr+DC4VggjaUVwgQp
 Xuky10Qib1F0tigs+X7+ybYN2KdxqlMeyOz9wm7LaMAAy+KocB16F52hN+gEKQkP7Q341nS
 MDNQRl982ypVIlm5VQ6i78bYNQRVRYskTssQmhSJbAqNpIgdSo0N5e06EC9XyziptpeBeMU
 D7Fh9R1Lp7IRJCZNuI2eC9WLeDJapQ+8vInzsquavsPtp34s7D+f1Q83iQ5CRcKBJrezkuC
 w+LKSFp2Bx2oTTFxZqCawYaz6Py37nCFYnietMUg/cW4mgRC6VeDsJh6IEBOfiGriyRlyjY
 qNKMdwnUdi9/RMS75ZGPDfQFRxMqvt6HYfdK56cjijYOVptJKHRHJ8hVEpL6Pxt7uE1qorJ
 xY6izUoUXVUBalUVypexZM+xM8tmsVDQ2coMzCuLo7TUlcVub8RCbQHDv+pEwYWFwD4i0C7
 2JA5mx0M0JVZxyl1CJ/SedpSWtUFGRnE9eqC0C5dnUxaZFmdn5Q65FXZ007w7pS3pBxxMz/
 Ppv5iIpOAe+D1owKYgVqX8ItRoC64miQukdMdPYlj4q5WDwP8AUttRL09Dp77utZm3nztZq
 gNJFA+yEC7VvfxCAa0W3xH0KvPjFXtexpwj3gohQ==
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

Currently, there are generally two types of DPHY for Rockchip. One is
the DPHY used by RK3288/RK3399, whose timing is described by Table A-3
High-Speed Transition Times in the databook. The other is the DPHY used
by PX30 and its successors. If its timing is still described using
RK3288/RK3399, it may not perform correctly on some DSI panel.

Add dphy_get_timing for different D-PHY types to adapt to timing
differences. The configuration details are as follows:

- RK3288/RK3399: Select the corresponding entry from the timing table based
                 on the data rate.
- PX30 and later platforms: Use a fixed timing configuration.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
Changes in v2:
- Add more comment about timing config.

---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 1060abec9f29..e64dfc327891 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -247,6 +247,7 @@ enum {
 	BIASEXTR_127_7,
 };
 
+struct dw_mipi_dsi_rockchip;
 struct rockchip_dw_dsi_chip_data {
 	u32 reg;
 
@@ -262,6 +263,9 @@ struct rockchip_dw_dsi_chip_data {
 	u32 lanecfg2_grf_reg;
 	u32 lanecfg2;
 
+	int (*dphy_get_timing)(struct dw_mipi_dsi_rockchip *dsi, unsigned int lane_mbps,
+			       struct dw_mipi_dsi_dphy_timing *timing);
+
 	int (*dphy_rx_init)(struct phy *phy);
 	int (*dphy_rx_power_on)(struct phy *phy);
 	int (*dphy_rx_power_off)(struct phy *phy);
@@ -721,8 +725,9 @@ static struct hstt hstt_table[] = {
 };
 
 static int
-dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
-			   struct dw_mipi_dsi_dphy_timing *timing)
+dw_mipi_dsi_phy_rk3288_get_timing(struct dw_mipi_dsi_rockchip *dsi,
+				  unsigned int lane_mbps,
+				  struct dw_mipi_dsi_dphy_timing *timing)
 {
 	int i;
 
@@ -738,6 +743,32 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
 	return 0;
 }
 
+static const struct dw_mipi_dsi_dphy_timing dphy_timing_px30 = {
+	.clk_lp2hs = 0x40,
+	.clk_hs2lp = 0x40,
+	.data_lp2hs = 0x10,
+	.data_hs2lp = 0x14,
+};
+
+static int
+dw_mipi_dsi_phy_px30_get_timing(struct dw_mipi_dsi_rockchip *dsi,
+				unsigned int lane_mbps,
+				struct dw_mipi_dsi_dphy_timing *timing)
+{
+	*timing = dphy_timing_px30;
+
+	return 0;
+}
+
+static int
+dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
+			   struct dw_mipi_dsi_dphy_timing *timing)
+{
+	struct dw_mipi_dsi_rockchip *dsi = priv_data;
+
+	return dsi->cdata->dphy_get_timing(dsi, lane_mbps, timing);
+}
+
 static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_rockchip_phy_ops = {
 	.init = dw_mipi_dsi_phy_init,
 	.power_on = dw_mipi_dsi_phy_power_on,
@@ -1506,6 +1537,7 @@ static const struct rockchip_dw_dsi_chip_data px30_chip_data[] = {
 
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1000000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1519,6 +1551,7 @@ static const struct rockchip_dw_dsi_chip_data rk3128_chip_data[] = {
 						RK3128_DSI_FORCETXSTOPMODE), 0),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1000000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1532,6 +1565,7 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_rk3288_get_timing,
 	},
 	{
 		.reg = 0xff964000,
@@ -1541,6 +1575,7 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_rk3288_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1554,6 +1589,7 @@ static const struct rockchip_dw_dsi_chip_data rk3368_chip_data[] = {
 						RK3368_DSI_FORCERXMODE), 0),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1642,6 +1678,7 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 		.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_rk3288_get_timing,
 	},
 	{
 		.reg = 0xff968000,
@@ -1671,6 +1708,7 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 		.dphy_rx_init = rk3399_dphy_tx1rx1_init,
 		.dphy_rx_power_on = rk3399_dphy_tx1rx1_power_on,
 		.dphy_rx_power_off = rk3399_dphy_tx1rx1_power_off,
+		.dphy_get_timing = dw_mipi_dsi_phy_rk3288_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1698,6 +1736,7 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RK3568_DSI0_FORCERXMODE, 0)),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1200000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{
 		.reg = 0xfe070000,
@@ -1708,6 +1747,7 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RK3568_DSI1_FORCERXMODE, 0)),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1200000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1721,6 +1761,7 @@ static const struct rockchip_dw_dsi_chip_data rv1126_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCETXSTOPMODE, 0)),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1000000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
-- 
2.53.0

