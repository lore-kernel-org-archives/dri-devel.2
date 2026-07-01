Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDC9C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5D510EE78;
	Wed,  1 Jul 2026 08:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m6QTuUxg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EA110EE78
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:59:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0B5D43F2C;
 Wed,  1 Jul 2026 08:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3781F000E9;
 Wed,  1 Jul 2026 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782896383;
 bh=0lRsz+bsd59r/YXRL4xu3uteL9lA+FSwzHtZ025wxN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m6QTuUxgqiakjeh4Srm3Evvf+x8GPJPlS/3Lskx8UQXFHBicETcE5qifKdaVarGO2
 RPvCyOkZJ9PVEKt3cydgiN3nEpUYCSwX+UTu5SVKcIeDunip/TfvEh8XllbD5Imi26
 nKSGoJIL4UA6IOSO+vRvjfRYAwNW4GGgLb3fx0COd0rV+bdQYmMRRG9LgyivRygHbd
 NH2vo8wRMNzbomkC5/PBjRpDtLgLiDnp1U+AeZ9Z9HhEUAvWaZfpYv2BsSSF4Xk8t0
 /f+srLd0t6QmSU/4RiTfp34vrlFjWGE2QQ7oQbtgh7pb0W64HiMELyYrKC/Yx8h+mI
 NZWhqmKpP6Piw==
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
Subject: [PATCH 2/5] drm/sched: Lock spsc_queue in drm_sched_entity_pop_job()
Date: Wed,  1 Jul 2026 10:59:18 +0200
Message-ID: <20260701085920.3253248-4-phasta@kernel.org>
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

Cleanup work in the preceding commit added locking to
drm_sched_entity_pop_job(). This cleanup causes a slightly sub-optimal
lock cycle with drm_sched_rq_pop_entity().

sched_entity also utilizes the lockless spsc_queue (partially already
used simultaneously with locks), which was marked for removal in

commit 6e7eb171ac96 ("Documentation: drm: Add entry for removing spsc_queue to TODO list")

To remove the lock-cycle mentioned above, the unlock must be moved
downwards, also locking the lockless queue.

Guard spsc_queue_pop() in drm_sched_entity_pop_job() with the lock and
document why that is being done.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 91aec20611ad..5cf0af91faf2 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -529,9 +529,17 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	spin_lock(&entity->lock);
 	prev_last_scheduled = entity->last_scheduled;
 	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
-	spin_unlock(&entity->lock);
 
+	/* Preceding cleanup work made it necessary to add the spinlock
+	 * to this function. spsc_queue, a lockless queue, is now
+	 * counterintuitively guarded by the lock as well. spsc_queue is queued
+	 * for removal (see DRM TODO list), so this somewhat serves as a
+	 * preparational step.
+	 *
+	 * TODO: Replace spsc_queue completely with a locked (h)list.
+	 */
 	spsc_queue_pop(&entity->job_queue);
+	spin_unlock(&entity->lock);
 
 	dma_fence_put(prev_last_scheduled);
 	drm_sched_rq_pop_entity(entity);
-- 
2.54.0

