Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662C606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQ76ncCX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8C010E8AC;
	Mon,  9 Nov 2026 13:57:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E51710F315;
 Mon,  9 Nov 2026 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232647; x=1825768647;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6jD/pjdV0YSr+RYqlKEe6r7xBxh5CAIF4fydgh5i7Go=;
 b=SQ76ncCX9TUq+MJMcXPEtHiQsB+8r4fAP5PVH9DyJqbfZXck3wSO6PBw
 mgVgRvUvpTD6lGQwKQi09lXO3Xtpm2JLdNp440K6xzEquaZ06HcF+h3af
 enD6uN1vQhksmafOGT1FoozfwpkZqtrzx1F8t5JDpY5dbh+XVYvTKAbpz
 nedg/yjMBsyE4u/cZwculAwhyk6ZBFXpW6E0Jl+l7GWlZo1tbP8wP6370
 xQRUmGfi4unxdmSI0wO7AdUk8Gznnfuho2tJBzyqrQ218PCAy4V+nrxzg
 XBkkChc9Ekt3UjI2eV4OR8RHEdVTSAtfkq06oaQu/WqjNdEfidqiocpm/ Q==;
X-CSE-ConnectionGUID: pxC3RDX7RvCtyrp8vrntGw==
X-CSE-MsgGUID: EYMFkzZFRtyHe+75l+OwtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850904"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850904"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:21 -0800
X-CSE-ConnectionGUID: 0UAU2aRSTquYJ4DhsAbp0Q==
X-CSE-MsgGUID: PUyT33jaSRWapQCTM2BWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202885"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:16 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Subject: [PATCH 14/20] drm/xe/eudebug: Add userptr vm pread/pwrite
Date: Mon,  9 Nov 2026 15:55:39 +0200
Message-ID: <20261109135549.4128280-15-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement debugger vm access for userptrs.

When bind is done, take a ref to the current task so that
we know from which vm the address was bound. Then during
debugger pread/pwrite we use this target task as
parameter to access the debuggee vm with access_process_vm().

This is based on suggestions from Simona, Thomas and Joonas.

v2: need to add offset into vma (Dominik)
v3: move code into xe_userptr.c (Mika)
v4: check that task mm has not changed (Claude)

Cc: Simona Vetter <simona@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_eudebug_vm.c | 52 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_userptr.c    |  4 +++
 drivers/gpu/drm/xe/xe_userptr.h    | 34 +++++++++++++++++++
 include/uapi/drm/xe_drm_eudebug.h  |  2 ++
 4 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_eudebug_vm.c b/drivers/gpu/drm/xe/xe_eudebug_vm.c
index 385fcc7e8f5c..e18792c87ca8 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_vm.c
+++ b/drivers/gpu/drm/xe/xe_eudebug_vm.c
@@ -8,6 +8,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/dma-resv.h>
 #include <linux/fs.h>
+#include <linux/sched/mm.h>
 #include <linux/string_choices.h>
 #include <linux/vmalloc.h>
 
@@ -106,6 +107,57 @@ static int xe_eudebug_vma_access(struct xe_vma *vma,
 		xe_bo_put(bo);
 
 		return ret;
+	} else if (xe_vma_is_userptr(vma)) {
+		struct xe_userptr *userptr = &to_userptr_vma(vma)->userptr;
+		struct mm_struct *mm;
+		int ret;
+
+		if (XE_WARN_ON(!userptr->eudebug.task))
+			return -EINVAL;
+
+		/*
+		 * XXX FIXME: access_remote_vm() on userptr->notifier.mm would
+		 * fit better, as the notifier already holds a reference on the
+		 * mm and no task reference would be needed at all. It is not
+		 * exported though, so go through the task with
+		 * access_process_vm(), which is.
+		 *
+		 * Going through the task means the address space is resolved
+		 * from it on every access, and the task outlives its mm: after
+		 * an execve the same task carries a different address space,
+		 * and after the thread exits it carries none at all even
+		 * though the process and this mapping are still alive.
+		 *
+		 * Confirm the mm the userptr was bound against is still the
+		 * one the task holds, so that a replaced address space is
+		 * refused instead of handing the debugger bytes from an
+		 * unrelated program. access_process_vm() resolves the mm
+		 * again on its own, so this narrows that window rather than
+		 * closing it. Keying the access on the mm instead, with
+		 * get_user_pages_remote() on userptr->notifier.mm, would
+		 * remove the task from the picture entirely.
+		 */
+		mm = get_task_mm(userptr->eudebug.task);
+		if (!mm)
+			return -ESRCH;
+
+		ret = mm == userptr->notifier.mm ? 0 : -ESRCH;
+		mmput(mm);
+		if (ret)
+			return ret;
+
+		/*
+		 * access_process_vm() reports a failure to reach even the
+		 * first byte as 0, not as an errno. Turn that into -EIO, as
+		 * /proc/pid/mem does, so that a read does not look like the
+		 * end of the vm and a write does not return 0.
+		 */
+		ret = access_process_vm(userptr->eudebug.task,
+					xe_vma_userptr(vma) + offset_in_vma,
+					buf, bytes,
+					write ? FOLL_WRITE : 0);
+
+		return ret ?: -EIO;
 	}
 
 	return -EINVAL;
diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
index 9c1dac0fce6f..87ca94a81a50 100644
--- a/drivers/gpu/drm/xe/xe_userptr.c
+++ b/drivers/gpu/drm/xe/xe_userptr.c
@@ -421,6 +421,8 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
 	if (err)
 		return err;
 
+	xe_eudebug_track_userptr_task(userptr);
+
 	return 0;
 }
 
@@ -429,6 +431,8 @@ void xe_userptr_remove(struct xe_userptr_vma *uvma)
 	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
 	struct xe_userptr *userptr = &uvma->userptr;
 
+	xe_eudebug_untrack_userptr_task(userptr);
+
 	drm_gpusvm_free_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
 			      xe_vma_size(&uvma->vma) >> PAGE_SHIFT);
 
diff --git a/drivers/gpu/drm/xe/xe_userptr.h b/drivers/gpu/drm/xe/xe_userptr.h
index 2a3cd1b5efbb..d6e1c46f56d6 100644
--- a/drivers/gpu/drm/xe/xe_userptr.h
+++ b/drivers/gpu/drm/xe/xe_userptr.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/sched/task.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 
@@ -95,6 +96,17 @@ struct xe_userptr {
 #if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
 	u32 divisor;
 #endif
+
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+	/** @eudebug: eudebug state of the userptr */
+	struct {
+		/**
+		 * @eudebug.task: task that bound the userptr, see
+		 * xe_eudebug_vma_access()
+		 */
+		struct task_struct *task;
+	} eudebug;
+#endif
 };
 
 #if IS_ENABLED(CONFIG_DRM_GPUSVM)
@@ -133,4 +145,26 @@ static inline void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
 {
 }
 #endif
+
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+static inline void xe_eudebug_track_userptr_task(struct xe_userptr *userptr)
+{
+	/* See xe_eudebug_vma_access() for why this is a task, not the mm */
+	userptr->eudebug.task = get_task_struct(current);
+}
+
+static inline void xe_eudebug_untrack_userptr_task(struct xe_userptr *userptr)
+{
+	put_task_struct(userptr->eudebug.task);
+}
+#else
+static inline void xe_eudebug_track_userptr_task(struct xe_userptr *userptr)
+{
+}
+
+static inline void xe_eudebug_untrack_userptr_task(struct xe_userptr *userptr)
+{
+}
+#endif /* CONFIG_DRM_XE_EUDEBUG */
+
 #endif
diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
index 448821c32d29..4bb01a3c4fe4 100644
--- a/include/uapi/drm/xe_drm_eudebug.h
+++ b/include/uapi/drm/xe_drm_eudebug.h
@@ -371,6 +371,8 @@ struct drm_xe_eudebug_ack {
  *   marked purgeable (DONTNEED) or the kernel already purged.
  * - -EINTR if the wait for the backing store to be ready was interrupted.
  * - -ENOTCONN if the debug target is gone.
+ * - -ESRCH if the mapping is a userptr whose address space can no longer
+ *   be reached.
  * - -ENOSPC from pwrite() at an offset at or past the end of the vm.
  *   pread() returns 0 there.
  * - -ENOMEM, -EFAULT, -EIO or -ENODATA if a bounce buffer could not be
-- 
2.53.0

