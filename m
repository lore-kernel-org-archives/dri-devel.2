Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5C6CA6004
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D746910E69E;
	Sat, 10 Oct 2026 11:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q1v4Ijq+";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99B210E69E
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:56:02 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48b9d8055dfso442351f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791633361; x=1792238161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RPzRZvC6M3eYrQVDkjYe0kKV8YaVNewsubnx0uw/yuw=;
 b=q1v4Ijq+qBlPrvm2NENHYAzW0Qam3xt6Fw8Hg4p4936NWuvJIi47Q9SPVq5pMrDAR7
 K1+wdvYW4vP34/zSGw0II1eITJv8m3sBOiaWJkSTdABtG5QhadSubJQ89/tuaXy6hfkG
 E5D9GMsIDCBMaxgfD4/l3i27pvi4QNrYLHOM4Xv24c8jTc09N2FuHSBPYao6f+2bPEf4
 gaB06cBZyPPTefnr8GzIgdNPvPNp7SMcJUAKokbWjl9g5DWdEis5Ajes/o8xyeahBDaF
 2SNK+SM0u/Ljgcs443UD0FFylMOHZCkTnPSfkotebgIpjH13kt61RT1d+04hVONzZiRN
 Fz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633361; x=1792238161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RPzRZvC6M3eYrQVDkjYe0kKV8YaVNewsubnx0uw/yuw=;
 b=ihzQxuj/MvSXdcGS+QJUWKF+Je0sLudQwZXT7PH4xGtnAwu15s/7D8cMtOSKhvPXUI
 V23DwUTBkY1cY7p0uhYTRmqy5t/6nPJM2oJYiCQugccOWy7XhBW4asWPZ8/ho6Lw/zKx
 TzjGWqtY1uaFOMn1GsjLjNAa898BlpCro1P5j1Uf5mFNvmkM0UvhvsPZrjpDW32rJ926
 s+pNWMSb1kplIhZeNQwJFvWQzLKBALyYJFz6UUM+3h1DyArpW/WkVRACdk9hyvBFKFMj
 IyDL60WevrEfWzRkeDprvfQ9DZzfIYc7UXO7JLIX+pO/9Z1GI9Ok8Jt90Y8dNT/fb+xp
 IAMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMlG5Hb49upEskaadAbtVOattrEbe4W/iB2La5+LChSfeBmNkYaCH5Xq0hHtNUdrx/ZTnCjZTfMG8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIfLHsUxpFjBMHMTLWiEa4LQa/5GPQfRqDiXSGDyGBNu6BC43RE
 uoLDNim6Ku1HSYNeWtHk3vCVIzYhUDmFgh+ZKal3Aa9lWR60id9BrUhN
X-Gm-Gg: AYBFou18hI8BQjja54fCnbZRqfHSmBckqafjrk298ZlOyZk3vbYxfYXy9tcvM8U1jhF
 yDt1O+/fmr47nDCnLDYW6yKUEQDgrPptIV8hGNYmAO2x3bgb/SPghdUWH/i8c9RkIaCow3Wx5y8
 VDJJw0DJEV+LLqsq6n/ONKZSEXO1wnOUwew8Jk8UX9Awallmhg20Syf5kT+Mhoi4TXwch7zWq9B
 mpBIkTZN8R21RUWUz6k29tSj3txjh8L1gVbol0qECNaK4h9OPZD4fsEJhdcwKLZobncgOOrDHfl
 CBD0yNYkaGuRP4eAWUm+F1i6hVSpiqQ8eMF2ysZIOvNi99LbHgCR1U1WMCJ2f6jDh/N6oVs8C2p
 GLqtiDTZqIW/UjuEhI5FMG2XvgHSNzb7dARN6WbdIFlh7DDDGEI+fc9KVpfdassIrL6ejMHGrWe
 Zr/2J7FDD/LEvTLRYshpihXCJLB+9JGo/QOU8Yrt/liFWRQTRdO+QaHIaCd2HRbEMZCw==
X-Received: by 2002:a05:6000:4310:b0:48a:f1fb:e165 with SMTP id
 ffacd0b85a97d-48dbaae39e0mr7896198f8f.21.1791633360918; 
 Sat, 10 Oct 2026 04:56:00 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm8746340f8f.43.2026.10.10.04.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 04:56:00 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Fabien Parent <fparent@baylibre.com>,
 CK Hu <ck.hu@mediatek.com>, chunhui dai <chunhui.dai@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 3/7] clk: mediatek: mt8167: Map apmixedsys iomem as shared
Date: Sat, 10 Oct 2026 13:54:03 +0200
Message-ID: <20261010115539.9237-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010115539.9237-1-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
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

The hdmi_phy for mt8167 and the apmixedsys clocks share the same IO
memory region and they both map it using devm_platform_ioremap_resource,
which implies exclusive access. Switch the apmixedsys driver to of_iomap,
like it is done in the mt8173-apmixedsys driver. Also, implement the
remove function while we're at it.

Fixes the following runtime error:
hdmi-phy: error -EBUSY: can't request region for resource
[mem 0x10018300-0x1001831f]

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c | 24 ++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
index fb6c21bbeef8..3e8611991de7 100644
--- a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8167-clk.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "clk-pll.h"
@@ -97,17 +98,19 @@ static int clk_mt8167_apmixed_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	base = devm_platform_ioremap_resource(pdev, 0);
+	base = of_iomap(node, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
 	clk_data = mtk_devm_alloc_clk_data(dev, MT8167_CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(clk_data)) {
+		ret = -ENOMEM;
+		goto unmap_io;
+	}
 
 	ret = mtk_clk_register_plls(dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (ret)
-		return ret;
+		goto unmap_io;
 
 	ret = mtk_clk_register_dividers(dev, adj_divs, ARRAY_SIZE(adj_divs), base,
 					&mt8167_apmixed_clk_lock, clk_data);
@@ -124,10 +127,22 @@ static int clk_mt8167_apmixed_probe(struct platform_device *pdev)
 	mtk_clk_unregister_dividers(adj_divs, ARRAY_SIZE(adj_divs), clk_data);
 unregister_plls:
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+unmap_io:
+	iounmap(base);
 
 	return ret;
 }
 
+static void clk_mt8167_apmixed_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_dividers(adj_divs, ARRAY_SIZE(adj_divs), clk_data);
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+}
+
 static const struct of_device_id of_match_clk_mt8167_apmixed[] = {
 	{ .compatible = "mediatek,mt8167-apmixedsys" },
 	{ /* sentinel */ }
@@ -136,6 +151,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8167_apmixed);
 
 static struct platform_driver clk_mt8167_apmixed_drv = {
 	.probe = clk_mt8167_apmixed_probe,
+	.remove = clk_mt8167_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8167-apmixed",
 		.of_match_table = of_match_clk_mt8167_apmixed,
-- 
2.43.0

