Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD5BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F3E10EE88;
	Wed,  1 Jul 2026 08:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FS3Ejs7T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F8210EE7B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:59:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C6DD601D8;
 Wed,  1 Jul 2026 08:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDAE1F000E9;
 Wed,  1 Jul 2026 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782896396;
 bh=sq9yVGjU7Aarfc6/TDWlud/Yv0zasvTjRqyAyAYsNn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FS3Ejs7TaXikZXz8JLom3RSefBMT3XBVPlGPTXvLeXtyZUzWj+4NsQCLhY5PtnSit
 PojGDW5OawhX02JGW8tT7ydJpl+PEDueaHbP5NaUpxAExsk97vmKW1YZWx8d/Zmkus
 UDFmmAPMVqXhSRse5AMD0vpyzb9GQCbSgujG8vYWhbhcr+hAmKzoUvzGZcA/Kn4fp3
 1IsHiz6/kdnP74rgQ9HbTqyYhrKrvVCm7ETD2JGZuh+K52k63QS90MSt46vDPVyivM
 P/M/oAlZ9LxYFoG97BQQsY2KsA/s6zQGcs7S2otWihWlN1sEGT66nGAinRfaxRZgaA
 kOJDXt2R5v+xQ==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Marco Pagani <marco.pagani@linux.dev>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 5/5] drm/sched: Remove entity->entity_idle
Date: Wed,  1 Jul 2026 10:59:21 +0200
Message-ID: <20260701085920.3253248-7-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701085920.3253248-2-phasta@kernel.org>
References: <20260701085920.3253248-2-phasta@kernel.org>
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

The completion entity->entity_idle only existed because the entity was
not properly locked through it's spinlock. The completion served to
inform waiters about whether the entity is actually idle, which is
something locking (previously added to drm_sched_entity_is_idle()) can
fully achieve.

Remove the surplus completion.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 9 ---------
 drivers/gpu/drm/scheduler/sched_main.c   | 2 --
 drivers/gpu/drm/scheduler/sched_rq.c     | 1 -
 include/drm/gpu_scheduler.h              | 7 -------
 4 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index cb03d6a36578..23536dcfa96a 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -136,10 +136,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	entity->rq = &sched_list[0]->rq;
 	RB_CLEAR_NODE(&entity->rb_tree_node);
-	init_completion(&entity->entity_idle);
-
-	/* We start in an idle state. */
-	complete_all(&entity->entity_idle);
 
 	spin_lock_init(&entity->lock);
 	spsc_queue_init(&entity->job_queue);
@@ -285,12 +281,7 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	spin_lock(&entity->lock);
 	entity->stopped = true;
 	drm_sched_rq_remove_entity(entity->rq, entity);
-	spin_unlock(&entity->lock);
 
-	/* Make sure this entity is not used by the scheduler at the moment */
-	wait_for_completion(&entity->entity_idle);
-
-	spin_lock(&entity->lock);
 	prev = entity->last_scheduled;
 	dma_fence_get(prev);
 	spin_unlock(&entity->lock);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d2ca01b31ee4..b90220794a14 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -997,7 +997,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 
 	sched_job = drm_sched_entity_pop_job(entity);
 	if (!sched_job) {
-		complete_all(&entity->entity_idle);
 		drm_sched_run_job_queue(sched);
 		return;
 	}
@@ -1013,7 +1012,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 	 * refcount has been incremented for the scheduler already.
 	 */
 	fence = sched->ops->run_job(sched_job);
-	complete_all(&entity->entity_idle);
 	drm_sched_fence_scheduled(s_fence, fence);
 
 	if (!IS_ERR_OR_NULL(fence)) {
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 97363f9ef8bc..54aba1ef0d7a 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -373,7 +373,6 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 				return ERR_PTR(-ENOSPC);
 			}
 
-			reinit_completion(&entity->entity_idle);
 			break;
 		}
 	}
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 176ff1f936cd..55260cbe880a 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -221,13 +221,6 @@ struct drm_sched_entity {
 	 */
 	bool 				stopped;
 
-	/**
-	 * @entity_idle:
-	 *
-	 * Signals when entity is not in use, used to sequence entity cleanup in
-	 * drm_sched_entity_fini().
-	 */
-	struct completion		entity_idle;
 
 	/**
 	 * @oldest_job_waiting:
-- 
2.54.0

