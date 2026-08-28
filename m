Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31208C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 564A410F45E;
	Fri, 28 Aug 2026 20:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="h+GrhLs2";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC15010E13A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950656; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dqTnxofqAXgiOP2lhLMUpLksYQRUMQXAu9/4Nw3ZnAHVet+qWPXhawwDnhNwuLSNIVLA10bbpaNNmH49qpWnoeB/CHirVLw1uPM/k8qIEj3ecAnE6YQGWmCbOoE/RHfjgCg766MdhqiWezPuOajmbZIK9eTnTO4xA9wOwMUk6i0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950656;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KTjS5hBPQO6+RTeil7zhPBG8q7IaCwN0MeCCodQTYuk=; 
 b=Zp0kXRQFVNdbdSOsJpgVwHB/w+f735B40uxhc/5EGVMNTp98FbAoApeKLzSslJFFaLMAodLfUoV92WqTzc+pDhrRhT//0mc0z5Ti9nAk5D3rLnbnwJe9tMxQB1RJm/mBVFBa6zUSMnuaU3nzik8TjCpJ9/e0cXN0EKk165ji+K8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950656; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=KTjS5hBPQO6+RTeil7zhPBG8q7IaCwN0MeCCodQTYuk=;
 b=h+GrhLs2tieRylZX2D0G+Blfw95fjGXEua6SeJQNTiGYLpLN6MdCN2U1iJMDB6HG
 XQ5Lsr+dl4Hdt6LOeICJ0m8wxX5rbphl11WjsjQ6lf0vMj5COzY8rIWbmxNBaF6JE+y
 ahsbFV5BUqO7/4ypmEnpyg0kf6677ftW28PnCJ0E=
Received: by mx.zohomail.com with SMTPS id 1787950654519845.7055630987205;
 Fri, 28 Aug 2026 13:57:34 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:42 +0100
Subject: [PATCH v7 02/17] drm/panfrost: Move all DRM device initialisation
 into device_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-2-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
In-Reply-To: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5174;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=+7lLC3RASscJtzYIoHPamAqwjiOy0dTWtgEK2tQLZCc=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYsD9Kf79FEW5OX4cZirTK2Uk8soY3j5HSAO
 DgWvJc3MfmJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LAAKCRAOJn5M7lND
 Pa3jDACqor8Y+iJnFwVoyFqjtdv8fZwilBv2VsHd4wwvFWjnqI1rZrwO1w6PoT8bm9IBrQ/JkB2
 2SsoXkpoP8ma83+PzwOQTh7LvjLYQXR6MdoJHJcEsYKQgYE4IbA4F3eVzZzjXEPwfm2+b4sTp5Y
 rw/Rm0pMZuTSpnLT8Wq7RVHCVfkm6fgU/c5donP6vvAgAElH0PrVekflVurB/jg83+oUYI6Qyua
 R0bMCyiuNXTatuBHF4lna0a70QJ48tenVZM4HMzWyGHCmqtrlAsLWIhf17SvzeyUmBdg2yavOde
 1HRVjbAlX0ugQy3A/+jIako2MHxaREkcqH/NiYkOAQmAzCrdNRLJY27Cc1OOo7lPuKSeZy6bb/b
 WCpQJThyaFjFQxg0fnBeDXMRDU41w/JfseCnDolbeoPkWuBA+la8UiashE6nYW4si1ua8Laftjt
 qprkfTV9j9tH+TeTKbSN5e9GHT0+AIESetxJlBx1ZJNhgomoU2CAFVOI6PxtaEFfmQzl4=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 33 ++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 44 +-----------------------------
 2 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 05c40d5a20b5..d2d2830f11a7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <drm/drm_drv.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -216,6 +217,15 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 {
 	int err;
 
+	pfdev->comp = of_device_get_match_data(pfdev->base.dev);
+	if (!pfdev->comp)
+		return -ENODEV;
+
+	pfdev->coherent = device_get_dma_attr(pfdev->base.dev) == DEV_DMA_COHERENT;
+
+	mutex_init(&pfdev->shrinker_lock);
+	INIT_LIST_HEAD(&pfdev->shrinker_list);
+
 	mutex_init(&pfdev->sched_lock);
 	INIT_LIST_HEAD(&pfdev->as_lru_list);
 
@@ -284,8 +294,25 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err)
 		goto out_perfcnt;
 
+	pm_runtime_set_active(pfdev->base.dev);
+	pm_runtime_mark_last_busy(pfdev->base.dev);
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
+		goto out_devreg;
+
 	return 0;
 
+out_devreg:
+	pm_runtime_disable(pfdev->base.dev);
+	panfrost_gem_fini(pfdev);
 out_perfcnt:
 	panfrost_perfcnt_fini(pfdev);
 out_job:
@@ -304,11 +331,15 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	panfrost_reset_fini(pfdev);
 out_pm_domain:
 	panfrost_pm_domain_fini(pfdev);
+	pm_runtime_set_suspended(pfdev->base.dev);
 	return err;
 }
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
+	pm_runtime_get_sync(pfdev->base.dev);
+	pm_runtime_disable(pfdev->base.dev);
+
 	panfrost_gem_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
 	panfrost_jm_fini(pfdev);
@@ -319,6 +350,8 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	panfrost_clk_fini(pfdev);
 	panfrost_reset_fini(pfdev);
 	panfrost_pm_domain_fini(pfdev);
+
+	pm_runtime_set_suspended(pfdev->base.dev);
 }
 
 #define PANFROST_EXCEPTION(id) \
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 9882a3ede75f..80996e311a9d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -964,7 +964,6 @@ MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with T
 static int panfrost_probe(struct platform_device *pdev)
 {
 	struct panfrost_device *pfdev;
-	int err;
 
 	pfdev = devm_drm_dev_alloc(&pdev->dev, &panfrost_drm_driver,
 				   struct panfrost_device, base);
@@ -973,45 +972,7 @@ static int panfrost_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pfdev);
 
-	pfdev->comp = of_device_get_match_data(&pdev->dev);
-	if (!pfdev->comp)
-		return -ENODEV;
-
-	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
-
-	mutex_init(&pfdev->shrinker_lock);
-	INIT_LIST_HEAD(&pfdev->shrinker_list);
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
-
-	return 0;
-
-err_out1:
-	pm_runtime_disable(pfdev->base.dev);
-	panfrost_device_fini(pfdev);
-	pm_runtime_set_suspended(pfdev->base.dev);
-err_out0:
-	return err;
+	return panfrost_device_init(pfdev);
 }
 
 static void panfrost_remove(struct platform_device *pdev)
@@ -1020,10 +981,7 @@ static void panfrost_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&pfdev->base);
 
-	pm_runtime_get_sync(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
-	pm_runtime_set_suspended(pfdev->base.dev);
 }
 
 static ssize_t profiling_show(struct device *dev,

-- 
2.55.0

