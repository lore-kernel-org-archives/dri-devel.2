Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE0CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 22:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7626A10E49F;
	Thu, 30 Apr 2026 22:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AFaGK68m";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB4E10E494
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 22:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777587637;
 bh=R1L8h7yO8kCrxg7Fqj+ePLa5i1JnhfKQFxkjYRGsCuE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AFaGK68mExRA7IJEP/IwEFGjk5M0+xRVHWsBSpnzb0vwqqZrO8OS1IZlgrv0+rBqH
 M318b6lBJt1cUYAhq0zWb0eGH2xb5c5oRO1K1j23Laz+L0pf98ylwEuZQdulpqw406
 J9OhMrzNzMTDy21772A5iC55W9LXFQo41/9Q7oNJX+3JpZhKkJCRnr7ou8s2uVUDXi
 jNxHny4I4cDSdoQaHgfzJnk15OlwykZ7wVERaWsCwK5UO3XTU7q0Bz+u3MSTORKUQj
 NynT/KL+gpd2DsYM2SCcgajnrs2i9rZMwR6XywSl9juI/zobXYvHcpPJV6pAcbmM0j
 nVdDe9IFXWMlA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B93B117E1582;
 Fri,  1 May 2026 00:20:37 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 18D5948003D; Fri, 01 May 2026 00:20:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 01 May 2026 00:20:34 +0200
Subject: [PATCH v2 07/12] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-synopsys-dw-dp-improvements-v2-7-d7e7f6bac77f@collabora.com>
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
In-Reply-To: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6551;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=R1L8h7yO8kCrxg7Fqj+ePLa5i1JnhfKQFxkjYRGsCuE=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnz1bSwkZo9Vp5csSabMBPsI1XpWIvMBTItD
 khlBHbSyDzgf4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJp89W0AAoJENju1/PI
 O/qa8OgP/iSf/cBsQx3BBUzKW//i3KLLBxgYSZNM+Axge7llxxfRSNkTdMZkmDKyLsIbplGToxS
 PR02BKwmaFHqukAxzUnr96jLoQTsuYydJptOQBKeVKWuvrskhv/JwmkABtX5JpMDHQ45L5G0ZwF
 vsKlqLdZhaV9LDhDslHJl0Q4tyTB2k0/3gP8h1t5ooRLU2Z3/3uUW4TgZaEj6F/zJBqe8KvVElr
 yNXBmEwz646X/Dc0t/pGNCsGjC5Q26JodR6dhHoLe9ACMNhXIjIbm3vW+8nu65j58pu8s6Q/9if
 DUGYbkg7t2C8tmZY80eduBYFwzSeVu9DRPfRsOFcjo+fagjGUHAw8ShScUqRod42EJ8hkzBC2/c
 jeMSx01ApRvsSvtFbAmCbF1uTWtf+auGJJ81Xuf4b8xcUlkLkaW+fifetiHVXMi0TgbEAkk42yt
 FOaTQPDxt1R3rMDYkG5vEiwT9a1eL9xF12SGaECKYyKY1rnGj4mrAuRVwxAw/7CHdvSrm+ufLsJ
 Kwcu9buh46ea+WFoP+fpvGHmiKeqOVQUrcjM7xXJSxhsTPW4mYGBQaQ3FGvU+KwCFB1I9sf/uMA
 ptPbFIU4dGamRnBXKqArqdQD+L38/b/MoKff9y/sWu22YT85DhjlGrp9fliEpGkhzlJFcvkkPRg
 DffAVpi1cKLekKV2pNYAqgA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Implement out-of-band hotplug handling, which will be used to receive
external hotplug information from the USB-C state machine. This is
currently handled by the USBDP PHY, which brings quite some trouble
as the register being accessed requires the power-domain from the DP
controller and also requires custom TypeC HPD info parsing in the
USBDP PHY driver.

In contrast to the USBDP PHY this does not just enable the hotplug
signal when a DP AltMode capable adapter is plugged in, but instead
properly detects if a cable is plugged in for things like USB-C to
HDMI adapters.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 126 ++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index 52e956bffb12..5750cf887981 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -8,9 +8,12 @@
 
 #include <linux/component.h>
 #include <linux/media-bus-format.h>
+#include <linux/hw_bitfield.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/videodev2.h>
+#include <linux/regmap.h>
 
 #include <drm/bridge/dw_dp.h>
 #include <drm/drm_atomic_helper.h>
@@ -24,12 +27,54 @@
 
 #include "rockchip_drm_drv.h"
 
+#define ROCKCHIP_MAX_CTRLS 2
+
+#define ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL BIT(10)
+#define ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG BIT(11)
+
+struct rockchip_dw_dp_plat_data {
+	u8 num_ctrls;
+	u32 ctrl_ids[ROCKCHIP_MAX_CTRLS];
+	u32 max_link_rate;
+	u8 pixel_mode;
+	u32 hpd_reg[ROCKCHIP_MAX_CTRLS];
+};
+
 struct rockchip_dw_dp {
 	struct dw_dp *base;
 	struct device *dev;
+	const struct rockchip_dw_dp_plat_data *pdata;
+	struct regmap *vo_grf;
 	struct rockchip_encoder encoder;
+	int id;
+	bool hpd_sel;
+	bool hpd_cfg;
 };
 
+static void dw_dp_rockchip_hpd_sw_sel(void *data, bool force_hpd_from_sw)
+{
+	struct rockchip_dw_dp *dp = data;
+	u32 hpd_reg = dp->pdata->hpd_reg[dp->id];
+
+	dp->hpd_sel = force_hpd_from_sw;
+
+	regmap_write(dp->vo_grf, hpd_reg,
+		     FIELD_PREP_WM16_CONST(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel));
+}
+
+static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
+{
+	struct rockchip_dw_dp *dp = data;
+	u32 hpd_reg = dp->pdata->hpd_reg[dp->id];
+
+	dev_dbg(dp->dev, "Force HPD connected=%s\n", str_yes_no(hpd));
+
+	dp->hpd_cfg = hpd;
+
+	regmap_write(dp->vo_grf, hpd_reg,
+		     FIELD_PREP_WM16_CONST(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));
+}
+
 static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,
 				      struct drm_crtc_state *crtc_state,
 				      struct drm_connector_state *conn_state)
@@ -72,14 +117,49 @@ static const struct drm_encoder_helper_funcs dw_dp_encoder_helper_funcs = {
 	.atomic_check		= dw_dp_encoder_atomic_check,
 };
 
+static struct regmap *dp_dp_rockchip_get_vo_grf(struct rockchip_dw_dp *dp)
+{
+	struct device_node *np = dev_of_node(dp->dev);
+	struct of_phandle_args args;
+	struct regmap *regmap;
+	int ret;
+
+	ret = of_parse_phandle_with_args(np, "phys", "#phy-cells", 0, &args);
+	if (ret)
+		return ERR_PTR(-ENODEV);
+
+	/*
+	 * Limit this workaround to RK3576 and RK3588, new platforms should
+	 * add a VO GRF phandle in the DisplayPort DT node.
+	 */
+	if (!of_device_is_compatible(args.np, "rockchip,rk3576-usbdp-phy") &&
+	    !of_device_is_compatible(args.np, "rockchip,rk3588-usbdp-phy")) {
+		regmap = ERR_PTR(-ENODEV);
+		goto out_put_node;
+	}
+
+	regmap = syscon_regmap_lookup_by_phandle(args.np, "rockchip,vo-grf");
+
+out_put_node:
+	of_node_put(args.np);
+	return regmap;
+}
+
 static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *data)
 {
-	const struct dw_dp_plat_data *plat_data;
+	const struct rockchip_dw_dp_plat_data *plat_data_const;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dp_plat_data *plat_data;
 	struct drm_device *drm_dev = data;
 	struct rockchip_dw_dp *dp;
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;
-	int ret;
+	struct resource *res;
+	int ret, id;
+
+	plat_data = drmm_kzalloc(drm_dev, sizeof(*plat_data), GFP_KERNEL);
+	if (!plat_data)
+		return -ENOMEM;
 
 	dp = drmm_kzalloc(drm_dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
@@ -88,10 +168,38 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
 	dp->dev = dev;
 	dev_set_drvdata(dev, dp);
 
-	plat_data = of_device_get_match_data(dev);
-	if (!plat_data)
+	plat_data_const = device_get_match_data(dev);
+	if (!plat_data_const)
 		return -ENODEV;
 
+	dp->pdata = plat_data_const;
+
+	res = platform_get_mem_or_io(pdev, 0);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+
+	/* find the DisplayPort ID from the io address */
+	dp->id = -ENODEV;
+	for (id = 0; id < plat_data_const->num_ctrls; id++) {
+		if (res->start == plat_data_const->ctrl_ids[id]) {
+			dp->id = id;
+			break;
+		}
+	}
+
+	if (dp->id < 0)
+		return dp->id;
+
+	dp->vo_grf = dp_dp_rockchip_get_vo_grf(dp);
+	if (IS_ERR(dp->vo_grf))
+		return PTR_ERR(dp->vo_grf);
+
+	plat_data->max_link_rate = plat_data_const->max_link_rate;
+	plat_data->pixel_mode = plat_data_const->pixel_mode;
+	plat_data->hpd_sw_sel = dw_dp_rockchip_hpd_sw_sel;
+	plat_data->hpd_sw_cfg = dw_dp_rockchip_hpd_sw_cfg;
+	plat_data->data = dp;
+
 	encoder = &dp->encoder.encoder;
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev, dev->of_node);
 	rockchip_drm_encoder_set_crtc_endpoint_id(&dp->encoder, dev->of_node, 0, 0);
@@ -138,14 +246,20 @@ static void dw_dp_remove(struct platform_device *pdev)
 	component_del(&pdev->dev, &dw_dp_rockchip_component_ops);
 }
 
-static const struct dw_dp_plat_data rk3588_dp_plat_data = {
+static const struct rockchip_dw_dp_plat_data rk3588_dp_plat_data = {
+	.num_ctrls = 2,
+	.ctrl_ids = {0xfde50000, 0xfde60000},
 	.max_link_rate = 810000,
 	.pixel_mode = DW_DP_MP_QUAD_PIXEL,
+	.hpd_reg = {0x0000, 0x0008},
 };
 
-static const struct dw_dp_plat_data rk3576_dp_plat_data = {
+static const struct rockchip_dw_dp_plat_data rk3576_dp_plat_data = {
+	.num_ctrls = 1,
+	.ctrl_ids = {0x27e40000},
 	.max_link_rate = 810000,
 	.pixel_mode = DW_DP_MP_DUAL_PIXEL,
+	.hpd_reg = {0x0000},
 };
 
 static const struct of_device_id dw_dp_of_match[] = {

-- 
2.53.0

