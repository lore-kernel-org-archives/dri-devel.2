Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8763C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1E110E39A;
	Mon,  6 Jul 2026 13:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lhe7iZqR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCB810E39A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NIzqLVn81E0+qb8jokX3LcPEEFcsdZVcGyAUrXI6UNw=; b=lhe7iZqR/B+p2tJlMHp+N0vjJV
 kxhOVzI5d+eeeHWMGQ/Q0vNqzoOsjo45lAs4VMy/C/CpEscidvr3/5RYx1YEPHBGUVtoYEdaJ3np9
 /MUdwbcxodM69N82tHMZQaUQMWQXd/ReyFbkU0gxhtG/rmWJnOJSKLHllF84RAMyUlNG7JopFZB9g
 0DhqYFKlhM2Q+0P7b+3v/eEikZto7LS5WBGXMCcpXw9KHvs5/u04DDdSgRHpq/bOmIVT+ePE6K5U0
 2JJgwO8PLlpSY7g/GvqXPPTNOYttcGWU1ldYRmgY2jGT1WwTL65cRTdb+f81xsEj453abmSO6O+Gq
 z0GPOY9Q==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wgjO5-009l5x-6J; Mon, 06 Jul 2026 15:29:29 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 06 Jul 2026 10:29:18 -0300
Subject: [PATCH v4 1/2] drm/v3d: Refactor perfmon locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-v3d-perfmon-lifetime-v4-1-d7b312ff2c83@igalia.com>
References: <20260706-v3d-perfmon-lifetime-v4-0-d7b312ff2c83@igalia.com>
In-Reply-To: <20260706-v3d-perfmon-lifetime-v4-0-d7b312ff2c83@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16912; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=p2C5YtEPQhA1h61U3t6AOd1XeLqWVSIEuIxdRNaZPDk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqS62z9vKxXpiq40/Zn/FRdXpcb2fk7aCGL+78Y
 2IZ92xqdMSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCakutswAKCRA/8w6Kdoj6
 qiEyCADXWgfE7ZlhnKWq/nsVX8fd2YExRWyZ9GwBfOvZxKYd1e2jZipO5IGVvEE9Ba5xBYcZXHw
 URUL0pcbLO0ABPuZa0OHQzeZweD5TNKo50znZnMP2fG/wACt5IejRdgVs1N+3jY9B+Z22P0mrXr
 w0HjSARoERb7G5GoPjLpKmLwGYC7P783v3dfI9IEcs+V/hklY+kykeG0C1HnDsjR/n6oe5+DO8Z
 D9DaCeXufbBMbwQpMv40/To/JpfvO6n9aWwvqtEaHyA54RjJSgWBVuC5N2O11SMcMofkKgrkVlF
 I2EA/P5etuWOOcuNjPH3mVZCSkoKlornhe551v0hRcewwyBx
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

v3d exposes a single set of performance counters per core, so at any
moment at most one performance monitor can be programmed in HW. In
software, this singleton is represented by v3d_dev->active_perfmon, but
until now nothing actually serialized access to it: scheduler callbacks,
the GPU-reset path, and perfmon ioctls all read and wrote that field
lock-free.

The existence of v3d_perfmon->lock mutex did not close the gap. It
serialized start/stop of *one* perfmon object against itself, but the
invariant that needs protection is device-wide: there can be exactly one
active perfmon at any moment in HW. Two threads acting on different
perfmon objects could race through v3d_dev->active_perfmon and the
counter registers, leaving software and HW out of sync.

This commit moves the locking to where the invariant actually lives. Group
the active perfmon pointer with a device-wide spinlock and route every
state transition (job start, job completion, set global, reset,
suspend/resume, destruction) through a small set of locked entry points
that are the only mutators of the HW counters.

Some design improvements needed to be made for the refactor:

  1. Stop the perfmon from the IRQ handler at job-completion time (the
     natural boundary for "active perfmon follows the active job"). This
     required a change from a mutex to a spinlock. This solves another
     issue of the existing design: perfmon start/stop was exclusively
     attached to run_job() callbacks, which means that if nothing was
     further queued up, a perfmon would never actually be stopped.

  2. Pause/resume the HW counters across runtime-PM transitions without
     dropping the software reference. This preserves the perfmon state
     while the device is idle.

  3. Move the global perfmon lifecycle management to the set_global
     IOCTL. This simplifies the logic in v3d_perfmon_start() and
     v3d_perfmon_stop(), as there is no need to always check if the
     global perfmon is enabled.

  4. v3d_perfmon_get_values_ioctl() doesn't stop the perfmon when
     capturing the values. All lifecycle management is handled by the
     job (for per-job perfmons) or the set_global IOCTL (for global
     perfmons).

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h     |  17 ++--
 drivers/gpu/drm/v3d/v3d_gem.c     |   4 +-
 drivers/gpu/drm/v3d/v3d_irq.c     |   7 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c | 183 +++++++++++++++++++++++++++-----------
 drivers/gpu/drm/v3d/v3d_power.c   |   4 +
 drivers/gpu/drm/v3d/v3d_sched.c   |  26 ++----
 drivers/gpu/drm/v3d/v3d_submit.c  |   6 +-
 7 files changed, 165 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 2e298d7545c0..cf836c4f13ad 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -87,9 +87,6 @@ struct v3d_perfmon {
 	 */
 	refcount_t refcnt;
 
-	/* Protects perfmon stop, as it can be invoked from multiple places. */
-	struct mutex lock;
-
 	/* Number of counters activated in this perfmon instance
 	 * (should be less than DRM_V3D_MAX_PERF_COUNTERS).
 	 */
@@ -171,8 +168,14 @@ struct v3d_dev {
 
 	struct v3d_queue_state queue[V3D_MAX_QUEUES];
 
-	/* Used to track the active perfmon if any. */
-	struct v3d_perfmon *active_perfmon;
+	/* Tracks the performance monitor state. */
+	struct {
+		/* Protects @active. */
+		spinlock_t lock;
+
+		/* Perfmon currently programmed in HW (or NULL if none). */
+		struct v3d_perfmon *active;
+	} perfmon_state;
 
 	/* Protects bo_stats */
 	struct mutex bo_lock;
@@ -667,6 +670,10 @@ void v3d_perfmon_put(struct v3d_perfmon *perfmon);
 void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon);
 void v3d_perfmon_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
 		      bool capture);
+void v3d_perfmon_stop_locked(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
+			     bool capture);
+void v3d_perfmon_suspend(struct v3d_dev *v3d);
+void v3d_perfmon_resume(struct v3d_dev *v3d);
 struct v3d_perfmon *v3d_perfmon_find(struct v3d_file_priv *v3d_priv, int id);
 void v3d_perfmon_open_file(struct v3d_file_priv *v3d_priv);
 void v3d_perfmon_close_file(struct v3d_file_priv *v3d_priv);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index c43d9af41374..7ad81b146f02 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -137,7 +137,8 @@ v3d_reset(struct v3d_dev *v3d)
 	v3d_mmu_set_page_table(v3d);
 	v3d_irq_reset(v3d);
 
-	v3d_perfmon_stop(v3d, v3d->active_perfmon, false);
+	/* Re-arm the global perfmon HW counters that the reset zeroed. */
+	v3d_perfmon_resume(v3d);
 
 	trace_v3d_reset_end(dev);
 }
@@ -307,6 +308,7 @@ v3d_gem_init(struct drm_device *dev)
 	}
 
 	spin_lock_init(&v3d->mm_lock);
+	spin_lock_init(&v3d->perfmon_state.lock);
 	ret = drmm_mutex_init(dev, &v3d->bo_lock);
 	if (ret)
 		goto err_stats;
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 86efaef2722c..963d711dc16b 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -90,9 +90,12 @@ v3d_irq_signal_fence(struct v3d_dev *v3d, enum v3d_queue q,
 		     void (*trace_irq)(struct drm_device *, uint64_t))
 {
 	struct v3d_queue_state *queue = &v3d->queue[q];
-	struct v3d_fence *fence = to_v3d_fence(queue->active_job->irq_fence);
+	struct v3d_job *job = queue->active_job;
+	struct v3d_fence *fence = to_v3d_fence(job->irq_fence);
 
-	v3d_job_update_stats(queue->active_job);
+	v3d_perfmon_stop(v3d, job->perfmon, true);
+
+	v3d_job_update_stats(job);
 	trace_irq(&v3d->drm, fence->seqno);
 
 	queue->active_job = NULL;
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 48ae748247be..3ad0f022753c 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -217,26 +217,15 @@ void v3d_perfmon_get(struct v3d_perfmon *perfmon)
 
 void v3d_perfmon_put(struct v3d_perfmon *perfmon)
 {
-	if (perfmon && refcount_dec_and_test(&perfmon->refcnt)) {
-		mutex_destroy(&perfmon->lock);
+	if (perfmon && refcount_dec_and_test(&perfmon->refcnt))
 		kfree(perfmon);
-	}
 }
 
-void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
+static void v3d_perfmon_hw_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
 {
+	u8 ncounters = perfmon->ncounters;
+	u32 mask = GENMASK(ncounters - 1, 0);
 	unsigned int i;
-	u32 mask;
-	u8 ncounters;
-
-	if (WARN_ON_ONCE(!perfmon || v3d->active_perfmon))
-		return;
-
-	if (!pm_runtime_get_if_active(v3d->drm.dev))
-		return;
-
-	ncounters = perfmon->ncounters;
-	mask = GENMASK(ncounters - 1, 0);
 
 	for (i = 0; i < ncounters; i++) {
 		u32 source = i / 4;
@@ -258,39 +247,106 @@ void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
 	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, mask);
 	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_CLR, mask);
 	V3D_CORE_WRITE(0, V3D_PCTR_0_OVERFLOW, mask);
+}
 
-	v3d->active_perfmon = perfmon;
+static void v3d_perfmon_hw_capture(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
+{
+	u32 mask = GENMASK(perfmon->ncounters - 1, 0);
 
+	for (int i = 0; i < perfmon->ncounters; i++)
+		perfmon->values[i] += V3D_CORE_READ(0, V3D_PCTR_0_PCTRX(i));
+
+	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_CLR, mask);
+}
+
+static void v3d_perfmon_hw_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
+				bool capture)
+{
+	if (capture)
+		v3d_perfmon_hw_capture(v3d, perfmon);
+
+	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, 0);
+}
+
+void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
+{
+	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
+
+	if (!perfmon || v3d->global_perfmon)
+		return;
+
+	if (!pm_runtime_get_if_active(v3d->drm.dev))
+		return;
+
+	v3d_perfmon_hw_start(v3d, perfmon);
+	v3d->perfmon_state.active = perfmon;
+
+	v3d_pm_runtime_put(v3d);
+}
+
+static void v3d_perfmon_capture_locked(struct v3d_dev *v3d,
+				       struct v3d_perfmon *perfmon)
+{
+	lockdep_assert_held(&v3d->perfmon_state.lock);
+
+	if (!perfmon || perfmon != v3d->perfmon_state.active)
+		return;
+
+	if (!pm_runtime_get_if_active(v3d->drm.dev))
+		return;
+
+	v3d_perfmon_hw_capture(v3d, perfmon);
+	v3d_pm_runtime_put(v3d);
+}
+
+void v3d_perfmon_stop_locked(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
+			     bool capture)
+{
+	lockdep_assert_held(&v3d->perfmon_state.lock);
+
+	if (!perfmon || perfmon != v3d->perfmon_state.active)
+		return;
+
+	v3d->perfmon_state.active = NULL;
+
+	/* If the device is suspended, the HW has already stopped counting. */
+	if (!pm_runtime_get_if_active(v3d->drm.dev))
+		return;
+
+	v3d_perfmon_hw_stop(v3d, perfmon, capture);
 	v3d_pm_runtime_put(v3d);
 }
 
 void v3d_perfmon_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
 		      bool capture)
 {
-	unsigned int i;
-
-	if (!perfmon || !v3d->active_perfmon)
+	if (!perfmon)
 		return;
 
-	mutex_lock(&perfmon->lock);
-	if (perfmon != v3d->active_perfmon)
-		goto out;
+	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
+	v3d_perfmon_stop_locked(v3d, perfmon, capture);
+}
 
-	if (!pm_runtime_get_if_active(v3d->drm.dev))
-		goto out_clear;
+void
+v3d_perfmon_suspend(struct v3d_dev *v3d)
+{
+	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
 
-	if (capture)
-		for (i = 0; i < perfmon->ncounters; i++)
-			perfmon->values[i] += V3D_CORE_READ(0, V3D_PCTR_0_PCTRX(i));
+	if (!v3d->perfmon_state.active)
+		return;
 
-	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, 0);
+	v3d_perfmon_hw_stop(v3d, v3d->perfmon_state.active, true);
+}
 
-	v3d_pm_runtime_put(v3d);
+void
+v3d_perfmon_resume(struct v3d_dev *v3d)
+{
+	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
 
-out_clear:
-	v3d->active_perfmon = NULL;
-out:
-	mutex_unlock(&perfmon->lock);
+	if (!v3d->perfmon_state.active)
+		return;
+
+	v3d_perfmon_hw_start(v3d, v3d->perfmon_state.active);
 }
 
 struct v3d_perfmon *v3d_perfmon_find(struct v3d_file_priv *v3d_priv, int id)
@@ -316,14 +372,17 @@ static void v3d_perfmon_delete(struct v3d_file_priv *v3d_priv,
 	struct v3d_dev *v3d = v3d_priv->v3d;
 
 	/* If the active perfmon is being destroyed, stop it first */
-	if (perfmon == v3d->active_perfmon)
-		v3d_perfmon_stop(v3d, perfmon, false);
+	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+		v3d_perfmon_stop_locked(v3d, perfmon, false);
 
-	/* If the global perfmon is being destroyed, clean it and release
-	 * the reference stashed in v3d_perfmon_set_global_ioctl().
-	 */
-	if (cmpxchg(&v3d->global_perfmon, perfmon, NULL) == perfmon)
-		v3d_perfmon_put(perfmon);
+		/* If the global perfmon is being destroyed, clean it and release
+		 * the reference stashed in v3d_perfmon_set_global_ioctl().
+		 */
+		if (v3d->global_perfmon == perfmon) {
+			v3d_perfmon_put(v3d->global_perfmon);
+			v3d->global_perfmon = NULL;
+		}
+	}
 
 	v3d_perfmon_put(perfmon);
 }
@@ -371,12 +430,10 @@ int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
 	perfmon->ncounters = req->ncounters;
 
 	refcount_set(&perfmon->refcnt, 1);
-	mutex_init(&perfmon->lock);
 
 	ret = xa_alloc(&v3d_priv->perfmons, &id, perfmon, xa_limit_32b,
 		       GFP_KERNEL);
 	if (ret < 0) {
-		mutex_destroy(&perfmon->lock);
 		kfree(perfmon);
 		return ret;
 	}
@@ -408,7 +465,9 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 	struct v3d_dev *v3d = to_v3d_dev(dev);
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct drm_v3d_perfmon_get_values *req = data;
+	u64 values[DRM_V3D_MAX_PERF_COUNTERS];
 	struct v3d_perfmon *perfmon;
+	size_t size;
 	int ret = 0;
 
 	if (req->pad != 0)
@@ -418,10 +477,14 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 	if (!perfmon)
 		return -EINVAL;
 
-	v3d_perfmon_stop(v3d, perfmon, true);
+	size = perfmon->ncounters * sizeof(u64);
 
-	if (copy_to_user(u64_to_user_ptr(req->values_ptr), perfmon->values,
-			 perfmon->ncounters * sizeof(u64)))
+	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+		v3d_perfmon_capture_locked(v3d, perfmon);
+		memcpy(values, perfmon->values, size);
+	}
+
+	if (copy_to_user(u64_to_user_ptr(req->values_ptr), values, size))
 		ret = -EFAULT;
 
 	v3d_perfmon_put(perfmon);
@@ -482,18 +545,36 @@ int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
 		 */
 		v3d_perfmon_put(perfmon);
 
-		old = xchg(&v3d->global_perfmon, NULL);
-		if (!old)
-			return -EINVAL;
+		scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+			old = v3d->global_perfmon;
+			if (!old)
+				return -EINVAL;
+
+			v3d_perfmon_stop_locked(v3d, old, true);
+			v3d->global_perfmon = NULL;
+		}
 
 		v3d_perfmon_put(old);
 
 		return 0;
 	}
 
-	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon)) {
-		v3d_perfmon_put(perfmon);
-		return -EBUSY;
+	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+		if (v3d->perfmon_state.active || v3d->global_perfmon) {
+			v3d_perfmon_put(perfmon);
+			return -EBUSY;
+		}
+
+		v3d->global_perfmon = perfmon;
+		v3d->perfmon_state.active = perfmon;
+
+		/* If the device is suspended, v3d_perfmon_resume() will
+		 * program the HW on the next resume.
+		 */
+		if (pm_runtime_get_if_active(v3d->drm.dev)) {
+			v3d_perfmon_hw_start(v3d, perfmon);
+			v3d_pm_runtime_put(v3d);
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/v3d/v3d_power.c b/drivers/gpu/drm/v3d/v3d_power.c
index f7df6393d38f..ade8e932fb9c 100644
--- a/drivers/gpu/drm/v3d/v3d_power.c
+++ b/drivers/gpu/drm/v3d/v3d_power.c
@@ -50,6 +50,8 @@ int v3d_power_suspend(struct device *dev)
 	struct v3d_dev *v3d = to_v3d_dev(drm);
 	int ret;
 
+	v3d_perfmon_suspend(v3d);
+
 	v3d_irq_disable(v3d);
 
 	v3d_clean_caches(v3d);
@@ -85,5 +87,7 @@ int v3d_power_resume(struct device *dev)
 	v3d_mmu_set_page_table(v3d);
 	v3d_irq_enable(v3d);
 
+	v3d_perfmon_resume(v3d);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index e950cee31bcb..5f33d3794598 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -125,24 +125,6 @@ v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
 	}
 }
 
-static void
-v3d_switch_perfmon(struct v3d_dev *v3d, struct v3d_job *job)
-{
-	struct v3d_perfmon *perfmon = v3d->global_perfmon;
-
-	if (!perfmon)
-		perfmon = job->perfmon;
-
-	if (perfmon == v3d->active_perfmon)
-		return;
-
-	if (perfmon != v3d->active_perfmon)
-		v3d_perfmon_stop(v3d, v3d->active_perfmon, true);
-
-	if (perfmon && v3d->active_perfmon != perfmon)
-		v3d_perfmon_start(v3d, perfmon);
-}
-
 static void
 v3d_stats_start(struct v3d_stats *stats, u64 now)
 {
@@ -220,7 +202,7 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 			    job->start, job->end);
 
 	v3d_job_start_stats(&job->base);
-	v3d_switch_perfmon(v3d, &job->base);
+	v3d_perfmon_start(v3d, job->base.perfmon);
 
 	/* Set the current and end address of the control list.
 	 * Writing the end register is what starts the job.
@@ -278,7 +260,7 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 			    job->start, job->end);
 
 	v3d_job_start_stats(&job->base);
-	v3d_switch_perfmon(v3d, &job->base);
+	v3d_perfmon_start(v3d, job->base.perfmon);
 
 	/* XXX: Set the QCFG */
 
@@ -381,7 +363,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	trace_v3d_submit_csd(dev, to_v3d_fence(fence)->seqno);
 
 	v3d_job_start_stats(&job->base);
-	v3d_switch_perfmon(v3d, &job->base);
+	v3d_perfmon_start(v3d, job->base.perfmon);
 
 	csd_cfg0_reg = V3D_CSD_QUEUED_CFG0(v3d->ver);
 	for (i = 1; i <= 6; i++)
@@ -723,6 +705,8 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d, struct drm_sched_job *sched_job,
 	if (sched_job)
 		drm_sched_increase_karma(sched_job);
 
+	v3d_perfmon_stop(v3d, job->perfmon, false);
+
 	/* get the GPU back into the init state */
 	v3d_reset(v3d);
 
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee2ac2540ed5..27cc98770b37 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -302,8 +302,10 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
 	if (!perfmon_id)
 		return 0;
 
-	if (v3d->global_perfmon)
-		return -EAGAIN;
+	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+		if (v3d->global_perfmon)
+			return -EAGAIN;
+	}
 
 	perfmon = v3d_perfmon_find(v3d_priv, perfmon_id);
 	if (!perfmon)

-- 
2.54.0

