Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C6DCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3192F10F2A5;
	Tue,  2 Jun 2026 15:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OIzPIqW4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E8010F2B2
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gst/2HN1uZ1/hINb2SoXt02LNK5H/R/udd3ZY+UW8C0=; b=OIzPIqW4ManAX+DPnIzfHA/ESm
 dQ5KM3FvhnDAUUoyjCkIZPK2Iv17aobyHgkCfhj+Shd/L56tuimipupDl8DaPQXJLTTOtjV3uwWBY
 UjTGQKQfCXOto48pxk1g8LN6+tlL2AZhp5nHNDbYMoOShctXEFf20H9VRnmyolqLhV49ig/DiOn62
 dqjwwBTXLkRAvsx9pWZ7zTHBLxGDMUrJ7XoOTAMT8D7cXAD+WWqtXzCrC5c/zE9ObwPABS0F5lz2b
 bE/GFkL/F7+XkGCWWPYFkAhDFoeR5HpJVplA8YyIoTdFmd57CxB1qJeuFTALwNFT2NLqxol1MIIYv
 etXvxwbQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUR7g-00Blk0-Tc; Tue, 02 Jun 2026 17:33:44 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] drm/sched: Remove redundant entity->rq initialization and
 checks
Date: Tue,  2 Jun 2026 16:33:39 +0100
Message-ID: <20260602153339.43453-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Commit
28c5bf28763d ("drm/sched: Disallow initializing entities with no schedulers")
failed to notice clearing of entity->rq in drm_sched_entity_init() is now
redundant and can be removed.

Given that entity->rq can now never be NULL, we also remove two impossible
checks, from drm_sched_entity_kill() and drm_sched_entity_flush()
respectively.

Similarly, we can also remove the !entity->rq check in
drm_sched_job_init(). And for the better, given that the error message, if
it ever triggered, would have dereferenced the yet un-initialized job->
sched (only initialized later in drm_sched_job_arm()). This appears to
have been theoretically broken ever since commit
56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 11 ++---------
 drivers/gpu/drm/scheduler/sched_main.c   |  9 ---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 4ebb513255ed..c51101ec70c1 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -129,7 +129,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&entity->list);
-	entity->rq = NULL;
 	entity->guilty = guilty;
 	entity->priority = priority;
 	entity->last_user = current->group_leader;
@@ -280,9 +279,6 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	struct drm_sched_job *job;
 	struct dma_fence *prev;
 
-	if (!entity->rq)
-		return;
-
 	spin_lock(&entity->lock);
 	entity->stopped = true;
 	drm_sched_rq_remove_entity(entity->rq, entity);
@@ -329,14 +325,11 @@ EXPORT_SYMBOL(drm_sched_entity_kill);
  */
 long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 {
-	struct drm_gpu_scheduler *sched;
+	struct drm_gpu_scheduler *sched =
+		container_of(entity->rq, typeof(*sched), rq);
 	struct task_struct *last_user;
 	long ret = timeout;
 
-	if (!entity->rq)
-		return 0;
-
-	sched = container_of(entity->rq, typeof(*sched), rq);
 	/*
 	 * The client will not queue more jobs during this fini - consume
 	 * existing queued ones, or discard them on SIGKILL.
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 818d3d4434b5..d2ca01b31ee4 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -588,15 +588,6 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		       u32 credits, void *owner,
 		       uint64_t drm_client_id)
 {
-	if (!entity->rq) {
-		/* This will most likely be followed by missing frames
-		 * or worse--a blank screen--leave a trail in the
-		 * logs, so this can be debugged easier.
-		 */
-		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
-		return -ENOENT;
-	}
-
 	if (unlikely(!credits)) {
 		pr_err("*ERROR* %s: credits cannot be 0!\n", __func__);
 		return -EINVAL;
-- 
2.54.0

