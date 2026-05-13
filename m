Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4179CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 269FF10EF80;
	Wed, 13 May 2026 16:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="F13wnAN7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4151E10EF84
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778691544;
 bh=5JKcUdxXHvhQCI1LQwFg7UllUAKuTCGb8JFxelc+z4Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=F13wnAN72bQ34z/ls0txawzH+G/Wb1Djs5EMfFi96/xIi2XYvKgjKVjqVs7zRkJZR
 Xl7gPyTiTxPZGEizMPugx6u55UuG+WJYh6bruOivIVD3nZ6IxELerzqOEzhgUohHFM
 7HoZiAFmx5ZGsJf2gaWVAuztoqRBm5SN2vLHjKIszAtK2K5u1zfprTuOeCT3oGr63a
 MTAYgspn5KCCTqfHgB/Z2EHaq6rW6Kn92cn+7F0MmwA6+zwVymQOyAkxASWpRb9rm1
 74k+ngppkOIwj44+XXi0ifUWYoh1ij13sxaVOPh/iYxs2fJcXEZ1fTTtroF1Zj4YiL
 Ivj90abjzz8Vw==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8631317E38C6;
 Wed, 13 May 2026 18:59:03 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 13 May 2026 18:58:54 +0200
Subject: [PATCH 6/6] drm/panthor: Add a new guard for our custom
 resume_and_get() PM helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-panthor-guard-refactor-v1-6-f2d8c15a97ce@collabora.com>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
In-Reply-To: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778691539; l=4385;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=5JKcUdxXHvhQCI1LQwFg7UllUAKuTCGb8JFxelc+z4Y=;
 b=/j4GD7bj6f01mPZjfZbWJzs8fGUcCv15qaDHQz1LMWFkC6+dttkTiBgbsj9qf1GPiwcmVgTz9
 Xsw0wzKTQlNCxJmFMZSmwdxR1WYZ9+kVEd4XWlnUgAspldj2fY9BP+W
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

Overload the already existing pm_runtime_active_auto_try_enabled guard
with our custom guard that force the state to suspened (and thus clear
the runtime_error) in case the resume fails.

Once done, we can replace the existing places where manual
panthor_device_resume_and_get()+pm_runtime_put_autosuspend() were
done by guards.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 10 +++++++---
 drivers/gpu/drm/panthor/panthor_drv.c    |  4 ++--
 drivers/gpu/drm/panthor/panthor_sched.c  | 11 ++++-------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 1aaf06df875b..51527d2e2f77 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -407,9 +407,10 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
 int panthor_device_resume(struct device *dev);
 int panthor_device_suspend(struct device *dev);
 
-static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
+static inline int panthor_device_resume_and_get(struct device *dev)
 {
-	int ret = pm_runtime_resume_and_get(ptdev->base.dev);
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
+	int ret = pm_runtime_resume_and_get(dev);
 
 	/* If the resume failed, we need to clear the runtime_error, which
 	 * can done by forcing the RPM state to suspended. If multiple
@@ -424,11 +425,14 @@ static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 	 * something we can live with.
 	 */
 	if (ret && atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) == 1)
-		pm_runtime_set_suspended(ptdev->base.dev);
+		pm_runtime_set_suspended(dev);
 
 	return ret;
 }
 
+DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled_or_suspend,
+		  panthor_device_resume_and_get(_T), _RET == 0)
+
 enum drm_panthor_exception_type {
 	DRM_PANTHOR_EXCEPTION_OK = 0x00,
 	DRM_PANTHOR_EXCEPTION_TERMINATED = 0x04,
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 789ddc0ff7ef..f2d60ff00896 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -824,7 +824,8 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 		(flags & DRM_PANTHOR_TIMESTAMP_DURATION) ||
 		(timestamp_types >= 2);
 
-	ret = panthor_device_resume_and_get(ptdev);
+	ACQUIRE(pm_runtime_active_auto_try_enabled_or_suspend, pm_guard)(ptdev->base.dev);
+	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled_or_suspend, &pm_guard);
 	if (ret)
 		return ret;
 
@@ -894,7 +895,6 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 		arg->cpu_timestamp_nsec = 0;
 	}
 
-	pm_runtime_put(ptdev->base.dev);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 9aa9941d2309..9afa38e87fc9 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2630,13 +2630,12 @@ static void tick_work(struct work_struct *work)
 	if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
 		return;
 
-	ret = panthor_device_resume_and_get(ptdev);
+	ACQUIRE(pm_runtime_active_auto_try_enabled_or_suspend, pm_guard)(ptdev->base.dev);
+	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled_or_suspend, &pm_guard);
 	if (drm_WARN_ON(&ptdev->base, ret))
 		return;
 
 	tick(sched);
-	pm_runtime_mark_last_busy(ptdev->base.dev);
-	pm_runtime_put_autosuspend(ptdev->base.dev);
 }
 
 static int panthor_queue_eval_syncwait(struct panthor_group *group, u8 queue_idx)
@@ -3359,7 +3358,8 @@ queue_run_job(struct drm_sched_job *sched_job)
 		return dma_fence_get(job->done_fence);
 	}
 
-	ret = panthor_device_resume_and_get(ptdev);
+	ACQUIRE(pm_runtime_active_auto_try_enabled_or_suspend, pm_guard)(ptdev->base.dev);
+	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled_or_suspend, &pm_guard);
 	if (drm_WARN_ON(&ptdev->base, ret))
 		return ERR_PTR(ret);
 
@@ -3367,9 +3367,6 @@ queue_run_job(struct drm_sched_job *sched_job)
 		done_fence = queue_run_job_locked(job);
 	}
 
-	pm_runtime_mark_last_busy(ptdev->base.dev);
-	pm_runtime_put_autosuspend(ptdev->base.dev);
-
 	return done_fence;
 }
 

-- 
2.54.0

