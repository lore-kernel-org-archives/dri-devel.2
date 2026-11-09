Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903A606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OBg/M+/0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D231B10F358;
	Mon,  9 Nov 2026 13:57:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFBC10F338;
 Mon,  9 Nov 2026 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232663; x=1825768663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PFy9NWUF2HBtjY1kCTXN3ZqUGOYtiOqb/SD2CN4jjbA=;
 b=OBg/M+/0ZM3Fg+J6Pu2O/33q4WQz8RRPnhUy65HFPDKo2HGxv1nZ/S8U
 2jf/QnyNSyzrFxTDenc7/4MmV5++kW0BcONiLyAgH14RGZE14OHfDTNQy
 enhqCZ+NbjM9SanC4DMk7Nfbg/iO0ISdwxVezQBg2egdeMjrDIb6h/XCi
 5R8haUrR7AIFmxNxO/LNGPRBErglTb6mZa3jiN0qdnMp7OkmQo+eqE0Zu
 myAaFjZB2XCQl0oMIih4IgBwk8qSFVGZYJlWNgmGWMGZ0FcfbIsvXWLx0
 LuiOnpS05M8BDtri7BifRRPLgW+Kbectoatbou6xHC/UjZS46ORkNFNmv w==;
X-CSE-ConnectionGUID: fKP2jaGsRPWQDX6Dvb0lwQ==
X-CSE-MsgGUID: Kasnq5yIS6WawdLJ4NYtcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850937"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850937"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:43 -0800
X-CSE-ConnectionGUID: qPkXEve+SnCKnzXcGRt8/A==
X-CSE-MsgGUID: 49/WWHapSMyeeUOD+LztbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202990"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:37 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Dominik Grzegorzek <dominik.grzegorzek@intel.com>,
 Christoph Manszewski <christoph.manszewski@intel.com>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 18/20] drm/xe/eudebug: Introduce per device attention scan
 worker
Date: Mon,  9 Nov 2026 15:55:43 +0200
Message-ID: <20261109135549.4128280-19-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

From: Dominik Grzegorzek <dominik.grzegorzek@intel.com>

Scan for EU debugging attention bits periodically to detect if some EU
thread has entered the system routine (SIP) due to EU thread exception.

Make the scanning interval 50 times slower when there are no
debuggable exec queues and no debugger connection open. Send an
attention event whenever we see attention with a debugger present.

Based on work by the authors and others who worked on attentions in
i915.

v2: - use xa_array for files
    - null ptr deref fix for non-debugged context (Dominik)
    - checkpatch (Tilak)
    - use discovery_lock during list traversal
v3: - engine status per gen improvements, force_wake ref
    - __counted_by (Mika)
v4: - attention register naming (Dominik)
v5: - free event on error (Mika)
v6: - annotate data race on extending the poll interval (Mika)
v7: - sysfs race fix, return error instead of XA_WARN_ON (Sashiko)
    - attention_poll_stop to async to avoid deadlock (lockdep)
v8: - don't send if there are no attentions
    - stop before cancel (Claude)
    - use a device workqueue instead of system_dfl_wq (Maciej, Claude)
v9: - use mem_is_zero for the attention bitmap (Sashiko)
v10: - assert attention bitmask alignment (Sashiko)
     - static align the attention bitmap
v11: - adapt to runalone queue get signature (Sashiko)
v12: - resolve the attention owner once, bail out early without a
       debugger and don't log it as an error (Mika)
     - dont disconnect on destroy race (Claude)
v13: - poll state under eudebug.lock, no discovery special case (Mika)
v14: - stamp attention seqno before the handle lookups, document why an
       in-flight poll round outliving a disable is harmless (Sashiko)

Signed-off-by: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Signed-off-by: Christoph Manszewski <christoph.manszewski@intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 Documentation/gpu/xe/xe_eudebug.rst   |   3 +
 drivers/gpu/drm/xe/xe_device_types.h  |  12 +
 drivers/gpu/drm/xe/xe_eudebug.c       | 492 +++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_eudebug.h       |   1 +
 drivers/gpu/drm/xe/xe_eudebug_hw.c    |  16 +-
 drivers/gpu/drm/xe/xe_eudebug_hw.h    |   2 +
 drivers/gpu/drm/xe/xe_eudebug_types.h |   2 +-
 include/uapi/drm/xe_drm_eudebug.h     |  41 +++
 8 files changed, 553 insertions(+), 16 deletions(-)

diff --git a/Documentation/gpu/xe/xe_eudebug.rst b/Documentation/gpu/xe/xe_eudebug.rst
index b5aed372f4d7..5cc681617d60 100644
--- a/Documentation/gpu/xe/xe_eudebug.rst
+++ b/Documentation/gpu/xe/xe_eudebug.rst
@@ -78,6 +78,9 @@ Resource Event Types
 .. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
    :identifiers: drm_xe_eudebug_event_vm_bind_ufence
 
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_event_eu_attention
+
 Acknowledging Events
 --------------------
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 6be8ea04f8f6..2cc5472d2708 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -653,6 +653,18 @@ struct xe_device {
 
 		/** @eudebug.wq: used for the async session disconnect */
 		struct workqueue_struct *wq;
+
+		/** @eudebug.attention_wq: used for the attention poll work */
+		struct workqueue_struct *attention_wq;
+
+		/** @eudebug.attention_dwork: attention poll work */
+		struct delayed_work attention_dwork;
+
+		/**
+		 * @eudebug.send_attentions: handle attentions or ignore,
+		 * protected by @eudebug.lock
+		 */
+		bool send_attentions;
 	} eudebug;
 #endif
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index 4fab8304046b..9b1f2f97b603 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -7,6 +7,8 @@
 #include <linux/cleanup.h>
 #include <linux/dma-resv.h>
 #include <linux/poll.h>
+#include <linux/sched/mm.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_drv.h>
@@ -22,6 +24,8 @@
 #include "xe_eudebug_vm.h"
 #include "xe_exec_queue.h"
 #include "xe_gt.h"
+#include "xe_gt_debug.h"
+#include "xe_guc_submit.h"
 #include "xe_hw_engine.h"
 #include "xe_macros.h"
 #include "xe_oa.h"
@@ -642,6 +646,17 @@ xe_eudebug_get(struct xe_file *xef)
 	return __xe_eudebug_get(xef);
 }
 
+/*
+ * Without the ioctl_lock, the debugger can be seen while discovery is
+ * still relaying the target's resources, so a resource may not have a
+ * handle yet.
+ */
+struct xe_eudebug *
+xe_eudebug_get_nolock(struct xe_file *xef)
+{
+	return __xe_eudebug_get(xef);
+}
+
 static int xe_eudebug_queue_event(struct xe_eudebug *d,
 				  struct drm_xe_eudebug_event *event)
 {
@@ -2218,6 +2233,362 @@ static const struct file_operations fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 };
 
+/*
+ * The uapi tells userspace the attention bitmask sits 8 byte aligned within
+ * the event, so it may be scanned as u32 or u64 words. That holds today
+ * because the preceding members are u64, but a field added ahead of the
+ * array could quietly break it, so pin it down here. Only the offset can
+ * be: plain __u64 members are 4 byte aligned on i386.
+ */
+static_assert(offsetof(struct drm_xe_eudebug_event_eu_attention, bitmask) %
+	      sizeof(__u64) == 0);
+
+static int send_attention_event(struct xe_eudebug *d, struct xe_exec_queue *q,
+				int lrc_idx, void *bitmap, unsigned int size,
+				u64 seqno)
+{
+	struct drm_xe_eudebug_event_eu_attention *e;
+	struct drm_xe_eudebug_event *event;
+	const u32 sz = struct_size(e, bitmask, size);
+	int h_queue, h_lrc;
+	int ret;
+
+	if (lrc_idx < 0 || lrc_idx >= q->width)
+		return -EINVAL;
+
+	h_queue = find_handle(d, XE_EUDEBUG_RES_TYPE_EXEC_QUEUE, q);
+	if (h_queue < 0)
+		return h_queue;
+
+	h_lrc = find_handle(d, XE_EUDEBUG_RES_TYPE_LRC, q->lrc[lrc_idx]);
+	if (h_lrc < 0)
+		return h_lrc;
+
+	mutex_lock(&d->lock);
+	event = xe_eudebug_prepare_event(d, DRM_XE_EUDEBUG_EVENT_EU_ATTENTION,
+					 seqno, DRM_XE_EUDEBUG_EVENT_STATE_CHANGE,
+					 sz);
+
+	e = cast_event(e, event);
+	e->exec_queue_handle = h_queue;
+	e->lrc_handle = h_lrc;
+	e->bitmask_size = size;
+
+	memcpy(e->bitmask, bitmap, size);
+	ret = xe_eudebug_queue_event(d, event);
+	mutex_unlock(&d->lock);
+
+	return ret;
+}
+
+static int relay_gt_attention(struct xe_eudebug *d, struct xe_exec_queue *q,
+			      struct xe_hw_engine *hwe, int lrc_idx)
+{
+	const u32 size = xe_gt_eu_attention_bitmap_size(q->gt);
+	void *bitmask;
+	u64 seqno;
+	int ret;
+
+	/* If we fail at this time, assume we manage to send eventually */
+	bitmask = kvzalloc(size, GFP_KERNEL);
+	if (!bitmask)
+		return 0;
+
+	/*
+	 * Attention is state, so the event is stamped where that state is
+	 * observed: as the bits are read. That is also before the handle
+	 * lookups in send_attention_event(), so a handle still found there is
+	 * destroyed with a later seqno. A round that ends up sending nothing
+	 * leaves a gap in the numbering, which the uapi allows.
+	 */
+	seqno = atomic64_inc_return(&d->events.seqno);
+
+	ret = xe_gt_eu_attention_bitmap(q->gt, bitmask, size);
+
+	/*
+	 * EU_ATT is gt wide, and q was looked up before reading it. Only if
+	 * q is still the active context after the read are the bits its
+	 * own. Otherwise drop the round, rather than relay attention of some
+	 * other context under q's handles.
+	 */
+	if (!ret) {
+		ret = xe_eudebug_check_lrc_active(hwe, q->lrc[lrc_idx]);
+		if (ret == -EBUSY || ret == -ENOENT) {
+			eu_dbg(d, "context switched while reading attention, skipped");
+			ret = 0;
+			goto out;
+		}
+	}
+
+	if (!ret && !mem_is_zero(bitmask, size)) {
+		ret = send_attention_event(d, q, lrc_idx, bitmask, size, seqno);
+
+		if (ret == -ENOENT) {
+			eu_dbg(d, "attention on a queue without handles, skipped");
+			ret = 0;
+		}
+
+		/*
+		 * Unlike the other events, attention is state, and it is sent
+		 * again every round for as long as it lasts. A full fifo
+		 * already holds unread copies of it, so drop this one rather
+		 * than the debugger, and with it the target.
+		 */
+		if (ret == -ENOSPC) {
+			eu_dbg(d, "event fifo full, attention skipped");
+			ret = 0;
+		}
+
+		if (ret && !xe_eudebug_is_detached(d))
+			xe_eudebug_disconnect(d, ret);
+	}
+
+out:
+	kvfree(bitmask);
+
+	return ret;
+}
+
+static void handle_attention_fail(struct xe_gt *gt, int gt_id, int ret)
+{
+	/*
+	 * The owner of the attention cannot be resolved, but that covers two
+	 * different things. The context may have switched out between reading
+	 * the bits and looking it up, for instance after a debugger resumed
+	 * its threads, and then there is nothing left to service. Or the
+	 * threads are still waiting, in a workload that is not in debug mode,
+	 * and nobody is ever going to answer them.
+	 *
+	 * The error tells the two apart no better than the bits do: a
+	 * workload not in debug mode is not runalone either, so it fails the
+	 * same lookup. Read the attention again instead. If it is gone, the
+	 * scan raced something that serviced it; if it is still there, it is
+	 * stuck and the gt has to be reset to get the engine back.
+	 */
+	if (!xe_gt_eu_threads_needing_attention(gt))
+		return;
+
+	/* TODO: error capture */
+	drm_err_ratelimited(&gt_to_xe(gt)->drm,
+			    "gt:%d unable to handle eu attention ret = %d\n",
+			    gt_id, ret);
+
+	xe_gt_reset_async(gt);
+}
+
+/*
+ * Attention on a debuggable queue that nobody is going to service: its
+ * client has no debugger, it was never attached or it detached while
+ * threads were halted, or the queue is already dead. The gt still has to
+ * be reset to get the engine back. But userspace did this on its own, so
+ * it is not an error, and the reset logs itself already.
+ *
+ * TODO: recover orphaned threads without a full gt reset.
+ */
+static void handle_attention_no_debugger(struct xe_gt *gt, int gt_id)
+{
+	/* Same race as in handle_attention_fail() */
+	if (!xe_gt_eu_threads_needing_attention(gt))
+		return;
+
+	drm_dbg(&gt_to_xe(gt)->drm,
+		"gt:%d eu attention with no debugger attached, resetting\n",
+		gt_id);
+
+	xe_gt_reset_async(gt);
+}
+
+/*
+ * Forcewake not acking, or a read that did not land because the device is
+ * suspending or mid-reset, says nothing about the attention itself. A gt
+ * reset over it would throw away threads a debugger is holding, so look
+ * again next round instead.
+ */
+static bool attention_error_is_transient(int err)
+{
+	return err == -ETIMEDOUT || err == -EIO;
+}
+
+/*
+ * Resolve the queue that raised attention on @gt and the debugger of its
+ * client, once, and relay the attention to it. The debugger being absent
+ * is decided here, before anything is sent, and not inferred afterwards
+ * from how sending failed.
+ */
+static void handle_gt_attention(struct xe_gt *gt, int gt_id)
+{
+	struct xe_exec_queue *q;
+	struct xe_hw_engine *hwe;
+	struct xe_eudebug *d;
+	int ret, lrc_idx;
+
+	q = xe_gt_runalone_active_queue_get(gt, &hwe, &lrc_idx);
+	if (IS_ERR(q)) {
+		if (!attention_error_is_transient(PTR_ERR(q)))
+			handle_attention_fail(gt, gt_id, PTR_ERR(q));
+		return;
+	}
+
+	/*
+	 * A killed, banned or reset queue can stay resident with halted
+	 * threads. It is going away and nothing can be resumed on it, so do
+	 * not relay its attention to a debugger, just get the engine back.
+	 */
+	if (q->ops->reset_status(q)) {
+		xe_exec_queue_put(q);
+		handle_attention_no_debugger(gt, gt_id);
+		return;
+	}
+
+	d = xe_eudebug_get_nolock(q->vm->xef);
+	if (!d) {
+		xe_exec_queue_put(q);
+		handle_attention_no_debugger(gt, gt_id);
+		return;
+	}
+
+	/*
+	 * A queue discovery has not reached yet has no handle, and
+	 * relay_gt_attention() skips it until the next round.
+	 */
+	ret = relay_gt_attention(d, q, hwe, lrc_idx);
+
+	/* Detached under us: sending failing is a consequence, not a cause */
+	if (ret && xe_eudebug_is_detached(d)) {
+		xe_eudebug_put(d);
+		xe_exec_queue_put(q);
+		handle_attention_no_debugger(gt, gt_id);
+		return;
+	}
+
+	xe_eudebug_put(d);
+	xe_exec_queue_put(q);
+
+	if (ret && !attention_error_is_transient(ret))
+		handle_attention_fail(gt, gt_id, ret);
+}
+
+/*
+ * A gt reset is in flight from the moment xe_gt_reset_async() marks GuC
+ * submission stopped until the restart at the end of gt_reset_worker()
+ * starts it again. The attention poll takes forcewake and does steered
+ * reads on every dss, none of which may race a reset of any gt on the
+ * device, so it has to stay out for that whole window.
+ */
+static bool attention_poll_reset_in_flight(struct xe_device *xe)
+{
+	struct xe_gt *gt;
+	u8 id;
+
+	if (xe_device_is_in_reset(xe))
+		return true;
+
+	for_each_gt(gt, xe, id) {
+		if (xe_guc_read_stopped(&gt->uc.guc))
+			return true;
+
+		if (work_busy(&gt->reset.worker))
+			return true;
+	}
+
+	return false;
+}
+
+static void attention_poll_work(struct work_struct *work)
+{
+	struct xe_device *xe = container_of(work, typeof(*xe),
+					    eudebug.attention_dwork.work);
+	const unsigned int poll_interval_ms = 100;
+	long delay = msecs_to_jiffies(poll_interval_ms);
+	bool polled = false;
+	struct xe_gt *gt;
+	u8 gt_id;
+
+	scoped_guard(mutex, &xe->eudebug.lock) {
+		if (!xe->eudebug.send_attentions)
+			return;
+	}
+
+	/* Skip this round and look again at the poll interval */
+	if (attention_poll_reset_in_flight(xe))
+		goto requeue;
+
+	if (xe_pm_runtime_get_if_active(xe)) {
+		for_each_gt(gt, xe, gt_id) {
+			if (gt->info.type != XE_GT_TYPE_MAIN)
+				continue;
+
+			if (!xe_gt_eu_threads_needing_attention(gt))
+				continue;
+
+			handle_gt_attention(gt, gt_id);
+		}
+
+		xe_pm_runtime_put(xe);
+	}
+
+	polled = true;
+
+requeue:
+	mutex_lock(&xe->eudebug.lock);
+
+	/*
+	 * Poll fast while the device carries any debuggable exec queue,
+	 * whether or not a debugger is attached to its client. Attention has
+	 * to be noticed with low latency to be worth anything, and for an
+	 * offline capture there is no debugger to key off at all.
+	 *
+	 * Poll fast for an attached debugger too, even with no debuggable
+	 * queue: attention from a workload that is not in debug mode has to
+	 * be spotted and the gt reset, and a debugger is the one waiting for
+	 * that to happen.
+	 *
+	 * Decided under the lock that queues and debuggers are added under,
+	 * so one that arrives afterwards wakes the poll, see
+	 * xe_eudebug_track_exec_queue().
+	 */
+	if (polled && list_empty(&xe->eudebug.targets) && !xe->eudebug.attached)
+		delay = round_jiffies_up_relative(5 * HZ);
+
+	if (xe->eudebug.send_attentions)
+		queue_delayed_work(xe->eudebug.attention_wq,
+				   &xe->eudebug.attention_dwork, delay);
+
+	mutex_unlock(&xe->eudebug.lock);
+}
+
+/*
+ * The cancel is deliberately the async one. This runs under
+ * xe->eudebug.lock and attention_poll_work() takes that same lock, so
+ * waiting for the worker here would deadlock.
+ *
+ * Clearing send_attentions is therefore what actually stops the poll: the
+ * worker checks it under the lock before each round and before rearming,
+ * so the cancel only has to take out a queued run.
+ *
+ * A round already past that check can still finish after the disable has
+ * returned. Disabling requires that no debugger is attached and no
+ * debuggable exec queue exists, so the round has nothing to relay, and
+ * the most it can do is queue a gt reset, which eudebug_hw_update() does
+ * anyway. Only a PF has to wait it out, before VFs may be enabled, and
+ * xe_eudebug_enable() does that once the lock is dropped.
+ */
+static void xe_eudebug_attention_poll_stop(struct xe_device *xe)
+{
+	lockdep_assert_held(&xe->eudebug.lock);
+
+	xe->eudebug.send_attentions = false;
+	cancel_delayed_work(&xe->eudebug.attention_dwork);
+}
+
+static void xe_eudebug_attention_poll_start(struct xe_device *xe)
+{
+	lockdep_assert_held(&xe->eudebug.lock);
+
+	xe->eudebug.send_attentions = true;
+	mod_delayed_work(xe->eudebug.attention_wq, &xe->eudebug.attention_dwork, 0);
+}
+
 /*
  * Tell lockdep up front where the lock sits, so that a violation is
  * reported on the first run rather than once both paths have been seen.
@@ -2329,6 +2700,18 @@ xe_eudebug_connect(struct xe_device *xe,
 
 	xe_eudebug_hw_init(d);
 
+	/*
+	 * add_debugger() dropped eudebug.lock, and the target closing its
+	 * fd since then detaches us and lets a disable run to completion,
+	 * lockdown release included, or the device got unbound. Starting the
+	 * poll regardless would leave it reading gt registers with eudebug
+	 * off and VFs allowed, or after they are unmapped.
+	 */
+	scoped_guard(mutex, &xe->eudebug.lock) {
+		if (__xe_eudebug_is_enabled(xe))
+			xe_eudebug_attention_poll_start(xe);
+	}
+
 	eu_dbg(d, "connected session %llu", d->session);
 
 	drm_dev_get(&xe->drm);
@@ -2478,14 +2861,19 @@ static int __xe_eudebug_enable(struct xe_device *xe, bool enable,
 	set_cap_state(xe, enable ?
 		      XE_EUDEBUG_CAP_ENABLED : XE_EUDEBUG_CAP_DISABLED);
 
-	/*
-	 * The lockdown must outlive any vm fsync() cache flush still writing
-	 * gt registers. Waiting those out under eudebug.lock would stall
-	 * everything else behind their polls, so hand the release to the
-	 * caller, which runs after we drop it.
-	 */
-	if (!enable)
+	if (enable) {
+		xe_eudebug_attention_poll_start(xe);
+	} else {
+		xe_eudebug_attention_poll_stop(xe);
+		/*
+		 * The lockdown must outlive the attention worker: it reads GT
+		 * mmio, and VFs must not be enabled while it does. Stopping it
+		 * for good needs a synchronous cancel, which cannot happen
+		 * under eudebug.lock because the worker takes that same lock.
+		 * Hand the release to the caller, which runs after we drop it.
+		 */
 		*end_lockdown = IS_SRIOV_PF(xe);
+	}
 
 	return 0;
 }
@@ -2499,6 +2887,13 @@ static int xe_eudebug_enable(struct xe_device *xe, bool enable)
 	if (ret || !end_lockdown)
 		return ret;
 
+	/*
+	 * eudebug.lock is dropped by now, so the worker can finish and this
+	 * cannot deadlock against it. Only once it is truly stopped is it
+	 * safe to let VFs be enabled again.
+	 */
+	cancel_delayed_work_sync(&xe->eudebug.attention_dwork);
+
 	/*
 	 * A debugger detached before the disable may still be in a vm
 	 * fsync() cache flush, writing gt registers. A flush only starts
@@ -2508,6 +2903,17 @@ static int xe_eudebug_enable(struct xe_device *xe, bool enable)
 	mutex_lock(&xe->eudebug.flush_lock);
 	mutex_unlock(&xe->eudebug.flush_lock);
 
+	/*
+	 * An enable may have got in between dropping eudebug.lock and the
+	 * cancel, and the cancel then took out the poll it queued. That
+	 * enable holds a lockdown of its own, so only the poll needs putting
+	 * back.
+	 */
+	scoped_guard(mutex, &xe->eudebug.lock) {
+		if (__xe_eudebug_is_enabled(xe))
+			xe_eudebug_attention_poll_start(xe);
+	}
+
 	xe_sriov_pf_end_lockdown(xe);
 
 	return 0;
@@ -2551,6 +2957,41 @@ static void xe_eudebug_sysfs_fini(void *arg)
 			  &dev_attr_enable_eudebug.attr);
 }
 
+/*
+ * xe_eudebug_fini() only runs at the final drm_dev_put(), which an open
+ * file, or a debugger connection, can hold off long past unbind. devm
+ * teardown unmaps the registers the poll reads well before that, and the
+ * device is left runtime active, so stop the poll at unbind.
+ *
+ * devm actions unwind in reverse, so the sysfs knob is gone by now. But
+ * xe ioctls do not hold off unplug, and a connect already past its entry
+ * check can still start the poll. It only does so under eudebug.lock with
+ * eudebug enabled, so mark it disabled under that lock first.
+ */
+static void xe_eudebug_attention_fini(void *arg)
+{
+	struct xe_device *xe = arg;
+
+	scoped_guard(mutex, &xe->eudebug.lock) {
+		set_cap_state(xe, XE_EUDEBUG_CAP_DISABLED);
+		xe_eudebug_attention_poll_stop(xe);
+	}
+
+	cancel_delayed_work_sync(&xe->eudebug.attention_dwork);
+}
+
+static void xe_eudebug_fini(struct drm_device *dev, void *__unused)
+{
+	struct xe_device *xe = to_xe_device(dev);
+
+	xe_assert(xe, !xe->eudebug.attached);
+	xe_assert(xe, list_empty(&xe->eudebug.targets));
+
+	scoped_guard(mutex, &xe->eudebug.lock)
+		xe_eudebug_attention_poll_stop(xe);
+	cancel_delayed_work_sync(&xe->eudebug.attention_dwork);
+}
+
 static void xe_eudebug_lock_fini(struct drm_device *dev, void *__unused)
 {
 	mutex_destroy(&to_xe_device(dev)->eudebug.lock);
@@ -2559,6 +3000,7 @@ static void xe_eudebug_lock_fini(struct drm_device *dev, void *__unused)
 void xe_eudebug_init_early(struct xe_device *xe)
 {
 	INIT_LIST_HEAD(&xe->eudebug.targets);
+	INIT_DELAYED_WORK(&xe->eudebug.attention_dwork, attention_poll_work);
 
 	/*
 	 * Not drmm_mutex_init(), which can fail and leave the lock destroyed:
@@ -2607,6 +3049,25 @@ void xe_eudebug_init(struct xe_device *xe)
 		goto out_err;
 	xe->eudebug.wq = wq;
 
+	/*
+	 * Freezable, so that system suspend drains the poll before any gt
+	 * is suspended, and holds it off until everything has resumed.
+	 */
+	wq = drmm_alloc_ordered_workqueue(dev, "xe-eudebug-attn", WQ_FREEZABLE);
+	if (IS_ERR(wq)) {
+		err = PTR_ERR(wq);
+		goto out_err;
+	}
+	xe->eudebug.attention_wq = wq;
+
+	err = drmm_add_action_or_reset(&xe->drm, xe_eudebug_fini, NULL);
+	if (err)
+		goto out_err;
+
+	err = devm_add_action_or_reset(dev->dev, xe_eudebug_attention_fini, xe);
+	if (err)
+		goto out_err;
+
 	err = devm_add_action_or_reset(dev->dev, xe_eudebug_sysfs_fini, xe);
 	if (err)
 		goto out_err;
@@ -2670,6 +3131,23 @@ int xe_eudebug_track_exec_queue(struct xe_exec_queue *q)
 	if (list_empty(&q->eudebug.target_link))
 		list_add_tail(&q->eudebug.target_link, &xe->eudebug.targets);
 
+	/*
+	 * Attention polling falls back to a lazy interval while the device
+	 * carries nothing debuggable. A queue that arrives during such a
+	 * sleep would have to wait it out before any attention of its own
+	 * is noticed, which is long enough for the job timeout to kill the
+	 * workload first. Wake the poll instead.
+	 *
+	 * attention_poll_work() picks its delay and rearms under this lock,
+	 * so the wakeup always lands after that decision. A stopped poll
+	 * returns at its own guard.
+	 *
+	 * The worker takes eudebug.lock itself, but mod_delayed_work() only
+	 * queues it, so doing this under the lock cannot deadlock.
+	 */
+	mod_delayed_work(xe->eudebug.attention_wq,
+			 &xe->eudebug.attention_dwork, 0);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
index 11a40bc33e6e..766295e0b112 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.h
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -66,6 +66,7 @@ void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm);
 
 bool xe_eudebug_is_detached(struct xe_eudebug *d);
 
+struct xe_eudebug *xe_eudebug_get_nolock(struct xe_file *xef);
 void xe_eudebug_put(struct xe_eudebug *d);
 
 struct xe_vm *xe_eudebug_vm_get(struct xe_eudebug *d, u32 vm_id);
diff --git a/drivers/gpu/drm/xe/xe_eudebug_hw.c b/drivers/gpu/drm/xe/xe_eudebug_hw.c
index 3c025f279488..f5fd50f58838 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_hw.c
+++ b/drivers/gpu/drm/xe/xe_eudebug_hw.c
@@ -354,13 +354,13 @@ static int check_lrc_sanity(const struct xe_exec_queue *q,
 }
 
 /*
- * The active context was sampled before the bitmask was copied in from
- * userspace and before eudebug.lock was taken, and the hardware may have
- * switched since. EU_ATT and EU_ATT_CLR are gt wide, so check again just
- * before touching them, as xe_eu_control_interrupt_all() does for TD_CTL,
- * rather than report or clear attention of some other context.
+ * The active context is sampled once, and the hardware may switch away
+ * from it any time after. EU_ATT and EU_ATT_CLR are gt wide, so check
+ * again right before clearing them, or right after reading them, as
+ * xe_eu_control_interrupt_all() does for TD_CTL, rather than report or
+ * clear attention of some other context.
  */
-static int check_lrc_active(struct xe_hw_engine *hwe, struct xe_lrc *lrc)
+int xe_eudebug_check_lrc_active(struct xe_hw_engine *hwe, struct xe_lrc *lrc)
 {
 	u32 lrc_hw;
 	int err;
@@ -498,12 +498,12 @@ static int do_eu_control(struct xe_eudebug *d,
 			ret = -EINVAL;
 		break;
 	case DRM_XE_EUDEBUG_EU_CONTROL_CMD_STOPPED:
-		ret = check_lrc_active(active_hwe, lrc);
+		ret = xe_eudebug_check_lrc_active(active_hwe, lrc);
 		if (!ret)
 			ret = d->ops->stopped(d, active, lrc, bits, attn_size);
 		break;
 	case DRM_XE_EUDEBUG_EU_CONTROL_CMD_RESUME:
-		ret = check_lrc_active(active_hwe, lrc);
+		ret = xe_eudebug_check_lrc_active(active_hwe, lrc);
 		if (!ret)
 			ret = d->ops->resume(d, active, lrc, bits, attn_size);
 		break;
diff --git a/drivers/gpu/drm/xe/xe_eudebug_hw.h b/drivers/gpu/drm/xe/xe_eudebug_hw.h
index 8c9d8fea1189..ba8e7cc93bff 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_hw.h
+++ b/drivers/gpu/drm/xe/xe_eudebug_hw.h
@@ -11,6 +11,7 @@
 struct xe_eudebug;
 struct xe_hw_engine;
 struct xe_gt;
+struct xe_lrc;
 
 #if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
 
@@ -22,6 +23,7 @@ long xe_eudebug_eu_control(struct xe_eudebug *d, const u64 arg);
 struct xe_exec_queue *xe_gt_runalone_active_queue_get(struct xe_gt *gt,
 						      struct xe_hw_engine **active_hwe,
 						      int *lrc_idx);
+int xe_eudebug_check_lrc_active(struct xe_hw_engine *hwe, struct xe_lrc *lrc);
 
 #endif /* CONFIG_DRM_XE_EUDEBUG */
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug_types.h b/drivers/gpu/drm/xe/xe_eudebug_types.h
index 9cbcadecb2a7..1b379cc52ba7 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_types.h
+++ b/drivers/gpu/drm/xe/xe_eudebug_types.h
@@ -37,7 +37,7 @@ enum xe_eudebug_cap_state {
 	XE_EUDEBUG_CAP_ENABLED,
 };
 
-#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_VM_BIND_UFENCE
+#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_EU_ATTENTION
 
 /**
  * struct xe_eudebug_handle - eudebug resource handle
diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
index fd498480df84..92fa96c35c3e 100644
--- a/include/uapi/drm/xe_drm_eudebug.h
+++ b/include/uapi/drm/xe_drm_eudebug.h
@@ -90,6 +90,7 @@ struct drm_xe_eudebug_event {
 #define DRM_XE_EUDEBUG_EVENT_VM_BIND		4
 #define DRM_XE_EUDEBUG_EVENT_VM_BIND_OP_DEBUG_DATA	5
 #define DRM_XE_EUDEBUG_EVENT_VM_BIND_UFENCE	6
+#define DRM_XE_EUDEBUG_EVENT_EU_ATTENTION	7
 
 	/** @flags: Flags */
 	__u16 flags;
@@ -475,6 +476,46 @@ struct drm_xe_eudebug_eu_control {
 	__u64 bitmask_ptr;
 };
 
+/**
+ * struct drm_xe_eudebug_event_eu_attention - EU Attention Event
+ *
+ * Whenever there is any thread in halted/attentions state, this
+ * event will be delivered. The event will be delivered periodically
+ * until there are no attentions detected.
+ *
+ */
+struct drm_xe_eudebug_event_eu_attention {
+	/** @base: base event */
+	struct drm_xe_eudebug_event base;
+
+	/** @exec_queue_handle: Exec queue handle for the attentions */
+	__u64 exec_queue_handle;
+
+	/** @lrc_handle: LRC handle for the attentions */
+	__u64 lrc_handle;
+
+	/**
+	 * @flags: Reserved for future use, reads as zero
+	 *
+	 * Event wide flags are carried in
+	 * :c:member:`drm_xe_eudebug_event_eu_attention.base`.
+	 */
+	__u32 flags;
+
+	/** @bitmask_size: Bitmask size in bytes for bitmask[] */
+	__u32 bitmask_size;
+
+	/**
+	 * @bitmask: Attention bits, one per thread
+	 *
+	 * @bitmask_size is always a multiple of 4, and the array is 8 byte
+	 * aligned within the event, so it can be scanned as u32 or u64
+	 * words instead of byte at a time. The content is hardware register
+	 * state in native endianness.
+	 */
+	__u8 bitmask[];
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.53.0

