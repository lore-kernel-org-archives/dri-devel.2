Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E991F9D0EE
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A1210E14C;
	Tue, 14 Apr 2026 18:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B1Xl9e74";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE23A10E14C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:17:39 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso48687945e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776190658; x=1776795458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a17qkKgLycvB9UF11qiLM7OBOR2drTyk3swDqmbXW8c=;
 b=B1Xl9e74ENv0202mF5nEqv+YrEP2tXYBN2ZC7lHTfOl39nK5jyS0T+1d8soHoNZFbF
 oWV9k0JbtA/MH0zM+pDo0ZSG86M5k8LcxPv+YJ5uVR4K6nUovwrKgCDOV6xTdcF8UqkH
 J6RafgicKe/GZ2rIbyJXhewag91euOi7as3ErUTtC/yIgzub14o9HW5EYddGGq781NRr
 arlMoT5qBh1lUmpsgAKqaAlSC7JG8KmPLu8XKGCX/EjMepW/f5ldzz0O4V2lrfb6OVCg
 7sopYxdJycIiSEXnlUu/JZ7P1mxDIKydnyOVLB1FnDG5pHwn85A91ELJPjyzBKS1oji4
 oYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776190658; x=1776795458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a17qkKgLycvB9UF11qiLM7OBOR2drTyk3swDqmbXW8c=;
 b=fljGtl+NHm88+YApGY7ZEi+o1Qz/7ihfyHTlHyYzXzrgcH4P78zQnD6q7X3FeTlwka
 N7t1QhZIFeXn8OQNybDsfSsUNX8ilnoC7ELFeu9lxfQ5vTolpQ54+Wf5A1MB/P4i+nJK
 8wcuRAZ7+krftiazkoJAXk/EijULkKwrKIUzHnKacmM/LM3IHE+cAJ2bEsIwNYRa1gw9
 TeBQi30LerZNjCjsM1XDI/ENlxAk1xNgovStGn3S5OOEyHZcPgF/53Bfh1FUpGdOkFgd
 VALl+9VYq9yMZCUrQmHpm4m9XFJYqBJUXrdC66I0PokoRUGiZlqupBCjV4xwt2AUT40p
 CiHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M680l6IpuLgZNUbqdTBd/UhMQcY3E0pRBCWLVzyI69axZYAgE5+9ZbrCekPlVonCZUTeoEfZMSL0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzV4ZeszLdpicvhMOoKxtER3iUjF27g7X0k/WsR8fvPVWkF5O/N
 ETC6Zu97Q7X8Qf2sBc3hCcELkt/4byxeimIugME5TEXO7N6lnyzDbdGc
X-Gm-Gg: AeBDiesxHPpxzewq++W/VsXoYM766LeqoWfYl1nTxiRu9ubVtM4wPD0xcydeaMLaiWA
 QoUjqWQ50TuxhyC35oRKU89w1QZHk7kaOl5oaf1WZd9Sfw1Q6+2Cjqc7wZkCoeoxQjqfhx7mhK0
 IrMWXKuCunK6IGg6JUUmfYOgKmDXHo5KxIoAq6LAKfWE3uxo4Vl5xttMIxTX0k5g/H89vmFdHb/
 4tBSzJ6KdskOwAnWo1SpXlmo6TrF/eUmI4xrVo8Edw9utRlPcmZNjt0VtOdXgFTRrUgjP+M0qmi
 LAAmux3K3kwSOgzko3jszqK28idmfx368B0ikhcemu4axHEypcGumhpnCFGUiBXgCwa41Ve+7iq
 EfzFYDUysRUWhHhBTMjnTYCbqjDJMfAO7FapRSPdj3L4Z1uEPu5xQnyJ7VBl6Zg1d9mzXixqpkN
 50wYOwYfXrqsJdlvGbpSFqeNR3WLSvYN6RUYVrNvZso96vY9ZiJB/fdGpKWz98
X-Received: by 2002:a05:600d:d:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-488d67b8db8mr197770685e9.2.1776190658370; 
 Tue, 14 Apr 2026 11:17:38 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:cb49:f403:bb20:cc84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e217sm116926665e9.5.2026.04.14.11.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 11:17:37 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2] drm/sti: hdmi: simplify probe with devm DDC and bridge
Date: Tue, 14 Apr 2026 20:17:25 +0200
Message-ID: <20260414181726.177168-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Use devm_add_action_or_reset() to release the DDC I2C adapter from
of_get_i2c_adapter_by_node(), eliminating the release_adapter goto path.

Switch to devm_drm_bridge_add() so the bridge is released on probe failure
without manual drm_bridge_remove() in remove().

v2: devm_add_action_or_reset for DDC + devm_drm_bridge_add (reviewer)

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 48 ++++++++++++++--------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 839c80a7d954..19beaede8501 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1373,6 +1373,11 @@ static const struct of_device_id hdmi_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, hdmi_of_match);
 
+static void sti_hdmi_i2c_put(void *ptr)
+{
+	i2c_put_adapter(ptr);
+}
+
 static int sti_hdmi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1393,14 +1398,15 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 		of_node_put(ddc);
 		if (!hdmi->ddc_adapt)
 			return -EPROBE_DEFER;
+		ret = devm_add_action_or_reset(dev, sti_hdmi_i2c_put, hdmi->ddc_adapt);
+		if (ret)
+			return ret;
 	}
 
 	hdmi->dev = pdev->dev;
 	hdmi->regs = devm_platform_ioremap_resource_byname(pdev, "hdmi-reg");
-	if (IS_ERR(hdmi->regs)) {
-		ret = PTR_ERR(hdmi->regs);
-		goto release_adapter;
-	}
+	if (IS_ERR(hdmi->regs))
+		return PTR_ERR(hdmi->regs);
 
 	hdmi->phy_ops = (struct hdmi_phy_ops *)
 		of_match_node(hdmi_of_match, np)->data;
@@ -1409,29 +1415,25 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	hdmi->clk_pix = devm_clk_get(dev, "pix");
 	if (IS_ERR(hdmi->clk_pix)) {
 		DRM_ERROR("Cannot get hdmi_pix clock\n");
-		ret = PTR_ERR(hdmi->clk_pix);
-		goto release_adapter;
+		return PTR_ERR(hdmi->clk_pix);
 	}
 
 	hdmi->clk_tmds = devm_clk_get(dev, "tmds");
 	if (IS_ERR(hdmi->clk_tmds)) {
 		DRM_ERROR("Cannot get hdmi_tmds clock\n");
-		ret = PTR_ERR(hdmi->clk_tmds);
-		goto release_adapter;
+		return PTR_ERR(hdmi->clk_tmds);
 	}
 
 	hdmi->clk_phy = devm_clk_get(dev, "phy");
 	if (IS_ERR(hdmi->clk_phy)) {
 		DRM_ERROR("Cannot get hdmi_phy clock\n");
-		ret = PTR_ERR(hdmi->clk_phy);
-		goto release_adapter;
+		return PTR_ERR(hdmi->clk_phy);
 	}
 
 	hdmi->clk_audio = devm_clk_get(dev, "audio");
 	if (IS_ERR(hdmi->clk_audio)) {
 		DRM_ERROR("Cannot get hdmi_audio clock\n");
-		ret = PTR_ERR(hdmi->clk_audio);
-		goto release_adapter;
+		return PTR_ERR(hdmi->clk_audio);
 	}
 
 	hdmi->hpd = readl(hdmi->regs + HDMI_STA) & HDMI_STA_HOT_PLUG;
@@ -1441,15 +1443,14 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	hdmi->irq = platform_get_irq_byname(pdev, "irq");
 	if (hdmi->irq < 0) {
 		DRM_ERROR("Cannot get HDMI irq\n");
-		ret = hdmi->irq;
-		goto release_adapter;
+		return hdmi->irq;
 	}
 
 	ret = devm_request_threaded_irq(dev, hdmi->irq, hdmi_irq,
-			hdmi_irq_thread, IRQF_ONESHOT, dev_name(dev), hdmi);
+					hdmi_irq_thread, IRQF_ONESHOT, dev_name(dev), hdmi);
 	if (ret) {
 		DRM_ERROR("Failed to register HDMI interrupt\n");
-		goto release_adapter;
+		return ret;
 	}
 
 	hdmi->reset = devm_reset_control_get(dev, "hdmi");
@@ -1459,29 +1460,20 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hdmi);
 
-	drm_bridge_add(&hdmi->bridge);
-	ret = component_add(&pdev->dev, &sti_hdmi_ops);
+	ret = devm_drm_bridge_add(dev, &hdmi->bridge);
 	if (ret)
-		goto remove_bridge;
-	return 0;
-
- remove_bridge:
-	drm_bridge_remove(&hdmi->bridge);
- release_adapter:
-	i2c_put_adapter(hdmi->ddc_adapt);
+		return ret;
 
-	return ret;
+	return component_add(&pdev->dev, &sti_hdmi_ops);
 }
 
 static void sti_hdmi_remove(struct platform_device *pdev)
 {
 	struct sti_hdmi *hdmi = dev_get_drvdata(&pdev->dev);
 
-	i2c_put_adapter(hdmi->ddc_adapt);
 	if (hdmi->audio_pdev)
 		platform_device_unregister(hdmi->audio_pdev);
 	component_del(&pdev->dev, &sti_hdmi_ops);
-	drm_bridge_remove(&hdmi->bridge);
 }
 
 struct platform_driver sti_hdmi_driver = {
-- 
2.43.0

