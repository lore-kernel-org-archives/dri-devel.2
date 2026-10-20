Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302E60A2608
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=C1xAHWP0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2A910F6C9;
	Tue, 20 Oct 2026 15:41:35 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 170FB10F685;
 Tue, 20 Oct 2026 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=aovglTqOpRcFlt/l4QOVNEMi7ALd0q2xC2hKw0Ph57I=; b=C1xAHWP05pkuT/UNkk/Py1tp7F
 Fhws5tQin3VB53xJwevwWWGA6eYkCv/O7nm+yxbIn3yyGhr+AglEuS5ahjBSu2p7JPfz06nOzS82n
 aYGDgnR9B13ZEpNDAaq1IAsTCkopypsyACVoL4fGr23E9XLAq8G97IznOAXEw9m+McuJvCzsyQx9d
 anXlK9eiJn+J9jgEDQXgxToKwkJb33UJCfd3OwHJMoQGZ6TnOkRC3qjSsrvnvf26cp98LyCEDEktR
 KH/Y8+xStWEqGEA0QoI4qiVO3bmY27vqXeyxVeh+7o06BsHAYMeY+6Slnwt6kyEfA3/3ncO2lB7kc
 KUe2YaRA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJBxv-004idk-3i; Tue, 20 Oct 2026 17:41:27 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2 2/8] drm/sched: Disallow initializing entities with
 un-initialized schedulers
Date: Tue, 20 Oct 2026 16:41:17 +0100
Message-ID: <20261020154123.33631-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/scheduler/sched_entity.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e12709b7bd0c..95bb79b3d003 100644
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
 
-- 
2.56.0

