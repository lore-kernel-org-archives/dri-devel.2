Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ED2C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA35010E3E3;
	Wed, 12 Aug 2026 07:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="pGU7+GLg";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0827C10E3E3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1786519821;
 bh=hdB9ZEs4Q4RuH4r3lqNZ9fprVS/0wKCGmZXX0HdNJ5g=;
 h=From:To:Subject:Date:Message-Id;
 b=pGU7+GLg82pVlmH4xrKuzeDapMJTA502UFkJLJZ/RUpKqEZR+VIX7MvEc1KxNpPKr
 yEx8qw2Ynh2JG1csJhvpB2pNNEiD8rFvZqERQabdaHX3welN1r+hYTedoB9kfECie3
 8Ql50K0hT1/KjIBDkGFBr2Yg2LUlsu29rfMInkvI=
X-QQ-mid: esmtpsz11t1786519819t61391391
X-QQ-Originating-IP: NFMnSnCm7ZV5Cgwrkeb8TpF9vAHc9hb9n2Q5jHP7+L4=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Aug 2026 15:30:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8596351136751817460
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
Subject: [PATCH v4 2/3] drm/rockchip: dsi: Add dphy_get_timing support for
 multiple PHY types
Date: Wed, 12 Aug 2026 15:30:01 +0800
Message-Id: <20260812073002.328-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260812073002.328-1-kernel@airkyi.com>
References: <20260812073002.328-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OaeBaVXaJN9DeH333aEmqn5jUWk9qqp9VW6WDXiJy5bgCFy/R8gvtA2U
 Q7ipVoSjaSzkCMnROTr2WKJqVKtU5ESFzELVJSxhyktK5U6mKVNfXCzaErsJ3yH1DfIwpDI
 voco3//0G3NOjGjyg1UmE7DAoKr5z25LzVoLReE6CYfednLA8FTKl5WOdMpti2sa7ngZxjl
 i8CdbnjqqjWIxt+bFonOiK+fz+NTsmK5ChVXNjoXl4gg/TLEYdBOPKMA0LXdVsjoZgPpV34
 QM21dfLCAzjIohmEgfz7xmwqNHs3pRT/hSTM2mYKAdnWEKQA2vw2RQWW+cKUA5gVcUWpkDF
 dtrfXObyVtJJg+8M3OkotUJ9EIokQkWdK3LGg4z1nDR7JKoqHTQdxmYFAhNMJ8VDJJ/Eeuv
 n7hHt9wYcW5OWOqgEUJJ68hL7TT9Z4cqh+uwREqLFPoOph2oFcsuIlYaSBFyVweRr1DMqWe
 dE0J0cOGM7a1cBmReEqtBbXU0AOFAYNJ2adwtZLUFtamw4FWwzaN0LBIl+Hw8l94e8pX2Zm
 oGT3VDEuscqJDXkbNW9ekOJq2hde8iO5PZG0/UwVJzK1gxBlrWqRsJsOVepsk7o2/Poeq5x
 nHX/MnuXcIVFBpO73FGft4qNYvCJgMqxvTdd79yuCG0+AOA1tvg/Jcl2+7IphTg3QgaGzA3
 jj/vQ8l1V8JGDTUpXnbYBe605MJp5XzKhjJjc0C9hTX+9y57r/v2Z3DZ70ntShtgNr8WDn7
 WtjsrH7kHfjzNGP1XpQvlKCd92XPjzEXLaFFktwI9O66pxz4VhEERJ/e/4Koy9LoZJGXioU
 SMZ6l51bL+hchvknhTha1bQhm6z1P7jj9rGMjYOHc21a7kZGDwe4Cqv8HI5Uj00mDr/mS/+
 q8zK0czvkR7NOZdAekZ2xmbS4MYYxVDJzVtagSd2kahsrDCYlDuliGf66cty8APhlt/dvlm
 R1w0SVdfmMjFMAtVRb8tyI520jLQDPYZtXZgoSZ2AfSOwmSLWfGqYj0C2N1yuSlaMvT0xyP
 gru6QW8+FVPG0nbdA3QsF7D6FebR7PwK2LGCTCm2p+zYg4ZKTc
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Changes in v4:
- Add missing RK3506 timing and the fallback path for get_timing
  (sashiko).

Changes in v3:
- Rebase to Linux v7.2

Changes in v2:
- Add more comment about timing config.

---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 49 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 1060abec9f29..d183c82ef9bc 100644
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
 
@@ -738,6 +743,35 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
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
+	if (dsi->cdata->dphy_get_timing)
+		return dsi->cdata->dphy_get_timing(dsi, lane_mbps, timing);
+
+	return dw_mipi_dsi_phy_px30_get_timing(dsi, lane_mbps, timing);
+}
+
 static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_rockchip_phy_ops = {
 	.init = dw_mipi_dsi_phy_init,
 	.power_on = dw_mipi_dsi_phy_power_on,
@@ -1506,6 +1540,7 @@ static const struct rockchip_dw_dsi_chip_data px30_chip_data[] = {
 
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1000000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1519,6 +1554,7 @@ static const struct rockchip_dw_dsi_chip_data rk3128_chip_data[] = {
 						RK3128_DSI_FORCETXSTOPMODE), 0),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1000000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1532,6 +1568,7 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_rk3288_get_timing,
 	},
 	{
 		.reg = 0xff964000,
@@ -1541,6 +1578,7 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_rk3288_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1554,6 +1592,7 @@ static const struct rockchip_dw_dsi_chip_data rk3368_chip_data[] = {
 						RK3368_DSI_FORCERXMODE), 0),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1642,6 +1681,7 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 		.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_rk3288_get_timing,
 	},
 	{
 		.reg = 0xff968000,
@@ -1671,6 +1711,7 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 		.dphy_rx_init = rk3399_dphy_tx1rx1_init,
 		.dphy_rx_power_on = rk3399_dphy_tx1rx1_power_on,
 		.dphy_rx_power_off = rk3399_dphy_tx1rx1_power_off,
+		.dphy_get_timing = dw_mipi_dsi_phy_rk3288_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1684,6 +1725,7 @@ static const struct rockchip_dw_dsi_chip_data rk3506_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCETXSTOPMODE, 0)),
 		.max_data_lanes = 2,
 		.max_bit_rate_per_lane = 1500000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1698,6 +1740,7 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RK3568_DSI0_FORCERXMODE, 0)),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1200000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{
 		.reg = 0xfe070000,
@@ -1708,6 +1751,7 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RK3568_DSI1_FORCERXMODE, 0)),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1200000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
@@ -1721,6 +1765,7 @@ static const struct rockchip_dw_dsi_chip_data rv1126_chip_data[] = {
 			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCETXSTOPMODE, 0)),
 		.max_data_lanes = 4,
 		.max_bit_rate_per_lane = 1000000000UL,
+		.dphy_get_timing = dw_mipi_dsi_phy_px30_get_timing,
 	},
 	{ /* sentinel */ }
 };
-- 
2.53.0

