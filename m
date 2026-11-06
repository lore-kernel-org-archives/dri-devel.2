Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97A606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=h3L1l0Co
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F00310EA6B;
	Fri,  6 Nov 2026 14:57:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C7A10EB77;
 Fri,  6 Nov 2026 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=uEob53vGgLQ4iMVQkdH5VH1rqTBiA/SP6OGWRgL0ooI=; t=1793977026; x=2109337026; 
 b=h3L1l0Co2sA65Qtb18wYeinaEjTMP+m6VbM/2XEjgMJP2Q2tnfYnVHi+WYHB8YvmdIY1G1VQTNQ
 LXEmYgVcwwCDjWWIjHtkv5MuEc0wRSd/AVgA9XSYmMg+dNWr8HFHd7Vs9FkAwMsR/kQFmFcrJzylf
 ogbEb3CSXoWMimqsyMqtN3DVMr0HanSLSzbEBsmxCm47WWPr3MZnrgKj8tw+crVXq93vj9GzxlamU
 jte+oIBG8QwlLmoaQRd+2s4XAqfjx5v3AULwZkBzSzXPIk2DBT6YmSzZuNGVmXJ1pp57ml1EeX0Jz
 dmkZQtle4OaK6FmkWaQaN1rAa2WlNE2zCXRA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xPLNI-004VmQ-Q3; Fri, 06 Nov 2026 15:57:04 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 1/7] drm/sched: Disallow initializing entities with
 un-initialized schedulers
Date: Fri,  6 Nov 2026 14:56:56 +0000
Message-ID: <20261106145702.61640-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Simplify the code and theoretical runtime combinations by disallowing
initializing entities with un-initialized schedulers.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
I do not *think* any of the drivers relies on this inverted initialization
order but it needs more eyes for sure.
---
 drivers/gpu/drm/scheduler/sched_entity.c | 30 +++++++++++++++---------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 03e68b4102d5..2844049d4c66 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -119,9 +119,16 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 			  unsigned int num_sched_list,
 			  atomic_t *guilty)
 {
-	if (!entity || !sched_list || !num_sched_list || !sched_list[0])
+	unsigned int i;
+
+	if (!entity || !sched_list || !num_sched_list)
 		return -EINVAL;
 
+	for (i = 0; i < num_sched_list; i++) {
+		if (!sched_list[i] || !sched_list[i]->sched_rq)
+			return -EINVAL;
+	}
+
 	memset(entity, 0, sizeof(struct drm_sched_entity));
 
 	entity->stats = drm_sched_entity_stats_new();
@@ -135,13 +142,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 
-	if (!sched_list[0]->sched_rq) {
-		/* Since every entry covered by num_sched_list
-		 * should be non-NULL and therefore we warn drivers
-		 * not to do this and to fix their DRM calling order.
-		 */
-		pr_warn("%s: called with uninitialized scheduler\n", __func__);
-	} else if (priority >= sched_list[0]->num_user_rqs) {
+	if (priority >= sched_list[0]->num_user_rqs) {
 		/*
 		 * The "priority" of an entity cannot exceed the number of
 		 * run-queues of a scheduler. Protect against num_rqs being 0,
@@ -158,8 +159,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->priority = priority;
 	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
 			      DRM_SCHED_PRIORITY_KERNEL : priority;
-	if (sched_list[0]->sched_rq)
-		entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
+	entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
 
 	init_completion(&entity->entity_idle);
 
@@ -192,7 +192,15 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 				    struct drm_gpu_scheduler **sched_list,
 				    unsigned int num_sched_list)
 {
-	WARN_ON(!num_sched_list || !sched_list);
+	unsigned int i;
+
+	if (WARN_ON(!num_sched_list || !sched_list))
+		return;
+
+	for (i = 0; i < num_sched_list; i++) {
+		if (WARN_ON(!sched_list[i] || !sched_list[i]->sched_rq))
+			return;
+	}
 
 	spin_lock(&entity->lock);
 	entity->sched_list = sched_list;
-- 
2.56.0

