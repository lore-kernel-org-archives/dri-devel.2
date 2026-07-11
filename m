Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBF7C44514
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B3810F9EA;
	Sat, 11 Jul 2026 02:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YTejMl1C";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D5010E701;
 Sat, 11 Jul 2026 02:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738593; x=1815274593;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=edwgj3Vi6WamRFMDYophPmVDcMuGxbGZxiBdM3N7/5M=;
 b=YTejMl1CTPCTJEQ+a+bo2MCzTiotV8CT1aIlgY2WZP/wOwm9gA0CM8L3
 WUpzBJnGQRokPkdBKLQ1fpirW5VdyRJqV7ZkGxB0LnrXgwTpwLu1wxC9y
 1yHgS4xdA9s9d4xOuTHONPEJvgwXdrrcr+WNWuQS2XjTlxP9ZRYjUp+vo
 Vqg1AxOKFbx1K+Sf6iVCDX7PGvnZPWLDO6hRCTLW6IGMq2REmQES2esXH
 +v67TqoSddBjhr4PTTopHyxssaVP+3m0BpaNezEwFoRUsAiMFYIq+UqwH
 ENxDBZdOw+ZDTicOUNkNU6RGTt5n/FW0kkQyV4INYr2nW4QCVz2pVIgW9 A==;
X-CSE-ConnectionGUID: vrwBvA7XRYytiG9sQ7QtJg==
X-CSE-MsgGUID: jOZ6xh1zR32ggb7dhVxLzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986355"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986355"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:33 -0700
X-CSE-ConnectionGUID: bXXYBvgeT5y5f5ULHkOYIg==
X-CSE-MsgGUID: Omud59+4SYCol8CRYMbwyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987783"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:32 -0700
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
Subject: [PATCH v3 26/33] drm/xe: Add tracepoint for xe_gem_create_ioctl
Date: Fri, 10 Jul 2026 19:56:12 -0700
Message-Id: <20260711025619.2540575-27-matthew.brost@intel.com>
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

Add a xe_gem_create_ioctl tracepoint to help profile GEM creation, in
particular the cost of populating a BO while holding the dma-resv lock
versus the total IOCTL cost. This is useful for evaluating the
out-of-lock preallocation path, which aims to shrink the time spent
under the lock.

The tracepoint records the BO size, the requested placement mask, the
CPU caching mode, the VM asid (0 when no VM is bound), the total time
spent in the IOCTL, and the time spent under the dma-resv lock (the
xe_validation_guard region where the lock is held).

The asid is captured at VM lookup time rather than at trace emission,
since the VM reference is dropped before the tracepoint fires.

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
 - Guard lock_ns against an unset lock_start and use div_u64() in the
   tracepoint (Sashiko)
---
 drivers/gpu/drm/xe/xe_bo.c       | 17 +++++++++++++++++
 drivers/gpu/drm/xe/xe_trace_bo.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index a646a72122d4..caf5aa0bab53 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -3953,6 +3953,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 	bool have_prealloc = false;
 	unsigned int bo_flags;
 	u32 handle;
+	ktime_t ioctl_start = ktime_get();
+	ktime_t lock_start = ktime_set(0, 0);
+	u64 lock_ns = 0;
+	u32 asid = 0;
 	int err;
 
 	if (XE_IOCTL_DBG(xe, args->pad[0] || args->pad[1] || args->pad[2]) ||
@@ -4031,6 +4035,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 		vm = xe_vm_lookup(xef, args->vm_id);
 		if (XE_IOCTL_DBG(xe, !vm))
 			return -ENOENT;
+		asid = vm->usm.asid;
 	}
 
 	/*
@@ -4100,6 +4105,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 			if (err)
 				break;
 		}
+
+		if (lock_start == ktime_set(0, 0))
+			lock_start = ktime_get();
+
 		bo = xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
 				       bo_flags, have_prealloc ? &prealloc : NULL,
 				       &exec);
@@ -4110,6 +4119,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 			break;
 		}
 	}
+	if (lock_start != ktime_set(0, 0))
+		lock_ns = ktime_to_ns(ktime_sub(ktime_get(), lock_start));
 	if (have_prealloc)
 		ttm_pool_prealloc_fini(&xe->ttm.pool, &prealloc);
 	if (err)
@@ -4140,6 +4151,12 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (vm)
 		xe_vm_put(vm);
 
+	trace_xe_gem_create_ioctl(xe, args->size, args->placement,
+				  args->cpu_caching, asid,
+				  div_u64(ktime_to_ns(ktime_sub(ktime_get(),
+							ioctl_start)), 1000),
+				  div_u64(lock_ns, 1000));
+
 	return err;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
index b159d37d39a1..63db37edadc2 100644
--- a/drivers/gpu/drm/xe/xe_trace_bo.h
+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
@@ -144,6 +144,37 @@ TRACE_EVENT(xe_bo_defrag_one,
 		      __entry->ret)
 );
 
+TRACE_EVENT(xe_gem_create_ioctl,
+	    TP_PROTO(struct xe_device *xe, u64 size, u32 placement,
+		     u16 caching, u32 asid, u64 ioctl_us, u64 lock_us),
+	    TP_ARGS(xe, size, placement, caching, asid, ioctl_us, lock_us),
+
+	    TP_STRUCT__entry(
+		     __string(dev, dev_name(xe->drm.dev))
+		     __field(u64, size)
+		     __field(u32, placement)
+		     __field(u16, caching)
+		     __field(u32, asid)
+		     __field(u64, ioctl_us)
+		     __field(u64, lock_us)
+		     ),
+
+	    TP_fast_assign(
+		   __assign_str(dev);
+		   __entry->size = size;
+		   __entry->placement = placement;
+		   __entry->caching = caching;
+		   __entry->asid = asid;
+		   __entry->ioctl_us = ioctl_us;
+		   __entry->lock_us = lock_us;
+		   ),
+
+	    TP_printk("dev=%s, size=%llu, placement=0x%x, caching=%u, asid=%u, ioctl_us=%llu, lock_us=%llu",
+		      __get_str(dev), __entry->size, __entry->placement,
+		      __entry->caching, __entry->asid, __entry->ioctl_us,
+		      __entry->lock_us)
+);
+
 DECLARE_EVENT_CLASS(xe_vma,
 		    TP_PROTO(struct xe_vma *vma),
 		    TP_ARGS(vma),
-- 
2.34.1

