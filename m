Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F751C79FB9
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0A810EF4C;
	Wed,  9 Sep 2026 06:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ix9DK1bm";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3ED10E183
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 00:51:18 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d9201076b3so57986545ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 17:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788915078; x=1789519878; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=baACqoR6L3JYv00TizDf2hVxbGGX7jA9LTlR9p/Nxp0=;
 b=Ix9DK1bmgBQver3DNgtfB2FuDmNolEyR28C1cj1c6/fs0iggPaj4jlkrGuMkEU0/u7
 ihVRoPDLwfqH53kiAsumpNIIX4d/mKE7KXCGHHZ+rWMr/z81P5eHyNEu8l+1ssHWoCvG
 c6PYgmbINMNfoErIwHhxMEm13UiKhUW2ZAKa+klnjAmq3VJNBLVqGjr/7AeDJ+B0bN3W
 1U+upfAT0Qa1OBaluuhdtGaf9zLxO1HjRrQ7QhIKckJL4HtfAf3g4obEOcsTXPtM6b4O
 VeRsZSHhG/+VROnM4cnxoZ5gCxyZA972JRDajna589HAOjdk3hMiQiZvcbwtI4L9Ct7W
 kSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788915078; x=1789519878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=baACqoR6L3JYv00TizDf2hVxbGGX7jA9LTlR9p/Nxp0=;
 b=UH7y/Ge8bn6QjyVX+4OcKARHVgXk3bgRMvgukkJxloKk/5ecm4HwnSaPvCSbTyWa1h
 eHdJMWTrWjEzN6YkC+eM69x2DKPib4wWfmw6iUg2ww3zgwUJDe6dpSGB2R4bd6BnIBcX
 fJg98nTB/fE1badbYAIuqCd50UzNrlCDS+IMsd8SlkvQzfbx5Jq0UX4+IlEKRfr9LM4I
 l1kx5Ng+AGddVcU8hKyfk06qGmw65szDWQdNBCRYMDaz8+oiLpTF+SG338PLaktLerjY
 T48UcDcG6Y27BYSoxJcnjIJWEGuhuIhcTi+kPizTV5vx4Zf5HwHsAZia4zowCG79JLvm
 8z4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBynZtckbgWGO1NGQmksUSPfv4Jdzbi9XeGHH/k04YH1ePqwAbKBRZsQyvAywh5lzQMlMvIp73gq8hw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k9vlOn/tBEg9bi28YQb7fUFzufz0veZevYTM1rN89KiWlcCR6k
 FMAqmPdGoqPRDtyRdsoRmfyWY5e+OlVOwUsPuElbH0XQyw5oCw6t79k=
X-Gm-Gg: AYBFou1ePbCAphc8u7CISm+GBe+/JpGy+9VndIvqB/pxGeYf3H5CRAL7MdhHaKnzeQk
 Yv/2kgQnR/CMCbZa08PAgyCAh5jtnYVG6SJrsCOCWQs+1PECZ1DC5Lwduc/RDwdAIEaj2PZ5l3J
 dQNsmAjhLOr+0gYENfHy5K9c4RWdPg1mwUxRaclNAoi/Gp3VRZMebG32OkArfAljqhpEtV+rCqG
 1Qu/xWEzZ7NWXZ+owqP7bnevKeBGTsDC3srR5OkPc7VTSg2XPGEy3/ev0NZy4BsUDoxNjDPF2pr
 dBNQO8zWo80QCTi7s+8IWD1Nw5A6IhVGO49zQjY9UgLeFiAXWKTVq7/sG0eSFX1gQacK0h72st/
 s+bGad9WXKt7S1CYuAMqF3lKW74xpQBI0O8v4orbDGiJuJJrVJmKh1MFIZPoFKOxqRlqDm6ie7m
 pstke1wJidC8pS6SyvGaC64EwW0g/A0A5jbfF4uWYo/aiYriwp9gVRGY1GUaQW8BkEoSSu/Yxd9
 4Y55/+rMQcRUUN8
X-Received: by 2002:a17:902:d4ca:b0:2db:8019:847a with SMTP id
 d9443c01a7336-2db80198935mr80705225ad.9.1788915077702; 
 Tue, 08 Sep 2026 17:51:17 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1497e9e5sm63905685ad.38.2026.09.08.17.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 17:51:17 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 donggeunyoo.kernel@gmail.com
Subject: [PATCH] drm/sched: drop the unused entity argument from
 drm_sched_fence_alloc()
Date: Wed,  9 Sep 2026 09:51:12 +0900
Message-ID: <20260909005112.278538-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

drm_sched_fence_alloc() takes a struct drm_sched_entity *entity but
never uses it. Its only use, fence->sched = entity->rq->sched, moved
into drm_sched_fence_init() by commit dbe48d030b28 ("drm/sched: Split
drm_sched_job_init"), which separated fence allocation in
drm_sched_job_init() from arming in drm_sched_job_arm(). The deref
belongs at arm: drm_sched_job_arm() selects the run-queue via
drm_sched_entity_select_rq(), so for an entity with more than one
scheduler, entity->rq need not yet point at the scheduler the job lands
on. Reading it at allocation time could bind the fence to the wrong
scheduler.

Drop the argument. The sole caller still passes the entity to
drm_sched_fence_init() at arm time, so behavior is unchanged. This also
removes the parameter-name mismatch between the declaration (s_entity)
and the definition (entity).

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
Targets drm-misc-next. No functional change; compile-tested with W=1.
---
 drivers/gpu/drm/scheduler/sched_fence.c    | 3 +--
 drivers/gpu/drm/scheduler/sched_internal.h | 3 +--
 drivers/gpu/drm/scheduler/sched_main.c     | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 096fe28aa9c9..b7a4cb921234 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -205,8 +205,7 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f)
 }
 EXPORT_SYMBOL(to_drm_sched_fence);
 
-struct drm_sched_fence *drm_sched_fence_alloc(struct drm_sched_entity *entity,
-					      void *owner,
+struct drm_sched_fence *drm_sched_fence_alloc(void *owner,
 					      u64 drm_client_id)
 {
 	struct drm_sched_fence *fence = NULL;
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index a901801fce85..32d3ddb820be 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -58,8 +58,7 @@ drm_sched_rq_select_entity(struct drm_gpu_scheduler *sched,
 void drm_sched_entity_select_rq(struct drm_sched_entity *entity);
 struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity);
 
-struct drm_sched_fence *drm_sched_fence_alloc(struct drm_sched_entity *s_entity,
-					      void *owner, u64 drm_client_id);
+struct drm_sched_fence *drm_sched_fence_alloc(void *owner, u64 drm_client_id);
 void drm_sched_fence_init(struct drm_sched_fence *fence,
 			  struct drm_sched_entity *entity);
 void drm_sched_fence_free(struct drm_sched_fence *fence);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 6cb6f9546493..e4835b99ca60 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -612,7 +612,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 
 	job->entity = entity;
 	job->credits = credits;
-	job->s_fence = drm_sched_fence_alloc(entity, owner, drm_client_id);
+	job->s_fence = drm_sched_fence_alloc(owner, drm_client_id);
 	if (!job->s_fence)
 		return -ENOMEM;
 
-- 
2.53.0

