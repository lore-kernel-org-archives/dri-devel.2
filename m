Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365C0C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CA510EA58;
	Wed, 29 Jul 2026 02:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="lItCpRYU";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989CA10EA58
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293683; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cYI2xrqaFsOj8XX/ET1V/uu5oeHGXgz26wx5x6dRuD6Qpv9N7TQod/RJKJmU9GQS8fUtjMo6whonCn5Cmux7wd5i0eES5IisXFZbGCJdmvDpjJzTxYfc7jK3ItYdrfl41w/cKGEj5MFq2n1YjAg6FymhgHYWQvh1rTEVF3ue4/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293683;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1kzvaM/sVXK++3qpL2Yr3/wR3lUNQWo7IzZm1lddka8=; 
 b=arTGq5i41XO9fBYSWA8IDnv2iBAD8FQjDakrzDUbY6TJUwH3T7znloCzswkivcVN8hBNqSkO5pQMpZD1CzK9RZHReVevauyQD1rS4VtP6kIVk8p1sChWMT4Z7XMdUx8pyrU9RtKM+B2PMQPb10Eao8w3PIXayxM/RrZAgxTMOY8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293683; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1kzvaM/sVXK++3qpL2Yr3/wR3lUNQWo7IzZm1lddka8=;
 b=lItCpRYUKWtge7AZUraEGfdhl2qyDLqQv8VD4kshvbsmjbtQz7QOeixjU9RZ+SzC
 1Xgb8cb8v5TgIXDZzQwp4jZt/qzBNGsOGPgfURH4h1X0pmnsQAkQGuzmJSrnJ31gqqE
 SqzAq/Hu02Iv1oVpzX85wUsg1oIy05VTzkQEyAkg=
Received: by mx.zohomail.com with SMTPS id 1785293682167365.41333457434223;
 Tue, 28 Jul 2026 19:54:42 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:16 +0100
Subject: [PATCH v4 04/13] drm/panfrost: Move shrinker initialization and
 unplug one level down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-4-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
In-Reply-To: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6121;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=joT9PlL9hU2eKey1PFjRqTFsz+PaSRiLeEwozdFAh6Y=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtWUDTZ2jPNiLI5c8YvMWjO8gcyT1cjd+TF7
 4gQQ5O8GxmJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVgAKCRAOJn5M7lND
 PbMbC/0ZAYQpTSciGTdVJWsZvaqETjvmK2xoAEjbZEKtPpz60nS5PImvJ+AY3X6auK15JnZe7ZH
 jt02JYPs93sJ4y3oV0wsvZiRoyEFsxV5+XgkbXZgtA/uTR8A2VuN1fdZVe636Un3Rwc9DJ8uRuv
 KxSGwejNBm10dRvWaqAqvxCcBvYq5mZ3sqCYazvB6GATGGxRBDFXubf8R2r3TwWake9CpzQwyAv
 W05cXEPWe7PMdXh4N36YL8bJyUWpoO9OAVB/+DUV5od3Os+qqs2xqe7omPHa7pM/LrpcJHNqSag
 CvhNX9FMX28xJ7zUqj6qvmncJeX272HDPnR+59AdZUXfDIuDyH82NWBx0S3JbMc/sC8vS6RLqwO
 TNs4z9MqdgzX5J1JMhtsqG4OZUkVrREdM1SuTAW7bBsy3c7Iy7Wqn9L/rqlHGBzYy5/Z+HEmGNq
 Oj5qf1OI8OzcjyLWS3nXXACWGp7vxml1/4L9ZlJWFflBVkzDvJDZ23mvq6q8fuE1ZD7LE=
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
 drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
 drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
 drivers/gpu/drm/panfrost/panfrost_gem.c          | 19 ++++++++++---------
 drivers/gpu/drm/panfrost/panfrost_gem.h          |  6 +++---
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
 5 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index d8421fd6a662..03905495aee2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -281,9 +281,14 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err)
 		goto out_job;
 
-	panfrost_gem_init(pfdev);
+	err = panfrost_gem_init(pfdev);
+	if (err)
+		goto out_perfcnt;
 
 	return 0;
+
+out_perfcnt:
+	panfrost_perfcnt_fini(pfdev);
 out_job:
 	panfrost_jm_fini(pfdev);
 out_mmu:
@@ -305,6 +310,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
+	panfrost_gem_shrinker_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
 	panfrost_jm_fini(pfdev);
 	panfrost_mmu_fini(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 2e931fa90da0..331a3bd5b98c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1002,14 +1002,9 @@ static int panfrost_probe(struct platform_device *pdev)
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
@@ -1023,7 +1018,6 @@ static void panfrost_remove(struct platform_device *pdev)
 	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
 
 	drm_dev_unregister(&pfdev->base);
-	panfrost_gem_shrinker_cleanup(&pfdev->base);
 
 	pm_runtime_get_sync(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 3a7fce428898..aa3a604b3439 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -15,20 +15,21 @@
 #include "panfrost_gem.h"
 #include "panfrost_mmu.h"
 
-void panfrost_gem_init(struct panfrost_device *pfdev)
+int panfrost_gem_init(struct panfrost_device *pfdev)
 {
 	int err;
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-	    !panfrost_transparent_hugepage)
-		return;
+	    panfrost_transparent_hugepage) {
+		err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
+		if (drm_gem_get_huge_mnt(&pfdev->base))
+			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
+		else if (err)
+			drm_warn(&pfdev->base,
+				 "Can't use Transparent Hugepage (%d)\n", err);
+	}
 
-	err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
-	if (drm_gem_get_huge_mnt(&pfdev->base))
-		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
-	else if (err)
-		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
-			 err);
+	return panfrost_gem_shrinker_init(pfdev);
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index 79d4377019e9..d6e55c2e4d86 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -129,7 +129,7 @@ drm_mm_node_to_panfrost_mapping(struct drm_mm_node *node)
 	return container_of(node, struct panfrost_gem_mapping, mmnode);
 }
 
-void panfrost_gem_init(struct panfrost_device *pfdev);
+int panfrost_gem_init(struct panfrost_device *pfdev);
 
 struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t size);
 
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
2.55.0

