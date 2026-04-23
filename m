Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6BCFDEE3F
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120A810E3BF;
	Thu, 23 Apr 2026 20:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WS6YycmB";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1534510E3BF
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:06:33 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so50845055e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776974792; x=1777579592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pr8ZXEmD5yrFHrl2Ct33Ap6JH6uM0Ws47D8sKfOxOo4=;
 b=WS6YycmBMEYz/UH6zqWsW3XH5bUOBpLmgZkw/oSVJXBPZU9DFJf4JN1EhbTXh9Y2D5
 n8Tkk2JGWmIvu66/lpF+DpaqVeGkmNIwuLJRQSPkdtyUMG1AQLn/mRMhzJLdELYCTQET
 tvAeMSWnRxC8P/z+a1VJ0uZEPhNbSuIInIUSGKHqevD6Ra7TyntCIN29c/gQTFUiGHb4
 1Z/A1fs8Z1iFpd/wqcyc6GdP6HueC1vCHl0leWzfZI26hiwvzowmcJIgUi5LpwguT/7B
 QgIaujl4PODIPVPfFRkkVOSQ8DnpxhCwxCsb9Lp4GPuq8kNZ8UJpP+gJ0DV5r79PMHVd
 Jf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776974792; x=1777579592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pr8ZXEmD5yrFHrl2Ct33Ap6JH6uM0Ws47D8sKfOxOo4=;
 b=cbOX96d9mw+cDuhFaHEgrOe5MGiEhbH2WZJ+0baJ6zn7Wm9xNgOnuiEoT2FqSH/ULb
 CjdwAAr1O5XYMXGIBIMiaxC8Ar+muJG+l+MB6DoXNSAI29rW+mNfc3mqAfGVmv1JB02c
 8FngiSpu/9gYGgBIfVQd4VVZzv6vRKXSNF3h9ZHD7/xEMpBp5ky/AC01+SlE0KLlN2da
 Q8O5TqwFxyZsxGWiyHfY01QtifjG8Pe5HVy9r080xlc5oo3lmqbZmkPXxgu5IyYRjQJh
 0ZqSUsWOsIwz8MTt+S90ts7rF94ENCKli159r+d3w68O1Ngs0m6RQPF1dNBq2pzVL5x7
 gZKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZcAJri9hVOCLb3UG/qgdVyM+V0yBRge6xSN7r8fOda2bwQZNc+svFiIvQNglcsV4B+nMs0X4Pgnk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw03PtO92cw+0t9VcNNFPcnaX9owbVTidMfKaCfoCp4xI/JXqUg
 WuPM2RwLViQyDq0NtcdXaMkq9Qs5Lk4lBU7lHuHrdObft8IO3lE0mQY7
X-Gm-Gg: AeBDieuVnbcuIqUg01hwqtUe6Y1e/UsP2O2Btc1xFpJFCl85yxJvAZfBSE8UPZWh/Kg
 KWAlKOd8ZQVTcmjl/pqe6zrrEN1/jw5betu+IWAA89sCJDsKKGs6EjVPL6HTmebwKVIkZrAlGxJ
 alzs5B/gbkHyOrtCj60yXX/i+/d1bImkmvSHekBaw3a7u9gAVKtGyEe/WRCCNevKUHmyyok77Oz
 WA6OI878DPt997h00GBHau1kYTsAbEP1U37kwUDjl/BsSZ5k02hItlXZnXrYSXrDWNKLK7GgfXZ
 xEgJp4wDkRwk1MBMZSxW48NLpLgQyvQOefNBCUwThgLyb4xZAi0Zaamz/7DacrscubOn4VmhRX8
 CIrT9jucOdtYo0M1c0v4mjiRWOoUGeSoyOA73wZ1Bm5qHNax3H+r/GGc3CM0/aXgC/LPWQHJEcG
 0/AoYFuh57h3iwsAJ5LC+3jSf7qt2WKcEuZCmMN0g+fAkd+MaPm0GTE7u9p9D7sFLxTQ+0DNU=
X-Received: by 2002:a05:600c:8587:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-488fb7880bdmr289804935e9.28.1776974791551; 
 Thu, 23 Apr 2026 13:06:31 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75ab25sm167658815e9.11.2026.04.23.13.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 13:06:31 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/sti: remove bridge when sti_hda component_add fails
Date: Thu, 23 Apr 2026 22:06:19 +0200
Message-ID: <20260423200622.325076-1-osama.abdelkader@gmail.com>
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

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop the manual drm_bridge_remove() in remove().

Check the return value of devm_drm_bridge_add().

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: d28726efc637 ("drm/sti: hda: add bridge before attaching")
Cc: stable@vger.kernel.org
---
v3: add Fixes and Cc tags
v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge
---
 drivers/gpu/drm/sti/sti_hda.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b7397827889c..360a88ca8f0c 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -741,6 +741,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sti_hda *hda;
 	struct resource *res;
+	int ret;
 
 	DRM_INFO("%s\n", __func__);
 
@@ -779,7 +780,9 @@ static int sti_hda_probe(struct platform_device *pdev)
 		return PTR_ERR(hda->clk_hddac);
 	}
 
-	drm_bridge_add(&hda->bridge);
+	ret = devm_drm_bridge_add(dev, &hda->bridge);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, hda);
 
@@ -788,10 +791,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 
 static void sti_hda_remove(struct platform_device *pdev)
 {
-	struct sti_hda *hda = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &sti_hda_ops);
-	drm_bridge_remove(&hda->bridge);
 }
 
 static const struct of_device_id hda_of_match[] = {
-- 
2.43.0

