Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842C606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=dmxMcTAi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF48B10E552;
	Tue, 17 Nov 2026 09:43:34 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE6410E552
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=DWj1QfViLq56xsl88m7voBODx4fsa0knSKctkleJloM=; t=1794908608; x=2110268608; 
 b=dmxMcTAioGlzRli5WXkbrWMWhAiVpZF1knCaehLZkHsUetGB6b6kBotvceAx7MukwFbEer6zamt
 ym0xrxttLjOapnu0yHHQRDPyTOrQdS+jE6JM4RWQs2FZ89kymF5J0W3/HeDuKAX+ubVgPXpwMKugh
 vzYyh3Cz6zvRML4Lps08pUXgSEWfkrlPFLu8v5pQj3cNTWdMBtd7pKXVrY6s1PEO+r87iryAwWRjz
 Zhexygq4XlLSnuZxTXgRsJPOA/49uMhkyHO2yGSZkhQgWT7utoLi3HI3TWh32hbe2v4RUan/hCYdA
 LAMX2Trx0HAuTQfAINAYeFX5Sl5vdytw3MaA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTFin-00000000Wqh-3vcP; Tue, 17 Nov 2026 10:43:26 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2] drm/sched: Do not overaccount job runtime
Date: Tue, 17 Nov 2026 09:43:24 +0000
Message-ID: <20261117094324.8256-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the starting timestamp of the next job on the timeline is
adjusted to the end of a preceding job. This works if the next job has
been submitted while the preceding job was still executing, but not if it
was submitted in the window between it finishing and free job work running
the timestamp adjustment.

This can happen because the run job and free job work items share the same
ordered workqueue and run job can easily submit the next job before the
free job gets a chance to run. This over accounting window is present
especially with single credit schedulers, but not limited too.

Fix it by only adjusting the starting timestamp if it is not already after
the finish time of the preceding job.

While at it move the logic to a helper to keep indendation at bay.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 1774baa64f93 ("drm/scheduler: Change scheduled fence track v2")
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
v2:
 * Add drm_sched_job_ prefix to the local helper.
---
 drivers/gpu/drm/scheduler/sched_main.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 5a2c99b0b38f..d0d34c523615 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -898,6 +898,25 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 	return IS_ERR(entity) ? NULL : entity;
 }
 
+static void
+drm_sched_job_adjust_next_start(struct drm_sched_job *job,
+				struct drm_sched_job *next)
+{
+	struct dma_fence *next_scheduled = &next->s_fence->scheduled;
+	ktime_t ts;
+
+	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &next_scheduled->flags))
+		return;
+
+	/*
+	 * If the next job has been submitted while the previous one was still
+	 * running adjust it's starting timestamp to avoid accounting overlap.
+	 */
+	ts = dma_fence_timestamp(&job->s_fence->finished);
+	if (ktime_after(ts, next_scheduled->timestamp))
+		next_scheduled->timestamp = ts;
+}
+
 /**
  * drm_sched_get_finished_job - fetch the next finished job to be destroyed
  *
@@ -929,11 +948,7 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 						typeof(*next), list);
 		if (next) {
 			/* make the scheduled timestamp more accurate */
-			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
-				     &next->s_fence->scheduled.flags))
-				next->s_fence->scheduled.timestamp =
-					dma_fence_timestamp(&job->s_fence->finished);
-
+			drm_sched_job_adjust_next_start(job, next);
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
 		}
-- 
2.56.0

