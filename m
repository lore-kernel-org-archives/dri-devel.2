Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA74CC88E40
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 05:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C909210E1D4;
	Thu, 10 Sep 2026 05:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lEl8aA3K";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC7510E1D4
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:45:45 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d944747d41so75288865ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 22:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789019145; x=1789623945; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TorC7V36k30jSb5TWYgDiKQ9Uk9U0ujF5LpdwA3W0Vc=;
 b=lEl8aA3Kw4C+cdeqN+PFqt3KtGi2GILAKyEky1Y+KjpMNLsN3puFStyHB4lrt0yC76
 KhMkNmwiCeKaA8gGo2PW10IH/PX37ETmXqOs4gccWr9Tb2//hXznUq1iFcadtV7+UQBO
 E0sI9JqLUWlR0z3kQur19W2VtOqqFVEwStyUL7F8vFeTaF/ugn7AxsXj+ugFamOP2WKP
 jnSkDXiyUtdyTOkxJ2SV6R6f9bq53gjU44HtAh98Uc/QeUiAeLnKSOhSE4mL94NFluG0
 8GT12mtzK/lR9HPWCpvsR8M6VrpXwerR7QwQSuH5ptz9v9rYBfmmk30GxXZ9e5moGy3g
 ZN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789019145; x=1789623945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TorC7V36k30jSb5TWYgDiKQ9Uk9U0ujF5LpdwA3W0Vc=;
 b=kflLCwpKKgAKdr5HHLa2UYHy6WH8VfMVjeFnaSy9B8+jwwszj22G2BEWd4kVkFEVvD
 EHjFX9gLYOHfQRHMJcp1uQhIOE7XJfZ6nGfTD+UurkhVYAPaz38DoB/kDUloGmk2kCGs
 tBAswUHWg2kPugVZaSb9/HucsdATw/SiIb/8BqKaIowVqg41AFFh/njUXO2LNi8hLz3I
 hZjvPeD0EMuMiXWoAwTrd0eTiU7xkkfq/aZAPkKe8Czz8SnRpcAbm4G5a8362nTNrOhJ
 htv2GhzwAvaY2nKdtRkelKuQ4OTDCupQisaAkrhy7Fo5zGo7Ly7/r1oVW+I/3ptyOCWh
 IHJw==
X-Forwarded-Encrypted: i=1;
 AKwUvByoecmQ9mHAqQuvYfucy2tROOrZFNNYFJmkvRQhwQRtFtcQR+ri5/3xvxJxekTtTidKCHLQ2MznzPs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mnC/hM5KrK8aUQfSoFK1KxbWd2nH1mjhnIgbC7rRDOBepXXRw+
 wBaZbJiZyv9pMqG6xlufukZNKZB6ucsl+NoEBKZCraRvUXcdj2HfOEM=
X-Gm-Gg: AYBFou1lvhMJZIfVli+t5cM65Rpe+uktbKrWxlBfVB3u7pjbndClFU1LDP2PYJzxY09
 UKyQM7fS1ZPJMxsMDrK6khzLzNBFbiAeZYMJW7sEpjnnQD0Zr6LpsB5A2/ZHCWaG2pwEK85DvvK
 6wqzJb/x4bOQAVa3WPIZzPMRaHfYaSgrC1jMXtkNMTDsLUhY2V7hgmmKO5SXb5ExJMWMTiLBn3K
 drdUeDpCctBHYTr0KijeRDzuBWDCUj/cuXff2y0tz6wWLpXZ0Nz412ihsLar8nAEh6oz7BBHeeZ
 q4oQj7eEbaXNGcRGRNhFfNDlHxnbDvVKZPZuw+4vg2jb5GzTCykZKJqslp/59P2YZDL7WoSUND8
 aMjGZ2hmQSTGeoTEVHXqi0sV0useJcYtwZ8ZmuDoD0tcmreavVCT642KEu79jWQz/uXOMZAfl0s
 rKfQQvqS/Vuovp99h0ruBb3B8hlf8aCxfw2cZZf265VFvEdm5LdULC2IT33ZYSM6dM2gGNn10Dk
 EkF6GLPIbdu1ziZGe+Wm1L3msbKJQWdogkL
X-Received: by 2002:a17:90b:2781:b0:398:9c00:29ee with SMTP id
 98e67ed59e1d1-39b26289136mr62814945a91.22.1789019145273; 
 Wed, 09 Sep 2026 22:45:45 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7740383asm3531936a91.7.2026.09.09.22.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:45:44 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 donggeunyoo.kernel@gmail.com
Subject: [PATCH v2] drm/sched: Drop the unused entity argument from
 drm_sched_fence_alloc()
Date: Thu, 10 Sep 2026 14:45:37 +0900
Message-ID: <20260910054537.633952-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Resent: the original reached lkml but not dri-devel/amd-gfx - I was not
subscribed at the time. Apologies to those seeing it twice.

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

