Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C978CC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0468F10EBDF;
	Tue, 11 Aug 2026 13:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bpSNSc22";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3CB10EBD2;
 Tue, 11 Aug 2026 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=uJ3EpT7DmA9CpGm3ROx190dkI0zlO+2mVu+iubKl05E=; b=
 bpSNSc222L7rDeXkh5F6GmJSHk97PDWZWthhl4Wac9tIw6W2+xTeDWqmMe4Cwan3VtR7EbH8EOEQ3
 BHyeI3LmHeUj0b89xu62Md72fh73D0Y91U+qeVAWDxf9OTqrqWuU+xphtInwbaDqSH5AhVV8lEaP1
 fCqGn5WXCYPHKRs2AqMj76L78ujp4D3aPXeFGCpJI5fcc1fsNDYpxHQ0eVhHdS0EssD4xkB2wME4Q
 /pmr+TANv3vZTFzvQ/4QqAc6kfraqgfcP1v5M1HQjWpYMiGYSvd2X1vGpRsqNBnDzOYrH5BIMo7fU
 6teZ7CkYL4izadl3Yz4rynp5L+FQD5wNlQ==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpl-00H9mM-PJ; Tue, 11 Aug 2026 15:48:01 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 01/20] Revert "drm/sched: Remove redundant entity->rq
 initialization and checks"
Date: Tue, 11 Aug 2026 14:47:39 +0100
Message-ID: <20260811134758.96339-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
References: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
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

This reverts commit 2df5efb45425b48fbf5a3c1f36a686af26871009.
---
 drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++++--
 drivers/gpu/drm/scheduler/sched_main.c   |  9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index c51101ec70c1..4ebb513255ed 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -129,6 +129,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&entity->list);
+	entity->rq = NULL;
 	entity->guilty = guilty;
 	entity->priority = priority;
 	entity->last_user = current->group_leader;
@@ -279,6 +280,9 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	struct drm_sched_job *job;
 	struct dma_fence *prev;
 
+	if (!entity->rq)
+		return;
+
 	spin_lock(&entity->lock);
 	entity->stopped = true;
 	drm_sched_rq_remove_entity(entity->rq, entity);
@@ -325,11 +329,14 @@ EXPORT_SYMBOL(drm_sched_entity_kill);
  */
 long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 {
-	struct drm_gpu_scheduler *sched =
-		container_of(entity->rq, typeof(*sched), rq);
+	struct drm_gpu_scheduler *sched;
 	struct task_struct *last_user;
 	long ret = timeout;
 
+	if (!entity->rq)
+		return 0;
+
+	sched = container_of(entity->rq, typeof(*sched), rq);
 	/*
 	 * The client will not queue more jobs during this fini - consume
 	 * existing queued ones, or discard them on SIGKILL.
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d2ca01b31ee4..818d3d4434b5 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -588,6 +588,15 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		       u32 credits, void *owner,
 		       uint64_t drm_client_id)
 {
+	if (!entity->rq) {
+		/* This will most likely be followed by missing frames
+		 * or worse--a blank screen--leave a trail in the
+		 * logs, so this can be debugged easier.
+		 */
+		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
+		return -ENOENT;
+	}
+
 	if (unlikely(!credits)) {
 		pr_err("*ERROR* %s: credits cannot be 0!\n", __func__);
 		return -EINVAL;
-- 
2.54.0

