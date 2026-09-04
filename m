Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA42EC79F94
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E73C10E624;
	Sat,  5 Sep 2026 15:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VtU7a0ok";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3844410E54F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:06:29 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3969e82ff8fso817556a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788509189; x=1789113989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLEldnOCQedCUETCWprtecBudZpW3CKJjf9frld/ASI=;
 b=VtU7a0okCvHt3VtMIPTqmafaECscuyKOF7I52Vfk6m7QD5HWZrC7ktt4KLhlenrtma
 6rO6g4aLGnZSYiyEAVJn1b0Ez9MXBP1hWZ5Yv3midon9xzZqm/bYjsCYsQjPgFk+C+tl
 dgb5kUlQxqI3efhKk4o2lO21HGQHfpERTRZfpGxk2DiWjFrq4IFb6TWT2NOqa82BXTby
 5LpBxuU9dRHbqeT1OdBLqCOCL3gDzlibvA4V+j7G77fnrcNA58Igpm3ThU/LcZz7bWqS
 GaLFjZiNc/1fOsnksf3HcGUG24Kp+bUnir5oabgJ+y51TBc+twO1FEt8kXKRnQpmUyFr
 bQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788509189; x=1789113989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OLEldnOCQedCUETCWprtecBudZpW3CKJjf9frld/ASI=;
 b=HKegS6K9Qa0gsTvRtRhfEohipO2fL5BcmYbJ98rb5D4evjTBhdmGAjuyVxCbMQiBLB
 2KidWebankdikhQRG1ZtJADlZNnNGELZHLjXbXI+ffR8PdPHlnnelLq2/tNZ7R57mWOK
 OStMQVtsyVEvfvu+eg05f4ZOT32WW6sfB5FkVckpfIOJCblr58o794AqLvm4NKJoNEWe
 CcfzkflxXjtVeAFqFM2IDfje24xvZqNge3xUetdhyYu07UwDogJjDpNu2pThFxG8jg/5
 TQfqZvPbBVHbr9drAj+KsXLq5Zpzg140VnZ4Hos6j1x1b28xUxRXtOYglcf53c747SQL
 xz0Q==
X-Gm-Message-State: AFuF++moEpNnzr46g1bve3keHguC1EPIJ8/B5KeG1EMmOVdWgnRbj1Rk
 GHpMZJKnSSzxALuUJjVOaHZbwBbxaauTgkI2K//0BK/rtWBNzYwHM68=
X-Gm-Gg: AYBFou2volK3qdBB0yFZypIdC4iSRfxZzfR1WQA6yfVZon1MGivV5S6DmW384apQlsI
 fgQrswnS+JhtXzX2ibtLGDouLTSS4huHNw4GozUiH9Di4M4wwN2w29qcd483xUvdN5qmSBCDZj3
 prMpZKa6ziiRi1q0EYkkp0WtCfKfFIprvsqRFzMtgV7y8PNEpskV5nOv2+ni8w6b2dZ25hGgvFA
 G/oELsRodok1E9b0o2nbsMVRvN13a6boUwC+jWKTt6lsdTHNSEyVPmaCj8Hol4NZdkmXvSUC/Ae
 7dptzCPGXCAIOKUdy86s4CrjnXUbblP082VKCFiVaB8n0dyiK1Bv/OcqJsXEoiehNA5jEe0zYZE
 UOkhYSqkqRa5yLgFzY0Phjtyrt/IFl7VCj8C2+/KPB60h9LP7wwOA8S1v7+5Dgt/C6Ioh7lkrFz
 +JgQyHtcV5dnp20a0vMBG5W5IWW3wLq7vZcfWGm6kHrTnjYH3YJfIpPmrV7Sr8+ZrM8980m02bI
 BJRXoquu8CWp5cFTSpnhVPIxyU=
X-Received: by 2002:a17:90a:ec8d:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-39b261002f5mr6201345a91.6.1788509187124; 
 Fri, 04 Sep 2026 01:06:27 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b261549f3sm3181153a91.16.2026.09.04.01.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:06:26 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Date: Fri,  4 Sep 2026 17:06:16 +0900
Message-ID: <20260904080618.2098450-2-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904080618.2098450-1-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

A driver that allocates a drm_gpu_scheduler at per-context/per-queue/per-VM
granularity and frees it on an unprivileged context/fd close, while
exporting the resulting finished fence to userspace (drm_syncobj /
sync_file / dma_resv), leaves fence->sched dangling after the free. A
subsequent SYNC_IOC_FILE_INFO ioctl (which calls get_timeline_name()) then
reads the freed scheduler:

  BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name

This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
(drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
(VM_BIND) are still affected in mainline, so fix it in the core to cover
any per-context-scheduler driver at once.

Cache the scheduler's name pointer in the fence at init time, while the
scheduler is guaranteed alive, and return the cached value from
get_timeline_name() without dereferencing fence->sched. The timeline name
is not guaranteed by the contract to outlive the scheduler, so document in
struct drm_sched_init_args that the @name passed to drm_sched_init() must
follow the dma-fence safe access rules and outlive any exported fence.
Every in-tree driver passes a string literal, which satisfies this;
commit 299bc6d50b1b ("drm/xe/guc: Keep scheduler timeline name alive")
keeps drm/xe's dynamically-allocated name alive across the RCU grace and
can be simplified on top of this.

Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document the rules")
Cc: stable@vger.kernel.org # we don't know since when
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 24 +++++++++++++++++++++++-
 include/drm/gpu_scheduler.h             | 18 +++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 096fe28aa9c9..b2a842a1c9ba 100644
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
@@ -180,6 +186,14 @@ static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
 		dma_fence_set_deadline(parent, deadline);
 }
 
+/*
+ * TODO: Both fences implement .release, so dma_fence keeps their ops attached
+ * after signalling. Dropping the callbacks would let dma_fence detach the ops,
+ * after which neither get_timeline_name() nor get_driver_name() can run against
+ * a freed scheduler or an unloaded module - the complete fix. It first requires
+ * auditing every to_drm_sched_fence() caller, since ops-detach makes the helper
+ * return NULL for a signalled fence. See Documentation/gpu/todo.rst.
+ */
 static const struct dma_fence_ops drm_sched_fence_ops_scheduled = {
 	.get_driver_name = drm_sched_fence_get_driver_name,
 	.get_timeline_name = drm_sched_fence_get_timeline_name,
@@ -228,6 +242,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 	unsigned seq;
 
 	fence->sched = entity->rq->sched;
+	/*
+	 * Cache the scheduler's timeline name. The finished fence may be
+	 * exported to userspace and outlive @sched (per-context schedulers are
+	 * freed on context teardown), so get_timeline_name() must not
+	 * dereference @sched. The name is required to outlive any exported
+	 * fence (see @name in struct drm_sched_init_args).
+	 */
+	fence->sched_name = fence->sched->name;
 	seq = atomic_inc_return(&entity->fence_seq);
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
 		       &fence->lock, entity->fence_context, seq);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 7a64cc11de08..412b8c4643f1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -322,6 +322,17 @@ struct drm_sched_fence {
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
@@ -646,7 +657,12 @@ struct drm_gpu_scheduler {
  * @timeout: timeout value in jiffies for submitted jobs.
  * @timeout_wq: workqueue to use for timeout work. If NULL, the system_wq is used.
  * @score: score atomic shared with other schedulers. May be NULL.
- * @name: name (typically the driver's name). Used for debugging
+ * @name: name (typically the driver's name). Used for debugging, and as the
+ *	dma-fence timeline name of the scheduler's fences. It must follow the
+ *	dma-fence safe access rules: a &drm_sched_fence.finished exported to
+ *	userspace can outlive the scheduler, so @name has to outlive any such
+ *	fence - use a string literal, or free it only after an RCU grace period
+ *	past the last exported fence. See drm_sched_fence_get_timeline_name().
  * @dev: associated device. Used for debugging
  */
 struct drm_sched_init_args {
-- 
2.43.0

