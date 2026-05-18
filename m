Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510C6CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE27310E8D3;
	Mon, 18 May 2026 19:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="z+JhPWub";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4457010E8C9
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133725; bh=l5OMj0CSdajzATG6j/dCDhDtBgJ3gMytB+btoMqUqdQ=;
 b=z+JhPWubjtdgakU14oDpwL6VLZfWi7+Cp5FKUfYtzrJbbGNo4fGb6RIxw9OF69MHHXhNn9KvN
 IwZSg1+aOGD28I8NNQzECWkyvcggbmhzU4MubI2es+UNlQ/cneLHU/ILV73oA2GfRCpKlaNfef0
 73DlKRXgYWvUXmumicrEKD1mCzJ0jZrZgVqmtk/Hoo3zc9G/sxFYKS+9o7TmDGy3eLd2dNkMfQK
 I9DTL1UzqIYUYHtgZ3RxVvmB3zqMAo3UtSN3fd4ezGJ/8W2eclYwoYI2eDpPPfEyri718lFq89D
 sty7PPYhYV8dCR2UaGeaALrkmBBkgzEIPhgdM8wc64rA==
X-Forward-Email-ID: 6a0b6d0fb74b0ebd362eef17
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
Subject: [PATCH 09/13] drm/meson: dw-hdmi: Use devm_clk_get_enabled() helper
Date: Mon, 18 May 2026 19:47:37 +0000
Message-ID: <20260518194744.2483580-10-jonas@kwiboo.se>
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

Change to use the devm_clk_get_enabled() helper instead of using an
open-coded variant.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 48 +++++++++------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index fcd2426af9fc..d0cf2042d41c 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -634,29 +634,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 
 }
 
-static void meson_disable_clk(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
-static int meson_enable_clk(struct device *dev, char *name)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = devm_clk_get(dev, name);
-	if (IS_ERR(clk)) {
-		dev_err(dev, "Unable to get %s pclk\n", name);
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (!ret)
-		ret = devm_add_action_or_reset(dev, meson_disable_clk, clk);
-
-	return ret;
-}
-
 static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 				void *data)
 {
@@ -666,6 +643,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct meson_drm *priv = drm->dev_private;
 	struct dw_hdmi_plat_data *dw_plat_data;
+	struct clk *clk;
 	int irq;
 	int ret;
 
@@ -716,17 +694,23 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (IS_ERR(meson_dw_hdmi->hdmitx))
 		return PTR_ERR(meson_dw_hdmi->hdmitx);
 
-	ret = meson_enable_clk(dev, "isfr");
-	if (ret)
-		return ret;
+	clk = devm_clk_get_enabled(dev, "isfr");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "Unable to get isfr pclk\n");
+		return PTR_ERR(clk);
+	}
 
-	ret = meson_enable_clk(dev, "iahb");
-	if (ret)
-		return ret;
+	clk = devm_clk_get_enabled(dev, "iahb");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "Unable to get iahb pclk\n");
+		return PTR_ERR(clk);
+	}
 
-	ret = meson_enable_clk(dev, "venci");
-	if (ret)
-		return ret;
+	clk = devm_clk_get_enabled(dev, "venci");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "Unable to get venci pclk\n");
+		return PTR_ERR(clk);
+	}
 
 	dw_plat_data->regm = devm_regmap_init(dev, NULL, meson_dw_hdmi,
 					      &meson_dw_hdmi_regmap_config);
-- 
2.54.0

