Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173A2CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3C110F4BE;
	Fri,  8 May 2026 13:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nkk1Hnwm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360B610F4A4
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mW1IzGgBCsVRdjcpGgKEN3ia9qcV4gVDnt+tGB5oiGc=; b=nkk1HnwmeI5VvSStvm9SYEm61M
 AuZ3vxRyOznfJLKmtK/ImTDngOwpYTiox99jK9S/Rj8q5Qi9md7q4nQgNKZt8u741uf9+E5gbYPCZ
 0DcwgTzRfXDd0kI+fl8YiIKXcaNQPMJxQKHg/SfTRh25fUmTkvJu9M0hbY6dORZYiCaOrJ2VVHr+x
 wLhWhyC0qiS1fkvwTesc/smHsLprgOwXJFtfs2vkIIWEepTgOIeuAa2Bm7zOPLx1h9d3J1ao11JNT
 aDqo7IOn0Ds9gH7Mm5MqFOXP81n9St/ztR7/gnwROKkSKMzzXaDwFrfOn0/y89breroKzBmcLK737
 eVdbsB8A==;
Received: from [189.7.87.137] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wLLSX-007u6e-Sk; Fri, 08 May 2026 15:41:41 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 08 May 2026 10:41:29 -0300
Subject: [PATCH 1/2] drm/v3d: Refactor perfmon locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260508-v3d-perfmon-lifetime-v1-1-f5b5642c085f@igalia.com>
References: <20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com>
In-Reply-To: <20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14628; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=mFgcLyeqM/WEGozYbUwxQV8UFsiacxQg/vx4W9gjimA=;
 b=kA0DAAoBP/MOinaI+qoByyZiAGn96A6jh3w0zVJUzgzGsdRwQTGMnij+PsgMDp9lRrtBitNzq
 YkBMwQAAQoAHRYhBPjkXX0BFncHKaZ30T/zDop2iPqqBQJp/egOAAoJED/zDop2iPqqYL8H+wUR
 K4yLYPfnegi0F4qCd/quqv22FzfOcGWHO+DNUVtbRxiT2g2g3FrCKkevVnTOqbCozlF3EIqh+EK
 xIvPNdH3dHuMfi1X6McQWeH8s9VgVm78Ttx+memDmvIcmIE3SFqumj6k9OX/nKCAgOFWytui13k
 9uTbqwL6VmUCwJa4DkrMz4CMP97/CZ1x2gXZU3FTwBgEiy617g9W0ek1zf7uYUSdnnNG1oN6D3j
 Ppjoya/LgPOu+MgkFul2soMNtZoemzC2vCYvQyHNYe9gtaHh8GpBzgVIxlY0UvjJiJapW0gv9bd
 UK44QXf6VIrIGF3sULdVyHzgyVA1Y3LNmHeoznk=
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

Using a spinlock also unlocks two design improvements: stopping the
perfmon from the IRQ handler at job-completion time (the natural boundary
for "active perfmon follows the active job"), and pausing/resuming the HW
counters across runtime-PM transitions without dropping the software
reference. This solves yet another issue of the current design: perfmon
start/stop was exclusively attached to run_job() callbacks, which means
that if nothing was further queued up, a perfmon would never actually
stopped.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h     |  20 ++++--
 drivers/gpu/drm/v3d/v3d_gem.c     |   3 +-
 drivers/gpu/drm/v3d/v3d_irq.c     |   6 ++
 drivers/gpu/drm/v3d/v3d_perfmon.c | 145 ++++++++++++++++++++++++++------------
 drivers/gpu/drm/v3d/v3d_power.c   |   4 ++
 drivers/gpu/drm/v3d/v3d_sched.c   |  24 +------
 drivers/gpu/drm/v3d/v3d_submit.c  |   7 +-
 7 files changed, 136 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 071d919fe860..3a7801348697 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -86,9 +86,6 @@ struct v3d_perfmon {
 	 */
 	refcount_t refcnt;
 
-	/* Protects perfmon stop, as it can be invoked from multiple places. */
-	struct mutex lock;
-
 	/* Number of counters activated in this perfmon instance
 	 * (should be less than DRM_V3D_MAX_PERF_COUNTERS).
 	 */
@@ -170,8 +167,14 @@ struct v3d_dev {
 
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
@@ -316,6 +319,9 @@ struct v3d_job {
 
 	struct v3d_dev *v3d;
 
+	/* The queue that the job was submitted on. */
+	enum v3d_queue queue;
+
 	/* This is the array of BOs that were looked up at the start
 	 * of submission.
 	 */
@@ -663,6 +669,10 @@ void v3d_perfmon_put(struct v3d_perfmon *perfmon);
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
index 1ee3c038d5f6..6e387c41fbee 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -137,7 +137,7 @@ v3d_reset(struct v3d_dev *v3d)
 	v3d_mmu_set_page_table(v3d);
 	v3d_irq_reset(v3d);
 
-	v3d_perfmon_stop(v3d, v3d->active_perfmon, false);
+	v3d_perfmon_stop(v3d, v3d->perfmon_state.active, false);
 
 	trace_v3d_reset_end(dev);
 }
@@ -299,6 +299,7 @@ v3d_gem_init(struct drm_device *dev)
 	}
 
 	spin_lock_init(&v3d->mm_lock);
+	spin_lock_init(&v3d->perfmon_state.lock);
 	ret = drmm_mutex_init(dev, &v3d->bo_lock);
 	if (ret)
 		goto err_stats;
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index d4d7c39227be..9b446672c424 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -92,6 +92,12 @@ v3d_irq_signal_fence(struct v3d_dev *v3d, enum v3d_queue q,
 	struct v3d_fence *fence = to_v3d_fence(queue->active_job->irq_fence);
 
 	v3d_job_update_stats(queue->active_job);
+
+	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+		if (v3d->perfmon_state.active != v3d->global_perfmon)
+			v3d_perfmon_stop_locked(v3d, v3d->perfmon_state.active, true);
+	}
+
 	trace_irq(&v3d->drm, fence->seqno);
 
 	queue->active_job = NULL;
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 02451fc09dbb..4f1c59e282b5 100644
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
@@ -258,8 +247,56 @@ void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
 	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, mask);
 	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_CLR, mask);
 	V3D_CORE_WRITE(0, V3D_PCTR_0_OVERFLOW, mask);
+}
 
-	v3d->active_perfmon = perfmon;
+static void v3d_perfmon_hw_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
+				bool capture)
+{
+	unsigned int i;
+
+	if (capture)
+		for (i = 0; i < perfmon->ncounters; i++)
+			perfmon->values[i] += V3D_CORE_READ(0, V3D_PCTR_0_PCTRX(i));
+
+	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, 0);
+}
+
+void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
+{
+	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
+
+	perfmon = v3d->global_perfmon ?: perfmon;
+
+	if (!perfmon)
+		return;
+
+	if (perfmon == v3d->perfmon_state.active)
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
+void v3d_perfmon_stop_locked(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
+			     bool capture)
+{
+	lockdep_assert_held(&v3d->perfmon_state.lock);
+
+	if (!perfmon || perfmon != v3d->perfmon_state.active)
+		return;
+
+	if (!pm_runtime_get_if_active(v3d->drm.dev)) {
+		v3d->perfmon_state.active = NULL;
+		return;
+	}
+
+	v3d_perfmon_hw_stop(v3d, perfmon, capture);
+	v3d->perfmon_state.active = NULL;
 
 	v3d_pm_runtime_put(v3d);
 }
@@ -267,30 +304,31 @@ void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
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
+void v3d_perfmon_suspend(struct v3d_dev *v3d)
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
+void v3d_perfmon_resume(struct v3d_dev *v3d)
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
@@ -316,11 +354,15 @@ static void v3d_perfmon_delete(struct v3d_file_priv *v3d_priv,
 	struct v3d_dev *v3d = v3d_priv->v3d;
 
 	/* If the active perfmon is being destroyed, stop it first */
-	if (perfmon == v3d->active_perfmon)
-		v3d_perfmon_stop(v3d, perfmon, false);
+	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+		/* If the global perfmon is being destroyed, set it to NULL */
+		if (v3d->global_perfmon == perfmon) {
+			v3d->global_perfmon = NULL;
+			v3d_perfmon_put(perfmon);
+		}
 
-	/* If the global perfmon is being destroyed, set it to NULL */
-	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
+		v3d_perfmon_stop_locked(v3d, perfmon, false);
+	}
 
 	v3d_perfmon_put(perfmon);
 }
@@ -368,12 +410,10 @@ int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
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
@@ -471,16 +511,33 @@ int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
 
 	/* If the request is to clear the global performance monitor */
 	if (req->flags & DRM_V3D_PERFMON_CLEAR_GLOBAL) {
-		if (!v3d->global_perfmon)
-			return -EINVAL;
+		struct v3d_perfmon *old;
 
-		xchg(&v3d->global_perfmon, NULL);
+		scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+			old = v3d->global_perfmon;
+			if (!old) {
+				v3d_perfmon_put(perfmon);
+				return -EINVAL;
+			}
+
+			v3d->global_perfmon = NULL;
+			v3d_perfmon_stop_locked(v3d, old, true);
+		}
+
+		v3d_perfmon_put(old);
+		v3d_perfmon_put(perfmon);
 
 		return 0;
 	}
 
-	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon))
-		return -EBUSY;
+	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+		if (v3d->perfmon_state.active || v3d->global_perfmon) {
+			v3d_perfmon_put(perfmon);
+			return -EBUSY;
+		}
+
+		v3d->global_perfmon = perfmon;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/v3d/v3d_power.c b/drivers/gpu/drm/v3d/v3d_power.c
index 769e90032b04..1a4b651a2c5f 100644
--- a/drivers/gpu/drm/v3d/v3d_power.c
+++ b/drivers/gpu/drm/v3d/v3d_power.c
@@ -50,6 +50,8 @@ int v3d_power_suspend(struct device *dev)
 	struct v3d_dev *v3d = to_v3d_dev(drm);
 	int ret;
 
+	v3d_perfmon_suspend(v3d);
+
 	v3d_irq_disable(v3d);
 
 	ret = v3d_suspend_sms(v3d);
@@ -83,5 +85,7 @@ int v3d_power_resume(struct device *dev)
 	v3d_mmu_set_page_table(v3d);
 	v3d_irq_enable(v3d);
 
+	v3d_perfmon_resume(v3d);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 96d476b20abd..ae7f08e60b9e 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -139,24 +139,6 @@ v3d_cpu_job_free(struct drm_sched_job *sched_job)
 	v3d_job_cleanup(&job->base);
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
@@ -233,7 +215,7 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 			    job->start, job->end);
 
 	v3d_job_start_stats(&job->base);
-	v3d_switch_perfmon(v3d, &job->base);
+	v3d_perfmon_start(v3d, job->base.perfmon);
 
 	/* Set the current and end address of the control list.
 	 * Writing the end register is what starts the job.
@@ -291,7 +273,7 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 			    job->start, job->end);
 
 	v3d_job_start_stats(&job->base);
-	v3d_switch_perfmon(v3d, &job->base);
+	v3d_perfmon_start(v3d, job->base.perfmon);
 
 	/* XXX: Set the QCFG */
 
@@ -384,7 +366,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	trace_v3d_submit_csd(dev, to_v3d_fence(fence)->seqno);
 
 	v3d_job_start_stats(&job->base);
-	v3d_switch_perfmon(v3d, &job->base);
+	v3d_perfmon_start(v3d, job->base.perfmon);
 
 	csd_cfg0_reg = V3D_CSD_QUEUED_CFG0(v3d->ver);
 	for (i = 1; i <= 6; i++)
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index d1ce1a7dbcf4..1047aca58282 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -210,6 +210,7 @@ v3d_submit_add_job(struct v3d_submit *submit, void **container, size_t size,
 	job->v3d = v3d;
 	job->free = free;
 	job->file_priv = v3d_priv;
+	job->queue = queue;
 
 	ret = drm_sched_job_init(&job->base, &v3d_priv->sched_entity[queue],
 				 1, v3d_priv, submit->file_priv->client_id);
@@ -251,8 +252,10 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
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

