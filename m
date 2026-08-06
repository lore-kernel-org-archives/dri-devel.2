Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92211C5AD44
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B3A10F245;
	Thu,  6 Aug 2026 17:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="frpr5RoL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2F510E368
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786035746;
 bh=8AzTw6Q7BgLg8qygPB9irNWnzZO5bZlDFBZ2JLmp7kk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=frpr5RoLTdZ48juveo8BvEgkXDQ88GcjAnJTLp+ha4DWbrtk2wBlnSykEgsPnGp6L
 Ve7007hwaZci32CIHKDlWUEV1xOikA1DNgK5JIJ4fVwd7OlTOJRKIxpAtHAZySiv7B
 99kh6CdgLhmtP/8xB/SuUHAYVSFieaspNONXevpcp4Iw+ml9wdTmYA8WSnB33mawbP
 QzBenYTUW4Z1Ly3jWIaZiFkVtfCNoZzNsiBFr1FdqqLFN/tXWlYxKNve0+g+amnvBO
 OuOvuFrtbxlENFcNYxpzc24MGflh832YZ7iekBxQm+qDCe1OmiKHrzcDN1ZnAQHSo5
 YC7rg61dQ8yYA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BBBEB17E121D;
 Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0AD3348004E; Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 19:02:19 +0200
Subject: [PATCH v11 13/21] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-13-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6435;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=8AzTw6Q7BgLg8qygPB9irNWnzZO5bZlDFBZ2JLmp7kk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viCYPQTnASeQnQg6C6MedD/ncl7bqKxUg
 BhCyIgIOhrd6IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qaE1oQAJHN3RjzdL1PAV3pwLfdr9Bmy+nvpSHiWUEUfy3Ze3oMO+cLgdFZuSFKD8nw/d8MD/Q
 g4GVE6PJ/PBgkEMiLJQGf6U2OO5toMqnnBR65F+nVnABT5CQHjh4snWEy0kEfBJBK4kmTIeOOkW
 NswUAB+RNOnVCBNaGFNgkEQSk2d/aGwP1TwXYJcIUCA91/SOjWfh67MvvUf+sNd6gz/kSm0ftoh
 0bcGt+/F1R3YZRQJeZOIs4gTXNr3UPtd2b70Gn2n6XXeVnS9vaxLP4R3ILfXuIKUFV32nxPeJqi
 wfiniWMe234QOv8HCve4Vh7debVAirJTAiCXyFYh6jIVC+HUJq5weLcEABTJosRYTGiqBzwa51L
 b3aKxP2Jw8423EPwkbLnrZn+cbrsfQh+VCTfp6HiMSobAS+pTiyui4VVIyaxcZfSzOvnkkKXBiE
 mkE47oeB0bli+4G+SNQF7AUVjL67CA8sKOIs9VidPDxsB38zsqkAjy1hb4VnC2ZEwhRRbsnoZbQ
 K9DIpqxPrXJfGvHFOt6x3raI9PXIRjkLKzPdbRJZoC4uKOsMaSq9lbaqQsKfRxdiWt7ilapF/dd
 lwRVwh45msRyHzvOAhnrL+qMUZ/D0lCZNnHb/5jatLNcat5KFhqw7R+Li78TNguvy+IpNJ55Hvl
 JQCMxd7+PzF0xi6tAtAopig==
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
controller. Thus this patch prevents massive SError problems once
runtime PM is implemented (and enabled) in the DP driver. Apart from
that it avoids custom TypeC HPD info parsing in the USBDP PHY driver.

In contrast to the USBDP PHY this does not just enable the hotplug
signal when a DP AltMode capable adapter is plugged in, but instead
properly detects if a cable is plugged in for things like USB-C to
HDMI adapters.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 118 ++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index 38e8fe75718e..9e49e7dbf420 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -7,9 +7,12 @@
  */
 
 #include <linux/component.h>
+#include <linux/hw_bitfield.h>
 #include <linux/media-bus-format.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/videodev2.h>
 
 #include <drm/bridge/dw_dp.h>
@@ -23,12 +26,48 @@
 
 #include "rockchip_drm_drv.h"
 
+#define ROCKCHIP_MAX_CTRLS 2
+
+#define ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL BIT(10)
+#define ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG BIT(11)
+
+struct rockchip_dw_dp_plat_data {
+	u8 num_ctrls;
+	u64 ctrl_ids[ROCKCHIP_MAX_CTRLS];
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
 	struct rockchip_encoder *encoder;
+	int id;
 };
 
+static void dw_dp_rockchip_hpd_sw_sel(void *data, bool force_hpd_from_sw)
+{
+	struct rockchip_dw_dp *dp = data;
+	u32 hpd_reg = dp->pdata->hpd_reg[dp->id];
+
+	regmap_write(dp->vo_grf, hpd_reg,
+		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, force_hpd_from_sw));
+}
+
+static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
+{
+	struct rockchip_dw_dp *dp = data;
+	u32 hpd_reg = dp->pdata->hpd_reg[dp->id];
+
+	dev_dbg(dp->dev, "Force HPD connected=%s\n", str_yes_no(hpd));
+
+	regmap_write(dp->vo_grf, hpd_reg,
+		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, hpd));
+}
+
 static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,
 				      struct drm_crtc_state *crtc_state,
 				      struct drm_connector_state *conn_state)
@@ -71,6 +110,35 @@ static const struct drm_encoder_helper_funcs dw_dp_encoder_helper_funcs = {
 	.atomic_check		= dw_dp_encoder_atomic_check,
 };
 
+static struct regmap *dw_dp_rockchip_get_vo_grf(struct rockchip_dw_dp *dp)
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
+	 * Limit this workaround to RK3576 and RK3588, potential future platforms
+	 * reusing the driver should just add a VO GRF phandle in the DisplayPort
+	 * controller DT node.
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
 	struct rockchip_dw_dp *dp = dev_get_drvdata(dev);
@@ -121,19 +189,53 @@ static const struct component_ops dw_dp_rockchip_component_ops = {
 
 static int dw_dp_rockchip_probe(struct platform_device *pdev)
 {
-	const struct dw_dp_plat_data *plat_data;
+	const struct rockchip_dw_dp_plat_data *plat_data_const;
+	struct dw_dp_plat_data *plat_data;
 	struct device *dev = &pdev->dev;
 	struct rockchip_dw_dp *dp;
+	struct resource *res;
+	int id;
 
-	plat_data = of_device_get_match_data(dev);
-	if (!plat_data)
+	plat_data_const = device_get_match_data(dev);
+	if (!plat_data_const)
 		return -ENODEV;
 
+	plat_data = devm_kzalloc(dev, sizeof(*plat_data), GFP_KERNEL);
+	if (!plat_data)
+		return -ENOMEM;
+
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, dp);
 	dp->dev = dev;
+	dp->pdata = plat_data_const;
+
+	res = platform_get_mem_or_io(pdev, 0);
+	if (!res)
+		return -ENODEV;
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
+	dp->vo_grf = dw_dp_rockchip_get_vo_grf(dp);
+	if (IS_ERR(dp->vo_grf))
+		return PTR_ERR(dp->vo_grf);
+
+	plat_data->max_link_rate = plat_data_const->max_link_rate;
+	plat_data->pixel_mode = plat_data_const->pixel_mode;
+	plat_data->hpd_sw_sel = dw_dp_rockchip_hpd_sw_sel;
+	plat_data->hpd_sw_cfg = dw_dp_rockchip_hpd_sw_cfg;
+	plat_data->data = dp;
 
 	dp->base = dw_dp_probe(pdev, plat_data);
 	if (IS_ERR(dp->base))
@@ -147,14 +249,20 @@ static void dw_dp_rockchip_remove(struct platform_device *pdev)
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

