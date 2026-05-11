Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1FFCD4840
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 16:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2193210E80F;
	Mon, 11 May 2026 16:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TywpEAD7";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F5FD10E80F;
 Mon, 11 May 2026 16:40:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 28DA64E42BF4;
 Mon, 11 May 2026 16:40:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EF8E760646;
 Mon, 11 May 2026 16:40:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 26AF211AF9F70; 
 Mon, 11 May 2026 18:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778517640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=695tIBtiGj0Zt5p+JSC1oz7b/RdXY/fqVD2MgB83H7c=;
 b=TywpEAD7Uo6nhAi0zlkPDokGJfN0z9RNpa71Y1ZzG9CIbCN9beeMSWqlofXm4mahl1HHOR
 cDTQJNzwT7j8gJ2n3cyGpa6OVDH7w7Qh8vhmpjgnZ6x4+31EdtzESYLyfb9otJF5Di06xl
 6+LFcCA6Zg7KxP1r4sc3YI1sL3W2AhAtTff+5f2pLoH1YbJC83ZgKf5TbSvG1hoja4Hc6Z
 PTnpkk6B5wG1Udpyl49oxtlyIUBF4NXjvyCvICFYm/zZ9oEtuI+zO2EMz/21aqtWZapHE6
 jLvQ1NQETLUODEEBs/lA4EEKlM2qLFlnuyHUhTgo04hHF/492BLWrktCr8XRdQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 11 May 2026 18:40:07 +0200
Subject: [PATCH v6 03/11] drm/msm/hdmi: switch to
 of_drm_get_bridge_by_endpoint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-3-f61c9e498b3f@bootlin.com>
References: <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-0-f61c9e498b3f@bootlin.com>
In-Reply-To: <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-0-f61c9e498b3f@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
@panel parameter, thus using a reduced feature set of that function.
Replace this call with the simpler of_drm_get_bridge_by_endpoint().

Since of_drm_get_bridge_by_endpoint() increases the refcount of the
returned bridge, ensure it is put on removal.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v6:
- move assignment of next_bridge earlier (avoid access before assignment)

Changes in v5:
- simplify error management code flow

Changes in v4:
- ensure next_bridge is put on later probe failures

Changes in v3:
- fix ERR_PTR deref when -ENODEV is returned

- move assignment of next_bridge earlier (avoid access before assignment)
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 70 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index d9491aac1a89..474006084633 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -285,19 +285,27 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 	spin_lock_init(&hdmi->reg_lock);
 	mutex_init(&hdmi->state_mutex);
 
-	ret = drm_of_find_panel_or_bridge(dev_of_node(dev), 1, 0, NULL, &hdmi->next_bridge);
-	if (ret && ret != -ENODEV)
-		return ret;
+	hdmi->next_bridge = of_drm_get_bridge_by_endpoint(dev_of_node(dev), 1, 0);
+	if (IS_ERR(hdmi->next_bridge)) {
+		if (PTR_ERR(hdmi->next_bridge) != -ENODEV)
+			return PTR_ERR(hdmi->next_bridge);
+
+		hdmi->next_bridge = NULL;
+	}
 
 	hdmi->mmio = msm_ioremap(pdev, "core_physical");
-	if (IS_ERR(hdmi->mmio))
-		return PTR_ERR(hdmi->mmio);
+	if (IS_ERR(hdmi->mmio)) {
+		ret = PTR_ERR(hdmi->mmio);
+		goto err_put_bridge;
+	}
 
 	/* HDCP needs physical address of hdmi register */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 		"core_physical");
-	if (!res)
-		return -EINVAL;
+	if (!res) {
+		ret = -EINVAL;
+		goto err_put_bridge;
+	}
 	hdmi->mmio_phy_addr = res->start;
 
 	hdmi->qfprom_mmio = msm_ioremap(pdev, "qfprom_physical");
@@ -307,45 +315,58 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 	}
 
 	hdmi->irq = platform_get_irq(pdev, 0);
-	if (hdmi->irq < 0)
-		return hdmi->irq;
+	if (hdmi->irq < 0) {
+		ret = hdmi->irq;
+		goto err_put_bridge;
+	}
 
 	hdmi->pwr_regs = devm_kcalloc(dev, config->pwr_reg_cnt,
 				      sizeof(hdmi->pwr_regs[0]),
 				      GFP_KERNEL);
-	if (!hdmi->pwr_regs)
-		return -ENOMEM;
+	if (!hdmi->pwr_regs) {
+		ret = -ENOMEM;
+		goto err_put_bridge;
+	}
 
 	for (i = 0; i < config->pwr_reg_cnt; i++)
 		hdmi->pwr_regs[i].supply = config->pwr_reg_names[i];
 
 	ret = devm_regulator_bulk_get(dev, config->pwr_reg_cnt, hdmi->pwr_regs);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to get pwr regulators\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to get pwr regulators\n");
+		goto err_put_bridge;
+	}
 
 	hdmi->pwr_clks = devm_kcalloc(dev, config->pwr_clk_cnt,
 				      sizeof(hdmi->pwr_clks[0]),
 				      GFP_KERNEL);
-	if (!hdmi->pwr_clks)
-		return -ENOMEM;
+	if (!hdmi->pwr_clks) {
+		ret = -ENOMEM;
+		goto err_put_bridge;
+	}
 
 	for (i = 0; i < config->pwr_clk_cnt; i++)
 		hdmi->pwr_clks[i].id = config->pwr_clk_names[i];
 
 	ret = devm_clk_bulk_get(dev, config->pwr_clk_cnt, hdmi->pwr_clks);
 	if (ret)
-		return ret;
+		goto err_put_bridge;
+
 
 	hdmi->extp_clk = devm_clk_get_optional(dev, "extp");
-	if (IS_ERR(hdmi->extp_clk))
-		return dev_err_probe(dev, PTR_ERR(hdmi->extp_clk),
-				     "failed to get extp clock\n");
+	if (IS_ERR(hdmi->extp_clk)) {
+		ret = dev_err_probe(dev, PTR_ERR(hdmi->extp_clk),
+				    "failed to get extp clock\n");
+		goto err_put_bridge;
+	}
 
 	hdmi->hpd_gpiod = devm_gpiod_get_optional(dev, "hpd", GPIOD_IN);
 	/* This will catch e.g. -EPROBE_DEFER */
-	if (IS_ERR(hdmi->hpd_gpiod))
-		return dev_err_probe(dev, PTR_ERR(hdmi->hpd_gpiod),
-				     "failed to get hpd gpio\n");
+	if (IS_ERR(hdmi->hpd_gpiod)) {
+		ret = dev_err_probe(dev, PTR_ERR(hdmi->hpd_gpiod),
+				    "failed to get hpd gpio\n");
+		goto err_put_bridge;
+	}
 
 	if (!hdmi->hpd_gpiod)
 		DBG("failed to get HPD gpio");
@@ -355,7 +376,7 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 
 	ret = msm_hdmi_get_phy(hdmi);
 	if (ret)
-		return ret;
+		goto err_put_bridge;
 
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
@@ -371,6 +392,8 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 
 err_put_phy:
 	msm_hdmi_put_phy(hdmi);
+err_put_bridge:
+	drm_bridge_put(hdmi->next_bridge);
 	return ret;
 }
 
@@ -381,6 +404,7 @@ static void msm_hdmi_dev_remove(struct platform_device *pdev)
 	component_del(&pdev->dev, &msm_hdmi_ops);
 
 	msm_hdmi_put_phy(hdmi);
+	drm_bridge_put(hdmi->next_bridge);
 }
 
 static int msm_hdmi_runtime_suspend(struct device *dev)

-- 
2.54.0

