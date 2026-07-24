Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466EBC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CC910F336;
	Fri, 24 Jul 2026 08:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="m4QTcMWc";
	dkim-atps=neutral
Received: from th8-b.mail-neoserv.si (th8-b.mail-neoserv.si [152.89.234.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF7510F336
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:08:54 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=UCCjsyRJYDdriNMixFwUaEpzmbCU9YyVO7gREtrpBLZT3sUG0iyxMCnb1jaCfT9uzYcviRfdbA
 6d//HpM+BGiPgyCI3XpCzUdmVu2jQzMquqF4euIkv/k4Qqkdy9/VRsniK52tz3/yGOzoGMBtRJ
 7Wp3fdhawrTc8+ZENygOctYeDxaCKjQodEvO5dPFRoMKqnJ3kl2wzH6Dxd8Vmw2x3zimeeaIwd
 nKZGV0EH4aIL/HCZhSDqQwF41YE+CiN+DtVc2brQer9djpvsKfzh4i75YtiPDiSAakdW1zr6Me
 vc1nokaJMC1Q/V5K4DtKNgz0tX+JZLUw+ZQrulmj1P6bUA==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=8s30Gl15a21fZ6EQPmkXonXSon09EfWbOHB28lgxk+o=;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:DKIM-Signature;
 b=S8L5ibC/xZ+jaeGqTNMTro30yjfr8VvW9MblwcO7aZ3+aKbYA9ZSm93EpmJP0XLUSjiGZLlJ6k
 BkCxRuABFHtOqgcfGItAJrl2QJ5z8yD58ZxHDRvcKHXaA93sXruF2/F7bLMQ9oggcLTEoh1tXK
 od08FPe0jz+R8a6TJS2LDk3oKMnaIboGfOAbVcUVELgWpZB1P0w3sVB3SsTH06jcLiVdxZ+Ckg
 ZQVPYpGhdR8L/KAE+pIDqYh4LhGS1jx7upKnYwBiZH0VvYoi7SBFmVrjdbEcl0Ep/RX0IO549q
 W86pWo8XZFj4QqjfHDkc5s26IVzexJFzClwN/5zOkkR50A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sHp1ILgtzWw+HPPkq7+0Y4vaMWFk1APoT4yVjj83tpU=; b=m4QTcMWcFEX3NoRv+kd9OsqzW1
 R0XOw1Zh/MkwuC1o88nxBO147rXyJYObA6t0tdC8AsePGcKVJVx8RT0iLyiJWXmHpFXL3v8TllPt/
 0C0SUQ1HMQC0ObBAyBrYBwAvO8FWL68mRrMoy+1X0XlgYJRWnhDhivDor3NIWw7y9zt/A+hmrKmOh
 GrNtbXFjD7T+7Y36l+ifV+VRsjoQ66ky3Dp3PXtYaymCaWaLGnbaOvJ018NGaSWYSsYdCGyqs7X6O
 dqW5WQ1KB4feXWeHh8vMNVqnm5uBXDK6+TwHeDqmCuIk7SNWnVPoqJk0cNENKADmEjS2Qp+kH427n
 ktX27GVA==;
Received: from [193.77.36.193] (port=41890 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wnAxL-0000000AcoX-0f6c; Fri, 24 Jul 2026 10:08:31 +0200
From: Rok Markovic <rok@kanardia.eu>
To: Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alibek Omarov <a1ba.omarov@gmail.com>,
 Rok Markovic <rok@kanardia.eu>
Subject: [PATCH v2 3/4] drm/rockchip: lvds: add RK3568 support
Date: Fri, 24 Jul 2026 10:08:23 +0200
Message-ID: <20260724080824.115260-4-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724080824.115260-1-rok@kanardia.eu>
References: <20260724080824.115260-1-rok@kanardia.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wnAxL-0000000AcoX-0f6c
X-NEOSERV-MailScanner: Found to be clean
X-NEOSERV-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=1.31, required 7, ALL_TRUSTED -1.00, BAYES_50 0.80,
 KAM_DMARC_QUARANTINE 1.50, KAM_DMARC_STATUS 0.01)
X-NEOSERV-MailScanner-SpamScore: s
X-NEOSERV-MailScanner-From: rok@kanardia.eu
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - th8.neoserv.si
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kanardia.eu
X-Get-Message-Sender-Via: th8.neoserv.si: authenticated_id: rok@kanardia.eu
X-Authenticated-Sender: th8.neoserv.si: rok@kanardia.eu
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

The RK3568 LVDS transmitter has no register block of its own. It is
driven entirely through the GRF and re-uses the MIPI DSI0 D-PHY in
PHY_MODE_LVDS, which phy-rockchip-inno-dsidphy already supports.

Based on Alibek Omarov's earlier posting [1], with the changes below.

Power the D-PHY from the encoder enable path rather than from probe.
phy_power_on() runs the phy driver's whole LVDS bring-up: PLL and
bandgap power-on, a settle, PLL mode select, then a reset pulse of the
serializer and the lane enables. None of that is safe at probe time -
the GRF has not yet switched the block to LVDS mode (LVDS0_MODE_EN is
set from rk3568_lvds_poweron(), i.e. the enable path) and the VOP is
not driving dclk. The serializer is clocked from dclk and latches its
state coming out of that reset, so it comes up dead and stays dead.
The failure is silent: every register in the phy, the GRF and the VOP
reads back exactly as on a working system while the lanes sit at
common mode and never toggle.

Program RK3568_LVDS0_DCLK_INV_SEL from the CRTC state's bus_flags so
the panel's declared pixelclk-active is honoured on the LVDS block as
well as on the VOP pin polarity. Both have to agree with the edge the
panel samples on.

Re-assert RK3568_LVDS0_P2S_EN in rk3568_lvds_poweron().
rk3568_lvds_poweroff() clears MODE_EN and P2S_EN together, so setting
P2S_EN once at probe would leave the parallel-to-serial converter off
after the first disable/enable cycle.

Use regmap_write() rather than regmap_update_bits() for the GRF. These
registers are write-masked - the upper 16 bits select which of the
lower 16 a write may change - so there is nothing to preserve and no
reason to read first. Passing a FIELD_PREP_WM16() value as both the
mask and the value of an update_bits() applies the masking twice and
only works by accident.

Take no clock. The block exposes no MMIO of its own, so there is
nothing for the DSI controller's APB clock to reach; the vendor BSP
scans out LVDS with PCLK_DSITX_0's gate off, and so does this driver.

Between the above, nothing needs programming at probe at all: the GRF
is written entirely from the enable path, so px30_lvds_probe() is left
alone rather than being refactored into a shared phy helper.

Track the enabled state so that a .enable() that bails out unwinds
itself and the .disable() that the atomic helpers still call afterwards
becomes a no-op, rather than underflowing the phy power count and the
runtime-PM count of an encoder that never came up.

[1] https://lore.kernel.org/all/20230119184807.171132-1-a1ba.omarov@gmail.com/

Co-developed-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Rok Markovic <rok@kanardia.eu>
Assisted-by: Claude:claude-opus-4-8
---
Changes in v2:
  - Drop the clock. rk3568_lvds_poweron() no longer enables a pclk;
    the block has no MMIO for the DSI APB clock to reach, and the
    vendor BSP scans out with PCLK_DSITX_0 gated off.
  - Merge rk3568_lvds_grf_config() into rk3568_lvds_poweron(): a
    single masked write to VO_CON2 instead of two, and check the
    output type before resuming runtime PM.
  - Balance the enable/disable teardown so a .enable() that fails
    partway does not underflow the phy power and runtime-PM counts
    when the atomic helpers then call .disable().
  - Use pm_runtime_resume_and_get(), matching the rk3288/px30 paths.
  - Drop the in-code comments restating phy_set_mode() internals and
    the write-masked GRF convention; the ordering rationale is in the
    commit message.

 drivers/gpu/drm/rockchip/rockchip_lvds.c | 124 +++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_lvds.h |  10 ++
 2 files changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 95fa0a9..9af21fc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -51,6 +51,7 @@ struct rockchip_lvds {
 	struct regmap *grf;
 	struct clk *pclk;
 	struct phy *dphy;
+	bool enabled;
 	const struct rockchip_lvds_soc_data *soc_data;
 	int output; /* rgb lvds or dual lvds output */
 	int format; /* vesa or jeida format */
@@ -435,6 +436,100 @@ static void px30_lvds_encoder_disable(struct drm_encoder *encoder)
 	drm_panel_unprepare(lvds->panel);
 }
 
+static int rk3568_lvds_poweron(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+	struct rockchip_crtc_state *s =
+		to_rockchip_crtc_state(encoder->crtc->state);
+	bool negedge = !!(s->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE);
+	int ret;
+
+	if (lvds->output != DISPLAY_OUTPUT_LVDS) {
+		DRM_DEV_ERROR(lvds->dev, "Unsupported display output %d\n",
+			      lvds->output);
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_resume_and_get(lvds->dev);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to get pm runtime: %d\n", ret);
+		return ret;
+	}
+
+	regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
+		     RK3568_LVDS0_MODE_EN(1) | RK3568_LVDS0_P2S_EN(1) |
+		     RK3568_LVDS0_DCLK_INV_SEL(negedge));
+	regmap_write(lvds->grf, RK3568_GRF_VO_CON0,
+		     RK3568_LVDS0_SELECT(lvds->format) |
+		     RK3568_LVDS0_MSBSEL(1));
+
+	return 0;
+}
+
+static void rk3568_lvds_poweroff(struct rockchip_lvds *lvds)
+{
+	regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
+		     RK3568_LVDS0_MODE_EN(0) | RK3568_LVDS0_P2S_EN(0));
+
+	pm_runtime_put(lvds->dev);
+}
+
+static void rk3568_lvds_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+	int ret;
+
+	drm_panel_prepare(lvds->panel);
+
+	ret = rk3568_lvds_poweron(encoder);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to power on LVDS: %d\n", ret);
+		goto err_unprepare;
+	}
+
+	/* The GRF must be in LVDS mode with dclk running before the phy. */
+	ret = phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to set phy mode: %d\n", ret);
+		goto err_poweroff;
+	}
+
+	ret = phy_power_on(lvds->dphy);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to power on phy: %d\n", ret);
+		goto err_poweroff;
+	}
+
+	lvds->enabled = true;
+	drm_panel_enable(lvds->panel);
+	return;
+
+err_poweroff:
+	rk3568_lvds_poweroff(lvds);
+err_unprepare:
+	drm_panel_unprepare(lvds->panel);
+}
+
+static void rk3568_lvds_encoder_disable(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+
+	/*
+	 * .enable() cannot report failure, so the atomic helpers call this even
+	 * when it bailed out and already unwound itself. Tear down only what an
+	 * enable that ran to completion left behind, or the phy power count and
+	 * the runtime-PM count of a half-enabled encoder underflow.
+	 */
+	if (!lvds->enabled)
+		return;
+
+	drm_panel_disable(lvds->panel);
+	phy_power_off(lvds->dphy);
+	rk3568_lvds_poweroff(lvds);
+	drm_panel_unprepare(lvds->panel);
+	lvds->enabled = false;
+}
+
 static const
 struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
 	.enable = rk3288_lvds_encoder_enable,
@@ -449,6 +544,13 @@ struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
 	.atomic_check = rockchip_lvds_encoder_atomic_check,
 };
 
+static const
+struct drm_encoder_helper_funcs rk3568_lvds_encoder_helper_funcs = {
+	.enable = rk3568_lvds_encoder_enable,
+	.disable = rk3568_lvds_encoder_disable,
+	.atomic_check = rockchip_lvds_encoder_atomic_check,
+};
+
 static int rk3288_lvds_probe(struct platform_device *pdev,
 			     struct rockchip_lvds *lvds)
 {
@@ -512,6 +614,17 @@ static int px30_lvds_probe(struct platform_device *pdev,
 	return phy_power_on(lvds->dphy);
 }
 
+static int rk3568_lvds_probe(struct platform_device *pdev,
+			     struct rockchip_lvds *lvds)
+{
+	/* The phy is powered on from the encoder enable path, not here. */
+	lvds->dphy = devm_phy_get(&pdev->dev, "dphy");
+	if (IS_ERR(lvds->dphy))
+		return PTR_ERR(lvds->dphy);
+
+	return phy_init(lvds->dphy);
+}
+
 static const struct rockchip_lvds_soc_data rk3288_lvds_data = {
 	.probe = rk3288_lvds_probe,
 	.helper_funcs = &rk3288_lvds_encoder_helper_funcs,
@@ -522,6 +635,11 @@ static const struct rockchip_lvds_soc_data px30_lvds_data = {
 	.helper_funcs = &px30_lvds_encoder_helper_funcs,
 };
 
+static const struct rockchip_lvds_soc_data rk3568_lvds_data = {
+	.probe = rk3568_lvds_probe,
+	.helper_funcs = &rk3568_lvds_encoder_helper_funcs,
+};
+
 static const struct of_device_id rockchip_lvds_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3288-lvds",
@@ -531,6 +649,10 @@ static const struct of_device_id rockchip_lvds_dt_ids[] = {
 		.compatible = "rockchip,px30-lvds",
 		.data = &px30_lvds_data
 	},
+	{
+		.compatible = "rockchip,rk3568-lvds",
+		.data = &rk3568_lvds_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rockchip_lvds_dt_ids);
@@ -601,6 +723,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	encoder = &lvds->encoder.encoder;
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dev->of_node);
+	rockchip_drm_encoder_set_crtc_endpoint_id(&lvds->encoder,
+						  dev->of_node, 0, 0);
 
 	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
index 2d92447..93d3415 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.h
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
@@ -121,4 +121,14 @@
 #define   PX30_LVDS_P2S_EN(val)			FIELD_PREP_WM16(BIT(6), (val))
 #define   PX30_LVDS_VOP_SEL(val)		FIELD_PREP_WM16(BIT(1), (val))
 
+#define RK3568_GRF_VO_CON0			0x0360
+#define   RK3568_LVDS0_SELECT(val)		FIELD_PREP_WM16(GENMASK(5, 4), (val))
+#define   RK3568_LVDS0_MSBSEL(val)		FIELD_PREP_WM16(BIT(3), (val))
+
+#define RK3568_GRF_VO_CON2			0x0368
+#define   RK3568_LVDS0_DCLK_INV_SEL(val)	FIELD_PREP_WM16(BIT(9), (val))
+#define   RK3568_LVDS0_DCLK_DIV2_SEL(val)	FIELD_PREP_WM16(BIT(8), (val))
+#define   RK3568_LVDS0_MODE_EN(val)		FIELD_PREP_WM16(BIT(1), (val))
+#define   RK3568_LVDS0_P2S_EN(val)		FIELD_PREP_WM16(BIT(0), (val))
+
 #endif /* _ROCKCHIP_LVDS_ */
-- 
2.43.0

