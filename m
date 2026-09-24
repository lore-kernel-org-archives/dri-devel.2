Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD0CC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6283610F6FB;
	Thu, 24 Sep 2026 18:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="fI1qdBJB";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D435D10F6FB
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790273425; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ldl/MqTGybXADH88ZA6vA1SFiO6eOkmETO1olpiubiONZ1uVx3vL/RTnn9XDUVX1XKiMA9tNEsf47ametpZjSbq440iw2fqHOf/mWXt4VqTzDQyRdF+nIsR0dpRshGj6MeQAs0uEemnW3K1vyhDnFS6jQFkG/IMZwrWvzsjpjRc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790273425;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6O0y7YHB5eYuiFJy4FE91xQeeayyLqa5GzNXokwz1uU=; 
 b=JGevWE2YeXTQDfk9n4+1yXbV3BWtXvtgu85YOrpb84VN8FTGHouwYDO32NvzXyYS2W5BQB9YGQwxZvMt3+66ouGyW+/RGrU9jXrVRYOSMN6k+VGPJ/htWKLoIxOQ47vxZyjLwjuZzUkG5MhcPck5F6DmAruWD9Ca2T5cTDDEVO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790273425; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=6O0y7YHB5eYuiFJy4FE91xQeeayyLqa5GzNXokwz1uU=;
 b=fI1qdBJB1/gBQNDYmx+nD+DJ0IJfO8es8q5XORMYiuMfcE+utQoqeMDR4UlVOxai
 4I7t/DiviIND1nNcuqcKuw7FUszJXMnPL2qAWOlQxmGajjYC5AnWXRjy4gruB+WybLq
 QJ9GtvxP3qMgH6ObqawLRy7zULrtu6hLErSVUKtw=
Received: by smtp.zohomail.com with SMTPS id 1790273424541916.4231231614267;
 Thu, 24 Sep 2026 11:10:24 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 24 Sep 2026 19:09:25 +0100
Subject: [PATCH v10 08/15] drm/panfrost: Move all DRM device initialisation
 into device_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-claude-fixes-v10-8-755929b3cc19@collabora.com>
References: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
In-Reply-To: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5733;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=5lhOVXQZup+E3Rx2DZM+/coFT9uP8Ke0U5hX3WPESxE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtWdZlkhG9Z1EaqYQ4Dm5mOq37cOAplMn5rPan
 t1jLmReJSWJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarVnWQAKCRAOJn5M7lND
 PSMaDACuOLKonzc/p0k29nV79c+L2mJYlMAYdzDFMt4hxFe+Ju+x3M58w4kbuZm8RAJSOLpmYYQ
 6LxmtfDh532FSaBfWQtIDjxh+zNEDZG3lo9860VEu92XXrgpQT+EP9zfsJ2YeGWJJBJ04Wyzrr/
 BGp2jUYGMyahjIIUL2j9k3gt8Ma2UOq90Cm3gHdiQv5AfyUsU26rajXyAS8ZDCcwSbLY/LihO3h
 8bdQMmtKqnmbrXKjcVqgVaE3vhFXtIJ+XS+KfciBk3GISKBPCIYqhWqCbIRbIT8Qh2pl1JQXkk8
 mbOirMwGCttmVaoMYqoesKvdsRhZZCsV6riTAI+SpWtuoWpOCFyn76Qugm2/ffjdosAbADUcTmp
 ZqMooru7AqTEb0j1Ea6Z9wVP9RumnADYv/feF+lDrcl0LT+d0k5SMjaeZSRW/fp9fplb0wmOGt5
 LtvYhFhClqieBuaQwPFXoFL2src59USHqyFwHwthDa8AQFhHb3gRt/QdWB68PHBrtwsss=
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 51 +-----------------------------
 2 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 9f2b1967a398..d531bada62f6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <drm/drm_drv.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -230,6 +231,12 @@ int panfrost_device_init(struct panfrost_device *pfdev)
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
@@ -291,8 +298,35 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err)
 		goto out_perfcnt;
 
+	/* The reason we must manually set the PM status and usage counter is
+	 * we have just powered the device up but did not go through the PM
+	 * runtime resume callback, so we need to update these ourselves.
+	 */
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
@@ -316,6 +350,13 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
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
index 02ddd391231c..f77780c72a1a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -830,7 +830,6 @@ static const struct drm_driver panfrost_drm_driver = {
 static int panfrost_probe(struct platform_device *pdev)
 {
 	struct panfrost_device *pfdev;
-	int err;
 
 	pfdev = devm_drm_dev_alloc(&pdev->dev, &panfrost_drm_driver,
 				   struct panfrost_device, base);
@@ -839,50 +838,7 @@ static int panfrost_probe(struct platform_device *pdev)
 
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
-	/* The reason we must manually set the PM status and usage counter is
-	 * we have just powered the device up but did not go through the PM
-	 * runtime resume callback, so we need to update these ourselves.
-	 */
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
@@ -891,11 +847,6 @@ static void panfrost_remove(struct platform_device *pdev)
 
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

