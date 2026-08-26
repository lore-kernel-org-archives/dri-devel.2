Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B47C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6692310E348;
	Wed, 26 Aug 2026 21:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ZomIYufI";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9214810E348
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787779140; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ILQDyiFl5Ia27SbEfnvnt2AU+qHfQ6Nri8YJvPFBr7oG9ic6iWcblKlqcBtV9egleSmK0sNsYHvYMwvPGSiP2sbw3952fA71sX/cMBpKAdqque/VdfZGYWMikRvRT6MxX5QAZe/MoaujtRbvOfWJKpFWbnAvA7ZOmuR8aLEkM+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787779140;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gBjMnNuVwUEEUlfzgCnAzxMkRvVOaVTqr5gwFUFL0Ok=; 
 b=XPtwp9DiLYfl7Qc1h7benQpTF3rtxMed5P++jv5DYWjDOeAjywtwtflAQj2FVRHbXj4v0iMpa+2kHxtQDuP6/Mj3O7Jeve5XfWR0TDywN9i6LQ74xE025q/jVAhsLIToEp7M79xwBxgqnLperMmQkil5E6aaNXnM9elCEYaXn3w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787779140; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=gBjMnNuVwUEEUlfzgCnAzxMkRvVOaVTqr5gwFUFL0Ok=;
 b=ZomIYufILAYF0zTvm0VIrfnlvoaPM84mzEu4yV6h51/usOIDmEkNkczxoLWfd24W
 orbRLthBLvaixxo+3yWDYRhLigZkZkXKi4YR0LbkajpgK8zhVvVCf8fnVWEdyKuhCop
 Yw6bKDnFkO67+ahL4M7pesAyCoW8q8Ff8pCDwgxU=
Received: by mx.zohomail.com with SMTPS id 1787779137735187.57043034842513;
 Wed, 26 Aug 2026 14:18:57 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 26 Aug 2026 22:18:09 +0100
Subject: [PATCH v6 07/16] drm/panfrost: Split subsystem init/reset from
 interrupt enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260826-claude-fixes-v6-7-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
In-Reply-To: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11096;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=/AU0Y2Amps1pNds5NAeqfyYzVbqmWOuZ023ejvfOyVY=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqj1gLexhfwWhX4OrhkkOoCqcC3cL3SD0lgzAWr
 g0vCg8S0IiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCao9YCwAKCRAOJn5M7lND
 PRTIC/9qmf/Xmf7vVrUNvvL74nHq7CluUesJfH+3WOFvtWhV63JjhexH6mwDAP/iMtSzrjxXxKR
 zHq/Jiv3zqpxnjyrQdolDXWSiuFp1JyB9oJCuCnamdeLqcgAsdHga7Q07XgZ+E7eifIMUx7iyS2
 STBdshU7+shAwmeSBZWe1KrtHpOVsnm8NvHA5mSJF4mI4KhnBqFEoFWNJJkoaQRU7OgpWfL0Ars
 DEupLFNbLG4zbLraypcPKfoN/C8d6A3fg9XF8C3AfHumrWTV463I27+7cRGw3Q4dEB06UmT3RtJ
 iGMEoDX37NzIJNAnibhI+dgWlYrV+eTIGZ+x4O6ji1YGu3SfNPbV61WVDSUWBFISLcVHKImoNtv
 p3tXzhcOJ+Of4wCnKttBWGvvpwOeu4qAh7Jt+hbpfPoYB1tSLzxgcD+GiXZHVrPAxhDryxYTZo7
 Pec119MB9FjKzr3zkdtfZVvKQnj0uGf0RVF+WQq6o+0KecyZmZBHPXQg5Gtz4XRisOKzg=
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

Because MMU interrupts are only enabled when the device is reset, it
happened that after DRM device registration, the very first job targeting
the tiler heap BO would always time out. The reason is the reset sequence
is only part of PM runtime resume, which is not called explicitly at driver
probe time, and an actual reset work item manually triggered after a HW
error.

I have attempted a somewhat drastic solution, which is completely
decoupling GPU/MMU/JM subsystem initialisation and reset from interrupt
enablement, so that we can handle IRQ toggling a bit more flexibly.

To this end:
- Ensure every subsystem with its own IRQ has an 'enable interrupts'
method, and that it doesn't enable them anywhere else.
- Force IRQ masking at MMU reset time. Up until, now, panfrost_mmu_reset()
was clearing the MMU IRQ suspension bit, but at no point that is set during
the reset sequence.

Then manually enable all interrupts when the device is fully initialised at
probe time, right before DRM device registration, or after the reset
sequence is complete. Also disable all interrupts at device remove time,
so that their IRQs can be sync'ed right before tearing the device down.

Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 41 ++++++++++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 ++-
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 19 ++++++++------
 drivers/gpu/drm/panfrost/panfrost_gpu.h    |  2 ++
 drivers/gpu/drm/panfrost/panfrost_job.c    |  7 +++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c    |  9 +++++--
 drivers/gpu/drm/panfrost/panfrost_mmu.h    |  2 ++
 7 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 9549ddb7854a..0cc277efb585 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -226,6 +226,27 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
 	return err;
 }
 
+void panfrost_device_enable_int(struct panfrost_device *pfdev)
+{
+	panfrost_gpu_enable_interrupts(pfdev);
+	panfrost_mmu_enable_interrupts(pfdev);
+	panfrost_jm_enable_interrupts(pfdev);
+}
+
+static void panfrost_device_enable_hw(struct panfrost_device *pfdev)
+{
+	panfrost_device_enable_int(pfdev);
+	panfrost_devfreq_resume(pfdev);
+}
+
+static void panfrost_device_disable_hw(struct panfrost_device *pfdev)
+{
+	panfrost_devfreq_suspend(pfdev);
+	panfrost_jm_suspend_irq(pfdev);
+	panfrost_mmu_suspend_irq(pfdev);
+	panfrost_gpu_suspend_irq(pfdev);
+}
+
 int panfrost_device_init(struct panfrost_device *pfdev)
 {
 	int err;
@@ -297,6 +318,8 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err)
 		goto out_perfcnt;
 
+	panfrost_device_enable_hw(pfdev);
+
 	pm_runtime_set_active(pfdev->base.dev);
 	pm_runtime_mark_last_busy(pfdev->base.dev);
 	pm_runtime_enable(pfdev->base.dev);
@@ -315,6 +338,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 out_devreg:
 	pm_runtime_disable(pfdev->base.dev);
+	panfrost_device_disable_hw(pfdev);
 	panfrost_gem_fini(pfdev);
 out_perfcnt:
 	panfrost_perfcnt_fini(pfdev);
@@ -341,6 +365,8 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	pm_runtime_get_sync(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 
+	panfrost_device_disable_hw(pfdev);
+
 	panfrost_gem_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
 	panfrost_jm_fini(pfdev);
@@ -454,16 +480,12 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 	return false;
 }
 
-void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
+void panfrost_device_reset(struct panfrost_device *pfdev)
 {
 	panfrost_gpu_soft_reset(pfdev);
-
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
-
 	panfrost_jm_reset_interrupts(pfdev);
-	if (enable_job_int)
-		panfrost_jm_enable_interrupts(pfdev);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
@@ -477,8 +499,8 @@ static int panfrost_device_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	panfrost_device_reset(pfdev, true);
-	panfrost_devfreq_resume(pfdev);
+	panfrost_device_reset(pfdev);
+	panfrost_device_enable_hw(pfdev);
 
 	return 0;
 }
@@ -490,10 +512,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 	if (!panfrost_jm_is_idle(pfdev))
 		return -EBUSY;
 
-	panfrost_devfreq_suspend(pfdev);
-	panfrost_jm_suspend_irq(pfdev);
-	panfrost_mmu_suspend_irq(pfdev);
-	panfrost_gpu_suspend_irq(pfdev);
+	panfrost_device_disable_hw(pfdev);
 	panfrost_gpu_power_off(pfdev);
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index a0b9a2145fc9..c94546b49662 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -250,7 +250,8 @@ int panfrost_unstable_ioctl_check(void);
 
 int panfrost_device_init(struct panfrost_device *pfdev);
 void panfrost_device_fini(struct panfrost_device *pfdev);
-void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
+void panfrost_device_enable_int(struct panfrost_device *pfdev);
+void panfrost_device_reset(struct panfrost_device *pfdev);
 
 extern const struct dev_pm_ops panfrost_pm_ops;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 8a15ccce08e9..c8e0b1acc669 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -67,8 +67,6 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 	gpu_write(pfdev, GPU_INT_MASK, 0);
 	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
 
-	clear_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended);
-
 	gpu_write(pfdev, GPU_CMD, GPU_CMD_SOFT_RESET);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + GPU_INT_RAWSTAT,
 		val, val & GPU_IRQ_RESET_COMPLETED, 10, 10000);
@@ -87,12 +85,6 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 
 	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_MASK_ALL);
 
-	/* Only enable the interrupts we care about */
-	gpu_write(pfdev, GPU_INT_MASK,
-		  GPU_IRQ_MASK_ERROR |
-		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED |
-		  GPU_IRQ_CLEAN_CACHES_COMPLETED);
-
 	/*
 	 * All in-flight jobs should have released their cycle
 	 * counter references upon reset, but let us make sure
@@ -504,6 +496,17 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
 		dev_err(pfdev->base.dev, "l2 power transition timeout");
 }
 
+void panfrost_gpu_enable_interrupts(struct panfrost_device *pfdev)
+{
+	clear_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended);
+
+	/* Only enable the interrupts we care about */
+	gpu_write(pfdev, GPU_INT_MASK,
+		  GPU_IRQ_MASK_ERROR |
+		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED |
+		  GPU_IRQ_CLEAN_CACHES_COMPLETED);
+}
+
 void panfrost_gpu_suspend_irq(struct panfrost_device *pfdev)
 {
 	set_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
index b4fef11211d5..743d45b00d9f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
@@ -15,6 +15,8 @@ u32 panfrost_gpu_get_latest_flush_id(struct panfrost_device *pfdev);
 int panfrost_gpu_soft_reset(struct panfrost_device *pfdev);
 void panfrost_gpu_power_on(struct panfrost_device *pfdev);
 void panfrost_gpu_power_off(struct panfrost_device *pfdev);
+
+void panfrost_gpu_enable_interrupts(struct panfrost_device *pfdev);
 void panfrost_gpu_suspend_irq(struct panfrost_device *pfdev);
 
 void panfrost_cycle_counter_get(struct panfrost_device *pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 5016d2d53da2..087905cd347a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -732,7 +732,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 	spin_unlock(&pfdev->js->job_lock);
 
 	/* Proceed with reset now. */
-	panfrost_device_reset(pfdev, false);
+	panfrost_device_reset(pfdev);
 
 	/* GPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&pfdev->reset.pending, 0);
@@ -753,8 +753,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
-	/* Re-enable job interrupts now that everything has been restarted. */
-	panfrost_jm_enable_interrupts(pfdev);
+	/* Re-enable interrupts now that everything has been restarted. */
+	panfrost_device_enable_int(pfdev);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -908,7 +908,6 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	}
 
 	panfrost_jm_reset_interrupts(pfdev);
-	panfrost_jm_enable_interrupts(pfdev);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 5c393ed6e310..7fd89ee4ef9e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -340,7 +340,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
 {
 	struct panfrost_mmu *mmu, *mmu_tmp;
 
-	clear_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
+	mmu_write(pfdev, MMU_INT_MASK, 0);
 
 	spin_lock(&pfdev->as_lock);
 
@@ -356,7 +356,6 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
 	spin_unlock(&pfdev->as_lock);
 
 	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
-	mmu_write(pfdev, MMU_INT_MASK, ~0);
 }
 
 static size_t get_pgsize(u64 addr, size_t size, size_t *count)
@@ -981,6 +980,12 @@ void panfrost_mmu_fini(struct panfrost_device *pfdev)
 	mmu_write(pfdev, MMU_INT_MASK, 0);
 }
 
+void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
+{
+	clear_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
+	mmu_write(pfdev, MMU_INT_MASK, ~0);
+}
+
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
 {
 	set_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index 27c3c65ed074..689cf95caa21 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -15,6 +15,8 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping);
 int panfrost_mmu_init(struct panfrost_device *pfdev);
 void panfrost_mmu_fini(struct panfrost_device *pfdev);
 void panfrost_mmu_reset(struct panfrost_device *pfdev);
+
+void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev);
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
 
 int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);

-- 
2.55.0

