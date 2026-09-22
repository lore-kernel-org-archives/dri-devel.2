Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB15C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDCE10E4D2;
	Tue, 22 Sep 2026 13:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YgKh/eus";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D458810E4D2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=GCOKotr3NubxobsEmPHTeqNyQQCF72Zm4mofnJ6NU1Q=; b=YgKh/eusfKVPaYTRyKAaUzOWt8
 s3F4im+y8QAxFrrgFavuweA/bwJEEmr7defWRfHX9+8GQGXciyLsTXMyHGvcqUhBBlZ9t71a6g2nZ
 jxMLOmcSPVGvmHaqh9YwR7Uf5mv7CBeS3p7eSHX2NRct7+P3A8J9Yvb/H1T92LhR9XEaDgIdyN7rg
 u27ujfvbrw6agjW0kxAzOxytVan5wXjaV8hDDUfhQugDGb8rBA+Tg8A3atHcEFgXBRieO5IolhGpb
 qaB3M6kTLekzrRNwJ6V5702B3Onb1am52/Uov8F2rDILO1AplC+MQ3x2v+kVfpL0YjBN9PHyemLZ/
 WwW9SzMQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x90X7-005e24-Ee; Tue, 22 Sep 2026 15:27:42 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 22 Sep 2026 10:24:51 -0300
Subject: [PATCH v2 2/2] drm/v3d: Skip perfmon serialization while a global
 perfmon is set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-v3d-quick-exit-perfmon-serialize-v2-2-2a8021dc32f2@igalia.com>
References: <20260922-v3d-quick-exit-perfmon-serialize-v2-0-2a8021dc32f2@igalia.com>
In-Reply-To: <20260922-v3d-quick-exit-perfmon-serialize-v2-0-2a8021dc32f2@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=GhM2zjCROejIvkiQwyiTlV5SFUmAe7u/JzxBL5+634U=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqsoHJMXojh2Wf/ZqN0E07/PDboMu1bROCi1WR5
 fazNLTVpdWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCarKByQAKCRA/8w6Kdoj6
 qvmmB/9FvBirQtiuR/ZIJLjIfzvnIVzuOpLqbbe6zNQSPOAlpSNdHGUgIAbNtlhQxqT92TnjazY
 +GSrHId5ohZaI9vKS+MHGG3Ou+YXGzMNgV7/3XAXX+05PwZz1mA4EqK+xmR1LMGaCi2vl/OE27I
 i3t1hTSfKqV8AZ5YZ0mBvjH9YluooQj3fDsUqRvA1aaPeuX56rVfs1mJHk5OOgmEx/481V7i6V+
 c0vUiGZ2NLEIPMStmKXWILFFndlnsodr6xmQCXclGGpngvVkEiF6EI3zb1Qq4wwOOxSn8ukushY
 DU0hjtEDYMrvY6efMUa/Tskk4Jd+0Q62rOD5joyXtOZZfKxg
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

A global perfmon counts concurrent activity from every job, so no
dependency is added while one is set. Skip the accumulator for the jobs
carrying no perfmon while a global perfmon is enabled, which is every job
in the common case.

Jobs carrying their own perfmon stay tracked. The global perfmon may be
cleared before such a job runs, and the next job carrying a perfmon has
to wait for it, otherwise both are in flight at once and only one gets
programmed in the HW.

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  3 ++-
 drivers/gpu/drm/v3d/v3d_submit.c | 18 ++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 02b6ab7dc72b..d40610a34db9 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -201,7 +201,8 @@ struct v3d_dev {
 		 * queue, which is used so that a new perfmon-carrying job can
 		 * depend on every job currently in-flight across all queues.
 		 *
-		 * Finished fences are only tracked if @nperfmons > 0.
+		 * Finished fences are only tracked if @nperfmons > 0 and no
+		 * global perfmon is set.
 		 */
 		struct dma_fence *last_hw_fence[V3D_MAX_QUEUES];
 	} perfmon_state;
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index bc3c43fd4fd9..7548faab67ba 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -359,15 +359,15 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
  * track concurrent activity from all jobs.
  *
  * Keeping track of the in-flight jobs costs a fence merge per job, so it is
- * only done while at least one perfmon is alive. Jobs submitted while no
- * perfmon exists go untracked and may overlap the first measured job.
+ * only done while at least one perfmon is alive, and is skipped for the jobs
+ * carrying no perfmon while a global perfmon is set. Jobs submitted while
+ * tracking is off go untracked and may overlap the first measured job.
  */
 static int
 v3d_serialize_for_perfmon(struct v3d_job *job)
 {
 	struct v3d_dev *v3d = job->v3d;
 	struct dma_fence *merged;
-	bool is_global_perfmon;
 	int ret;
 
 	lockdep_assert_held(&v3d->sched_lock);
@@ -375,11 +375,10 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
 	if (!atomic_read(&v3d->perfmon_state.nperfmons))
 		return 0;
 
-	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock)
-		is_global_perfmon = !!v3d->global_perfmon;
-
-	if (is_global_perfmon)
-		goto publish;
+	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
+		if (!job->perfmon && v3d->global_perfmon)
+			return 0;
+	}
 
 	if (job->perfmon) {
 		for (enum v3d_queue q = 0; q < V3D_MAX_QUEUES; q++) {
@@ -400,7 +399,6 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
 			return ret;
 	}
 
-publish:
 	/*
 	 * Accumulate every in-flight job on this queue into one merged fence.
 	 * A HW queue is fed by several scheduler entities (one per-fd), so jobs
@@ -414,7 +412,7 @@ v3d_serialize_for_perfmon(struct v3d_job *job)
 	dma_fence_put(v3d->perfmon_state.last_hw_fence[job->queue]);
 	v3d->perfmon_state.last_hw_fence[job->queue] = merged;
 
-	if (job->perfmon && !is_global_perfmon) {
+	if (job->perfmon) {
 		dma_fence_put(v3d->perfmon_state.fence);
 		v3d->perfmon_state.fence = dma_fence_get(job->done_fence);
 	}

-- 
2.55.0

