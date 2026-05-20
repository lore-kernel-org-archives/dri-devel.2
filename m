Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BAECD5BAF
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B62810F131;
	Wed, 20 May 2026 18:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AYNNuQ0E";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D06D10F119
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779302323;
 bh=JWNAjcEVpG0B81zUFQxCXhj/12VEmQn2O4tSeJ4AcNc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AYNNuQ0E8nucADDE4PR9x/PlanrmoTo9PShX8xw320H3qiGejAib9DtK/Rn3i/Jwn
 EEog+WNY306Jpq9sHHxlN8G46MmHnmzrYb8qnCpYcCI2SuR7Q2K2n5VVKsxkBEbrk3
 rqk77Y3M5Rf81/92wyeP8NZg69SBF3c/0VRqd/TzIVnOrYx5F6HPNLhUWL8k60ZTVC
 XZEhi1Hrkl/0poP5xaRpew1q5/WkhrtruayLrEvZEOZ/gSC7NztpGZ9j+BsvuShUNy
 mikrdFw2He1LWoy1vMvI0zkUzRyYDgNOFsDE7HTkBk9dkeNVvz1Wn8JC0ZUsORdM2S
 0Wo1D5heteKGw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1BC8C17E155B;
 Wed, 20 May 2026 20:38:43 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 20 May 2026 21:38:27 +0300
Subject: [PATCH v6 16/22] drm/rockchip: dw_hdmi_qp: Use local dev variable
 consistently in bind()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dw-hdmi-qp-scramb-v6-16-24b74603b782@collabora.com>
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
In-Reply-To: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.1
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

Replace indirect struct device accesses via hdmi->dev and pdev->dev with
the local dev parameter already available in dw_hdmi_qp_rockchip_bind(),
for consistency and readability.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 33 +++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 296f9a3ba66a..46df5abe31a4 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -475,7 +475,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	struct clk *ref_clk;
 	int ret, irq, i;
 
-	if (!pdev->dev.of_node)
+	if (!dev->of_node)
 		return -ENODEV;
 
 	hdmi = drmm_kzalloc(drm, sizeof(*hdmi), GFP_KERNEL);
@@ -495,7 +495,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(dev, -ENODEV, "Missing platform ctrl ops\n");
 
 	hdmi->ctrl_ops = cfg->ctrl_ops;
-	hdmi->dev = &pdev->dev;
+	hdmi->dev = dev;
 	hdmi->port_id = -ENODEV;
 
 	/* Identify port ID by matching base IO address */
@@ -506,7 +506,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		}
 	}
 	if (hdmi->port_id < 0)
-		return dev_err_probe(hdmi->dev, hdmi->port_id,
+		return dev_err_probe(dev, hdmi->port_id,
 				     "Failed to match HDMI port ID\n");
 
 	plat_data.phy_ops = cfg->phy_ops;
@@ -530,37 +530,36 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	hdmi->regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
 						       "rockchip,grf");
 	if (IS_ERR(hdmi->regmap))
-		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->regmap),
+		return dev_err_probe(dev, PTR_ERR(hdmi->regmap),
 				     "Unable to get rockchip,grf\n");
 
 	hdmi->vo_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
 							  "rockchip,vo-grf");
 	if (IS_ERR(hdmi->vo_regmap))
-		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->vo_regmap),
+		return dev_err_probe(dev, PTR_ERR(hdmi->vo_regmap),
 				     "Unable to get rockchip,vo-grf\n");
 
-	ret = devm_clk_bulk_get_all_enabled(hdmi->dev, &clks);
+	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
 	if (ret < 0)
-		return dev_err_probe(hdmi->dev, ret, "Failed to get clocks\n");
+		return dev_err_probe(dev, ret, "Failed to get clocks\n");
 
-	ref_clk = clk_get(hdmi->dev, "ref");
+	ref_clk = clk_get(dev, "ref");
 	if (IS_ERR(ref_clk))
-		return dev_err_probe(hdmi->dev, PTR_ERR(ref_clk),
+		return dev_err_probe(dev, PTR_ERR(ref_clk),
 				     "Failed to get ref clock\n");
 
 	plat_data.ref_clk_rate = clk_get_rate(ref_clk);
 	clk_put(ref_clk);
 
-	hdmi->frl_enable_gpio = devm_gpiod_get_optional(hdmi->dev, "frl-enable",
+	hdmi->frl_enable_gpio = devm_gpiod_get_optional(dev, "frl-enable",
 							GPIOD_OUT_LOW);
 	if (IS_ERR(hdmi->frl_enable_gpio))
-		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->frl_enable_gpio),
+		return dev_err_probe(dev, PTR_ERR(hdmi->frl_enable_gpio),
 				     "Failed to request FRL enable GPIO\n");
 
 	hdmi->phy = devm_of_phy_get_by_index(dev, dev->of_node, 0);
 	if (IS_ERR(hdmi->phy))
-		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->phy),
-				     "Failed to get phy\n");
+		return dev_err_probe(dev, PTR_ERR(hdmi->phy), "Failed to get phy\n");
 
 	cfg->ctrl_ops->io_init(hdmi);
 
@@ -578,7 +577,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_threaded_irq(hdmi->dev, irq,
+	ret = devm_request_threaded_irq(dev, irq,
 					cfg->ctrl_ops->hardirq_callback,
 					cfg->ctrl_ops->irq_callback,
 					IRQF_SHARED, "dw-hdmi-qp-hpd",
@@ -589,18 +588,18 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_funcs);
 	ret = drmm_encoder_init(drm, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret)
-		return dev_err_probe(hdmi->dev, ret, "Failed to init encoder\n");
+		return dev_err_probe(dev, ret, "Failed to init encoder\n");
 
 	platform_set_drvdata(pdev, hdmi);
 
 	hdmi->hdmi = dw_hdmi_qp_bind(pdev, encoder, &plat_data);
 	if (IS_ERR(hdmi->hdmi))
-		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->hdmi),
+		return dev_err_probe(dev, PTR_ERR(hdmi->hdmi),
 				     "Failed to bind dw-hdmi-qp\n");
 
 	connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(connector))
-		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
+		return dev_err_probe(dev, PTR_ERR(connector),
 				     "Failed to init bridge connector\n");
 
 	return 0;

-- 
2.53.0

