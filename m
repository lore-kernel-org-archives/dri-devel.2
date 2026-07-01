Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539CFC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F73310EE6F;
	Wed,  1 Jul 2026 08:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mRJyP7j/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7F0E10EE6F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:59:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B565601D7;
 Wed,  1 Jul 2026 08:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184091F00A3A;
 Wed,  1 Jul 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782896387;
 bh=iZAhHXGtjOwctuSESrqjb/h//3iNlg1eMfjJgUlrvZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mRJyP7j/RCXvc/gtQYunFK4hD8zFzBnadLMrxpO8DSoKayGBw5x7XDZ9K54jPSyJN
 ikbW4Ztj/mql0/sqzPFxP5C40Sxk115RYWGvpvFtm3Bbm3UOXjAWnyaZ01z4fj+RVP
 /5qLE4pXFC0F45srB5WM8W0TNKHAi4I9SGK7Y6sXhBJh6ReoqiH3eLF9Hj5cwfV0mW
 N8AxZ/oLawBxIwcROAhNZhs+I8h3nzMmEPxV8vHuJMx7mxMCZxZCxV8LOoFN+JENAp
 rL1+KVAx5rTCOU1/+TK9E3hp+YtzMkvGpdu4r2EX0T+SRmdFiZp4jik8+qWy0kkiZt
 Vcl/UhOTP1rew==
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
Subject: [PATCH 3/5] drm/sched: Avoid lock cycle for sched_entity
Date: Wed,  1 Jul 2026 10:59:19 +0200
Message-ID: <20260701085920.3253248-5-phasta@kernel.org>
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

Previous cleanup commits created a slightly sub-optimal lock-cycle
between the two functions drm_sched_entity_pop_job() and
drm_sched_rq_pop_entity().

Avoid the lock-cycle by moving the locking from
drm_sched_rq_pop_entity() to drm_sched_entity_pop_job(). Add the
appropriate lockdep check.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 drivers/gpu/drm/scheduler/sched_rq.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 5cf0af91faf2..0fc1213a0d3f 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -539,10 +539,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	 * TODO: Replace spsc_queue completely with a locked (h)list.
 	 */
 	spsc_queue_pop(&entity->job_queue);
+	drm_sched_rq_pop_entity(entity);
 	spin_unlock(&entity->lock);
 
 	dma_fence_put(prev_last_scheduled);
-	drm_sched_rq_pop_entity(entity);
 
 	/* Jobs and entities might have different lifecycles. Since we're
 	 * removing the job from the entities queue, set the jobs entity pointer
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 044546bcb5f8..97363f9ef8bc 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -319,11 +319,12 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
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
@@ -340,7 +341,6 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 		drm_sched_entity_save_vruntime(entity, min_vruntime);
 	}
 	spin_unlock(&rq->lock);
-	spin_unlock(&entity->lock);
 }
 
 /**
-- 
2.54.0

