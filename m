Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28A9C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE5F10E611;
	Fri, 24 Jul 2026 00:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="CfT5Oj79";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFE110E611
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851237; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gmWSkZz44xVeUhSgmOm9Xe0bnpIwEQZxAQm2Z5dA0nKT4skuDC2l6+/bRHFshjSCOH0hb6cvfuDbnK2XiDQQUzQfS5x1aSXj0NmSeb+z8ibAdVpff0ty+NYrUwROtEl8D5afhkhVfxzjwizHdrUD9Cr1fwLbf/hPHc4yPdIum/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851237;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=eDNnqgnZU72iYmpE1bKG1/fpRFgXbogRm5CpzmddOuU=; 
 b=gknip5N1SDwj8o/NeqlIqjum0iKZflJ1xXlyNuBbMbsyJJxsaB5qDs9unFxcM1mMjtL8fUi537mmsY48wN1LWq7xZ9gP0F7Hf+U21qWbFNa9CL3GU/M+yO4W4SIfBzD1RN6qMWDrZF85S0Drm4+s3Qjx4AVoO0XRIXTmswYNMDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851237; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=eDNnqgnZU72iYmpE1bKG1/fpRFgXbogRm5CpzmddOuU=;
 b=CfT5Oj79OuQ2Dx6AqeEFjWqbJhW2VzjY18RR4VPB1XHs4GMg8HZ6qv08PSm5AGfR
 rhauDMp0j5+Ai+fGKCyr4uQNihXR+/fBkjbNv9VcNeFaBW27agThKDMFoAoLJLcnCXG
 tpbMCp3aYXCUU9rPZkuVsvJBLivyMtJ+01feFV8k=
Received: by mx.zohomail.com with SMTPS id 1784851235204158.1304830012358;
 Thu, 23 Jul 2026 17:00:35 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:59:01 +0100
Subject: [PATCH v3 08/13] drm/panfrost: Rewire reset sequence to avoid
 concurrent attempts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-8-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
In-Reply-To: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3904;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=cWP60f/sU6HbsGbiX3msep8L6EjlkG92o3kqyo/Yy94=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqroSJOMrW656b0Yx0KAOaeuj9wEFwXtrHrL/
 TQgDwb6P9SJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 Pda/C/0X3Zja4UXeN6VrubGRNzzerqzjyNxofcXGynZyxvK7coiffdBbhd6EwwijPIqcihGob0x
 Z1H3+7iYvDfKD0GkN3jdi+RRjiy/WJVSRrvN3aFVHlbZUmkw6hw+TJU695Wguk9KHSnKKyCZcPX
 4TH35cWjFQJXNKScscm3DqkIRe9qR3V5LHbOxfEDLVPbxRAa5sXmSy0HfrvtyVerO38gQpoF/pD
 4HQqhxqPzeEuBMEB1mM5sN8cqj+Pi5Aw8OrHMRCsMtT7ORi6VlyJPPCKohEJtyM+5RWT9/jN8Nr
 iBaPcRNLQbQsQf637BDUeaD5YsRTK+IELPks8Yguvjm4GeyCxfWUjyaNawnPliWKkDdIQqv+vHM
 1jwwkR8LyCSXLFxUk9y/zVOKVmjzKvBH41ctl89S3CZOgFYFROCIwdGaWUf6s/j+61kdHBgsaZb
 JjJtxJ+3meG+/CmqyvZRYQyITZ2Gr0pmhOfZThkhMcmGkX9ib1HY6GLA9Q9DZFxD1TmBE=
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

This way, and in imitation of Panthor, only a single reset thread can
progress at a time, and other threads wanting to trigger it just wait
on the ongoing one to finish and wake them up.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c |  1 +
 drivers/gpu/drm/panfrost/panfrost_device.h |  5 +++--
 drivers/gpu/drm/panfrost/panfrost_job.c    | 16 ++++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index d68f1ec82895..cf115db9cebf 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/wait.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 6bec8fcb701e..23dea923bd04 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -167,6 +167,7 @@ struct panfrost_device {
 	struct {
 		struct workqueue_struct *wq;
 		struct work_struct work;
+		wait_queue_head_t wait;
 		atomic_t pending;
 	} reset;
 
@@ -341,8 +342,8 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 static inline void
 panfrost_device_schedule_reset(struct panfrost_device *pfdev)
 {
-	atomic_set(&pfdev->reset.pending, 1);
-	queue_work(pfdev->reset.wq, &pfdev->reset.work);
+	if (!atomic_cmpxchg(&pfdev->reset.pending, 0, 1))
+		queue_work(pfdev->reset.wq, &pfdev->reset.work);
 }
 
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 2d12b83e900a..c2a1670a74e8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -497,10 +497,8 @@ static void panfrost_job_handle_err(struct panfrost_device *pfdev,
 
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 
-	if (panfrost_exception_needs_reset(pfdev, js_status)) {
-		atomic_set(&pfdev->reset.pending, 1);
+	if (panfrost_exception_needs_reset(pfdev, js_status))
 		drm_sched_fault(&pfdev->js->queue[js].sched);
-	}
 }
 
 static void panfrost_jm_handle_done(struct panfrost_device *pfdev,
@@ -755,6 +753,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	panfrost_jm_enable_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
+
+	wake_up_all(&pfdev->reset.wait);
 }
 
 static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
@@ -763,6 +763,7 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 	struct panfrost_job *job = to_panfrost_job(sched_job);
 	struct panfrost_device *pfdev = job->pfdev;
 	int js = panfrost_job_get_slot(job);
+	int ret;
 
 	/*
 	 * If the GPU managed to complete this jobs fence, the timeout has
@@ -797,10 +798,12 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 
 	panfrost_core_dump(job);
 
-	atomic_set(&pfdev->reset.pending, 1);
-	panfrost_reset(pfdev, sched_job);
+	panfrost_device_schedule_reset(pfdev);
+	ret = wait_event_timeout(pfdev->reset.wait,
+				 !atomic_read(&pfdev->reset.pending),
+				 msecs_to_jiffies(60));
 
-	return DRM_GPU_SCHED_STAT_RESET;
+	return (ret) ? DRM_GPU_SCHED_STAT_RESET : DRM_GPU_SCHED_STAT_ENODEV;
 }
 
 static void panfrost_reset_work(struct work_struct *work)
@@ -892,6 +895,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	if (!pfdev->reset.wq)
 		return -ENOMEM;
 	args.timeout_wq = pfdev->reset.wq;
+	init_waitqueue_head(&pfdev->reset.wait);
 
 	for (j = 0; j < NUM_JOB_SLOTS; j++) {
 		js->queue[j].fence_context = dma_fence_context_alloc(1);

-- 
2.55.0

