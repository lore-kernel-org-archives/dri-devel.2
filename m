Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0AFC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FB310E707;
	Tue, 22 Sep 2026 13:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FSWv+2VY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A270210E4D2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=+OfFd/PpmB1Gb/rueONvaWS5Oft1mWHUnXSc8xAE8U8=; b=FSWv+2VY5XmOPycyQxpHUlOWQc
 BRMKCYMbnZJP3obYgR9r9YjFv5ZmaUmprQ+O8wLiojRfiNZON77PiFTOcMmWPR9eeO7WcKzh/gKc8
 VJH+Q6OZItEw2KxxPR2vp1jrff2G0Ybb2AM8pCXDnPEdJwKuWRH3E6iaO5hs9819D9FKi6J9iNnih
 tu1o+Et601XvI+0wuhbxzI6O++ilEwgWqH6F+DFVfwXX0RRq+e/9b++GNsPUaJvCk7kQVFEh3pZta
 c+DC3fBk9CuFxe3JUwfGgPgfp6itXb3yPGK2orbv1U+n5udcVrwV09vRJvoxGsfu6pXoQTtT20ZJ7
 4TKU7oIA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x90Wz-005e24-Pp; Tue, 22 Sep 2026 15:27:34 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 22 Sep 2026 10:24:50 -0300
Subject: [PATCH v2 1/2] drm/v3d: Skip perfmon serialization while the
 device has no perfmon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-v3d-quick-exit-perfmon-serialize-v2-1-2a8021dc32f2@igalia.com>
References: <20260922-v3d-quick-exit-perfmon-serialize-v2-0-2a8021dc32f2@igalia.com>
In-Reply-To: <20260922-v3d-quick-exit-perfmon-serialize-v2-0-2a8021dc32f2@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4946; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ZBw0VcQ7Z7kUT6AOe3HolYA5eTmd5uBz624pxdARka8=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFmbGk86x0zkOHlzZmNZ3C0Xk+Q/7c/D/of2BjClFbE0G
 eh033nTyWjMwsDIxSArpsjy40lsLaNYObvmsvKLMINYmUCmMHBxCsBE6l6w/zPPFp/Jx6/j9fBY
 fO9G8bf+nqdmMXrZLVXzvBBssXj+z5cMUjstEjJj1PkZPxY02Tsz+gqZG/7l/dYgmOl3QG3mUcb
 lE2LDI1XUeZ0tREQlz9ib3dk5i8l595s6hRj/mTsuxCb/3y34iWG+k8OmYl1erz0cNV8YNz9nZP
 o1zeCgqd5RV92LAm69K2tvBb/db21ZV3Th05xPi/pbWvR+m/LcjzkXd/Dqe35186OBNRuDo5rUH
 8gXWJiyf/Eoaea5M2+GZLzkynuzPj3ynsbs9Wr/e68rMmXaT4+WrktQ3haYfXXFvbciFWu2RGtH
 BXCZBf4+ZV66/Kb6l5f7KoO7KgtjW75dW1wv/WJOfu0uAA==
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

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h     | 13 +++++++++++--
 drivers/gpu/drm/v3d/v3d_perfmon.c |  8 ++++++--
 drivers/gpu/drm/v3d/v3d_submit.c  |  7 +++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 26f8c3f635f9..02b6ab7dc72b 100644
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
@@ -191,8 +198,10 @@ struct v3d_dev {
 		struct dma_fence *fence;
 
 		/* Finished fence of the most recently submitted job on each HW
-		 * queue. Used so that a new perfmon-carrying job can depend on
-		 * every job currently in-flight across all queues.
+		 * queue, which is used so that a new perfmon-carrying job can
+		 * depend on every job currently in-flight across all queues.
+		 *
+		 * Finished fences are only tracked if @nperfmons > 0.
 		 */
 		struct dma_fence *last_hw_fence[V3D_MAX_QUEUES];
 	} perfmon_state;
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 4cadc3e17280..c00f18d4a425 100644
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
@@ -435,13 +437,15 @@ int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
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

