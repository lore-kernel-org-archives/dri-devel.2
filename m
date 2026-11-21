Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599B606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sml3Pnu6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DE210E6C6;
	Sun, 22 Nov 2026 17:15:52 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39EC10E008
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 03:55:55 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cdda6625e2aso32784a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795233355; x=1795838155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BYuLdHFh3PjInD4IVzuU3ekK0WuSuMqNwB/0sKKTRRs=;
 b=sml3Pnu6tn7JD3+iq/ujx1maGZq6T2Gao/luYS+EQKDVJelGrRzmVClDVNMqaLpwtD
 AkKfQfD8YKHDMnykKgRvUnbdCxG/09mKRb2gS/TZejjoZWmBs8oa7ipCPhACYyKAGV/p
 2xX1alWAY5gkfg3cTtu8KomjZhhMK7tYP/dww2Q4BGySTGesGxjVr+BazGe4Eh//jhC4
 3LaUJNOVNqmClac1ZlFCR8F8DiV21qN7pXhPBTfln08FN75D9eVK5NsVtQRIWOgVykOa
 fDjrFvFt7DCxS78wUm4czOPJSXrNVGSTv/4WJgiCpCDpA3AU1QO13f5ZxZtu7k0f9ykb
 4lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795233355; x=1795838155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BYuLdHFh3PjInD4IVzuU3ekK0WuSuMqNwB/0sKKTRRs=;
 b=rd+4EvzzHE/FloBcMvLszOAr6dYda+5UaN6sHrq96xwMHlGnEcVbvdF+sG4uqOzNgS
 BN8/bEeVISXXPOjOgIttwgydKn3QI+qrZJjXaWjvv7hhqO19/rDLFtasd301Jl1uP33n
 yb/FSEgVHzusYdiLWEaNJsIEzLkHn1PA7pvuRf1tOQW4+dW/gKs2gbxwMJhouVb0BPGr
 94HmfJ/+FhNPDGzZvENv9pSwn1cbR0WYZHFn/Dv2nLXmhDwXp0bzdfQJ4AEo6Yq+ARXc
 glwcflAe4m7SbbYrXSnHkLVh+Tb3VLJF02c7ZP3oCQhiOrCTAZ2cQVvK9STMk4WbQ37V
 svqQ==
X-Gm-Message-State: APuU4Z8GWQsikY9k03PMn2cOvQYO/BB6GTSyBnaK9LX7u8+9bhK0HrgS
 RYF8MghOp/jmCjyEa0rUFVQvvTNEbHCgcYduvcAOWak99zTh8RgMwvnD
X-Gm-Gg: AZFdTZffLg9hANUB/XZnCOlKopUwl8cgqFvZbgTDi4FHcqiYvSivZmT3SiiVES0vWx5
 fqNINW8wrPql5Vsrhyl633XMHMKiTtTZx6MgMu9voUMNn2F29F19f51s35Glr4JrPspOKS+pwN3
 nRwjfDSmJwlk/mmbshygpF/0oP5wgikB7xMKScUgaMWgRUgbiOq7Rj0s8jjMuZ7pqwK7I3cI9UQ
 3yLZf4by85LuYz//22u5YrBi0DEZpu24xX5mEUcFkfYFpW0iH8FF+78b6QGUrgPaurTA6Oz+jvT
 Rx5mhsZYeAKfxSnw8cZhIMbs7RHRW8FK5/deq+qFYlThau2oouMQB1lTv4p4PcDX1P3V0FFNeR2
 9P15M03v5JdAF+nIhbTr+eqHaI+mWc+cYVEvyYTppeMYP04sOkwMI9UCzLAlOKKppThpAjVkA/Z
 eEFBqT/NqJjw/lvyv11mZaFIyceBHPn1Fp36oqxNaYxgC7H1+ujdsUiNXu1bz5yPqJW5qqJbxyC
 LUDqjlxUk4Yxk1Cp4XXaqW05Y6QUYUhg528moevpTySo0LHjiCrbIVJi1OH90C2XBnf0JhRqrhZ
 8o0BZsyvF4JO/suC3sHIt0t/wKtydw3VKPZJlA==
X-Received: by 2002:a05:6a00:7594:b0:8a0:8282:6462 with SMTP id
 d2e1a72fcca58-8c87bdb2d3dmr6143684b3a.3.1795233355296; 
 Fri, 20 Nov 2026 19:55:55 -0800 (PST)
Received: from localhost.localdomain ([50.52.95.8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e45eccsm2331673b3a.31.2026.11.20.19.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 19:55:54 -0800 (PST)
From: Tarel Ethridge <tarelerulz@gmail.com>
To: mwen@igalia.com,
	mcanal@igalia.com
Cc: dri-devel@lists.freedesktop.org,
	Tarel Ethridge <tarelerulz@gmail.com>
Subject: [PATCH] drm/v3d: Propagate a failed job's error to dependent jobs
Date: Fri, 20 Nov 2026 19:55:51 -0800
Message-ID: <20261121035551.8048-1-tarelerulz@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A job that hangs is dropped after the GPU reset and its finished fence
gets an error. drm_sched does not carry that error over to a job that
depends on it, and the run_job() callbacks only look at their own
finished fence. A dependent job therefore runs and signals success, so
the syncobj userspace waits on reports success although the work was
never completed.

This affects two kinds of dependency: the previous job of the same
submission (for example the cache clean job after a compute job, whose
done fence is the one attached to the out syncobj), and syncobjs the job
waits on, which is how userspace such as Mesa v3dv chains the no-op job
that signals a VkFence to an earlier submission.

Remember the done fence of the previous job of the submission and the
fences of the syncobjs the job waits on. In run_job(), copy an error from
any of them to the job's own finished fence. The job is then skipped by
the existing error check and its fence reports the failure.

Tested on a Raspberry Pi 400 (V3D 4.2) with a compute shader that never
finishes: before the change vkWaitForFences returns success after the
reset, with the change it returns VK_ERROR_DEVICE_LOST (with a Mesa
change that reads the fence status). That test used an equivalent change
on a 6.12 kernel; this version is only compile-tested.

Signed-off-by: Tarel Ethridge <tarelerulz@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  7 ++++++
 drivers/gpu/drm/v3d/v3d_sched.c  | 38 ++++++++++++++++++++++++-----
 drivers/gpu/drm/v3d/v3d_submit.c | 42 +++++++++++++++++++++++++++++---
 3 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 3bccb35ed..d5502b895 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -367,6 +367,13 @@ struct v3d_job {
 	 */
 	struct dma_fence *done_fence;
 
+	/* Done fence of the previous job of the submission, if any. */
+	struct dma_fence *prev_fence;
+
+	/* Fences of the syncobjs this job waits on, as found at submit. */
+	struct dma_fence **dep_fences;
+	u32 dep_count;
+
 	/* Pointer to a performance monitor object if the user requested it,
 	 * NULL otherwise.
 	 */
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index f29d79b15..62b7b8987 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -165,6 +165,32 @@ v3d_job_update_stats(struct v3d_job *job)
 	preempt_enable();
 }
 
+/*
+ * drm_sched does not propagate a failed dependency to the job that waits on
+ * it, and the jobs of a submission run on different queues. Take the error of
+ * the previous job of the submission, or of a syncobj it waited on, so that
+ * this job is skipped and the fence userspace waits for reports the failure.
+ */
+static bool v3d_job_failed(struct v3d_job *job)
+{
+	struct dma_fence *finished = &job->base.s_fence->finished;
+	int err, i;
+
+	for (i = 0; i < job->dep_count && !finished->error; i++) {
+		err = dma_fence_get_status(job->dep_fences[i]);
+		if (err < 0)
+			dma_fence_set_error(finished, err);
+	}
+
+	if (job->prev_fence) {
+		err = dma_fence_get_status(job->prev_fence);
+		if (err < 0)
+			dma_fence_set_error(finished, err);
+	}
+
+	return finished->error;
+}
+
 static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 {
 	struct v3d_bin_job *job = to_bin_job(sched_job);
@@ -174,7 +200,7 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence = NULL;
 	unsigned long irqflags;
 
-	if (unlikely(job->base.base.s_fence->finished.error))
+	if (unlikely(v3d_job_failed(&job->base)))
 		goto out_clean_job;
 
 	/* Lock required around bin_job update vs
@@ -235,7 +261,7 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence = NULL;
 
-	if (unlikely(job->base.base.s_fence->finished.error))
+	if (unlikely(v3d_job_failed(&job->base)))
 		goto out_clean_job;
 
 	v3d->queue[V3D_RENDER].active_job = &job->base;
@@ -285,7 +311,7 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence = NULL;
 
-	if (unlikely(job->base.base.s_fence->finished.error))
+	if (unlikely(v3d_job_failed(&job->base)))
 		goto out_clean_job;
 
 	v3d->queue[V3D_TFU].active_job = &job->base;
@@ -351,7 +377,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence = NULL;
 	int i, csd_cfg0_reg;
 
-	if (unlikely(job->base.base.s_fence->finished.error))
+	if (unlikely(v3d_job_failed(&job->base)))
 		goto out_clean_job;
 
 	/* The HW interprets a workgroup size of 0 as 65536; however, the
@@ -662,7 +688,7 @@ v3d_cpu_job_run(struct drm_sched_job *sched_job)
 	struct v3d_cpu_job *job = to_cpu_job(sched_job);
 	struct v3d_dev *v3d = job->base.v3d;
 
-	if (unlikely(job->base.base.s_fence->finished.error))
+	if (unlikely(v3d_job_failed(&job->base)))
 		return NULL;
 
 	if (job->job_type >= ARRAY_SIZE(cpu_job_function)) {
@@ -688,7 +714,7 @@ v3d_cache_clean_job_run(struct drm_sched_job *sched_job)
 	struct v3d_job *job = to_v3d_job(sched_job);
 	struct v3d_dev *v3d = job->v3d;
 
-	if (unlikely(job->base.s_fence->finished.error))
+	if (unlikely(v3d_job_failed(job)))
 		return NULL;
 
 	v3d_job_start_stats(job);
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index eada30a31..3f464128c 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -141,6 +141,10 @@ v3d_job_free(struct kref *ref)
 
 	dma_fence_put(job->irq_fence);
 	dma_fence_put(job->done_fence);
+	dma_fence_put(job->prev_fence);
+	for (i = 0; i < job->dep_count; i++)
+		dma_fence_put(job->dep_fences[i]);
+	kfree(job->dep_fences);
 
 	if (job->perfmon)
 		v3d_perfmon_put(job->perfmon);
@@ -203,6 +207,34 @@ void v3d_job_put(struct v3d_job *job)
 	kref_put(&job->refcount, job->free);
 }
 
+/* Remember the fence a syncobj dependency waits on, so that run_job() can
+ * tell whether the work this job depends on failed.
+ */
+static int
+v3d_job_add_syncobj_dep(struct v3d_job *job, struct drm_file *file_priv,
+			u32 handle, u32 max_deps)
+{
+	struct dma_fence *fence = NULL;
+	int ret;
+
+	ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv, handle, 0);
+	if (ret)
+		return ret;
+
+	if (!job->dep_fences) {
+		job->dep_fences = kcalloc(max_deps, sizeof(*job->dep_fences),
+					  GFP_KERNEL);
+		if (!job->dep_fences)
+			return -ENOMEM;
+	}
+
+	if (job->dep_count < max_deps &&
+	    !drm_syncobj_find_fence(file_priv, handle, 0, 0, &fence) && fence)
+		job->dep_fences[job->dep_count++] = fence;
+
+	return 0;
+}
+
 static int
 v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 		     u32 in_sync, struct v3d_submit_ext *se)
@@ -214,8 +246,7 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 	if (!has_multisync) {
 		/* Ignore syncobj if its handle is zero */
 		if (in_sync)
-			ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
-								   in_sync, 0);
+			ret = v3d_job_add_syncobj_dep(job, file_priv, in_sync, 1);
 		return ret;
 	}
 
@@ -232,8 +263,8 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 
 			/* Ignore syncobj if its handle is zero */
 			if (in.handle) {
-				ret = drm_sched_job_add_syncobj_dependency(&job->base,
-									   file_priv, in.handle, 0);
+				ret = v3d_job_add_syncobj_dep(job, file_priv, in.handle,
+							      se->in_sync_count);
 				if (ret)
 					return ret;
 			}
@@ -494,6 +525,9 @@ v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
 						   dma_fence_get(submit->jobs[i - 1]->done_fence));
 		if (ret)
 			goto err;
+
+		submit->jobs[i]->prev_fence =
+			dma_fence_get(submit->jobs[i - 1]->done_fence);
 	}
 
 	for (int i = 0; i < submit->job_count; i++) {
-- 
2.53.0

