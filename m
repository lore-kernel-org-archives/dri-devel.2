Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EE0C54F54
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDAD910EA60;
	Wed, 29 Jul 2026 02:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="gTRkNU63";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0872910EA65
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293719; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JdyloWbIY/RcVWpSf7rp4HvtN3pxzNP9Wh8/SPxqu1zWviPLA0zkVvvC6Amok6y9IwRsgPSuYB5nuaABpi8w8e4KSxhqFmj1r/w5sTRAVtaz3ZnXYI57OOMv32LMDuosxH6l2VKT3+66669R9S+sQGh9utFuvqH9yzYVwIq4A2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293719;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XaCwoWojQTgSrs1n8qKjTicKz013/Lei3jUf30lDsVU=; 
 b=a874sxJIouYoHlXMZu+WwiBmzYY1VFvhlmyjK+xtAoKaotOJIsPKf20mFXiaLxKQQU4ZYbnNx+gcZuMyqdOGJHDqLg3FjvGcIPTOrLW5EAqq9FnudplRZSM08Sm/J7Jg26cpBQwIoJQueMg4g7jValUV+dLs1ZpXsG1msh68n6Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293719; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=XaCwoWojQTgSrs1n8qKjTicKz013/Lei3jUf30lDsVU=;
 b=gTRkNU63ifADddqg9jtJMQu+Dc8m9HcCypt9szVM8Zy5KVN3RDCUIx6L7NW+SnOk
 aI7AucEnJpFxuDvA0FMOvmKpderiTdY1EguRVh1dvkfFmhWlpy3WnzL02sQCzKV3Gko
 Pvuoa5WJp+vzvd6tLGVaucvOdMCrvoZXoneY/ya8=
Received: by mx.zohomail.com with SMTPS id 1785293718316323.45528079087285;
 Tue, 28 Jul 2026 19:55:18 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:23 +0100
Subject: [PATCH v4 11/13] drm/panfrost: Introduce a reset lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-11-01968f2ec77a@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3300;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=AIJrw+2AeMglq07AsvxC6mtBDbRuQJcv6JCPqRGD2ac=;
 b=owEB7AET/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtXIf+3NHuI0zN4JtzAUGT+13J7aU7sCCuCN
 QOBRcP9XrKJAbIEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVwAKCRAOJn5M7lND
 PWs1C/d4M4yFZWRjJp9FVJOpCHxcKycLnr+xBvhEvFWo6UYwu3BT9nigyZTMmk6p9aaz2FC8qWl
 5KB2EdoT1Nt9yZIoDQkmsgGzL0RVxXkiVuqaTRY/iYN5UwumbCFrILOk2slAx8Rxc2NRRDoOPxy
 Ty0YRQxlSKnwJ9FQfFBV79TKOZMDFORu6/nPlsi23H6QTqfeOH3IvjVpjaoyZr75KJpcTuqdLUh
 2YbHdNbyB14/xz9qpN1LHDHL/OKhJFHfV/JgcFSGASjjoWuk+4HJC8O9VskN00F66Mg/XAav+Ci
 zL2pFbhQryu24f09VIkwrEmbHtRYIm81TunssAotyYm0c1Foh9DI7Kxpqo0U7KoiWlbfQV/QfIU
 uM0HSLTJmiwvJfS71MET47cVC2ghKq9/h3utdCV+x9fEVgpSBOnccIgRZMWfClfsY6lV9vUh7wD
 b6L/OYN2yv7efEk4V6xC0gUvalBKgrAZzQE6iYVzynAe1tzVeHbcxirB+wFeZ8iEWg0g==
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

So as to avoid accessing HW register while a reset is ongoing, a read/write
semaphore that envelopes the reset sequence will help driver entry points
avoid racing with it. For now, the only such racy entry point is the ioctl
that returns the current GPU timestmap.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 5 +++++
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_job.c    | 2 ++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index c0334b72c70b..926bdf21389f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -615,6 +615,10 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	int ret;
 
+	/* Pre-reset */
+	if (panfrost_device_started(pfdev))
+		down_write(&pfdev->reset.lock);
+
 	/* Do the actual device reset */
 	ret = panfrost_gpu_soft_reset(pfdev);
 	panfrost_gpu_power_on(pfdev);
@@ -625,6 +629,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 		panfrost_jm_reset_interrupts(pfdev);
 		if (enable_job_int)
 			panfrost_jm_enable_interrupts(pfdev);
+		up_write(&pfdev->reset.lock);
 	}
 
 	if (!panfrost_device_started(pfdev) && !ret)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index f96ba50dfa91..81f2290d3e86 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -167,6 +167,7 @@ struct panfrost_device {
 	struct {
 		struct workqueue_struct *wq;
 		struct work_struct work;
+		struct rw_semaphore lock;
 		wait_queue_head_t wait;
 		atomic_t pending;
 	} reset;
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index fac5be20ad60..3212dbadcdb8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -41,9 +41,12 @@ static int panfrost_ioctl_query_timestamp(struct panfrost_device *pfdev,
 	if (ret)
 		return ret;
 
-	panfrost_cycle_counter_get(pfdev);
-	*arg = panfrost_timestamp_read(pfdev);
-	panfrost_cycle_counter_put(pfdev);
+	/* We should not read timestamp register while the GPU  is being reset */
+	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		panfrost_cycle_counter_get(pfdev);
+		*arg = panfrost_timestamp_read(pfdev);
+		panfrost_cycle_counter_put(pfdev);
+	}
 
 	pm_runtime_put(pfdev->base.dev);
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index ed8a1fabd47b..f40563682860 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -893,7 +893,9 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	if (!pfdev->reset.wq)
 		return -ENOMEM;
 	args.timeout_wq = pfdev->reset.wq;
+
 	init_waitqueue_head(&pfdev->reset.wait);
+	init_rwsem(&pfdev->reset.lock);
 
 	for (j = 0; j < NUM_JOB_SLOTS; j++) {
 		js->queue[j].fence_context = dma_fence_context_alloc(1);

-- 
2.55.0

