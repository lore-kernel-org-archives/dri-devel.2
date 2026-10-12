Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9E4CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38FB10E5B9;
	Mon, 12 Oct 2026 14:48:25 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593C710E5B9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791816494; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lVxKFrC9CyUzmbrdEcgM/3N098IFq8wQkUUCv0+TyZvflvkOt8r/dG84nafv46OROQOVnAJId4iXth+k13rirlkGBNQ89nX2suPUi5jNTeB7Wsw7/rLcge1fVI8AVmx6iO2KM4mpHPc/4OHfjOoT0iIEzrqZDTrJ/BHKlnZNYv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791816494;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3tfB9dUhf4vIJBCiCOEyLD4Jpz/dkpla2SoP6tof+CI=; 
 b=EjbhW94TftWqWn7fk4RRRUo3IKur5wtpdV3FtbCFhFL+JrBaWIny4IxX5Y2q4LWkX7/X/HasQbqxdujpviM46GgD5TkRa4rLquBdOvWncse4A17cJE+4qyIrwIkR2f7SMvlsPuYQgh2GNPYwKQMVt48wEXmoKkaw4FmU7tn94Z0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791816494; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=3tfB9dUhf4vIJBCiCOEyLD4Jpz/dkpla2SoP6tof+CI=;
 b=PWnOyeYcUYHyfqjLZWBrGGeTvXv5GQeUEVIq906YCalbw7FzgrP90ZphjEXN4o2J
 V9vp4RwxSCebva8+l9DRT48eTz4BPK0c87mT87gJ9YRJvtqgcGCbMY/Zil1fdTFcGOO
 6b9rpvqaB+B+s4icU9bfTKh/6H9Wi0DZ0g5ONobE=
Received: by smtp.zohomail.com with SMTPS id 1791816492230765.2015092250269;
 Mon, 12 Oct 2026 07:48:12 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 12 Oct 2026 15:47:54 +0100
Subject: [PATCH v15 02/15] drm/panfrost: Move lock and modparam
 initialisations into their subsystems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-claude-fixes-v15-2-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
In-Reply-To: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7241;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=Yft/DjEqqucDjTSqKfKALWWjn/XO9EqkbpRJX6+FO2Q=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqzPMafHHBoFnAo/7GwZChtXHoH8oOrxRFLy6Z+
 oGg/vA4BD6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaszzGgAKCRAOJn5M7lND
 PeusC/oCPlU8sgVzXTjDc114MDVjESuCWy+CHxCOZfPj3q4jFA2bybvKcOdAaWGcsTO4sEZoQoq
 Ej9ZtssKmKkuh5IhV3LrVdVxLMc3AZTmMxaewLHRWKDj/Zxh0N3/PeYbBI7Vpbo/RRpSnu9Yk1z
 Iyp0+DXSDQteK9eCZM8EvrxOP9N1LoECNmxY9lH1XF8RH1tdNVTIu3YZpCyRl5c9ZzhGPO+KnWy
 jhF7GF6kXr+r4KYmzxQW6deWFKDOrBZKaYrm6cjEkw6qFj4xX7UyIw/+10lRaf4X6M0Z/1+vYPE
 MlnHuJi6IRuZFDQeKHR8iUsizj0kENwo0er6Jx4yTydxN+9c5r4lHuZrHSDI/JtoObJMU2DnsKb
 aD6z0kiHOhhXCofXCPsCJN6fAACi3e62lXk13fCs5600TjqHYaNui1r6aX3B4wHnbJnOIVsp9uA
 TgQ9RCvFtFh0Z2dHyFywKzTl8No5R+Rm/3UdmS0ooN58AJeaz8ALM7MmMCJeusG/J597w=
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

The device init function feels a bit cluttered with things that should be
done in the specific subsystems where those locks and lists are being
used. Same goes for module parameters, it's best to limit them to the
subsystems where they're relevant.

Then we can also discard panfrost_drv.h since the transparent_huge_page
doesn't need to be accessed elsewhere. We can also simplify the
creation of a mount point, because drm_gem_get_huge_mnt() would never
return NULL if drm_gem_huge_mnt_create() returns 0 when kernel is built
with support for transparent huge pages.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c       |  7 -------
 drivers/gpu/drm/panfrost/panfrost_drv.c          | 10 ----------
 drivers/gpu/drm/panfrost/panfrost_drv.h          |  9 ---------
 drivers/gpu/drm/panfrost/panfrost_gem.c          | 19 +++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  3 +++
 drivers/gpu/drm/panfrost/panfrost_gpu.c          |  2 ++
 drivers/gpu/drm/panfrost/panfrost_job.c          |  1 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  3 +++
 8 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 05c40d5a20b5..c1a2e93a2b9b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -216,13 +216,6 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 {
 	int err;
 
-	mutex_init(&pfdev->sched_lock);
-	INIT_LIST_HEAD(&pfdev->as_lru_list);
-
-	spin_lock_init(&pfdev->as_lock);
-
-	spin_lock_init(&pfdev->cycle_counter.lock);
-
 #ifdef CONFIG_DEBUG_FS
 	mutex_init(&pfdev->debugfs.gems_lock);
 	INIT_LIST_HEAD(&pfdev->debugfs.gems_list);
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 130ec763343b..86917c8f195f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -21,7 +21,6 @@
 #include <drm/drm_timeout.h>
 
 #include "panfrost_device.h"
-#include "panfrost_drv.h"
 #include "panfrost_gem.h"
 #include "panfrost_mmu.h"
 #include "panfrost_job.h"
@@ -955,12 +954,6 @@ static const struct drm_driver panfrost_drm_driver = {
 #endif
 };
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-bool panfrost_transparent_hugepage = true;
-module_param_named(transparent_hugepage, panfrost_transparent_hugepage, bool, 0400);
-MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with Transparent Hugepage enabled (true = default)");
-#endif
-
 static int panfrost_probe(struct platform_device *pdev)
 {
 	struct panfrost_device *pfdev;
@@ -979,9 +972,6 @@ static int panfrost_probe(struct platform_device *pdev)
 
 	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
 
-	mutex_init(&pfdev->shrinker_lock);
-	INIT_LIST_HEAD(&pfdev->shrinker_list);
-
 	err = panfrost_device_init(pfdev);
 	if (err) {
 		if (err != -EPROBE_DEFER)
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.h b/drivers/gpu/drm/panfrost/panfrost_drv.h
deleted file mode 100644
index a2277ec61aab..000000000000
--- a/drivers/gpu/drm/panfrost/panfrost_drv.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 or MIT */
-/* Copyright 2025 Amazon.com, Inc. or its affiliates */
-
-#ifndef __PANFROST_DRV_H__
-#define __PANFROST_DRV_H__
-
-extern bool panfrost_transparent_hugepage;
-
-#endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index f39c0f50ed4f..383ac8cd5645 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -11,20 +11,27 @@
 #include <drm/panfrost_drm.h>
 #include <drm/drm_print.h>
 #include "panfrost_device.h"
-#include "panfrost_drv.h"
 #include "panfrost_gem.h"
 #include "panfrost_mmu.h"
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static bool panfrost_transparent_hugepage = true;
+module_param_named(transparent_hugepage, panfrost_transparent_hugepage, bool, 0400);
+MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with Transparent Hugepage enabled (true = default)");
+#else
+#define panfrost_transparent_hugepage false
+#endif
+
 int panfrost_gem_init(struct panfrost_device *pfdev)
 {
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && panfrost_transparent_hugepage) {
+	if (panfrost_transparent_hugepage) {
 		int err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
 
-		if (drm_gem_get_huge_mnt(&pfdev->base))
+		if (err)
+			drm_warn(&pfdev->base,
+				 "Can't use Transparent Hugepage (%d)\n", err);
+		else
 			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
-		else if (err)
-			drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
-				 err);
 	}
 
 	return panfrost_gem_shrinker_init(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
index fefae87535d6..72cd7a165e6d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
@@ -97,6 +97,9 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
  */
 int panfrost_gem_shrinker_init(struct panfrost_device *pfdev)
 {
+	mutex_init(&pfdev->shrinker_lock);
+	INIT_LIST_HEAD(&pfdev->shrinker_list);
+
 	pfdev->shrinker = shrinker_alloc(0, "drm-panfrost");
 	if (!pfdev->shrinker)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 29ac0dce5ff8..6081b27829e1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -519,6 +519,8 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 {
 	int err;
 
+	spin_lock_init(&pfdev->cycle_counter.lock);
+
 	err = panfrost_gpu_soft_reset(pfdev);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index d59b4863b8ad..476c936b54e6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -874,6 +874,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 
 	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
 	spin_lock_init(&js->job_lock);
+	mutex_init(&pfdev->sched_lock);
 
 	js->irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "job");
 	if (js->irq < 0)
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..5c393ed6e310 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -955,6 +955,9 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 {
 	int err;
 
+	INIT_LIST_HEAD(&pfdev->as_lru_list);
+	spin_lock_init(&pfdev->as_lock);
+
 	pfdev->mmu_irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "mmu");
 	if (pfdev->mmu_irq < 0)
 		return pfdev->mmu_irq;

-- 
2.55.0

