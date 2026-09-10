Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29817C88E47
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F52A10F41D;
	Thu, 10 Sep 2026 10:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="reJQyvQW";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE1510E220
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:05:59 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d6fe26ef1cso69300165ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789002359; x=1789607159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i3KZVybWmfPUW8DJx5y+rAR9UZPpXnS8RWCoLGg5ZjQ=;
 b=reJQyvQWGt8BnOs1Xu41Z+NeqkoEwSHnGAZe+ZQgz2JMRuOkM/lVrdOfbyHkr9/13n
 6rDPaO5fWebnUhR6SIX+CD3dVtoWfByTKYX10ncJyGtDSizYVH9UFfgElzFjh1NDmvkZ
 NR8zor0eKY+RYgQX2wTk3eO+8nC2P8zHdeqhk1XD0f5b4kpneVBkvvq4K+u5ljFGAPko
 p4oEfKReIDaD9qK+wHQVv2alPw/064PH7vvWWtu57QnUQecd2ewLXs0hJIOD05kRUPht
 1y0q9BFr80uBiDYdFzj/rRmn0NrYqc8aVaumT9fo6HxL2GJ/xcGbeabk2PNuwtcWC21S
 LKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789002359; x=1789607159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i3KZVybWmfPUW8DJx5y+rAR9UZPpXnS8RWCoLGg5ZjQ=;
 b=Sg6kkYD6ZFy5WRBXk7pH8+N9ks26le1hcqb3dY0ZonKJ9s/YoxPB1t2Rtxj8HgOTdt
 2owGmZXvEkrqaXV8Ak8VdE/IK/EfcQLgzJezt95WsPQ5+lIb/JNA+6u60GGXEOSvRqOE
 bpPn1fFkMpjO+NDZkd37hBe71EQ7qOL99btl7DO4ff7zZW7xm+PMNIalgO760sMemZqj
 pdEZGjjhwTTp2uTX1wifZYV3Ij1IV1EAHJqggeibFhPPtFWi0EmRBZ6h9PXkzZksQJjI
 A0hBioFqborFdlou33P5b4yyXo/Fmts93JV87Fd5obQ6XZGjTHlcTbPyTrpiQ/81qTU5
 1V6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPmLSnr9E3Cfdzsy6eNq/9CmU62s9uHHFsdQpp0Yna4jKXH1jo0QKnJbBCjoVeIPt+TnrLEACpkso=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k7hRy3BoCdiamhG31LmwlPX58Hl5M2q1ImZpzV5G2DHK2+qFJu
 jI2bJaUSlzPMU2H/MPhXDhou51p4Hr9abH20zPAAlOjS4Ds3KLUODVM=
X-Gm-Gg: AYBFou0EoR5zfkQGVxJ+8vuVGKx1ON63FqooETRRvN4M5U+qiZYp6IBVx+hbQ0cnvfN
 WmXQUz39eTriH7WcAdJa3CEtDHmu0nU/vh53yKl4pJbursAD5mov94+RXC4oG52zvbXSQpMqTQu
 ieRcYbNZQXqnnosFQAWdqMt/xUmJR0mf7/r3/iYp7WHYKucFTmel3/TlPE/pLe2Ex5krTjtk5//
 TIFY9LvQdFm9fSyVOgWPL+re9fbDorJlP502ZTSOrFhSXqcgo66pX3EVbjhimP915P0091AZpJj
 Qf5FpLr3XmHOx8w1Zh3xPzaffo/L3mCrjYykhuHqfiP4UQF6+xz2Ico0/gxBoq/0XAnh1kSFbTu
 qyHL0qxrqb4oOPy1b1zpViqx4+4onZHT4+mKlLMIIBqer2SF1xLmFHPYSU2ddEIlbR6B7ijAW3v
 LRgxDAp1A5H1eUcn8jXutI3Dr6ZpOMxLvBiw53XgSM3RnfhIpLjcvjt0U6gBt3D+vUApB4Wq2cs
 WPBYGDIiKFV1PPUtnWVKqAU1g==
X-Received: by 2002:a17:90b:35d2:b0:396:d28e:bd8 with SMTP id
 98e67ed59e1d1-39b260fe242mr59283556a91.3.1789002358576; 
 Wed, 09 Sep 2026 18:05:58 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d77608fb4sm2231505a91.15.2026.09.09.18.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 18:05:58 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 donggeunyoo.kernel@gmail.com
Subject: [PATCH v2] drm/sched: Drop the unused entity argument from
 drm_sched_fence_alloc()
Date: Thu, 10 Sep 2026 10:05:53 +0900
Message-ID: <20260910010553.531847-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

In commit dbe48d030b28 ("drm/sched: Split drm_sched_job_init") the only
use of the entity argument of drm_sched_fence_alloc(), fence->sched =
entity->rq->sched, moved into drm_sched_fence_init(), and the now unused
argument was left behind.

Drop the argument. The sole caller still passes the entity to
drm_sched_fence_init() at arm time, so behavior is unchanged. This also
removes the parameter-name mismatch between the declaration (s_entity)
and the definition (entity).

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
Targets drm-misc-next. No functional change; compile-tested with W=1.

v2: trim the first paragraph, which read as if the patch addressed a bug
    when it only removes an unused argument (Philipp Stanner). Capitalize
    the subject to match the subtree.
Link to v1: https://lore.kernel.org/dri-devel/20260909005112.278538-1-donggeunyoo.kernel@gmail.com/

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

