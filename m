Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB3AC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F1910E8E8;
	Mon,  7 Sep 2026 20:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AZKttDI1";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2282A10E8F7
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788812235; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b6RzJpFG35AJAVeEGCxJ67n+D2OrR36A93bpNyZw4NaXpY+zc1nKaYggEyVF/ojhjNSI3AilNdnZzdMEFREkN/qx78I7sm/55SPaPp5/BDe8P4HitAd2cEuKjDa0mqNAWJEOtJJs5M4GAYxmFupKEu0D4wOLJE47L4i5UVB/KnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788812235;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5TbboicgS2mWaIpPIltnspzcsGg/Zur7OzHvZuUvftY=; 
 b=FBMg6TU1ozyvD+nq6Yz6sHc6tcZBCCgRuB2fWhswCVsVMuPFlMyr4sqwc8uy6PoWOTZMgurXeTziX3uFFyIa70eaebAZKsCcGiGjPOSXbj+gVPr08/aIcsBhboEqhEjR9K8n9EDCvGJ+ER1zBVaBWcT/q/yHHNj5HUKcjw/YPJ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788812234; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5TbboicgS2mWaIpPIltnspzcsGg/Zur7OzHvZuUvftY=;
 b=AZKttDI1/ATzGmXKowU9CJsuybX4spWPtCAlt1BL5BtccL00YkmdK3CUQIYvAkZ3
 EE4msNr4or+uW32UcKii7DN/aGQAhLIPdWos6aq8dk3VSUeIKcCu8UKDoapiSbR1qBG
 O4JsAVFvfH6HTZrT/k0TF8i5oN0CvVfrRRhQLir8=
Received: by mx.zohomail.com with SMTPS id 17888122340911021.5922630388368;
 Mon, 7 Sep 2026 13:17:14 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 07 Sep 2026 21:16:17 +0100
Subject: [PATCH v8 08/16] drm/panfrost: Move all DRM device initialisation
 into device_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-claude-fixes-v8-8-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
In-Reply-To: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5230;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=F80dE/xqs+i0X5VauRBHNJkrVG6wPijB1c9Nd17vLV4=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqnxuLqdS4sO5laCcDW4yXXQOayW5ynYzo/nHqU
 TVp2PJUxq6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCap8biwAKCRAOJn5M7lND
 PT7UDACbnE5Hv/DuJTendtEOdILpZ9t/a+R/ZDwk+p3UxEklawEHdZdVbneq6zMErA0QUokiDXF
 LSXz/ht7YgT3ib/gVXKaVbpx762dnSAOySPPt9sgo7+5gJHIkcEKLelp9OqmhVACFf/XCAfrkkW
 KooAPmkcBNATeaalPsyNdhHF7Rx7i5mlBlRtVRB4441OxUqmSwAz//M5bBEhQ+DDKDg9CzgYAnE
 XknA0nmH2EDq4Eznlv5vHpTLJO7nJXJs5tgjOz3nG7U4hzq+b3UocRXLRXibw8uqKy3Mw0w0JmW
 N7jvGuj50b5inugxXf2le6kwMtkzVcB8oxulu7vQJDN8zfRTFbIGoNJdG8t3slTXeCCejAFwk+1
 hs6uzGqB94bbeLUieYbDi3SNHFX3JQ680t1YonjR1lVk10Qs+jG/BC047VO2MNY7NCaoKd0ReLt
 g5DC+mI1GJOyV6m7UcXiZHLgzBfP0bM4us6rpbiBh5EEJpwm5OBOGKtcwVnFlExgmD2+M=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Ideally the probe() function will do as little as possible, and all device
initialisation and registration should happen inside the panfrost device
subsystem, just like it's done in Panthor. This also simplifies resource
unwinding in the error path.

Do the same thing for DRM driver remove, as in, sweep most of the action
into panfrost_device_fini(), just like we did for device probe.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 37 +++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 47 +-----------------------------
 2 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 48135e412b6c..be4443e41d9a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <drm/drm_drv.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -227,6 +228,12 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 {
 	int err;
 
+	pfdev->comp = of_device_get_match_data(pfdev->base.dev);
+	if (!pfdev->comp)
+		return -ENODEV;
+
+	pfdev->coherent = device_get_dma_attr(pfdev->base.dev) == DEV_DMA_COHERENT;
+
 #ifdef CONFIG_DEBUG_FS
 	mutex_init(&pfdev->debugfs.gems_lock);
 	INIT_LIST_HEAD(&pfdev->debugfs.gems_list);
@@ -288,8 +295,31 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err)
 		goto out_perfcnt;
 
+	pm_runtime_set_active(pfdev->base.dev);
+	pm_runtime_mark_last_busy(pfdev->base.dev);
+	pm_runtime_get_noresume(pfdev->base.dev);
+	pm_runtime_enable(pfdev->base.dev);
+	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
+	pm_runtime_use_autosuspend(pfdev->base.dev);
+
+	/*
+	 * Register the DRM device with the core and the connectors with
+	 * sysfs
+	 */
+	err = drm_dev_register(&pfdev->base, 0);
+	if (err < 0)
+		goto err_disable_rpm;
+
+	pm_runtime_put_autosuspend(pfdev->base.dev);
+
 	return 0;
 
+err_disable_rpm:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
+	pm_runtime_disable(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
+	pm_runtime_set_suspended(pfdev->base.dev);
+	panfrost_gem_fini(pfdev);
 out_perfcnt:
 	panfrost_perfcnt_fini(pfdev);
 out_job:
@@ -313,6 +343,13 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
+	pm_runtime_get_sync(pfdev->base.dev);
+
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
+	pm_runtime_disable(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
+	pm_runtime_set_suspended(pfdev->base.dev);
+
 	panfrost_gem_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
 	panfrost_jm_fini(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index a3eff77add55..f77780c72a1a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -830,7 +830,6 @@ static const struct drm_driver panfrost_drm_driver = {
 static int panfrost_probe(struct platform_device *pdev)
 {
 	struct panfrost_device *pfdev;
-	int err;
 
 	pfdev = devm_drm_dev_alloc(&pdev->dev, &panfrost_drm_driver,
 				   struct panfrost_device, base);
@@ -839,46 +838,7 @@ static int panfrost_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pfdev);
 
-	pfdev->comp = of_device_get_match_data(&pdev->dev);
-	if (!pfdev->comp)
-		return -ENODEV;
-
-	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
-
-	err = panfrost_device_init(pfdev);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Fatal error during GPU init\n");
-		goto err_out0;
-	}
-
-	pm_runtime_set_active(pfdev->base.dev);
-	pm_runtime_mark_last_busy(pfdev->base.dev);
-	pm_runtime_get_noresume(pfdev->base.dev);
-	pm_runtime_enable(pfdev->base.dev);
-	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
-	pm_runtime_use_autosuspend(pfdev->base.dev);
-
-	/*
-	 * Register the DRM device with the core and the connectors with
-	 * sysfs
-	 */
-	err = drm_dev_register(&pfdev->base, 0);
-	if (err < 0)
-		goto err_out1;
-
-	pm_runtime_put_autosuspend(pfdev->base.dev);
-
-	return 0;
-
-err_out1:
-	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
-	pm_runtime_put_noidle(pfdev->base.dev);
-	pm_runtime_set_suspended(pfdev->base.dev);
-	panfrost_device_fini(pfdev);
-err_out0:
-	return err;
+	return panfrost_device_init(pfdev);
 }
 
 static void panfrost_remove(struct platform_device *pdev)
@@ -887,11 +847,6 @@ static void panfrost_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&pfdev->base);
 
-	pm_runtime_get_sync(pfdev->base.dev);
-	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
-	pm_runtime_put_noidle(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
-	pm_runtime_set_suspended(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 }
 

-- 
2.55.0

