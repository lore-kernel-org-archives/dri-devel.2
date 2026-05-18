Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39FCCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2773B10E7F1;
	Mon, 18 May 2026 19:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sojFFrov";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B4210E7F1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133095; bh=qoxUWyo9gdy2DESJxBXzDzmP4EJJbwI5fCPj+AITnn4=;
 b=sojFFrovclrxaKzxuWT/dqjiRIzhrHP+gNgTrv7daZkfgIBaMV7MpxNljXVRu6SxTgS+j8meJ
 5AhSLexPcN2qhGPBViVczgwg1MwRoaVSB+M6ExHOG3O1G7Xl3zSc8USyjVfaAZlbTI22l3Lbb9X
 9OduwZru4JzmLM9UvWW3g8/jdxnISW2u+YUn4FyoNKf2D52+29gW8VoiJfsgjfW9w9zEzZrhwqv
 vtrTIYHm4Q5+pRWRgx8Nxe9ztTiQyMsHwUqTFwsgMqnNivzqatxRprckoaM2o79vao4jHSNtA7D
 TN4IG7DaJ34dUjkWDNlu0D4g99DKmdNQkFdh1m3e2Bhw==
X-Forward-Email-ID: 6a0b6aa1486b4b38b826fa0b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 04/11] drm/rockchip: dw_hdmi: Inline resource lookup into
 bind()
Date: Mon, 18 May 2026 19:37:38 +0000
Message-ID: <20260518193748.2482823-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518193748.2482823-1-jonas@kwiboo.se>
References: <20260518193748.2482823-1-jonas@kwiboo.se>
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

Inline rockchip_hdmi_parse_dt() into dw_hdmi_rockchip_bind() so the
probe path is easier to follow in one place. Also ensure failures in
bind() use dev_err_probe() so probe deferrals and errors are reported
consistently.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 74 +++++++++------------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 12a7c989c4ee..8c26223b70b5 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -196,41 +196,6 @@ static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
 
-static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
-{
-	struct device_node *np = hdmi->dev->of_node;
-	int ret;
-
-	hdmi->regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
-	if (IS_ERR(hdmi->regmap)) {
-		dev_err(hdmi->dev, "Unable to get rockchip,grf\n");
-		return PTR_ERR(hdmi->regmap);
-	}
-
-	hdmi->ref_clk = devm_clk_get_optional_enabled(hdmi->dev, "ref");
-	if (!hdmi->ref_clk)
-		hdmi->ref_clk = devm_clk_get_optional_enabled(hdmi->dev, "vpll");
-
-	if (IS_ERR(hdmi->ref_clk)) {
-		ret = PTR_ERR(hdmi->ref_clk);
-		return dev_err_probe(hdmi->dev, ret, "failed to get reference clock\n");
-	}
-
-	hdmi->grf_clk = devm_clk_get_optional(hdmi->dev, "grf");
-	if (IS_ERR(hdmi->grf_clk)) {
-		ret = PTR_ERR(hdmi->grf_clk);
-		return dev_err_probe(hdmi->dev, ret, "failed to get grf clock\n");
-	}
-
-	ret = devm_regulator_get_enable(hdmi->dev, "avdd-0v9");
-	if (ret)
-		return ret;
-
-	ret = devm_regulator_get_enable(hdmi->dev, "avdd-1v8");
-
-	return ret;
-}
-
 static enum drm_mode_status
 dw_hdmi_rockchip_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 			    const struct drm_display_info *info,
@@ -578,18 +543,39 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	 * the required CRTC is added later.
 	 */
 	if (encoder->possible_crtcs == 0)
-		return -EPROBE_DEFER;
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "failed to find possible crtcs\n");
 
-	ret = rockchip_hdmi_parse_dt(hdmi);
-	if (ret) {
-		return dev_err_probe(dev, ret, "Unable to parse OF data\n");
-	}
+	hdmi->regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(hdmi->regmap))
+		return dev_err_probe(dev, PTR_ERR(hdmi->regmap),
+				     "failed to get rockchip,grf\n");
+
+	hdmi->ref_clk = devm_clk_get_optional_enabled(dev, "ref");
+	if (!hdmi->ref_clk)
+		hdmi->ref_clk = devm_clk_get_optional_enabled(dev, "vpll");
+
+	if (IS_ERR(hdmi->ref_clk))
+		return dev_err_probe(dev, PTR_ERR(hdmi->ref_clk),
+				     "failed to get reference clock\n");
+
+	hdmi->grf_clk = devm_clk_get_optional(dev, "grf");
+	if (IS_ERR(hdmi->grf_clk))
+		return dev_err_probe(dev, PTR_ERR(hdmi->grf_clk),
+				     "failed to get grf clock\n");
+
+	ret = devm_regulator_get_enable(dev, "avdd-0v9");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable avdd-0v9\n");
+
+	ret = devm_regulator_get_enable(dev, "avdd-1v8");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable avdd-1v8\n");
 
 	hdmi->phy = devm_phy_optional_get(dev, "hdmi");
-	if (IS_ERR(hdmi->phy)) {
-		ret = PTR_ERR(hdmi->phy);
-		return dev_err_probe(dev, ret, "failed to get phy\n");
-	}
+	if (IS_ERR(hdmi->phy))
+		return dev_err_probe(dev, PTR_ERR(hdmi->phy),
+				     "failed to get phy\n");
 
 	index = of_property_match_string(np, "phy-names", "hdmi");
 	if (index >= 0) {
-- 
2.54.0

