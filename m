Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F005CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B9710E8C6;
	Mon, 18 May 2026 19:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ALl3eYpt";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790AF10E8CE
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133728; bh=29OmGxotXpQtQ8RYOjbQxdOif6EH1gz/kJ3dPWnQUVk=;
 b=ALl3eYpt4KxCohT0suC6Tdin1mKut8BaTEFI/Nnn8BgNaxGTGZVuB9HOvZlvxTNvOYa3W4X/A
 FlMVd+eXaZIgAdwB0knB9mejZCDhx6UTITFaynbmwE/EtdYdhDCp7Rzyko5LwITjyjA4SzPBc9R
 1nVH//+xOE4ubKKCsRswCj4brHXfWUlekWV4ttYGLhwbgW8+ZX9YZ9mSWv2cTHoiqtzyd+iQ34A
 yQeYHbzoWYfsH4Ov24iWCJimhR9h2RvFiUs+TUofHhPsIsZoBql+dtAbizDgZymF9G09W/9LYPS
 t/sXOzjgeVHsQYRgMIeswT1weXyE92tDLYp5r54IOsFQ==
X-Forward-Email-ID: 6a0b6d13b74b0ebd362eef32
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org
Subject: [PATCH 10/13] drm/meson: dw-hdmi: Use dev_err_probe() to report errors
Date: Mon, 18 May 2026 19:47:38 +0000
Message-ID: <20260518194744.2483580-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518194744.2483580-1-jonas@kwiboo.se>
References: <20260518194744.2483580-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change to use dev_err_probe() to report bind() errors consistently.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 65 +++++++++++++--------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index d0cf2042d41c..1dd59196ff7f 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -650,10 +650,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	DRM_DEBUG_DRIVER("\n");
 
 	match = of_device_get_match_data(dev);
-	if (!match) {
-		dev_err(dev, "failed to get match data\n");
-		return -ENODEV;
-	}
+	if (!match)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to get match data\n");
 
 	meson_dw_hdmi = devm_kzalloc(dev, sizeof(*meson_dw_hdmi),
 				     GFP_KERNEL);
@@ -667,50 +666,45 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	ret = devm_regulator_get_enable_optional(dev, "hdmi");
 	if (ret < 0 && ret != -ENODEV)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Failed to get/enable hdmi regulator\n");
 
 	meson_dw_hdmi->hdmitx_apb = devm_reset_control_get_exclusive(dev,
 						"hdmitx_apb");
-	if (IS_ERR(meson_dw_hdmi->hdmitx_apb)) {
-		dev_err(dev, "Failed to get hdmitx_apb reset\n");
-		return PTR_ERR(meson_dw_hdmi->hdmitx_apb);
-	}
+	if (IS_ERR(meson_dw_hdmi->hdmitx_apb))
+		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->hdmitx_apb),
+				     "Failed to get hdmitx_apb reset\n");
 
 	meson_dw_hdmi->hdmitx_ctrl = devm_reset_control_get_exclusive(dev,
 						"hdmitx");
-	if (IS_ERR(meson_dw_hdmi->hdmitx_ctrl)) {
-		dev_err(dev, "Failed to get hdmitx reset\n");
-		return PTR_ERR(meson_dw_hdmi->hdmitx_ctrl);
-	}
+	if (IS_ERR(meson_dw_hdmi->hdmitx_ctrl))
+		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->hdmitx_ctrl),
+				     "Failed to get hdmitx reset\n");
 
 	meson_dw_hdmi->hdmitx_phy = devm_reset_control_get_exclusive(dev,
 						"hdmitx_phy");
-	if (IS_ERR(meson_dw_hdmi->hdmitx_phy)) {
-		dev_err(dev, "Failed to get hdmitx_phy reset\n");
-		return PTR_ERR(meson_dw_hdmi->hdmitx_phy);
-	}
+	if (IS_ERR(meson_dw_hdmi->hdmitx_phy))
+		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->hdmitx_phy),
+				     "Failed to get hdmitx_phy reset\n");
 
 	meson_dw_hdmi->hdmitx = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson_dw_hdmi->hdmitx))
 		return PTR_ERR(meson_dw_hdmi->hdmitx);
 
 	clk = devm_clk_get_enabled(dev, "isfr");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "Unable to get isfr pclk\n");
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get isfr pclk\n");
 
 	clk = devm_clk_get_enabled(dev, "iahb");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "Unable to get iahb pclk\n");
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get iahb pclk\n");
 
 	clk = devm_clk_get_enabled(dev, "venci");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "Unable to get venci pclk\n");
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get venci pclk\n");
 
 	dw_plat_data->regm = devm_regmap_init(dev, NULL, meson_dw_hdmi,
 					      &meson_dw_hdmi_regmap_config);
@@ -724,10 +718,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_top_irq,
 					dw_hdmi_top_thread_irq, IRQF_SHARED,
 					"dw_hdmi_top_irq", meson_dw_hdmi);
-	if (ret) {
-		dev_err(dev, "Failed to request hdmi top irq\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to request hdmi top irq\n");
 
 	meson_dw_hdmi_init(meson_dw_hdmi);
 
@@ -752,14 +745,16 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	meson_dw_hdmi->hdmi = dw_hdmi_probe(pdev, &meson_dw_hdmi->dw_plat_data);
 	if (IS_ERR(meson_dw_hdmi->hdmi)) {
 		devm_free_irq(dev, irq, meson_dw_hdmi);
-		return PTR_ERR(meson_dw_hdmi->hdmi);
+		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->hdmi),
+				     "Failed to probe dw-hdmi bridge\n");
 	}
 
 	meson_dw_hdmi->bridge = of_drm_find_and_get_bridge(dev->of_node);
 	if (!meson_dw_hdmi->bridge) {
 		devm_free_irq(dev, irq, meson_dw_hdmi);
 		dw_hdmi_remove(meson_dw_hdmi->hdmi);
-		return -ENODEV;
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to find dw-hdmi bridge\n");
 	}
 
 	DRM_DEBUG_DRIVER("HDMI controller initialized\n");
-- 
2.54.0

