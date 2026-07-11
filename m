Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A68C4450C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F31910F9BE;
	Sat, 11 Jul 2026 02:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NzBxxq3F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F2710E6FE;
 Sat, 11 Jul 2026 02:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738592; x=1815274592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J1YcdAqKuIyiuZspeqa7qmtktzppXeERlakUfbNUKXM=;
 b=NzBxxq3F+gcRKF47eEQiuUc1ZJzGoIoFmlhIKgtejT6aUN1r0XwFZ13P
 cgNMtQbWzzd2MAGUlUvHH0yUyUDNii2lLX9FVUoUdR0CxW33Z/DXxXMPs
 dGHvyyhdOuaxGbEYc2vX8qNh34F151QmAFM/F1/+qo8XmwA42V1R44YQx
 DY7JWFdI+P4KI/kpjRcOVDpCFI7uqTbTOswalCa0By/GA4F8JLrVMiaSj
 y5tIXXBc8w8iDKf1hr2bU22EI1HtoH1gLkPi03KBI3C6jV6PNlha3L9Jv
 f9jB/dicudzDnvAFUutDwuZtH1qc6RZ0unfa1QMr9PK3zus+ZBdMphLei Q==;
X-CSE-ConnectionGUID: s1bZKW3EQ5e/Jv8FchTd1Q==
X-CSE-MsgGUID: 7zMCsudkS3C2ut2DXSe/eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986339"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986339"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:32 -0700
X-CSE-ConnectionGUID: gN9+bWohTD27RwrHoJ61QQ==
X-CSE-MsgGUID: R7lxnx79R5iLY0OPROz9aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987776"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 24/33] drm/xe: Add defrag profiling tracepoints
Date: Fri, 10 Jul 2026 19:56:10 -0700
Message-Id: <20260711025619.2540575-25-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add two tracepoints to profile the page defragmentation worker:

 - xe_bo_defrag_worker: emitted on worker entry and exit with the
   current defrag list count and the bytes processed in the run.
 - xe_bo_defrag_one: emitted per BO with the run budget, the prealloc
   fill ratio (got/want) and the lock-held, lock-wait and prealloc
   durations, plus the bytes consumed and the result.

These break down the cost of a defrag attempt into its locked vs
unlocked phases, making it possible to confirm that the expensive
beneficial-order allocation and cpu cache mode change happen outside
the BO dma-resv lock and that the residual lock-held time is copy-bound
(with the tail dominated by lock-wait behind active rendering).

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

v3:
 - Move the ns-to-us division into TP_fast_assign() to avoid a 64-bit
   divide in TP_printk() (Sashiko)
---
 drivers/gpu/drm/xe/xe_bo.c       | 18 +++++++++-
 drivers/gpu/drm/xe/xe_trace_bo.h | 59 ++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 8b89d34f37d4..25e5b72f870c 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1263,7 +1263,9 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
 	struct ttm_placement placement;
 	struct ttm_place place;
 	enum ttm_caching tt_caching;
-	unsigned int order, want = 0;
+	unsigned int order, want = 0, got = 0;
+	u64 lock_ns = 0, prealloc_ns = 0, lockwait_ns = 0;
+	ktime_t t0;
 	int ret = 0;
 
 	*consumed = 0;
@@ -1294,6 +1296,7 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
 
 	/* Phase 2: preallocate outside the lock; */
 	if (want) {
+		t0 = ktime_get();
 		ret = ttm_pool_prealloc_fill(pool, tt_caching, &pp, want);
 		if (ret || !pp.count) {
 			ret = ret ?: -ENOMEM;
@@ -1301,12 +1304,16 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
 					 XE_GT_STATS_ID_DEFRAG_FAILED_COUNT, 1);
 			goto out_err;
 		}
+		prealloc_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
 	}
 
 	/*
 	 * Phase 3: re-take the lock, re-check, and validate using the prealloc.
 	 */
+	t0 = ktime_get();
 	xe_bo_lock(bo, false);
+	lockwait_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
+	t0 = ktime_get();
 
 	if (!xe_bo_needs_defrag(bo)) {
 		xe_bo_defrag_remove(bo);
@@ -1362,9 +1369,13 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
 
 unlock:
 	xe_bo_unlock(bo);
+	lock_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
+	got = pp.used;
 out_err:
 	ttm_pool_prealloc_fini(pool, &pp);
 out:
+	trace_xe_bo_defrag_one(bo, budget, want, got, lock_ns, prealloc_ns,
+			       lockwait_ns, *consumed, ret);
 	return ret;
 }
 
@@ -1396,6 +1407,9 @@ static void xe_bo_defrag_worker(struct work_struct *w)
 		return;
 	}
 
+	trace_xe_bo_defrag_worker(xe, 0, atomic_read(&xe->mem.defrag.count),
+				  true);
+
 	/*
 	 * Process at most XE_BO_DEFRAG_SIZE_LIMIT bytes of newly (re)allocated
 	 * backing per run rather than draining the whole list in one go. Only
@@ -1503,6 +1517,8 @@ static void xe_bo_defrag_worker(struct work_struct *w)
 
 	xe_pm_runtime_put(xe);
 	drm_dev_exit(idx);
+	trace_xe_bo_defrag_worker(xe, defrag_bytes,
+				  atomic_read(&xe->mem.defrag.count), false);
 }
 
 static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
index 86323cf3be2c..b159d37d39a1 100644
--- a/drivers/gpu/drm/xe/xe_trace_bo.h
+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
@@ -85,6 +85,65 @@ TRACE_EVENT(xe_bo_move,
 		      __get_str(new_placement_name), __get_str(device_id))
 );
 
+TRACE_EVENT(xe_bo_defrag_worker,
+	    TP_PROTO(struct xe_device *xe, u64 defrag_bytes, int count,
+		     bool enter),
+	    TP_ARGS(xe, defrag_bytes, count, enter),
+	    TP_STRUCT__entry(
+		     __string(dev, dev_name(xe->drm.dev))
+		     __field(u64, defrag_bytes)
+		     __field(int, count)
+		     __field(bool, enter)
+		     ),
+	    TP_fast_assign(
+		   __assign_str(dev);
+		   __entry->defrag_bytes = defrag_bytes;
+		   __entry->count = count;
+		   __entry->enter = enter;
+		   ),
+	    TP_printk("dev=%s %s defrag_bytes=%llu count=%d",
+		      __get_str(dev), __entry->enter ? "enter" : "exit",
+		      __entry->defrag_bytes, __entry->count)
+);
+
+TRACE_EVENT(xe_bo_defrag_one,
+	    TP_PROTO(struct xe_bo *bo, u64 budget, unsigned int prealloc_want,
+		     unsigned int prealloc_got, u64 lock_ns, u64 prealloc_ns,
+		     u64 lockwait_ns, u64 consumed, int ret),
+	    TP_ARGS(bo, budget, prealloc_want, prealloc_got, lock_ns,
+		    prealloc_ns, lockwait_ns, consumed, ret),
+	    TP_STRUCT__entry(
+		     __string(dev, __dev_name_bo(bo))
+		     __field(size_t, size)
+		     __field(u64, budget)
+		     __field(unsigned int, prealloc_want)
+		     __field(unsigned int, prealloc_got)
+		     __field(u64, lock_us)
+		     __field(u64, prealloc_us)
+		     __field(u64, lockwait_us)
+		     __field(u64, consumed)
+		     __field(int, ret)
+		     ),
+	    TP_fast_assign(
+		   __assign_str(dev);
+		   __entry->size = xe_bo_size(bo);
+		   __entry->budget = budget;
+		   __entry->prealloc_want = prealloc_want;
+		   __entry->prealloc_got = prealloc_got;
+		   __entry->lock_us = div_u64(lock_ns, 1000);
+		   __entry->prealloc_us = div_u64(prealloc_ns, 1000);
+		   __entry->lockwait_us = div_u64(lockwait_ns, 1000);
+		   __entry->consumed = consumed;
+		   __entry->ret = ret;
+		   ),
+	    TP_printk("dev=%s size=%zu budget=%llu prealloc=%u/%u lock_us=%llu lockwait_us=%llu prealloc_us=%llu consumed=%llu ret=%d",
+		      __get_str(dev), __entry->size, __entry->budget,
+		      __entry->prealloc_got, __entry->prealloc_want,
+		      __entry->lock_us, __entry->lockwait_us,
+		      __entry->prealloc_us, __entry->consumed,
+		      __entry->ret)
+);
+
 DECLARE_EVENT_CLASS(xe_vma,
 		    TP_PROTO(struct xe_vma *vma),
 		    TP_ARGS(vma),
-- 
2.34.1

