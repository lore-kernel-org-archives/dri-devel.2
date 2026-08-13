Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE62AC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974CF10E4B5;
	Thu, 13 Aug 2026 09:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lC2PxkaN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C218510E4B5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:25:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA24E408A2;
 Thu, 13 Aug 2026 09:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A614F1F00A3A;
 Thu, 13 Aug 2026 09:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786613152;
 bh=h15twvV/eMa+9Jn70S93UAOC33kfTs0bdU3w+BwPuxE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lC2PxkaNJQqwGnbPo61aGHbbo9Rgf3h+c1M6E3qUxMH5LTROCuiUkKwG+yYn8cfjT
 k+IrHFgw7c4U6gMj7DzUUZCi2D+4SFgLZxoleh6ZS5UGDpXPa+4Vl3xelvBSUxYlKO
 P26dyw3OgLvk6Qgz7l/DjDNq/vcW6G+UkutXNm97vOhUaoGJlM9LJxdEDrtJtiRh+Q
 pMZZAy0aNh+g+KGxozq/Gprbefq3Ke4NhzUhZuoTiOnMAELrQWHf3XZuhRjH0jQNTN
 R0aM0s+mrPj2V39MjGP7AhsP97XTIiyp0j16y2sgUziIsenG6Y3JG6daJAVgLqrJc2
 OsgrRo2OOm2dg==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Subject: [PATCH v2 1/2] drm/sched: Lock drm_sched_rq_pop_entity() externally
Date: Thu, 13 Aug 2026 11:25:12 +0200
Message-ID: <20260813092510.2385962-5-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813092510.2385962-4-phasta@kernel.org>
References: <20260813092510.2385962-4-phasta@kernel.org>
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
index 672b5c57ed8e..7fe47fc86c0e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -568,7 +568,9 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
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

