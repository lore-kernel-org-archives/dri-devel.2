Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9934CC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E3410F481;
	Fri, 28 Aug 2026 20:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="HQL1EMAo";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F27110F481
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950732; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dlC18NI1jRr66QgQvYnCsFR5K2mrWg6FS5kXxYJ0BV2HvAU2YrG40Tzct02BxifyUccAt8uGrXQami63a6fYVwkjUtHyPfaANujRqdAnZ+72nkhTnA7NhIRc2t+ue+L7TmLhkv2BpP9fqrWTOz9Y+bJ8HC/EkJ8r7mdUU2/Wm4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950732;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VD2fes/fOh0H9HYorZiXx5jDAFaLYGFTnncVl2ZZDKE=; 
 b=QYrpmwVvl36HKXNFYpuTeGttDnw9ICwjdKMMk5d6bA0j61iQ2acwrUK2R3+qkzsNhYzWqO5v3bc/h+IJP8ya1huu55qveUKA7hs45msEw2BcG1jpEhTuH4W++5wsgQMRCqLXql84Ci3v2WkmWbbs43tFnN0zMrLQVmYbj6AGWbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950732; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=VD2fes/fOh0H9HYorZiXx5jDAFaLYGFTnncVl2ZZDKE=;
 b=HQL1EMAoxmjN+lFRD2r0Cjy//vgPtTsLixqeucTlr/win4cA7R6oeFm4nej7QS4S
 q1T/96UwmCL+rlKFPqdLmNyl/gbZVT5CMUh+LHF4DRNIGvR6tVk6lNj8knjCISLjZ6t
 v8LkBYU2MtG2GHETHcy9l0+moTbBP7Wc8rCF3LnE=
Received: by mx.zohomail.com with SMTPS id 178795072999763.48774119038751;
 Fri, 28 Aug 2026 13:58:49 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:55 +0100
Subject: [PATCH v7 15/17] drm/panfrost: Introduce a reset lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-15-72a13b2c125d@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3007;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=XxHvCH+XB23J2OhWjCliQe9NFjVTXQVbGLu8ijbSohE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYuOscds0sSOAudIIy2cDZN3wx1wnWupBaK5
 nsUMPYZ++OJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LgAKCRAOJn5M7lND
 Pf7DDACkJ8vR8sD90OwnNBH4PCVoVjoPbxDKJlcbj/EEJ/3ZuTQVNez4WolafvBCxEL34+kahQ5
 8gbWqU2ErIFGlglFmY7n1c9NXJ48Ia6CXqYZE7+gkytt/3CiQVP1zBdtju5DSCwhnT4ak8aVNHu
 sdc7O2F+E2tdjhVY0DhQOes91ZNlt5D6J+B4/vQ8Rociya0/3LzrKRg72xSYemcguCBN8pz0ybN
 GlaiV7oJrzPWssCRYHnu1ynLuLHN2GLkn7A78HQzUlvQYxdCvQbQS9UJmndr+S77LASHWzQZUg7
 p96aFKJyLJsru8xOt4CAJN3wPxG3Jalu1KVMCq8FSRTsXO9GG6IOLMp9V3H4EMV5yOcnBj3X0E5
 v7vUqypHQTccpPe77DKjlnEk060AbnSPKes7M1zmWoudzkkFRCZfZUPnEsyCFr+Jic117eMw/cx
 WZ7f0SVox4cdXYXbxoWVCaW6YPii0iZ5cLfib3A+xkQZjZdoE50JOl8CtBZ2YAvRyYluc=
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 2 ++
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_job.c    | 1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index b6a48ae0d3a6..c8c5dc26b03d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -492,6 +492,8 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 
 void panfrost_device_reset(struct panfrost_device *pfdev)
 {
+	guard(rwsem_write)(&pfdev->reset.lock);
+
 	panfrost_gpu_soft_reset(pfdev);
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index c94546b49662..0570cb1d650d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -165,6 +165,7 @@ struct panfrost_device {
 	struct {
 		struct workqueue_struct *wq;
 		struct work_struct work;
+		struct rw_semaphore lock;
 		atomic_t pending;
 	} reset;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index f77780c72a1a..571a26b84126 100644
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
index a3ff7d644276..e7ffbba58cf9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -891,6 +891,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
 	spin_lock_init(&js->job_lock);
 	mutex_init(&pfdev->sched_lock);
+	init_rwsem(&pfdev->reset.lock);
 
 	js->irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "job");
 	if (js->irq < 0)

-- 
2.55.0

