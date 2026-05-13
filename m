Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B429BCD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CD410ECEE;
	Wed, 13 May 2026 07:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iP54AtXF";
	dkim-atps=neutral
Received: from mail-m32103.qiye.163.com (mail-m32103.qiye.163.com
 [220.197.32.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD7110ECED
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 07:49:40 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3e3a94d03;
 Wed, 13 May 2026 15:44:35 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v5 08/10] drm/bridge: analogix_dp: Rename and simplify
 is_rockchip()
Date: Wed, 13 May 2026 15:44:12 +0800
Message-Id: <20260513074414.2053435-9-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513074414.2053435-1-damon.ding@rock-chips.com>
References: <20260513074414.2053435-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e204b6fb503a3kunm7763bb985611e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUNLVkkZGR1JTUNITUlNTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=iP54AtXFqmsXRrhEyW+o0XE5U/ZqLXOfuPvWQor/PQ2k0L+kijYbCEX9zHnGRiARV5R+9ARnTClIbFLrcIeOrd7zpZClAOKrLABcfI4Y0bddot2Zy/VNs3LxcsiwfqICSxs07KcCG1E1dHAuN9K6CSyyskXPGSx4j/c58T6Zl/M=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=LOMeAIx+KSl1dkBA7xVs1jEHQ7IWNjTCWlPoHezWkhE=;
 h=date:mime-version:subject:message-id:from;
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

Rename inline helper is_rockchip() to analogix_dp_is_rockchip()
to follow driver namespace convention consistently across code.

Replace chained equality comparisons with switch-case layout
to improve readability and simplify adding new SoC entries later.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Suggested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- Add Reviewed-by tag.

Changes in v4:
- Modify the commit msg.
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c |  2 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c  | 18 +++++++++---------
 include/drm/bridge/analogix_dp.h               | 11 +++++++++--
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8cf6b73bceac..116de3bd83a3 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -870,7 +870,7 @@ static int analogix_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	struct drm_display_info *di = &conn_state->connector->display_info;
 	u32 mask = BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) | BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
 
-	if (is_rockchip(dp->plat_data->dev_type)) {
+	if (analogix_dp_is_rockchip(dp->plat_data->dev_type)) {
 		if ((di->color_formats & mask)) {
 			DRM_DEBUG_KMS("Swapping display color format from YUV to RGB\n");
 			di->color_formats &= ~mask;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 38fd8d5014d2..6207ded7ffd5 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -72,7 +72,7 @@ void analogix_dp_init_analog_param(struct analogix_dp_device *dp)
 	reg = SEL_24M | TX_DVDD_BIT_1_0625V;
 	writel(reg, dp->reg_base + ANALOGIX_DP_ANALOG_CTL_2);
 
-	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type)) {
+	if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type)) {
 		reg = REF_CLK_24M;
 		if (dp->plat_data->dev_type == RK3288_DP)
 			reg ^= REF_CLK_MASK;
@@ -123,7 +123,7 @@ void analogix_dp_reset(struct analogix_dp_device *dp)
 	analogix_dp_stop_video(dp);
 	analogix_dp_enable_video_mute(dp, 0);
 
-	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+	if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
 		reg = RK_VID_CAP_FUNC_EN_N | RK_VID_FIFO_FUNC_EN_N |
 			SW_FUNC_EN_N;
 	else
@@ -233,7 +233,7 @@ void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable)
 	u32 mask = DP_PLL_PD;
 	u32 pd_addr = ANALOGIX_DP_PLL_CTL;
 
-	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type)) {
+	if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type)) {
 		pd_addr = ANALOGIX_DP_PD;
 		mask = RK_PLL_PD;
 	}
@@ -254,12 +254,12 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 	u32 phy_pd_addr = ANALOGIX_DP_PHY_PD;
 	u32 mask;
 
-	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+	if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
 		phy_pd_addr = ANALOGIX_DP_PD;
 
 	switch (block) {
 	case AUX_BLOCK:
-		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+		if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
 			mask = RK_AUX_PD;
 		else
 			mask = AUX_PD;
@@ -317,7 +317,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 		 * to power off everything instead of DP_PHY_PD in
 		 * Rockchip
 		 */
-		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+		if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
 			mask = DP_INC_BG;
 		else
 			mask = DP_PHY_PD;
@@ -329,7 +329,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 			reg &= ~mask;
 
 		writel(reg, dp->reg_base + phy_pd_addr);
-		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+		if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
 			usleep_range(10, 15);
 		break;
 	case POWER_ALL:
@@ -465,7 +465,7 @@ void analogix_dp_init_aux(struct analogix_dp_device *dp)
 	analogix_dp_reset_aux(dp);
 
 	/* AUX_BIT_PERIOD_EXPECTED_DELAY doesn't apply to Rockchip IP */
-	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
+	if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
 		reg = 0;
 	else
 		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3);
@@ -837,7 +837,7 @@ void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp)
 	u32 reg;
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
-	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type)) {
+	if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type)) {
 		reg &= ~(RK_VID_CAP_FUNC_EN_N | RK_VID_FIFO_FUNC_EN_N);
 	} else {
 		reg &= ~(MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N);
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index 854af692229b..7b670dd769e9 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -19,9 +19,16 @@ enum analogix_dp_devtype {
 	RK3588_EDP,
 };
 
-static inline bool is_rockchip(enum analogix_dp_devtype type)
+static inline bool analogix_dp_is_rockchip(enum analogix_dp_devtype type)
 {
-	return type == RK3288_DP || type == RK3399_EDP || type == RK3588_EDP;
+	switch (type) {
+	case RK3288_DP:
+	case RK3399_EDP:
+	case RK3588_EDP:
+		return true;
+	default:
+		return false;
+	}
 }
 
 struct analogix_dp_plat_data {
-- 
2.34.1

