Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83687C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6891910EAC7;
	Mon, 14 Sep 2026 01:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="XWJkIEwt";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9914810EAC4
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1789349637;
 bh=oc3xUGSKI5U6777EJPjftGTY8M5GzG1dVunokOfN0LQ=;
 h=From:To:Subject:Date:Message-Id;
 b=XWJkIEwtkJr/zOG4Y475KnISJgAq681245LxAfq1ICATBkd3a4o/FbmOy4mmp4NeS
 LhHRtnWk3WmaFMc06sNESAsLJN0suYHxgIqr/zOVXWEcZK+s8NKn1SrHnhSnOzwb1v
 no2udDCG1s6vVJpZN1Mybf/gsAwBg3ojqejsYJvM=
X-QQ-mid: esmtpsz11t1789349635t4449f98f
X-QQ-Originating-IP: FPOdyv5m3kRTIN4TEFBr8eBUwzFPIEzpylGFV/nQn6E=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 14 Sep 2026 09:33:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7744091270244906202
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
Subject: [PATCH v5 2/3] drm/rockchip: dsi: Add dphy_get_timing support for
 multiple PHY types
Date: Mon, 14 Sep 2026 09:33:30 +0800
Message-Id: <20260914013331.108-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260914013331.108-1-kernel@airkyi.com>
References: <20260914013331.108-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NrIFB/k3fFHRzwtvGjldvyaUlwZO8+S6PfXhdA98Jz5Mz5fIg//Is2+a
 fhhZ2wrMd2+mOqt8eWcithWszXriCdKywkxQaoMI4ieqevcCW8xpzg3s7Mcch15W9WW+47r
 yyyLiTSC2kWjNT3ztsCZMms7+aNjHn6ayxi5y5dpfr+jqEoZrk/7oIKXG0bxwtGKsvPCz8C
 jlqBDs3YaTuTTECEuzwIHnqBDZtQ08/2Tx1+blrTJF9Tq66HHQyGHFqmsdismR3wrj8jpCc
 nzeVDIJhP4xiCor7AdXwsHCnWxveL3/UOrrhPLRWMcJpq/CPHqR+2q9A/efL6D3Y9tVxK22
 7s61cBSmAgaHQnUNkheK8h0rIQ6r+BvldCE69M3F1E9LbX8zO+x0Kk8Lu73Rz02semasKNm
 HzaWM7goKAn7oimtuKBWJK6cekN2N3OPt5a/5ghDJM2bTLUpHdJNY7XGsZ4DNd746IRODsJ
 tNDxixVuyjnI63Moj0AFOha2z/CsJxGERp07j6y8CyZStLi0tb3W3//G3VbukzGFvmQi4r/
 nQ6tcb3ho86CsRQn+92RakFRS871eqnNEQxcLFuQsmvp5eh/2n0RgMKOnwcxDSPVnoRw8LH
 5zaO/d18aMGUoBb1BiEAOenoXV3hXv2+ZuFI3c0vP5pBtznDV966rzX3KLCRRXQIESX+sYp
 DPHVMWJqBOwscI3CMnNcyMuSPt3crYBXJAPrupbQ39uFyPsklDUuDMUyMvaYORajYvfmdNt
 GmPFzr7Flf/BpKLh9Yc3fCPMsNtVHOt/CnUfWcNgHBP4cyIpbbz5AHPvTxqSKSoB7UL5QhB
 MKk3g9ZmMhAmEqeN+/7JPuWigYzFJhuCsJ4f/QE1AlZsZ6auKjHC2ZWU2Fwr5Qnc40lukZs
 rnppI0IFkxxhjMzX581VKPRtqpsVrdAV+qxdd5r9MB6AncOF1ggHtsaOAmcKOhtSQr3vVWr
 l088DLpOAfMLcPhtP9KMK0gHKPqSFtAmUjlXBK6pVd2BS59jxRlQPHRxhhroQ+jSoCRwbkr
 1BdFUN6jRinyDzdzEKO7Xsx/8Ad8U//laemRepIDNu3KFrMjN0
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
(no changes since v5)

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
index 6a476c2c1303..feb484f7c03e 100644
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

