Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42489CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F1610E9C2;
	Sun,  4 Oct 2026 15:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="K3MYpfh+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF2210E9C2
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=6iCjU8bkEwteg/UGxUw8C4W7niGu0dsMNccMKH+ti3Q=; b=K3MYpfh+TePEyBg1gFeSA78bOG
 TZ/57rkLbJ4nXZAJEtN6s08RLEqnGAUgY7ffFy1GPPrLvB9U1PHL37L1jUFqwBhpuINcYSpI1oZIj
 IYtmXTwhHfWKF5S1ippF+ON61QkgAcbTu7aON36oP9i8Kbdsby5reVilU9DTfsqZ9Wfz9XIQgDpQl
 xIU8A2kEhmIKNy5mz0mNWInAMX6wkj5ipdc0i/iVMOQiyRwnrQQJGeAWk5TA8sdvHv0P4M0CTYZeq
 U649AzwqOhVM3tQ8wJ4eznuGAJ3VRjnbqXUFPutZs3SCRa2/cObDiqPfzNMH2CU191c5/YRj9a7bW
 udzS1SAw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOMS-00BNsh-L0; Sun, 04 Oct 2026 17:42:48 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:09 -0300
Subject: [PATCH 09/11] drm/vc4: Protect perfmon state with a dedicated lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-9-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7058; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Ie4wqW1YIaj0DYWB09IH+vkw1THkplNZrwUY/VhiFL8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPXKqlqVOFZzedpHQQnPUL6hVsaUCxiETo5/
 ck/cBjfxvOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1wAKCRA/8w6Kdoj6
 qu97CADHuhzzrxGD0L7OlHcOWArfi+NR/H9/Xo7UFZ9Ykre9f4tBH8GUMuWErEAIqhdPBFYL/rf
 gLrvcH61eB+zmIr1FEuQH7heMNjs3BmuCRHO47MHHMv694SJC4PovalfMio4BiMUZj9fY14yL4t
 59eOCURYVwFzauIVq5hoE8QmmfzLqoVgX1kcTgy32tAOBPQpyesMMAVIwIAola7Uz/ayqJOuNo6
 TNbOGj4aKLRSrcCJ1CmZnsjr0B6sMgx+NAf8nLFv9ypEBYI/qLmghB0EwxCjA10/SmpPJKzMKTd
 7rniEwp352RShxkxLkd4V5P8NJXIRjMtt0TJ+EGiV1KGVv/k
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

The V3D block exposes a single set of performance counters, so at most
one perfmon can be programmed into the hardware at a time. Until now,
job_lock serialises the access to the active perfmon, but not every access
was being serialized. For example, vc4_perfmon_get_values_ioctl() copies
perfmon->counters out while vc4_perfmon_stop() accumulates into the same
array from the interrupt handler, so userspace can read a half-updated
array. Also, vc4_perfmon_delete() tests the pointer before taking any
lock.

Extending job_lock over those two paths would put a userspace read and the
destroy path on the lock the interrupt handler uses to drive the job
queues. The perfmon state has no invariant in common with those queues.

Introduce a dedicated spinlock next to the active perfmon pointer and
take it in vc4_perfmon_start() and vc4_perfmon_stop(). Snapshot the
counter values under the same lock in vc4_perfmon_get_values_ioctl() so
that a concurrent stop cannot expose a half-updated array to userspace.

Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h     | 13 ++++++++++---
 drivers/gpu/drm/vc4/vc4_gem.c     |  7 ++-----
 drivers/gpu/drm/vc4/vc4_irq.c     |  3 +--
 drivers/gpu/drm/vc4/vc4_perfmon.c | 40 +++++++++++++++++++++++++++------------
 4 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index d18a0fece93c..2fad8a489558 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -181,10 +181,17 @@ struct vc4_dev {
 	wait_queue_head_t job_wait_queue;
 	struct work_struct job_done_work;
 
-	/* Used to track the active perfmon if any. Access to this field is
-	 * protected by job_lock.
+	/* Tracks the performance monitor state. The V3D block exposes a single
+	 * set of performance counters, so at most one perfmon can be active at
+	 * any moment.
 	 */
-	struct vc4_perfmon *active_perfmon;
+	struct {
+		/* Protects @active. */
+		spinlock_t lock;
+
+		/* Perfmon currently programmed in HW (or NULL if none). */
+		struct vc4_perfmon *active;
+	} perfmon_state;
 
 	/* The memory used for storing binner tile alloc, tile state,
 	 * and overflow memory allocations.  This is freed when V3D
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index b61f9b0a7c09..1f3cb3c2c7fc 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -488,11 +488,7 @@ vc4_submit_next_bin_job(struct drm_device *dev)
 
 	vc4_flush_caches(dev);
 
-	/* Only start the perfmon if it was not already started by a previous
-	 * job.
-	 */
-	if (exec->perfmon && vc4->active_perfmon != exec->perfmon)
-		vc4_perfmon_start(vc4, exec->perfmon);
+	vc4_perfmon_start(vc4, exec->perfmon);
 
 	/* Either put the job in the binner if it uses the binner, or
 	 * immediately move it to the to-be-rendered queue.
@@ -1181,6 +1177,7 @@ int vc4_gem_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&vc4->render_job_list);
 	INIT_LIST_HEAD(&vc4->job_done_list);
 	spin_lock_init(&vc4->job_lock);
+	spin_lock_init(&vc4->perfmon_state.lock);
 
 	INIT_WORK(&vc4->hangcheck.reset_work, vc4_reset_work);
 	timer_setup(&vc4->hangcheck.timer, vc4_hangcheck_elapsed, 0);
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index dcee4a1e17ad..f8787d4169ef 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -145,8 +145,7 @@ vc4_cancel_bin_job(struct drm_device *dev)
 		return;
 
 	/* Stop the perfmon so that the next bin job can be started. */
-	if (exec->perfmon)
-		vc4_perfmon_stop(vc4, exec->perfmon, false);
+	vc4_perfmon_stop(vc4, exec->perfmon, false);
 
 	list_move_tail(&exec->head, &vc4->bin_job_list);
 	vc4_submit_next_bin_job(dev);
diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
index f75dfd156756..dd3414157d61 100644
--- a/drivers/gpu/drm/vc4/vc4_perfmon.c
+++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
@@ -51,7 +51,15 @@ void vc4_perfmon_start(struct vc4_dev *vc4, struct vc4_perfmon *perfmon)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
 
-	if (WARN_ON_ONCE(!perfmon || vc4->active_perfmon))
+	if (!perfmon)
+		return;
+
+	guard(spinlock_irqsave)(&vc4->perfmon_state.lock);
+
+	/* Only start the perfmon if it was not already started by a
+	 * previous job.
+	 */
+	if (vc4->perfmon_state.active == perfmon)
 		return;
 
 	for (i = 0; i < perfmon->ncounters; i++)
@@ -60,7 +68,7 @@ void vc4_perfmon_start(struct vc4_dev *vc4, struct vc4_perfmon *perfmon)
 	mask = GENMASK(perfmon->ncounters - 1, 0);
 	V3D_WRITE(V3D_PCTRC, mask);
 	V3D_WRITE(V3D_PCTRE, V3D_PCTRE_EN | mask);
-	vc4->active_perfmon = perfmon;
+	vc4->perfmon_state.active = perfmon;
 }
 
 void vc4_perfmon_stop(struct vc4_dev *vc4, struct vc4_perfmon *perfmon,
@@ -71,8 +79,12 @@ void vc4_perfmon_stop(struct vc4_dev *vc4, struct vc4_perfmon *perfmon,
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
 
-	if (WARN_ON_ONCE(!vc4->active_perfmon ||
-			 perfmon != vc4->active_perfmon))
+	if (!perfmon)
+		return;
+
+	guard(spinlock_irqsave)(&vc4->perfmon_state.lock);
+
+	if (perfmon != vc4->perfmon_state.active)
 		return;
 
 	if (capture) {
@@ -81,7 +93,7 @@ void vc4_perfmon_stop(struct vc4_dev *vc4, struct vc4_perfmon *perfmon,
 	}
 
 	V3D_WRITE(V3D_PCTRE, 0);
-	vc4->active_perfmon = NULL;
+	vc4->perfmon_state.active = NULL;
 }
 
 struct vc4_perfmon *vc4_perfmon_find(struct vc4_file *vc4file, int id)
@@ -116,8 +128,7 @@ static void vc4_perfmon_delete(struct vc4_file *vc4file,
 	struct vc4_dev *vc4 = vc4file->dev;
 
 	/* If the active perfmon is being destroyed, stop it first */
-	if (perfmon == vc4->active_perfmon)
-		vc4_perfmon_stop(vc4, perfmon, false);
+	vc4_perfmon_stop(vc4, perfmon, false);
 
 	vc4_perfmon_put(perfmon);
 }
@@ -222,8 +233,10 @@ int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_file *vc4file = file_priv->driver_priv;
 	struct drm_vc4_perfmon_get_values *req = data;
+	u64 values[DRM_VC4_MAX_PERF_COUNTERS];
 	struct vc4_perfmon *perfmon;
-	int ret;
+	size_t size;
+	int ret = 0;
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return -ENODEV;
@@ -237,11 +250,14 @@ int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 	if (!perfmon)
 		return -EINVAL;
 
-	if (copy_to_user(u64_to_user_ptr(req->values_ptr), perfmon->counters,
-			 perfmon->ncounters * sizeof(u64)))
+	size = perfmon->ncounters * sizeof(u64);
+
+	/* Snapshot the counters under the perfmon lock */
+	scoped_guard(spinlock_irqsave, &vc4->perfmon_state.lock)
+		memcpy(values, perfmon->counters, size);
+
+	if (copy_to_user(u64_to_user_ptr(req->values_ptr), values, size))
 		ret = -EFAULT;
-	else
-		ret = 0;
 
 	vc4_perfmon_put(perfmon);
 	return ret;

-- 
2.55.0

