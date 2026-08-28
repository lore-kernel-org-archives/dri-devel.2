Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97303C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C818210F473;
	Fri, 28 Aug 2026 20:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="O1tfyQ6R";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CC510F473
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950690; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ku1JYnDRP8cS98fZNX8rb2khJBFDm9ZyUQStVErbnYA/gDySNLfs/hyJa0UL+I5qqoyunXh5jTfw1cwMJLiDM13ee9k8tHzEq4WaZxj3MX6KqMnqQcaM/NxkDBdQvoSR9DEmsTgdH50RrVdjSJCDXwZwLZLJwKW8nrJntV+tyvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950690;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=F5z/8ycwPUffCKjaBmrIZdQo0tveJFXXY3IIO7N7iR8=; 
 b=nlE/17WjS8wueioxiVwkgqjwmblEQ4ekk/G71VuHwMESXucej5fRXcnliuMSs69PB9GZlEbuE+vyuPB2Kl6kU8W0mvvcpKL3Er8zs3dAbBkeTeVceWtFEfDT8WVrUBo4Ksgw4uJjk56XzSfi35qFCcTC+QzQDY0AAwua2PIfBC0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950690; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=F5z/8ycwPUffCKjaBmrIZdQo0tveJFXXY3IIO7N7iR8=;
 b=O1tfyQ6Rxhgo/YJ117J81xctFAik11ZpbeyAHZ9FEPjJygXDWxfMfxUjbZK4dXEP
 ED2qpj7gdsdWACF5wtvwC49SN7S/BzmF0PFhNd2d+h3CRRO1T138a6V0zc8Lh+HsPEJ
 LHQ/HE+MZl+RKdguoyf5/RfvuESVjiyd8il3IYtE=
Received: by mx.zohomail.com with SMTPS id 1787950687808981.8407835768854;
 Fri, 28 Aug 2026 13:58:07 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:48 +0100
Subject: [PATCH v7 08/17] drm/panfrost: Split subsystem init/reset from
 interrupt enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-8-72a13b2c125d@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11059;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=Rmo/XO9XHoEmEO/7OVid6jBs5qtFuXwEb0EvBhaQe34=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYtMhqBVphzK72uG5KAl8Mki5XNCQxmjP0MX
 iDAeNQBAkWJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LQAKCRAOJn5M7lND
 PW7bC/43S59BXdLYAlGazPYMJj5rNlorjCymGoIlhGRp26ue81nVRDUZCGatDwXPxUvnlkun/6O
 AaMEUyTm4fkYfBFnO1uaSlm6y5BBQYluTgDiOUsIBDgQYva4ecmZu66G+VGwdwJLNyzCc1b/mef
 Lwb+6mH7Rz08uKhsscMwUJ4gTNGjDTNkpdbf1+w/TAaBPPej+Qp+diZF7JN+lV0fJIRW0WXBmFe
 UnJACu/VjrByM+w/wTnBkoyCBLNH2y9CsMwYJ3dm7LKF/uBMAN4YscWG4vyl1fdyX0KTLxQp1lu
 qwcfy4ZDRDvyXNS7lRhObLzEBLnCxmATjLmLzXwBOS6vzocIYkhR2BVr8up2COaCQMpsk1/DIju
 q6EUDoIkbBtcYK9Lw/tFSun5P04OhZTj022SzuaiXbkjFAuxeXQLS8RkO48656dnD9awnfWOAzH
 j2FDCe3dQtsS0w2rkGzzZiKTqTos9UzJKF5rEX00iNSe81JDs+tfsyX5xv2BZFWeBMqz0=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 40 ++++++++++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_device.h |  3 ++-
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 19 ++++++++------
 drivers/gpu/drm/panfrost/panfrost_gpu.h    |  2 ++
 drivers/gpu/drm/panfrost/panfrost_job.c    |  7 +++---
 drivers/gpu/drm/panfrost/panfrost_mmu.c    |  9 +++++--
 drivers/gpu/drm/panfrost/panfrost_mmu.h    |  2 ++
 7 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 9e02fb5f73c8..99f7da2180f9 100644
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
@@ -342,6 +366,7 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	pm_runtime_disable(pfdev->base.dev);
 
 	panfrost_jm_stop_sched_jobs(pfdev);
+	panfrost_device_disable_hw(pfdev);
 
 	panfrost_gem_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
@@ -456,16 +481,12 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
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
@@ -479,8 +500,8 @@ static int panfrost_device_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	panfrost_device_reset(pfdev, true);
-	panfrost_devfreq_resume(pfdev);
+	panfrost_device_reset(pfdev);
+	panfrost_device_enable_hw(pfdev);
 
 	return 0;
 }
@@ -492,10 +513,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
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
index 630298b7ea8a..a3ff7d644276 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -747,7 +747,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 	panfrost_stop_jobs(pfdev);
 
 	/* Proceed with reset now. */
-	panfrost_device_reset(pfdev, false);
+	panfrost_device_reset(pfdev);
 
 	/* GPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&pfdev->reset.pending, 0);
@@ -768,8 +768,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
-	/* Re-enable job interrupts now that everything has been restarted. */
-	panfrost_jm_enable_interrupts(pfdev);
+	/* Re-enable interrupts now that everything has been restarted. */
+	panfrost_device_enable_int(pfdev);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -923,7 +923,6 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
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

