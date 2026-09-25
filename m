Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EABC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F80810FC10;
	Fri, 25 Sep 2026 18:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jY3Rj9Tg";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A6710FC10
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790361976; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZjolhICEoVYWNzmjXVNbYeKQFbAspEcmMh9IKUYdt+DXWvRXYK/BHf/OfT9GsozmsXbyNH4UybKI6ch0htI1QqbBsaWu7SVaseHST6nG5AGDZdxhM0zXsEna+VHkSK8/gHQckP7ctCigkqjJ9DrE6UEQEAftOWs39h6cy694+YY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790361976;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=71FULSkaYc74KsTrakzFgr/RxxmJxiZGEoH1jtxrBWQ=; 
 b=bdg/POviFYx631cGutlgtfQAfa03q+JNx2sLmtFDM9kcoKDDcOxRwohTGJFQnn+x7a3ueEzQcYMdEYo5uCSlWs26ABH07U7C61f6tL6Hc3J1arTXu+hyKfzZGufEyQzr8qRtgnj0hWFV8YFP9NJIgMsOngNZ85zKdVHzkgP76vk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790361976; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=71FULSkaYc74KsTrakzFgr/RxxmJxiZGEoH1jtxrBWQ=;
 b=jY3Rj9TgAGfvD30Wxte8WmGXFo2TXLbfDZq+MCdNHH0RxnMsmDBLZMUEZ2IKjAyD
 2KPtpqKYPK7KN99/r7BbAjg7eZxHwPw9s2wRBvtU8EMaBHjq4jzHZWwKTf5zLg4AoDQ
 gpeJRYl1x4e+xqf/nB8jVcZc/tDpvfPIq+7bg2N4=
Received: by smtp.zohomail.com with SMTPS id 1790361975044531.0266577782828;
 Fri, 25 Sep 2026 11:46:15 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 25 Sep 2026 19:45:29 +0100
Subject: [PATCH v11 08/15] drm/panfrost: Move all DRM device initialisation
 into device_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-claude-fixes-v11-8-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
In-Reply-To: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6169;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=/bKH5elgcrjf7NBLI4NvlXyrB/1T8UuUFdCHxNM0Xbs=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtsFDSZ5f4m+EK3U/KhEiq0Pm2i7xmlU2ThAFj
 58ZElIkgTiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbBQwAKCRAOJn5M7lND
 Pf/QDACk0HKpavJdKj0s4LruZ8uFbPVUWDATWNntI390ZRZLSPCuKNokg8Qwtz4bBF8NGKDoXNc
 NEv5OeRoZ7twgge9kKndqQStIDG2XEJexoSIPJAODz1P/S9nh0ugep7j0Br3Nl8L2feg4HjBtlF
 3151bT7neV32hqplfQGJha6+VgKao2EyQy40G+QGlxYweGZi0y7JXJ5nBhP09/oteEc0VPRlrkP
 58ApdiUnbfqOXM2+VfVpMwrW9/ni0jo0u5pXbzuvA8XJg/Nt2P3PfHSdjt7dMHAeY8t0TlU4ewQ
 q6Fi6uCrHsPRRB8UV15d5TeD8l1tAmlR1JxU1iDzjB5LzfQD9G69pQFH5o83IL+V+rjIj3rfkAR
 JX7uuoDuJc7VsFrHPk7gZ6xvCSS/O+PfO/fh1RShdq3T+ypOP2X3DLHmsMKkE/ZCsG7Qp+6Kaxl
 bBzGn60NiSR/mV076awtGzB5IvikwHZqUfta4aZ4soybRwptHxfLaHynSnAtpOFoZIusk=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 46 ++++++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 52 +-----------------------------
 2 files changed, 47 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 9f2b1967a398..b8094c0d1252 100644
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
@@ -291,8 +298,33 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err)
 		goto out_perfcnt;
 
+	/* The reason we must manually set the PM status and usage counter is
+	 * we have just powered the device up but did not go through the PM
+	 * runtime resume callback, so we need to update these ourselves.
+	 */
+	pm_runtime_get_noresume(pfdev->base.dev);
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
+		goto err_disable_rpm;
+
+	pm_runtime_put_autosuspend(pfdev->base.dev);
+
 	return 0;
 
+err_disable_rpm:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
+	pm_runtime_disable(pfdev->base.dev);
+	panfrost_gem_fini(pfdev);
 out_perfcnt:
 	panfrost_perfcnt_fini(pfdev);
 out_job:
@@ -311,11 +343,22 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	panfrost_reset_fini(pfdev);
 out_pm_domain:
 	panfrost_pm_domain_fini(pfdev);
+
+	if (pm_runtime_active(pfdev->base.dev)) {
+		pm_runtime_set_suspended(pfdev->base.dev);
+		pm_runtime_put_noidle(pfdev->base.dev);
+	}
+
 	return err;
 }
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
+	pm_runtime_get_sync(pfdev->base.dev);
+
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
+	pm_runtime_disable(pfdev->base.dev);
+
 	panfrost_gem_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
 	panfrost_jm_fini(pfdev);
@@ -326,6 +369,9 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	panfrost_clk_fini(pfdev);
 	panfrost_reset_fini(pfdev);
 	panfrost_pm_domain_fini(pfdev);
+
+	pm_runtime_set_suspended(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
 }
 
 #define PANFROST_EXCEPTION(id) \
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 907d4a14a0b5..f77780c72a1a 100644
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
-	pm_runtime_get_noresume(pfdev->base.dev);
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
-	pm_runtime_put_autosuspend(pfdev->base.dev);
-
-	return 0;
-
-err_out1:
-	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
-	panfrost_device_fini(pfdev);
-	pm_runtime_set_suspended(pfdev->base.dev);
-	pm_runtime_put_noidle(pfdev->base.dev);
-err_out0:
-	return err;
+	return panfrost_device_init(pfdev);
 }
 
 static void panfrost_remove(struct platform_device *pdev)
@@ -891,13 +847,7 @@ static void panfrost_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&pfdev->base);
 
-	pm_runtime_get_sync(pfdev->base.dev);
-	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
-	pm_runtime_set_suspended(pfdev->base.dev);
-	pm_runtime_put_noidle(pfdev->base.dev);
-
 }
 
 static ssize_t profiling_show(struct device *dev,

-- 
2.55.0

