Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B21F43830
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE36C10E249;
	Wed, 15 Apr 2026 14:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XSpdZIxJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1026B10E249;
 Wed, 15 Apr 2026 14:50:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8627140852;
 Wed, 15 Apr 2026 14:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A756FC19424;
 Wed, 15 Apr 2026 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776264612;
 bh=bTj679hg+QgqNHfBXLngWCLfh/g/zoJF5btZjg6oR+E=;
 h=From:To:Cc:Subject:Date:From;
 b=XSpdZIxJDfqWq2HVGDNhVjue3SP7VIOr+CBuu6YdW+LAozl/CLXj+pcTTBoXh/gsG
 nuTQlnf08v+xdmKJrrlvxmo+dB3+9ewc1xpwThXIUHGppDkuXK/yFTt1S+bQHLduIb
 o+Tag1mnPSckwojhVE3CfrFciPLHoXD8Nk1+GEDAFZRbqqm11FmS/YpX4O/BYgIIVc
 Myy7y2NJk7f3pScmD1fY65j7AcqoqnLnuPErcM6fYgE+kC6h4GYJzrXs4mmACERPPI
 vM05JyYVhFYyhWy6Gsa25qyR4Gd50FfYTcQIGJHOKYwp/9CrPp2nRsozHoew/G1EED
 /8gE0SZ2xbv2A==
From: Philipp Stanner <phasta@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Dave Airlie <airlied@redhat.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/sched: Make drm_sched_entity_kill() a public
 function
Date: Wed, 15 Apr 2026 16:49:56 +0200
Message-ID: <20260415144956.272506-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
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

Some drivers do not care on teardown whether the last jobs pending in an
entity are actually executed before teardown completed. For such
scenarios, drm_sched_entity_flush() is not the ideal function since it's
intended to wait for jobs to complete.

Make drm_sched_entity_kill() public for that use-case and update the
documentation.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes in v2:
  - Improve wording, fix typo.
---
 drivers/gpu/drm/scheduler/sched_entity.c | 13 +++++++++++--
 include/drm/gpu_scheduler.h              |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 61a4818cc87b..7be5811b90cd 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -267,8 +267,16 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
 	schedule_work(&job->work);
 }
 
-/* Remove the entity from the scheduler and kill all pending jobs */
-static void drm_sched_entity_kill(struct drm_sched_entity *entity)
+/**
+ * drm_sched_entity_kill - kill an entity's pending jobs and remove it
+ * @entity: the entity to remove
+ *
+ * Removes the entity from the scheduler's run queue and kills all pending jobs.
+ *
+ * This function should be used over drm_sched_entity_flush() if it is not
+ * desired to actually wait for all pending jobs to finish.
+ */
+void drm_sched_entity_kill(struct drm_sched_entity *entity)
 {
 	struct drm_sched_job *job;
 	struct dma_fence *prev;
@@ -306,6 +314,7 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	}
 	dma_fence_put(prev);
 }
+EXPORT_SYMBOL(drm_sched_entity_kill);
 
 /**
  * drm_sched_entity_flush - Flush a context entity
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 53417baebd49..d61c19e78182 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -693,6 +693,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 			  unsigned int num_sched_list,
 			  atomic_t *guilty);
 long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout);
+void drm_sched_entity_kill(struct drm_sched_entity *entity);
 void drm_sched_entity_fini(struct drm_sched_entity *entity);
 void drm_sched_entity_destroy(struct drm_sched_entity *entity);
 void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
-- 
2.49.0

