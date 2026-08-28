Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C071C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BE510E686;
	Mon, 31 Aug 2026 07:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gv+Z4bqG";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C0B10E4F6
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:58:08 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d71ae3455aso15484735ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787929087; x=1788533887; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V+G8BuKyr4mNyS/k4RzS4KN1oeGSViDq6yduxoa5BN8=;
 b=Gv+Z4bqG8cUGbqbhP5kiHn7TKUU/1d7/QwCMn3p4gS78sIp+xEddiLUi3SAbDoM8vm
 xs6toNB63zo5Q+QDizL+ugiWlm7bZr2PK5Uky+5zmgMp6c/ODADNz0BKO+dlYUn9KKRS
 KFdOR/D4yDQORSKIBG1qS1SRUPGQe+6iSSnNnhIarBTIb4KAgkoW3JymLj0FzIk6C+pD
 fV/KABGeWMvlpPC4BOO+3O0qfeR/MlP3jzQxUPyoWT+Frji7ihmfmg+NPWtHBJhZBpTo
 Qev3BgzMUgKrhtwjtl54EsGsyyZB2FjY+TfYve69+5uzI4cuPBVRW4zTdUtH4NbonH+y
 HTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787929087; x=1788533887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V+G8BuKyr4mNyS/k4RzS4KN1oeGSViDq6yduxoa5BN8=;
 b=iFqp746UwwdrC24AHU5jBgR+JhL2wzmDp5ajgkkJdwpSoYYqe3DiTeVDaNfbknCOyh
 Rz03bORW9IVVhTDmR/jVIhWkETJVaL9exO1oZb0gKHWw3wOQOneDlspDtfq4A2Lx6Xd6
 3ALZZXoHS8KypuPRgdDyUdfN6EnDmgcGqoRxIePx8jZPGwrn/EVbuCjyS+lyU00QeMZC
 8KGCz5chsFUylg/wVXSMk+0QeOeUqoRUyTG5cVV92nXU7bbs60YCmmVa503RoE9VJupN
 qmfZIR+uDprbgT+DPH/K6Y/+Vi7hfVTA4jVPvDKkKa9nTuC9pil8bVT0285dg4Ok8yuq
 OvMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqa0v/JykLBPbHQZSnvAeZVJFFzBRN7XkWGsrrhzTjyBFAMW+LKuD+zfpumnN5/baPhaZ/AoEaSFEo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m4FsfYZfE8Rh+sKLICB8cpVEDiX9FB57z+tDw7Szncn5+9dnRL
 SGpqxp9RB+bz2WyqdBIQVsfIqYkV6O5VRxoQi32HfR0hoz80o4Vl+TU=
X-Gm-Gg: AR+sD13RAIopdxzgNFXzfSGDxol6PincpnnA/IKAnUv40DS0jX8a+AOiJ+9NAUHjX1T
 1dc8xeEKEDatlDUJJTfYUrtkkhdXQ/d2BukGPkf61hOMhsyfdsvKyd/+e30w9/5apjppb4+DcvH
 r2dIuvA9JwaOh8ad2NA2CPp5aBxDMPTE4cBuXGRqBjIHCkRBNxIN1jgwbCwNH3TuzPq+l39jaPe
 2amSGyLC42WhsiPWRVPQfY/o/ciopcG16YpmA2L/GLTTWs6iZNuXJrVKWatIZtq+AM4vCreI0k0
 DE8jTd517CbU1fp4jJOQVBoyPSfvuzrUJzHfWF5VGhxda8pRaJkL3ZiJmVzncM2br9LnJXSE7aZ
 3FCKe15VrKGMUWW6G8gQ9JDJsQTbYG4McV5GbmQ/1+mQ/NkOvhRjUq/0ADQGW9h/Atz3pel9IQO
 iv7R41TUaYevtM4HLGPiN2MRXtm1xSCGklzOqsTqv49dRHLaWlBbrmnhH/PRYtL9qwnsAe2kZL1
 vzZSJaObjmPjxeeM8qNAyJGZtkZN3Pd+4DEEQ==
X-Received: by 2002:a17:903:3d06:b0:2d8:d4cc:5baf with SMTP id
 d9443c01a7336-2d8d4cc5dcemr8450155ad.15.1787929087521; 
 Fri, 28 Aug 2026 07:58:07 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d75988b6fcsm6159625ad.56.2026.08.28.07.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:58:06 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v1 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
Date: Fri, 28 Aug 2026 23:57:56 +0900
Message-ID: <b191f55e53492f95d965407f891fd93b0e74958d.1787928528.git.malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787928528.git.malhyuk97@gmail.com>
References: <cover.1787928528.git.malhyuk97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
drm_sched_fence ops keep a .release callback, so the fence is not
ops-detached on signalling (dma_fence_signal_timestamp_locked() only
clears ->ops for fences without .release/.wait). The callback therefore
stays reachable on a long-signalled, userspace-held finished fence and
unconditionally dereferences fence->sched.

A driver that allocates a drm_gpu_scheduler at per-context/per-queue/
per-VM granularity and frees it on an unprivileged context/fd close, while
exporting the resulting finished fence to userspace (drm_syncobj /
sync_file / dma_resv), leaves fence->sched dangling after the free. A
subsequent SYNC_IOC_FILE_INFO ioctl (which calls get_timeline_name())
then reads the freed scheduler:

  BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name

This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
(drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
(VM_BIND) are still affected in mainline, so fix it in the core to cover
any per-context-scheduler driver at once.

Scheduler names are persistent strings (string literals passed to
drm_sched_init()), so cache the name pointer in the fence at init time,
while the scheduler is guaranteed alive, and return the cached value from
get_timeline_name() without dereferencing fence->sched.

Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 16 +++++++++++++++-
 include/drm/gpu_scheduler.h             | 11 +++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 85ee3d694dc9..280a2d036ffd 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -92,7 +92,13 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
 static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
-	return (const char *)fence->sched->name;
+
+	/*
+	 * Do not dereference fence->sched here: a userspace-held finished
+	 * fence can outlive a per-context scheduler. Return the name cached
+	 * in drm_sched_fence_init() instead.
+	 */
+	return fence->sched_name;
 }
 
 static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
@@ -228,6 +234,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 	unsigned seq;
 
 	fence->sched = container_of(entity->rq, typeof(*fence->sched), rq);
+	/*
+	 * Cache the scheduler's timeline name: the finished fence may be
+	 * exported to userspace and outlive @sched (per-context schedulers
+	 * are freed on context teardown), so get_timeline_name() must not
+	 * dereference @sched. Scheduler names are persistent (string
+	 * literals passed to drm_sched_init()).
+	 */
+	fence->sched_name = fence->sched->name;
 	seq = atomic_inc_return(&entity->fence_seq);
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
 		       &fence->lock, entity->fence_context, seq);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d61c19e78182..4f780d70acb6 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -305,6 +305,17 @@ struct drm_sched_fence {
          * belongs to.
          */
 	struct drm_gpu_scheduler	*sched;
+	/**
+	 * @sched_name: the timeline name of @sched, cached at init time.
+	 *
+	 * &drm_sched_fence.finished may be exported to userspace (via a
+	 * sync_file or drm_syncobj) and can outlive @sched: a driver using a
+	 * per-context scheduler frees it on context teardown while a
+	 * userspace-held finished fence still references it. The
+	 * get_timeline_name() callback must therefore not dereference @sched;
+	 * it returns this cached name instead.
+	 */
+	const char			*sched_name;
         /**
          * @lock: the lock used by the scheduled and the finished fences.
          */
-- 
2.43.0

