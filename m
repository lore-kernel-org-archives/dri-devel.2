Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B718C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 387B110EC1C;
	Tue, 11 Aug 2026 14:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="myyoPP/e";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF9A10EC1B;
 Tue, 11 Aug 2026 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=/E23Cm+zmF7lpZ1A2mN3gcn3PPLr11xJpYvbohzyLrQ=; b=myyoPP/e1wdiwkO+bpUfZvxjoZ
 pZrDadCfd90oK24CtwGUzy9MGmsYN+ytzVQxVffwRrZFW1i34A8A2A/hqFKy8kXkNDq0RojE97pOf
 5oy1pMAIi/0J3yWrVIFg0wCODbw3NhS99B/PMHwL0AITOxl4AnOQSIUcL4NGNOQ+7qBPGFEzWbyhu
 vvEt2OME+gJ0rc5MX+blrjTbIuuNFtEh1VLdbu2Vvsh4O7/TFdYl2eNvK/ZhNQBiovcQnrGCoqorb
 wQZ+xwjkN1vd9+iiZ40s3Nsg20cwQLVp+VSSiHGP+PCBK3u5sVl9yfso72Scf2VeUpfH+ZttsbpF6
 AakJUfzA==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtn8n-00HBeT-5e; Tue, 11 Aug 2026 16:07:41 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v2 01/20] Revert "drm/sched: Remove redundant entity->rq
 initialization and checks"
Date: Tue, 11 Aug 2026 15:07:18 +0100
Message-ID: <20260811140738.96974-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
References: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
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

This reverts commit 2df5efb45425b48fbf5a3c1f36a686af26871009.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
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

