Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C6DC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228FD10E31D;
	Mon, 21 Sep 2026 21:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="i1BWxhJs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E30910E31D
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=RIzVJpJaZuH7r5H5dqfctRdHCnUIAxFNtMsjsrLGc1E=; b=i1BWxhJsKODjKAfql97BHv0xeZ
 S2505ciDV1oR6WI/5daAVlkGTrMdZl8uYuwNeqIWFX81Z8/AHRfLDxK34BS9IKfOOAnhVZ7ilcgp1
 tb6B98I8541FWRH8KA7S2+cnfGHm5gXx4XVes7h/r79WH7mrYt4iluvUoVVUMYbCY49vuHwBIbbQQ
 EAMMZbx00EkkhYD4ouRc6w07gKV4zM+yewN+FWsyLLHNzL5lgqFdhYpmGKM6nkegCSHw/kt2ipQz3
 5jT6FoTrIMKchuA+zGxwsincp/0wp+6oViSNZc4Ymn7d5X6QeCsygK6Hf2J6As7Gok6JWONloQqYX
 y1ymyaCg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x8lVM-005Iwu-Qn; Mon, 21 Sep 2026 23:24:52 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 21 Sep 2026 18:24:31 -0300
Subject: [PATCH 1/2] drm/v3d: Skip perfmon serialization while the device
 has no perfmon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-v3d-quick-exit-perfmon-serialize-v1-1-e58aea1075e2@igalia.com>
References: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
In-Reply-To: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4341; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=PAJJaJhaO/pyMfOhXlE8eKqE5CVPpAXbeaEoSb4gFes=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqsaCY252bCAlDAVqADQIrGAjDm1Rvb46FB7vBO
 oAuvKBGmmiJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCarGgmAAKCRA/8w6Kdoj6
 qlj0CADOghiE46HYQGwwCviC4zAiC9YivzxgaA3tDJ7ZmMw+b2aG+vmvwJn1NE5bWrMcWU/t8xT
 3y8JyDskKt4cLjye//bSO0+2HUDi9hEIyiH5PlkBY7QozkVkFzIflz9PST2vR6nnNHodK9RvmAJ
 2jP6+iM8NVsdUXnlteSF13rr11ETjTmLm0jAO7cut0yard4OsNRWVbT29DkHnd3F4zIP8jay25c
 CAvEN9vncb6oZtOmrx6i1RpbW6vX7KQ+DRnfHfNQIJAGow9mNbT9mYnD9FW28FVsdxX7XcuvmO1
 DiaNGVL15RbEhPynuf1J18t3or7KXsisxqyNwdQAmafkTAyc
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

Every job merges its finished fence into the per-queue accumulator so
that a job carrying a perfmon can later depend on everything still in
flight. This is a (relatively high) cost that every job pays before
it is submitted.

Perfmons only exist while userspace runs a performance query, so the
common case is a client paying that on every job for a dependency that is
never actually added, increasing the submission latency.

Address this situation by counting the number of perfmons alive on the
device and returning early while that count is zero. This means that if
no perfmon exists, v3d_serialize_for_perfmon() will bail out immediately.

Jobs submitted while no perfmon is alive stay unaccounted and may overlap
the first measured job. The count returns to zero whenever the last
perfmon is destroyed, so that window reopens on every measurement cycle.
Closing it would mean merging a fence on every submission for the
lifetime of the device, so it is a reasonable compromise for the average
use case.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h     | 7 +++++++
 drivers/gpu/drm/v3d/v3d_perfmon.c | 8 ++++++--
 drivers/gpu/drm/v3d/v3d_submit.c  | 7 +++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 79ef20c89ff2..cd544af8d8c8 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -84,6 +84,8 @@ struct v3d_queue_state {
  * This way, only events related to a specific submission will be counted.
  */
 struct v3d_perfmon {
+	struct v3d_dev *v3d;
+
 	/* Tracks the number of users of the perfmon, when this counter reaches
 	 * zero the perfmon is destroyed.
 	 */
@@ -184,6 +186,11 @@ struct v3d_dev {
 		/* Perfmon currently programmed in HW (or NULL if none). */
 		struct v3d_perfmon *active;
 
+		/* Number of perfmons alive on this device. Jobs are not
+		 * serialized if the number is zero.
+		 */
+		atomic_t nperfmons;
+
 		/* Finished fence of the most recently submitted job that
 		 * opened a serialization window (i.e. a job with a non-global
 		 * perfmon attached).
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 07dab7fb3060..359334616bd8 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -217,8 +217,10 @@ void v3d_perfmon_get(struct v3d_perfmon *perfmon)
 
 void v3d_perfmon_put(struct v3d_perfmon *perfmon)
 {
-	if (perfmon && refcount_dec_and_test(&perfmon->refcnt))
+	if (perfmon && refcount_dec_and_test(&perfmon->refcnt)) {
+		atomic_dec(&perfmon->v3d->perfmon_state.nperfmons);
 		kfree(perfmon);
+	}
 }
 
 static void v3d_perfmon_hw_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
@@ -434,13 +436,15 @@ int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
 		perfmon->counters[i] = req->counters[i];
 
 	perfmon->ncounters = req->ncounters;
+	perfmon->v3d = v3d;
 
 	refcount_set(&perfmon->refcnt, 1);
+	atomic_inc(&v3d->perfmon_state.nperfmons);
 
 	ret = xa_alloc(&v3d_priv->perfmons, &id, perfmon, xa_limit_32b,
 		       GFP_KERNEL);
 	if (ret < 0) {
-		kfree(perfmon);
+		v3d_perfmon_put(perfmon);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 834d52030979..bc3c43fd4fd9 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -357,6 +357,10 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
  *
  * We don't serialize the jobs when using a global perfmon as it's expected to
  * track concurrent activity from all jobs.
+ *
+ * Keeping track of the in-flight jobs costs a fence merge per job, so it is
+ * only done while at least one perfmon is alive. Jobs submitted while no
+ * perfmon exists go untracked and may overlap the first measured job.
  */
 static int
 v3d_serialize_for_perfmon(struct v3d_job *job)
@@ -368,6 +372,9 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
 
 	lockdep_assert_held(&v3d->sched_lock);
 
+	if (!atomic_read(&v3d->perfmon_state.nperfmons))
+		return 0;
+
 	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock)
 		is_global_perfmon = !!v3d->global_perfmon;
 

-- 
2.55.0

