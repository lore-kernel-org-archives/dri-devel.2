Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD592CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1756B10E3C8;
	Thu,  4 Jun 2026 17:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="RwJhi2Qu";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3571128F0
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780594576; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZG/H4cv4LsYrGuX5Hs8zB9vFMY42IpltOmLu1Dgjfm28/iazT//p8cbaz3E6vvCMEDtnssBruuBmKeM6dMILcvVPa6cbHg7mZ90zg/RVPm7OhjPRatiW+pYl/Duv4eKwshwNOVr8NfOdEs9Z32VcwtY265gzl8WXWb80dpMeJTQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780594576;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Aw8Xp6e/O0fBl1LUOgwrUnYqJiNQ0v1DVfYDC2Jp0rU=; 
 b=mTueuZTh2q+qwUY1zTkwosCT6eFsMnuq4aL3Bul6X0OB2o88CAQZtgJ7vBMpmKnn8l6X+XJ8L8OeDfDMhq9i7wcX3M5rEBeipKf5jIAnQlVsEU+rO6N9yxyu+lozsmNY9/mgzIMT1azSwrCKpFEJ2wWrkkcuSEJUTtzbs7vU+3g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594576; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Aw8Xp6e/O0fBl1LUOgwrUnYqJiNQ0v1DVfYDC2Jp0rU=;
 b=RwJhi2QulxoOH2pM4mjQLlQHFbA5CBN3I/1jm2u6EuvXgGw6+pPe1oSCPD5ZciyS
 HtYXh+BZMeWHDuVvHxQl7H+Xpe2ykK80ONbsiCeGfrK1sHFghy1bAFBX82vwqQUS1BP
 B2qGLWdfCA3Voez4cP+Fupn/knkbTu3ZSsiJJIIE=
Received: by mx.zohomail.com with SMTPS id 1780594573852741.1280981036659;
 Thu, 4 Jun 2026 10:36:13 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 04 Jun 2026 18:35:22 +0100
Subject: [PATCH v2 3/7] drm/panfrost: Move shrinker initialization and
 unplug one level down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-claude-fixes-v2-3-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
In-Reply-To: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4486;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=envzPTUCQc+h2llEXgapJvru00GcWmuLBMhw4xPsdkM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqIbd8AzD5yRWR2OF4sWoMokcZM/xgmSxYu6MCt
 CVm59bvAxmJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaiG3fAAKCRAOJn5M7lND
 PZmNC/91TG6cjRt8ogqHJY9YqDy2MZBcTW0yY+kTW0/kC6mluvGa1OZjymbpefYuaxErIq0LRid
 fEtseQON/iam79BSbJ7IJ4AotBb8x8AVI3Oaahmkcykf0iedX30lBk95ypdLdkSb/o0GWO23uUU
 i2/dIDF79/KVRVjwvpdH//wtgkKqhWbVjYg9n/gk3/Uak5GSfgSMXR+k5ZHKuTc0+wzPGnDJomL
 ryiQkzIVManMzMDUOCCJ3eqkv7uvCFMFp7UUqOEj4zed3LyMSxVvWpho4TFr+bHkhjs4vxwfbkG
 zfm8eJUjFP7JjMMDPQqKtaZMegGTSs8hzpSGVJEi2m+Et1iQV49nzOCZ6uapt4z69ilBzvIJqeT
 X20L8NlfY8MX7VhTZ15Pqa+I/UkapNVbatd3nlCkiASLu5MxGn3lh+TL+IgiqAffcLRSmBRGFj5
 JN97x6fnU8rdezibJnxBrEzqZmGKIWPVcPNNqDL0/d02JCXv6e/jvhN77c59J6B6tRhpw=
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

Since the moment we call drm_dev_register() the device should be in a
position to accept jobs, so it's best if the shrinker is already
initialized by then.

On top of that, make shrinker functions take an panfrost_device pointer
like other functions in the same sequence and rename them accordingly.

Essentially mimic the init/fini behaviour in Panthor.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c       | 7 +++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c          | 6 ------
 drivers/gpu/drm/panfrost/panfrost_gem.h          | 4 ++--
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c | 8 ++------
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 7fed22d555a5..87b372c9e675 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -282,9 +282,15 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err)
 		goto out_job;
 
+	err = panfrost_gem_shrinker_init(pfdev);
+	if (err)
+		goto out_perfcnt;
+
 	panfrost_gem_init(pfdev);
 
 	return 0;
+out_perfcnt:
+	panfrost_perfcnt_fini(pfdev);
 out_job:
 	panfrost_jm_fini(pfdev);
 out_mmu:
@@ -306,6 +312,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
+	panfrost_gem_shrinker_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
 	panfrost_jm_fini(pfdev);
 	panfrost_mmu_fini(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index cb8e5015847f..2d4b6aa95c66 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1000,14 +1000,9 @@ static int panfrost_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_out1;
 
-	err = panfrost_gem_shrinker_init(&pfdev->base);
-	if (err)
-		goto err_out2;
 
 	return 0;
 
-err_out2:
-	drm_dev_unregister(&pfdev->base);
 err_out1:
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
@@ -1021,7 +1016,6 @@ static void panfrost_remove(struct platform_device *pdev)
 	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
 
 	drm_dev_unregister(&pfdev->base);
-	panfrost_gem_shrinker_cleanup(&pfdev->base);
 
 	pm_runtime_get_sync(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index 79d4377019e9..323a1aee255e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -154,8 +154,8 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *bo,
 void panfrost_gem_mapping_put(struct panfrost_gem_mapping *mapping);
 void panfrost_gem_teardown_mappings_locked(struct panfrost_gem_object *bo);
 
-int panfrost_gem_shrinker_init(struct drm_device *dev);
-void panfrost_gem_shrinker_cleanup(struct drm_device *dev);
+int panfrost_gem_shrinker_init(struct panfrost_device *pfdev);
+void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev);
 
 void panfrost_gem_set_label(struct drm_gem_object *obj, const char *label);
 int panfrost_gem_sync(struct drm_gem_object *obj, u32 type,
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
index 2fe967a90bcb..fefae87535d6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
@@ -95,10 +95,8 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
  *
  * This function registers and sets up the panfrost shrinker.
  */
-int panfrost_gem_shrinker_init(struct drm_device *dev)
+int panfrost_gem_shrinker_init(struct panfrost_device *pfdev)
 {
-	struct panfrost_device *pfdev = to_panfrost_device(dev);
-
 	pfdev->shrinker = shrinker_alloc(0, "drm-panfrost");
 	if (!pfdev->shrinker)
 		return -ENOMEM;
@@ -118,10 +116,8 @@ int panfrost_gem_shrinker_init(struct drm_device *dev)
  *
  * This function unregisters the panfrost shrinker.
  */
-void panfrost_gem_shrinker_cleanup(struct drm_device *dev)
+void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev)
 {
-	struct panfrost_device *pfdev = to_panfrost_device(dev);
-
 	if (pfdev->shrinker)
 		shrinker_free(pfdev->shrinker);
 }

-- 
2.53.0

