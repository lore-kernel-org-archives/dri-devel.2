Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72B1CA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5996A10F8F1;
	Fri,  2 Oct 2026 15:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mM5Woh37";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281C510F8DA;
 Fri,  2 Oct 2026 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=EN/oMxHueohjeFOgo+Mvm+nba4WBPX1/Q5UBRH33nWg=; b=mM5Woh37ettl35uCJSIOSor5rS
 HfMwWi8mxjsDNShM9QebXOqyWbtv0dkBNB9FRNJbHDKSRaQQFFa61Isrejdqu9gdIPJT5oUau8aRd
 /+yu1i825lXhzjYvmpJGrN2yK/glPkc+G0cCxDAFmqarU+0iGEK5yxkW5QUKIXrGMz8umzTJPwiwb
 fO9nzwqj/CvdMW7KM3gj7EKlwaizH0R1GWoWm4PYvc0QCvEqicgBEP7ZRsEwA8RadzmZrNG69KfLP
 OW5eE/3shb6wXc8UwAF1YaRsHlr7aYiZ2Ed4FxK6UieOMzmQ0pKBnQ4gnELuPJ//HZ0I34my1JBmm
 9N8hPbjA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCfTi-00AflX-2S; Fri, 02 Oct 2026 17:47:18 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 3/9] drm/sched: Disallow initializing entities with
 un-initialized schedulers
Date: Fri,  2 Oct 2026 16:47:07 +0100
Message-ID: <20261002154713.77591-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
References: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
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
2.55.0

