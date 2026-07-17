Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078BDC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E9B10E6F1;
	Mon, 20 Jul 2026 07:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="IJIC5mEr";
	dkim-atps=neutral
Received: from th8-a.mail-neoserv.si (th8-a.mail-neoserv.si [152.89.234.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D1D10F53F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:26:31 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=bTTWRJf+XMhOqPKQ7BPD4xAkaVeF8baFGXkdpiMxs75/34gUYAKfh03vX9CL3DEmfsjXehAfWr
 zaayOr9GBxhx4Fayht12yBKve3RxgQPlLZcMCgAMXHAztf6oV02fCwtTDkvLvdpLUA224Wd3eG
 63y9BNDmplM3ilfl7CB2zJWdY78J24IzGehTjppXqo+j+0bcp5aY4JUOJXqwe2DaNggQ+S6Esj
 072cET5NZavK23LnL/9+Y8NpYIgEGAmcJsV558Gwpsbt/J4cGnRe/CS/Lr3vvcNJqF7jdTsAn3
 x3gZvUkilwwqBeB95SK3611o4o/bdz1X8lpZYEIS2Tl0/w==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=HJEE6D52PzAAraSZp2z43G1ocPYu02jSX6QRhRsFPig=;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:DKIM-Signature;
 b=hs2AAiHOATnFkggiiGMrk/eFJkEktsvH5I237eWWRtZ0ZLW1Ub69acfEbghxLWVStNlnH6vBWT
 4LMkaCVkpHzE8kDSvYimkGxvwqcd+jiL6FPDpRmVUQAHDmmYvq4Xa/wCEMF6v3NhsAUJcJl4NF
 /3hx+TEZ/f7PrbAwBqcftcCT1x+PQKd8XlSd/7tKGFv/Tpqe05Rgw/fJraC+wp0/nSQVTQwIsU
 kcgpJ9yD5wkxakYpJiZPgwhC+ric5UlWmB1wLePP28OKXZ/KEw85E1j8nnANjpD/iRlTEFlr8C
 fs3ghQJNmsniBk714Vew1BxybQ0PPITO4OGlgECshiSAFw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KkN4fPntNghDZyQYOm91IR8364WzNb2R09AK1tRR9bk=; b=IJIC5mEr2K667BtITzqIgDJJh0
 a+7EUWX1nJx2Kstr1TMD/KGJoFy38FedT3BfpIebboW+xsT9IG09AcpotSYrNIRIpOUYz+EpfjEo0
 NEX9PukBFnwKU/tIvzVundaaHSMwEuOIMALxb+AlaV8DBkkxo4i3cHjdugPsAxzBP7RaWSi/Vh6v4
 nKXzwekAyiL6nCj5xR6+F58YJKVA3VxdrjXgSPY0HrNVAKHxkZRwU9NQgQa8u2ZgulZs3q5j/KnbX
 K+JRTk5UOiosYABHrsY64xFiIkeNgOfUZlhXPZekDovYISspt+NY1QmWONJOvmjQoB13OBlG75tcy
 vYAw1oig==;
Received: from [193.77.36.193] (port=54788 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wkhHJ-00000001fP1-23GD; Fri, 17 Jul 2026 14:02:53 +0200
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
Subject: [PATCH 3/4] drm/rockchip: lvds: add RK3568 support
Date: Fri, 17 Jul 2026 14:00:04 +0200
Message-ID: <20260717120005.2087386-4-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717120005.2087386-1-rok@kanardia.eu>
References: <20260717120005.2087386-1-rok@kanardia.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wkhHJ-00000001fP1-23GD
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
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Between the two, nothing needs programming at probe at all: the GRF is
written entirely from the enable path, so px30_lvds_probe() is left
alone rather than being refactored into a shared phy helper.

[1] https://lore.kernel.org/all/20230119184807.171132-1-a1ba.omarov@gmail.com/

Co-developed-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Rok Markovic <rok@kanardia.eu>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 161 +++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_lvds.h |  10 ++
 2 files changed, 171 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 95fa0a9..f45d04a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -435,6 +435,133 @@ static void px30_lvds_encoder_disable(struct drm_encoder *encoder)
 	drm_panel_unprepare(lvds->panel);
 }
 
+static int rk3568_lvds_poweron(struct rockchip_lvds *lvds)
+{
+	int ret;
+
+	ret = clk_enable(lvds->pclk);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to enable lvds pclk %d\n", ret);
+		return ret;
+	}
+
+	ret = pm_runtime_get_sync(lvds->dev);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to get pm runtime: %d\n", ret);
+		clk_disable(lvds->pclk);
+		return ret;
+	}
+
+	/*
+	 * Enable LVDS mode and the parallel-to-serial converter. These are
+	 * write-masked registers, so a plain write only touches the bits named
+	 * here; there is nothing to preserve and no need to read first.
+	 */
+	return regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
+			    RK3568_LVDS0_MODE_EN(1) |
+			    RK3568_LVDS0_P2S_EN(1));
+}
+
+static void rk3568_lvds_poweroff(struct rockchip_lvds *lvds)
+{
+	regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
+		     RK3568_LVDS0_MODE_EN(0) | RK3568_LVDS0_P2S_EN(0));
+
+	pm_runtime_put(lvds->dev);
+	clk_disable(lvds->pclk);
+}
+
+static int rk3568_lvds_grf_config(struct drm_encoder *encoder,
+				  struct drm_display_mode *mode)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+	struct rockchip_crtc_state *s =
+		to_rockchip_crtc_state(encoder->crtc->state);
+	bool negedge = !!(s->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE);
+
+	if (lvds->output != DISPLAY_OUTPUT_LVDS) {
+		DRM_DEV_ERROR(lvds->dev, "Unsupported display output %d\n",
+			      lvds->output);
+		return -EINVAL;
+	}
+
+	/*
+	 * The LVDS block has its own dclk inversion select, separate from the
+	 * VOP's pin polarity. Both have to agree with what the panel samples on.
+	 */
+	regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
+		     RK3568_LVDS0_DCLK_INV_SEL(negedge));
+
+	/* Set format */
+	return regmap_write(lvds->grf, RK3568_GRF_VO_CON0,
+			    RK3568_LVDS0_SELECT(lvds->format) |
+			    RK3568_LVDS0_MSBSEL(1));
+}
+
+static void rk3568_lvds_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
+	int ret;
+
+	drm_panel_prepare(lvds->panel);
+
+	ret = rk3568_lvds_poweron(lvds);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to power on LVDS: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	ret = rk3568_lvds_grf_config(encoder, mode);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to configure LVDS: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	/*
+	 * Only now bring the D-PHY up. phy_power_on() runs the whole
+	 * inno_dsidphy_lvds_mode_enable() sequence - PLL and bandgap power-on,
+	 * a settle, PLL mode select, then a reset pulse of the serializer and
+	 * the lane enables. All of that has to happen with the block already
+	 * switched to LVDS mode in the GRF (above) and with the VOP's dclk
+	 * running, because the serializer is clocked from dclk and latches its
+	 * state out of that reset.
+	 *
+	 * Doing it at probe instead - as this driver used to - resets and
+	 * enables the serializer against a block that is not in LVDS mode yet
+	 * and has no input clock. Every register then reads back correct while
+	 * the lanes sit at common mode forever. Rockchip's BSP orders it this
+	 * way (GRF writes, then phy_set_mode + phy_power_on).
+	 */
+	ret = phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to set phy mode: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	ret = phy_power_on(lvds->dphy);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to power on phy: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	drm_panel_enable(lvds->panel);
+}
+
+static void rk3568_lvds_encoder_disable(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+
+	drm_panel_disable(lvds->panel);
+	phy_power_off(lvds->dphy);
+	rk3568_lvds_poweroff(lvds);
+	drm_panel_unprepare(lvds->panel);
+}
+
 static const
 struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
 	.enable = rk3288_lvds_encoder_enable,
@@ -449,6 +576,13 @@ struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
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
@@ -512,6 +646,22 @@ static int px30_lvds_probe(struct platform_device *pdev,
 	return phy_power_on(lvds->dphy);
 }
 
+static int rk3568_lvds_probe(struct platform_device *pdev,
+			     struct rockchip_lvds *lvds)
+{
+	/*
+	 * Grab and init the phy, but do NOT power it on here - that is done in
+	 * rk3568_lvds_encoder_enable() once the GRF is in LVDS mode and dclk is
+	 * running. See the comment there. The GRF is not touched at probe
+	 * either: every bit of it is programmed from the enable path.
+	 */
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
@@ -522,6 +672,11 @@ static const struct rockchip_lvds_soc_data px30_lvds_data = {
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
@@ -531,6 +686,10 @@ static const struct of_device_id rockchip_lvds_dt_ids[] = {
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
@@ -601,6 +760,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
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

