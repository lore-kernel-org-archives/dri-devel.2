Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD955C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D09910E5CD;
	Mon, 21 Sep 2026 21:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nrh0KVCP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5679010E5CD
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=djo7PlSx599p/R0bhPczBk57gwxG60EqaNiRU3FnwZI=; b=nrh0KVCP0v7+BQRcoW9or8acfH
 iEIRB2EAxpK6zKzbrKGhJK1R1H4s9+tg906YR7Qu6uSsB81h0MB1s81OG1q95YSVF2lvaQ2IyBIQ4
 42Cw8naoqxFV+m06Cs4KQkveJOkba7DoGppRqdPbAztHOgBVZNR1yhJH1nY/rRBkhX7IzauqA8yyZ
 6068dzPSiK4irxakQ2kypqVv1Yhlcz/XZslKzEEyals6BBqwylA47S6FPFczuTZtKwr6J2uNTXU/R
 vOqWCeVbwycw7O3DRDZaQmq4rJfs5OwuDCW37nmgkRNvysYPHIQhszxoEuBA5YDynA9y/L2Up68HW
 imwB+IqA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x8lVS-005Iwu-Ag; Mon, 21 Sep 2026 23:24:58 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 21 Sep 2026 18:24:32 -0300
Subject: [PATCH 2/2] drm/v3d: Skip perfmon serialization while a global
 perfmon is set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-v3d-quick-exit-perfmon-serialize-v1-2-e58aea1075e2@igalia.com>
References: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
In-Reply-To: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=uDO7knH5LZzmRSUye+eclohGD1r39+9R4x/9KoVXsfg=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqsaCYtJyQFj4HeDhAvF4ZaEhod9lYcu6lKRXRf
 sRVwyZowPaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCarGgmAAKCRA/8w6Kdoj6
 qr5yCADUlPUOZuCrK9NIlbQQgiiBl9T7B+lNbambJ0Nwm9jZuMTcUG0WKvj22BGzlABP77Hv9QJ
 zjAqWbGxQptSv5TzD3eAoYhOth2OZTHYEUl8T89N5WqlaBq88d1Mo72zRuoj5E4EPseZ+Q1KPGG
 d3yFvQG7bxSPqzTOyti2Nv3mnWvMA4yHeeiGBBB3qPJUuuKsXmkbSJh2Cicfo30mpaDmjkT/DzP
 +tuGq8tnWAKQn2nY3W6DIIfQgRlC9mVqTm71jfcUBMx/h7N94I/KruGqDvBSIHuft0T4OiLcMQI
 2Qc6gJfa+wKiVFPgm1j7lszzkGfjtwon3/Q90lMsjGhQobMp
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

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

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

