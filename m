Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E735D58B22
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0249D10E2B9;
	Mon, 16 Mar 2026 04:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HgAYEgPS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4D410E2BF;
 Mon, 16 Mar 2026 04:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635583; x=1805171583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=arp0KQ6DWFPgRfNZUw8uS5djA/sGeAQ7ZCxISwGsszo=;
 b=HgAYEgPSAAxMahfO8V/paY1mTZ3FBqiXCrekasRKmOskiXLeUkxQtqxe
 Gi89Xy47GwPJDZ2ceNF0Zu6bKIBnNXHtsSLuwZN8PkXIxZh43FCl018nH
 3b4C/xzDXFNvNbkWvzJ+Kmb+LdD1sWu+yqZe93DeYGYiGg/TrDYxudfYy
 /bnQhYeXZ8p2rZl5vHbxv2eGEWHZFm7lnl+w/EJCUNS3ViXkBQu+hadk5
 WRX3fkIm8XUGK5gA0SwyplBG8NgWWzJ/WNTjavc4+1iFdufTo23jETY/r
 MDws89X6OZNRHwkH1ovyU0SD2hgaJwUR4huTYUrig4RpFZfcCymoXnSwK g==;
X-CSE-ConnectionGUID: 4dHy2ZjzQ46e/+lE4GmoGg==
X-CSE-MsgGUID: IcBUtAbLRoGzTpr6fFWFrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683478"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683478"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:02 -0700
X-CSE-ConnectionGUID: yaqybi/gTXCjWiAqD3TwNQ==
X-CSE-MsgGUID: 7equaTrbTb6ZVwOf0N4nvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022161"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/12] workqueue: Add interface to teach lockdep to warn
 on reclaim violations
Date: Sun, 15 Mar 2026 21:32:44 -0700
Message-Id: <20260316043255.226352-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316043255.226352-1-matthew.brost@intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
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

Drivers often use workqueues that run in reclaim paths (e.g., DRM
scheduler workqueues). It is useful to teach lockdep that memory
allocations which can recurse into reclaim (e.g., GFP_KERNEL) are not
allowed on these workqueues. Add an interface that taints a workqueue’s
lockdep state with reclaim.

Also add a helper to test whether a workqueue is reclaim annotated,
allowing drivers to enforce reclaim-safe behavior.

Example of lockdep splat upon violation below:

[   60.953095] =============================================

[   73.023656] Console: switching to colour dummy device 80x25
[   73.023684] [IGT] xe_exec_reset: executing
[   73.038237] [IGT] xe_exec_reset: starting subtest gt-reset
[   73.044163] xe 0000:03:00.0: [drm] Tile0: GT0: trying reset from force_reset_write [xe]
[   73.044276] xe 0000:03:00.0: [drm] Tile0: GT0: reset queued

[   73.045963] ======================================================
[   73.052133] WARNING: possible circular locking dependency detected
[   73.058302] 7.0.0-rc3-xe+ #31 Tainted: G     U
[   73.063866] ------------------------------------------------------
[   73.070036] kworker/u64:5/158 is trying to acquire lock:
[   73.075342] ffffffff829a87a0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x39/0x420
[   73.083791]
               but task is already holding lock:
[   73.089612] ffffc9000152fe60 ((work_completion)(&gt->reset.worker)){+.+.}-{0:0}, at: process_one_work+0x1d2/0x6a0
[   73.099852]
               which lock already depends on the new lock.

[   73.108013]
               the existing dependency chain (in reverse order) is:
[   73.115481]
               -> #2 ((work_completion)(&gt->reset.worker)){+.+.}-{0:0}:
[   73.123381]        process_one_work+0x1ec/0x6a0
[   73.127906]        worker_thread+0x183/0x330
[   73.132173]        kthread+0xe2/0x120
[   73.135833]        ret_from_fork+0x289/0x2f0
[   73.140101]        ret_from_fork_asm+0x1a/0x30
[   73.144540]
               -> #1 ((wq_completion)gt-ordered-wq){+.+.}-{0:0}:
[   73.151749]        workqueue_warn_on_reclaim.part.0+0x32/0x50
[   73.157487]        alloc_workqueue_noprof+0xef/0x100
[   73.162445]        xe_gt_alloc+0x92/0x220 [xe]
[   73.166954]        xe_pci_probe+0x734/0x1660 [xe]
[   73.171720]        pci_device_probe+0x98/0x140
[   73.176161]        really_probe+0xcf/0x2c0
[   73.180256]        __driver_probe_device+0x6e/0x120
[   73.185126]        driver_probe_device+0x19/0x90
[   73.189740]        __driver_attach+0x89/0x140
[   73.194091]        bus_for_each_dev+0x79/0xd0
[   73.198446]        bus_add_driver+0xe6/0x210
[   73.202712]        driver_register+0x5b/0x110
[   73.207064]        0xffffffffa00aa0db
[   73.210724]        do_one_initcall+0x59/0x2e0
[   73.215077]        do_init_module+0x5f/0x230
[   73.219345]        init_module_from_file+0xc7/0xe0
[   73.224128]        idempotent_init_module+0x176/0x270
[   73.229175]        __x64_sys_finit_module+0x61/0xb0
[   73.234047]        do_syscall_64+0x9b/0x540
[   73.238228]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   73.243793]
               -> #0 (fs_reclaim){+.+.}-{0:0}:
[   73.249442]        __lock_acquire+0x1496/0x2510
[   73.253970]        lock_acquire+0xbd/0x2f0
[   73.258062]        fs_reclaim_acquire+0x98/0xd0
[   73.262586]        __kmalloc_cache_noprof+0x39/0x420
[   73.267545]        gt_reset_worker+0x27/0x1f0 [xe]
[   73.272385]        process_one_work+0x213/0x6a0
[   73.276910]        worker_thread+0x183/0x330
[   73.281178]        kthread+0xe2/0x120
[   73.284838]        ret_from_fork+0x289/0x2f0
[   73.289104]        ret_from_fork_asm+0x1a/0x30
[   73.293542]
               other info that might help us debug this:

[   73.301528] Chain exists of:
                 fs_reclaim --> (wq_completion)gt-ordered-wq --> (work_completion)(&gt->reset.worker)

[   73.314795]  Possible unsafe locking scenario:

[   73.320705]        CPU0                    CPU1
[   73.325232]        ----                    ----
[   73.329759]   lock((work_completion)(&gt->reset.worker));
[   73.335148]                                lock((wq_completion)gt-ordered-wq);
[   73.342359]                                lock((work_completion)(&gt->reset.worker));
[   73.350259]   lock(fs_reclaim);
[   73.353400]
                *** DEADLOCK ***

v2:
 - Add WQ flag to warn on reclaim violations (Tejun)
 - Add a helper function to test if WQ is annotated

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 include/linux/workqueue.h |  3 +++
 kernel/workqueue.c        | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a4749f56398f..5ad3b92ddd75 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -403,6 +403,7 @@ enum wq_flags {
 	 */
 	WQ_POWER_EFFICIENT	= 1 << 7,
 	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
+	WQ_MEM_WARN_ON_RECLAIM	= 1 << 9, /* teach lockdep to warn on reclaim */
 
 	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
@@ -582,6 +583,8 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
+extern bool workqueue_is_reclaim_annotated(struct workqueue_struct *wq);
+
 struct workqueue_attrs *alloc_workqueue_attrs_noprof(void);
 #define alloc_workqueue_attrs(...)	alloc_hooks(alloc_workqueue_attrs_noprof(__VA_ARGS__))
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b77119d71641..9c2c3a503e2c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5872,6 +5872,45 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 	return NULL;
 }
 
+#ifdef CONFIG_LOCKDEP
+static void workqueue_warn_on_reclaim(struct workqueue_struct *wq)
+{
+	if (wq->flags & WQ_MEM_WARN_ON_RECLAIM) {
+		fs_reclaim_acquire(GFP_KERNEL);
+		lock_map_acquire(wq->lockdep_map);
+		lock_map_release(wq->lockdep_map);
+		fs_reclaim_release(GFP_KERNEL);
+	}
+}
+#else
+static void workqueue_warn_on_reclaim(struct workqueue_struct *wq)
+{
+}
+#endif
+
+/**
+ * workqueue_is_reclaim_annotated() - Test whether a workqueue is annotated for
+ * reclaim safety
+ * @wq: workqueue to test
+ *
+ * Returns true if @wq is flags have both %WQ_MEM_WARN_ON_RECLAIM and
+ * %WQ_MEM_RECLAIM set. A workqueue marked with these flags indicates that it
+ * participates in reclaim paths, and therefore must not perform memory
+ * allocations that can recurse into reclaim (e.g., GFP_KERNEL is not allowed).
+ *
+ * Drivers can use this helper to enforce reclaim-safe behavior on workqueues
+ * that are created or provided elsewhere in the code.
+ *
+ * Return:
+ * true if the workqueue is reclaim-annotated, false otherwise.
+ */
+bool workqueue_is_reclaim_annotated(struct workqueue_struct *wq)
+{
+	return (wq->flags & WQ_MEM_WARN_ON_RECLAIM) &&
+		(wq->flags & WQ_MEM_RECLAIM);
+}
+EXPORT_SYMBOL_GPL(workqueue_is_reclaim_annotated);
+
 __printf(1, 4)
 struct workqueue_struct *alloc_workqueue_noprof(const char *fmt,
 						unsigned int flags,
@@ -5887,6 +5926,7 @@ struct workqueue_struct *alloc_workqueue_noprof(const char *fmt,
 		return NULL;
 
 	wq_init_lockdep(wq);
+	workqueue_warn_on_reclaim(wq);
 
 	return wq;
 }
@@ -5908,6 +5948,7 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags,
 		return NULL;
 
 	wq->lockdep_map = lockdep_map;
+	workqueue_warn_on_reclaim(wq);
 
 	return wq;
 }
-- 
2.34.1

