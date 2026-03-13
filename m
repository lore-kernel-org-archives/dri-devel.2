Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B4D105F79B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B4010EB6F;
	Fri, 13 Mar 2026 11:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KEFSiBeb";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADFC10EBAB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=om0xglTcuNDYM+xalbxku5+gocJ/6M+d8FAJL6FzxL0=; b=KEFSiBebyux/Y7ljuaaP1WxWb8
 1oDs6Yek+oQlucZMq9QQuwN0ctl9w+1MQ0zHdujMdcK+HHLazdiRoBuEZyYqcK9xiN0wBtOv/0ICm
 SI5j6zzRdLMnYO5eGe0LcDkBajXFR+ZGnuZMiGj8AckbI0ujYoZ6wZlpNHTp08vnSOtUCVdkkDmX8
 V+AqQH0pVcWVXVPC8FgL+pCOIFYmUiZCu+l17Xa7vjETgAew55o9uf/CrZ62M/Pk2dXLUVXSjlAxh
 dv4ZAlOk4dknFfidMGRzOCbu4Ph9Nc0JNrorTOnOrF/97RE+sSUM5DG7wY8dKs5GYxtjvHQq+DzPw
 It8kAb7Q==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1w10lR-0006ot-2S; Fri, 13 Mar 2026 12:33:09 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1w10lR-000LbO-0p; Fri, 13 Mar 2026 12:33:09 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/bridge: nwl-dsi: Use dev_err_probe
Date: Fri, 13 Mar 2026 12:32:58 +0100
Message-ID: <20260313113259.1721914-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27939/Fri Mar 13 07:24:42 2026)
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

This simplifies the code as well as adding a probe deferral message.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 114 +++++++++++--------------------
 1 file changed, 40 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 2f7429b24fc20..0a39643b128ba 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/dev_printk.h>
 #include <linux/irq.h>
 #include <linux/math64.h>
 #include <linux/mfd/syscon.h>
@@ -975,68 +976,46 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
 	struct platform_device *pdev = to_platform_device(dsi->dev);
 	struct clk *clk;
 	void __iomem *base;
-	int ret;
 
 	dsi->phy = devm_phy_get(dsi->dev, "dphy");
-	if (IS_ERR(dsi->phy)) {
-		ret = PTR_ERR(dsi->phy);
-		if (ret != -EPROBE_DEFER)
-			DRM_DEV_ERROR(dsi->dev, "Could not get PHY: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->phy))
+		return dev_err_probe(dsi->dev, PTR_ERR(dsi->phy),
+				     "Could not get PHY\n");
 
 	clk = devm_clk_get(dsi->dev, "lcdif");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		DRM_DEV_ERROR(dsi->dev, "Failed to get lcdif clock: %d\n",
-			      ret);
-		return ret;
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dsi->dev, PTR_ERR(clk),
+				     "Failed to get lcdif clock\n");
 	dsi->lcdif_clk = clk;
 
 	clk = devm_clk_get(dsi->dev, "core");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		DRM_DEV_ERROR(dsi->dev, "Failed to get core clock: %d\n",
-			      ret);
-		return ret;
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dsi->dev, PTR_ERR(clk),
+				     "Failed to get core clock\n");
 	dsi->core_clk = clk;
 
 	clk = devm_clk_get(dsi->dev, "phy_ref");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		DRM_DEV_ERROR(dsi->dev, "Failed to get phy_ref clock: %d\n",
-			      ret);
-		return ret;
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dsi->dev, PTR_ERR(clk),
+				     "Failed to get phy_ref clock\n");
 	dsi->phy_ref_clk = clk;
 
 	clk = devm_clk_get(dsi->dev, "rx_esc");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		DRM_DEV_ERROR(dsi->dev, "Failed to get rx_esc clock: %d\n",
-			      ret);
-		return ret;
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dsi->dev, PTR_ERR(clk),
+				     "Failed to get rx_esc clock\n");
 	dsi->rx_esc_clk = clk;
 
 	clk = devm_clk_get(dsi->dev, "tx_esc");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		DRM_DEV_ERROR(dsi->dev, "Failed to get tx_esc clock: %d\n",
-			      ret);
-		return ret;
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dsi->dev, PTR_ERR(clk),
+				     "Failed to get tx_esc clock\n");
 	dsi->tx_esc_clk = clk;
 
 	dsi->mux = devm_mux_control_get(dsi->dev, NULL);
-	if (IS_ERR(dsi->mux)) {
-		ret = PTR_ERR(dsi->mux);
-		if (ret != -EPROBE_DEFER)
-			DRM_DEV_ERROR(dsi->dev, "Failed to get mux: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->mux))
+		return dev_err_probe(dsi->dev, PTR_ERR(dsi->mux),
+				     "Failed to get mux\n");
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -1044,44 +1023,31 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
 
 	dsi->regmap =
 		devm_regmap_init_mmio(dsi->dev, base, &nwl_dsi_regmap_config);
-	if (IS_ERR(dsi->regmap)) {
-		ret = PTR_ERR(dsi->regmap);
-		DRM_DEV_ERROR(dsi->dev, "Failed to create NWL DSI regmap: %d\n",
-			      ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->regmap))
+		return dev_err_probe(dsi->dev, PTR_ERR(dsi->regmap),
+				     "Failed to create NWL DSI regmap\n");
 
 	dsi->irq = platform_get_irq(pdev, 0);
-	if (dsi->irq < 0) {
-		DRM_DEV_ERROR(dsi->dev, "Failed to get device IRQ: %d\n",
-			      dsi->irq);
-		return dsi->irq;
-	}
+	if (dsi->irq < 0)
+		return dev_err_probe(dsi->dev, dsi->irq,
+				     "Failed to get device IRQ\n");
 
 	dsi->rst_pclk = devm_reset_control_get_exclusive(dsi->dev, "pclk");
-	if (IS_ERR(dsi->rst_pclk)) {
-		DRM_DEV_ERROR(dsi->dev, "Failed to get pclk reset: %ld\n",
-			      PTR_ERR(dsi->rst_pclk));
-		return PTR_ERR(dsi->rst_pclk);
-	}
+	if (IS_ERR(dsi->rst_pclk))
+		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rst_pclk),
+				     "Failed to get pclk reset\n");
 	dsi->rst_byte = devm_reset_control_get_exclusive(dsi->dev, "byte");
-	if (IS_ERR(dsi->rst_byte)) {
-		DRM_DEV_ERROR(dsi->dev, "Failed to get byte reset: %ld\n",
-			      PTR_ERR(dsi->rst_byte));
-		return PTR_ERR(dsi->rst_byte);
-	}
+	if (IS_ERR(dsi->rst_byte))
+		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rst_byte),
+				     "Failed to get byte reset\n");
 	dsi->rst_esc = devm_reset_control_get_exclusive(dsi->dev, "esc");
-	if (IS_ERR(dsi->rst_esc)) {
-		DRM_DEV_ERROR(dsi->dev, "Failed to get esc reset: %ld\n",
-			      PTR_ERR(dsi->rst_esc));
-		return PTR_ERR(dsi->rst_esc);
-	}
+	if (IS_ERR(dsi->rst_esc))
+		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rst_esc),
+				     "Failed to get esc reset\n");
 	dsi->rst_dpi = devm_reset_control_get_exclusive(dsi->dev, "dpi");
-	if (IS_ERR(dsi->rst_dpi)) {
-		DRM_DEV_ERROR(dsi->dev, "Failed to get dpi reset: %ld\n",
-			      PTR_ERR(dsi->rst_dpi));
-		return PTR_ERR(dsi->rst_dpi);
-	}
+	if (IS_ERR(dsi->rst_dpi))
+		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rst_dpi),
+				     "Failed to get dpi reset\n");
 	return 0;
 }
 
-- 
2.43.0

