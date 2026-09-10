Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6793C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204C910F358;
	Thu, 10 Sep 2026 08:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QLHRmmRs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7001F10F358
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:00:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B4F343D96;
 Thu, 10 Sep 2026 08:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BA71F00893;
 Thu, 10 Sep 2026 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789027217;
 bh=A6O/FnKx9HiwEimzvzr069CdeenRxC9yV4dsMOzY6xY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QLHRmmRs7nmt7R0AYD2tJKkCSfOQuqIOIHZN/F0T/Pq/sP5NboYNwOXvTcDet9arh
 1kWjRoM11ODu6f7jnOGJldrYs+TOaRYi81XhKIG8zHkWRFBl0FZfipt124lRbhtmkv
 jWRxFjckGcoehZ66Gg0Foy28PPEEvGeg9Ji5I+0JMxFJhuqX+hU9U7p5SCWM6+sBAC
 T14tRl7ZtrsbO2Hs8DzB2w736zeoZFbr5FRokvDYLm3gwSo51pUaS6oP4pUwgQ3yD7
 09pHluAHbXVAclJ8LGP4IXLSJBhF6BdWpjb5ZObPEpm7JECaQ4gKTjLiVJi2xQidgW
 1mM3/frbinVmw==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] drm/sched: Lock drm_sched_rq_pop_entity() externally
Date: Thu, 10 Sep 2026 09:59:41 +0200
Message-ID: <20260910075942.2000338-3-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910075942.2000338-2-phasta@kernel.org>
References: <20260910075942.2000338-2-phasta@kernel.org>
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

In order to protect entity->last_scheduled with a spinlock, adding
locking to drm_sched_entity_pop_job() is necessary. This would lead to a
slightly suboptimal lock-unlock-relock pattern with
drm_sched_rq_pop_entity().

As a preparational step for adding the locking, lock
drm_sched_rq_pop_entity() externally.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
 drivers/gpu/drm/scheduler/sched_rq.c     | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index bf97508a45b9..274d7a702298 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -565,7 +565,9 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
 	spsc_queue_pop(&entity->job_queue);
 
+	spin_lock(&entity->lock);
 	drm_sched_rq_pop_entity(entity);
+	spin_unlock(&entity->lock);
 
 	/* Jobs and entities might have different lifecycles. Since we're
 	 * removing the job from the entities queue, set the jobs entity pointer
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 0464d324d98d..696792a18708 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -346,11 +346,12 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 	struct drm_sched_job *next_job;
 	struct drm_sched_rq *rq;
 
+	lockdep_assert_held(&entity->lock);
+
 	/*
 	 * Update the entity's location in the min heap according to
 	 * the timestamp of the next job, if any.
 	 */
-	spin_lock(&entity->lock);
 	rq = entity->rq;
 	spin_lock(&rq->lock);
 	next_job = drm_sched_entity_queue_peek(entity);
@@ -376,7 +377,6 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 		}
 	}
 	spin_unlock(&rq->lock);
-	spin_unlock(&entity->lock);
 }
 
 /**
-- 
2.55.0

