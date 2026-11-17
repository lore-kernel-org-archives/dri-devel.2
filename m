Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0265606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoDIexIJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F3710E073;
	Tue, 17 Nov 2026 09:37:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEE410E073
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:37:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEC1342E6C;
 Tue, 17 Nov 2026 09:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF501F000C6;
 Tue, 17 Nov 2026 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794908259;
 bh=sYsejNEMULh2lKIx2yILKbg2OeJOUfENCYPm27432Lc=;
 h=From:To:Cc:Subject:Date;
 b=UoDIexIJG7Z2g8JHrBHM+uRE8Gf/5jJcgqP38JNGPYK29sH3Hjg2iKmhucMs3l/uu
 /d5wYg0Uz3lP6hz+hajg2qDPFXiinsuMha+dUwyEu1Hr7BUOdla1a/RhzlZTQ+SAEw
 Ol6Mkm03OIC//7RYZBZtExrp40PPt5L62Hlpw1lG4Y3Kb18+G9ChdiwN2GoXek9xza
 vdZLbxVwOHMV0Q4vQNIOA5SzMX9Zd9/L6WnO3JHykfYpoDtAv/jK04hiSFxTSrpQp3
 fl07tz3V2adVX/sIE0tKwCbDJI+rTT5jyTC8d5OLFFOGu7YkqMZdxpWAQJvWwRPWRL
 j4ED0Y7MOraaw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Extend locking in drm_sched_entity_select_rq()
Date: Tue, 17 Nov 2026 10:37:09 +0100
Message-ID: <20261117093708.647488-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_sched_entity_select_rq() evaluates entity->sched_list locklessly,
which is elsewhere always lock-protected. Another lockless check regards
spsc_queue_count(). spsc_queue is evaluated under lock protection at
many places already and the plan is to replace it with fully locked
infrastructure anyways.

Move the spin_lock() in drm_sched_entity_select_rq() upwards.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 03e68b4102d5..3856d5e507d7 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -577,22 +577,21 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;
 
+	spin_lock(&entity->lock);
+
 	/* single possible engine and already selected */
 	if (!entity->sched_list)
-		return;
+		goto unlock;
 
 	/* queue non-empty, stay on the same engine */
 	if (spsc_queue_count(&entity->job_queue))
-		return;
+		goto unlock;
 
-	spin_lock(&entity->lock);
 	fence = entity->last_scheduled;
 
 	/* stay on the same engine if the previous job hasn't finished */
-	if (fence && !dma_fence_is_signaled(fence)) {
-		spin_unlock(&entity->lock);
-		return;
-	}
+	if (fence && !dma_fence_is_signaled(fence))
+		goto unlock;
 
 	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
 	rq = sched ? sched->sched_rq[entity->rq_priority] : NULL;
@@ -604,6 +603,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	if (entity->num_sched_list == 1)
 		entity->sched_list = NULL;
 
+unlock:
 	spin_unlock(&entity->lock);
 }
 
-- 
2.56.0

