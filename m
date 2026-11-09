Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9134606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QFbX6AXb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB69C10F333;
	Mon,  9 Nov 2026 13:57:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D75910F322;
 Mon,  9 Nov 2026 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232629; x=1825768629;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0R+xPdZYIz2NFfRFya8vx8tlMfBWt+6LjXtPq5FWxlM=;
 b=QFbX6AXbD3NlYwtn0unD0lbciCbshK40gApZUK3hxasXCNS3b2ohdCOk
 SngNWJpdo9LzXOykLDDsHcOp95K0B2DAdxeHdolp0cMMOwtgh82xEiUWI
 lcfMl4AaAtlXN4lqWz6OfljC3cpUv33Yfi9VuNodpnBYIDtidtLCsMJAd
 +Ew7CwRcgNZGfqTJhChKzfjhiQZKbGxCTRXvIWqZ+sMR9N+bwIIz7PFPF
 NiN3fr15MeEac4Bi2VljDDCo9Q4+j1CnMzljryw5hLeZl6DKRX9gMNjlF
 LBRXOl3gcFV/rs2kEt5j0OzeISieMglfnnSU4UY1NvX4UZf51vESP6cKU A==;
X-CSE-ConnectionGUID: 7OfpumUtQEKWn7PTnIk+MA==
X-CSE-MsgGUID: +BlhA6SLR0Gj1j/8DPYX+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850882"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850882"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:09 -0800
X-CSE-ConnectionGUID: B+OhZ6vpQLO2Amgb8rqx5g==
X-CSE-MsgGUID: hiGObHlgQ8OU69/UbC4rkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202821"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:04 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 12/20] drm/xe/eudebug: Add ufence events with acks
Date: Mon,  9 Nov 2026 15:55:37 +0200
Message-ID: <20261109135549.4128280-13-mika.kuoppala@linux.intel.com>
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

When the vma is in place, the debugger needs to intercept before
userspace proceeds with the workload, for example to install
a breakpoint in an EU shader.

If the ufence is part of a bind sequence, attach the debugger in
xe_user_fence. When the ufence signal is about to be delivered,
check if this ufence needs to be tracked by the debugger.
If so, stall the delivery of the ufence signal until the
debugger has acked the ufence (event), with the ack ioctl.

v2: - return err instead of 0 to guarantee signalling (Dominik)
    - checkpatch (Tilak)
    - Kconfig (Mika, Andrzej)
    - use lock instead of cmpxchg (Mika)
v4: - improve ref handling and no ufences nodebug binds
v5: - remove overzealous warn_on on bind_ref_seqno (Christoph)
    - remove superfluous signalled (Mika)
    - fix double free on bind sequence (Mika)
    - Don't fill op fields if no debugger (Maciej)
v6: - rework to align with xe_eudebug_bind_execute()
v7: - fix setting signalled before debugger acks (Jan)
v8: - explicit debugger set and clears (Mika)
    - take reference for tracking check (Mika)
    - fix leak of ref in handle_ack (Mika)
v9: - enforce mbz on user_arg.type (Sashiko)
v10: - avoid double signal if not tracked (Sashiko)
     - clear bind ref seqno if no debugger (Sashiko)
     - add reserved field
     - avoid referencing ack after dropping lock (Claude)
     - clear bind ref if tracking fails (Claude)
     - use GFP_KERNEL for ack allocation
     - don't starve discovery wq (Claude)
v11: - clear bind ref if detached late (Sashiko)
v12: - drop the debugger ref when not tracking (review-prompts)
v13: - ack tree under the debugger lock (Mika)
v14: - ack and its event added under one lock (Sashiko)

Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 Documentation/gpu/xe/xe_eudebug.rst   |   9 +
 drivers/gpu/drm/xe/xe_eudebug.c       | 391 +++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_eudebug.h       |   9 +
 drivers/gpu/drm/xe/xe_eudebug_types.h |   9 +-
 drivers/gpu/drm/xe/xe_sync.c          |  47 ++--
 drivers/gpu/drm/xe/xe_sync.h          |   3 +
 drivers/gpu/drm/xe/xe_sync_types.h    |  29 +-
 include/uapi/drm/xe_drm_eudebug.h     | 117 +++++++-
 8 files changed, 573 insertions(+), 41 deletions(-)

diff --git a/Documentation/gpu/xe/xe_eudebug.rst b/Documentation/gpu/xe/xe_eudebug.rst
index 71a8441e04cf..fbee568d44be 100644
--- a/Documentation/gpu/xe/xe_eudebug.rst
+++ b/Documentation/gpu/xe/xe_eudebug.rst
@@ -74,3 +74,12 @@ Resource Event Types
 
 .. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
    :identifiers: drm_xe_eudebug_event_vm_bind_op_debug_data
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_event_vm_bind_ufence
+
+Acknowledging Events
+--------------------
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_ack
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index c6d08b27042d..934dc116120e 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -22,6 +22,7 @@
 #include "xe_hw_engine.h"
 #include "xe_macros.h"
 #include "xe_sriov_pf.h"
+#include "xe_sync.h"
 #include "xe_vm.h"
 
 /**
@@ -290,10 +291,130 @@ static void xe_eudebug_put(struct xe_eudebug *d)
 	kref_put(&d->ref, xe_eudebug_free);
 }
 
+struct xe_eudebug_ack {
+	struct rb_node rb_node;
+	u64 seqno;
+	u64 ts_insert;
+	struct xe_user_fence *ufence;
+};
+
+#define fetch_ack(x) rb_entry(x, struct xe_eudebug_ack, rb_node)
+
+static int compare_ack(const u64 a, const u64 b)
+{
+	if (a < b)
+		return -1;
+	else if (a > b)
+		return 1;
+
+	return 0;
+}
+
+static int ack_insert_cmp(struct rb_node * const node,
+			  const struct rb_node * const p)
+{
+	return compare_ack(fetch_ack(node)->seqno,
+			   fetch_ack(p)->seqno);
+}
+
+static int ack_lookup_cmp(const void * const key,
+			  const struct rb_node * const node)
+{
+	return compare_ack(*(const u64 *)key,
+			   fetch_ack(node)->seqno);
+}
+
+static struct xe_eudebug_ack *remove_ack(struct xe_eudebug *d, u64 seqno)
+{
+	struct rb_root * const root = &d->acks.tree;
+	struct rb_node *node;
+
+	scoped_guard(mutex, &d->lock) {
+		node = rb_find(&seqno, root, ack_lookup_cmp);
+		if (node)
+			rb_erase(node, root);
+	}
+
+	if (!node)
+		return NULL;
+
+	return rb_entry_safe(node, struct xe_eudebug_ack, rb_node);
+}
+
+static void ufence_signal_worker(struct work_struct *w)
+{
+	struct xe_user_fence * const ufence =
+		container_of(w, struct xe_user_fence, eudebug.worker);
+
+	xe_sync_ufence_signal(ufence);
+
+	xe_sync_ufence_put(ufence);
+}
+
+/*
+ * Not on a workqueue of our own: a user_fence_worker() on xe->ordered_wq
+ * can still get here through a disconnect while the device is being
+ * released. xe_device_destroy() drains ordered_wq only after the drmm
+ * actions of xe_eudebug_init() have run, and destroys xe->unordered_wq
+ * after it.
+ */
+static void kick_ufence_worker(struct xe_user_fence *f)
+{
+	queue_work(f->xe->unordered_wq, &f->eudebug.worker);
+}
+
+static void handle_ack(struct xe_eudebug *d, struct xe_eudebug_ack *ack,
+		       bool on_disconnect)
+{
+	struct xe_user_fence *f = ack->ufence;
+	struct xe_eudebug *debugger = NULL;
+	u64 signalled_by;
+	bool signal = false;
+
+	spin_lock(&f->eudebug.lock);
+	if (!f->eudebug.signalled_seqno) {
+		f->eudebug.signalled_seqno = ack->seqno;
+		f->eudebug.bind_ref_seqno = 0;
+		debugger = f->eudebug.debugger;
+		f->eudebug.debugger = NULL;
+		signal = true;
+	}
+	signalled_by = f->eudebug.signalled_seqno;
+	spin_unlock(&f->eudebug.lock);
+
+	if (signal)
+		kick_ufence_worker(f);
+	else
+		xe_sync_ufence_put(f);
+
+	eu_dbg(d, "ACK: seqno=%llu: signalled by %llu (%s) (held %lluus)",
+	       ack->seqno, signalled_by,
+	       on_disconnect ? "disconnect" : "debugger",
+	       ktime_us_delta(ktime_get(), ack->ts_insert));
+
+	kfree(ack);
+
+	if (debugger)
+		xe_eudebug_put(debugger);
+}
+
+/*
+ * handle_ack() can drop a user fence reference, so the tree is taken out
+ * under the lock and released after it is dropped.
+ */
+static void release_acks(struct xe_eudebug *d, struct rb_root *root)
+{
+	struct xe_eudebug_ack *ack, *n;
+
+	rbtree_postorder_for_each_entry_safe(ack, n, root, rb_node)
+		handle_ack(d, ack, true);
+}
+
 static bool xe_eudebug_detach(struct xe_eudebug *d,
 			      const int err)
 {
 	struct xe_file *target = NULL;
+	struct rb_root acks;
 
 	XE_WARN_ON(err > 0);
 
@@ -304,6 +425,9 @@ static bool xe_eudebug_detach(struct xe_eudebug *d,
 	 * been detached, and the fd close path does exactly that. Drop the
 	 * handles in the same critical section, so nothing can be resolved
 	 * afterwards.
+	 *
+	 * Take the acks out even if already detached: an ack inserted after
+	 * the detach is released by the disconnect its failed event causes.
 	 */
 	scoped_guard(mutex, &d->lock) {
 		if (d->target.xef) {
@@ -312,6 +436,9 @@ static bool xe_eudebug_detach(struct xe_eudebug *d,
 			d->target.xef = NULL;
 			xe_eudebug_resources_clear(d);
 		}
+
+		acks = d->acks.tree;
+		d->acks.tree = RB_ROOT;
 	}
 
 	if (target) {
@@ -327,6 +454,8 @@ static bool xe_eudebug_detach(struct xe_eudebug *d,
 
 	wake_up_all(&d->events.write_done);
 
+	release_acks(d, &acks);
+
 	if (target) {
 		xe_eudebug_put(d);
 		xe_file_put(target);
@@ -363,8 +492,9 @@ static void disconnect_work_fn(struct work_struct *work)
  *
  * Until the worker runs, the session still reads as attached: the
  * debugger can read what was queued, and producers can still queue. That
- * leaves nothing behind, the debugger discards the session on -ENOTCONN
- * anyway.
+ * leaves nothing behind. The debugger discards the session on -ENOTCONN
+ * anyway, and a bind that fails here never hands its user fence over to
+ * wait for an ack.
  */
 static void xe_eudebug_disconnect_async(struct xe_eudebug *d, int err)
 {
@@ -747,7 +877,8 @@ xe_eudebug_prepare_event(struct xe_eudebug *d, u16 type, u64 seqno, u16 flags,
 	const u16 known_flags =
 		DRM_XE_EUDEBUG_EVENT_CREATE |
 		DRM_XE_EUDEBUG_EVENT_DESTROY |
-		DRM_XE_EUDEBUG_EVENT_STATE_CHANGE;
+		DRM_XE_EUDEBUG_EVENT_STATE_CHANGE |
+		DRM_XE_EUDEBUG_EVENT_NEED_ACK;
 	struct drm_xe_eudebug_event *event = d->events.staging;
 
 	lockdep_assert_held(&d->lock);
@@ -1199,6 +1330,191 @@ static int vm_bind_op_event(struct xe_eudebug *d,
 	return err;
 }
 
+void xe_eudebug_ufence_init(struct xe_user_fence *ufence)
+{
+	spin_lock_init(&ufence->eudebug.lock);
+	ufence->eudebug.debugger = NULL;
+	ufence->eudebug.bind_ref_seqno = 0;
+	ufence->eudebug.signalled_seqno = 0;
+	INIT_WORK(&ufence->eudebug.worker, ufence_signal_worker);
+}
+
+void xe_eudebug_ufence_fini(struct xe_user_fence *ufence)
+{
+	struct xe_eudebug *d;
+
+	/*
+	 * A fence can die still holding its bind reference. A bind of debug
+	 * data ops only has no page table work, and its fences are signalled
+	 * by xe_vm_bind_ioctl() after xe_eudebug_vm_bind_execute() attached
+	 * this one. In-fences are rejected up front for such a bind, so only
+	 * an allocation failure in xe_sync_in_fence_get() can make that
+	 * signalling fail, and then the fence is never signalled and nothing
+	 * will ever track or ack it. There is no event to send for a fence
+	 * that never signals, so just drop the reference.
+	 *
+	 * This is the release of the last fence reference, so nothing else
+	 * can be looking at the fence any more.
+	 */
+	d = ufence->eudebug.debugger;
+	if (!d)
+		return;
+
+	ufence->eudebug.debugger = NULL;
+
+	xe_eudebug_put(d);
+}
+
+static int track_ufence(struct xe_eudebug *d,
+			struct xe_user_fence *ufence,
+			u64 bind_ref_seqno,
+			bool *tracked)
+{
+	struct drm_xe_eudebug_event *event;
+	struct drm_xe_eudebug_event_vm_bind_ufence *e;
+	const u32 sz = sizeof(*e);
+	const u32 flags = DRM_XE_EUDEBUG_EVENT_CREATE |
+		DRM_XE_EUDEBUG_EVENT_NEED_ACK;
+	struct xe_eudebug_ack *ack;
+	struct rb_node *old;
+	u64 seqno;
+	int ret;
+
+	*tracked = false;
+
+	if (XE_WARN_ON(!bind_ref_seqno))
+		return -EINVAL;
+
+	seqno = atomic64_inc_return(&d->events.seqno);
+
+	/*
+	 * No __GFP_ACCOUNT: this runs in the fence worker, where it would not
+	 * be charged to the debugger or the target anyway.
+	 */
+	ack = kzalloc_obj(*ack, GFP_KERNEL);
+	if (!ack) {
+		eu_dbg(d, "ack allocation fail");
+		return -ENOMEM;
+	}
+
+	ack->seqno = seqno;
+	ack->ts_insert = ktime_get();
+	ack->ufence = ufence;
+
+	__xe_sync_ufence_get(ufence);
+
+	/*
+	 * The ack and the event asking for it go in under one lock, so the
+	 * debugger cannot ack a fence it has not been told about. Once the
+	 * lock is dropped the ack may already be gone, so it is not touched
+	 * after that.
+	 */
+	mutex_lock(&d->lock);
+	old = rb_find_add(&ack->rb_node, &d->acks.tree, ack_insert_cmp);
+	if (old) {
+		mutex_unlock(&d->lock);
+		xe_sync_ufence_put(ufence);
+		kfree(ack);
+		return -EEXIST;
+	}
+
+	*tracked = true;
+
+	event = xe_eudebug_prepare_event(d, DRM_XE_EUDEBUG_EVENT_VM_BIND_UFENCE,
+					 seqno, flags, sz);
+
+	e = cast_event(e, event);
+	e->vm_bind_ref_seqno = bind_ref_seqno;
+
+	ret = xe_eudebug_queue_event(d, event);
+	mutex_unlock(&d->lock);
+
+	return ret;
+}
+
+/*
+ * Signalling without an ack: the fence will not be tracked, so it must not
+ * keep the debugger either. Drop the reference taken in
+ * xe_eudebug_vm_bind_execute() now, as handle_ack() does for a tracked
+ * fence, instead of leaving it to the fence destructor, which can be as
+ * late as the vma the fence is attached to going away.
+ */
+static void ufence_drop_debugger(struct xe_user_fence *ufence)
+{
+	struct xe_eudebug *d;
+
+	scoped_guard(spinlock, &ufence->eudebug.lock) {
+		d = ufence->eudebug.debugger;
+		ufence->eudebug.debugger = NULL;
+		ufence->eudebug.bind_ref_seqno = 0;
+		ufence->eudebug.signalled_seqno = 0;
+	}
+
+	if (d)
+		xe_eudebug_put(d);
+}
+
+/**
+ * xe_eudebug_ufence_track - Track the ufence for eudebug
+ * @ufence : user fence that might be applicable to tracking
+ *
+ * If this user fence was part of bind sequence, we need
+ * to track it so that we can hold the client signalling on behalf
+ * of debugger and thus deliver event to debugger.
+ *
+ * Return: true debugger will track, false debugger not interested
+ *
+ */
+bool xe_eudebug_ufence_track(struct xe_user_fence *ufence)
+{
+	struct xe_eudebug *d;
+	u64 bind_ref_seqno;
+	bool tracked = false;
+	int ret;
+
+	spin_lock(&ufence->eudebug.lock);
+	d = ufence->eudebug.debugger;
+	if (d && !kref_get_unless_zero(&d->ref))
+		d = NULL;
+
+	if (!d) {
+		ufence->eudebug.bind_ref_seqno = 0;
+		ufence->eudebug.signalled_seqno = 0;
+	}
+	/*
+	 * Taken now: once the fence is in the ack tree, an ack or a
+	 * disconnect clears this.
+	 */
+	bind_ref_seqno = ufence->eudebug.bind_ref_seqno;
+	spin_unlock(&ufence->eudebug.lock);
+
+	if (!d)
+		return false;
+
+	if (xe_eudebug_is_detached(d)) {
+		/* Nothing will ack this fence any more */
+		ufence_drop_debugger(ufence);
+		xe_eudebug_put(d);
+		return false;
+	}
+
+	ret = track_ufence(d, ufence, bind_ref_seqno, &tracked);
+	if (ret) {
+		/*
+		 * If we failed before the ack made it into the tree, the
+		 * disconnect below has nothing to release for this fence.
+		 */
+		if (!tracked)
+			ufence_drop_debugger(ufence);
+
+		xe_eudebug_disconnect(d, ret);
+	}
+
+	xe_eudebug_put(d);
+
+	return tracked;
+}
+
 /*
  * The debug data entry a bind op adds or removes, and the event flag for
  * it, or NULL if the op is not a debug data op. vm_bind_ioctl_check_args()
@@ -1228,8 +1544,10 @@ static const struct xe_debug_data *bind_op_debug_data(struct xe_vma_op *op,
 void xe_eudebug_vm_bind_execute(struct xe_vm *vm,
 				struct xe_vma_ops *ops)
 {
+	struct xe_user_fence *ufence = NULL;
 	struct xe_eudebug *d;
 	struct xe_vma_op *op;
+	unsigned int i;
 	u64 bind_seqno = 0;
 	u32 num_ops;
 	int err;
@@ -1241,6 +1559,15 @@ void xe_eudebug_vm_bind_execute(struct xe_vm *vm,
 	if (!d)
 		return;
 
+	for (i = 0; i < ops->num_syncs; i++) {
+		struct xe_sync_entry *se = &ops->syncs[i];
+
+		if (xe_sync_is_ufence(se)) {
+			xe_assert(vm->xe, !ufence);
+			ufence = se->ufence;
+		}
+	}
+
 	num_ops = 0;
 	list_for_each_entry(op, &ops->list, link) {
 		u32 flags;
@@ -1256,7 +1583,8 @@ void xe_eudebug_vm_bind_execute(struct xe_vm *vm,
 		return;
 	}
 
-	err = vm_bind_event(d, vm, 0,
+	err = vm_bind_event(d, vm,
+			    ufence ? DRM_XE_EUDEBUG_EVENT_VM_BIND_FLAG_UFENCE : 0,
 			    num_ops, &bind_seqno);
 	if (err)
 		goto out_err;
@@ -1274,6 +1602,19 @@ void xe_eudebug_vm_bind_execute(struct xe_vm *vm,
 			goto out_err;
 	}
 
+	/*
+	 * Safe after the events: the bind's out-syncs, this user fence among
+	 * them, are attached to its fence only in vm_bind_ioctl_ops_fini() or
+	 * vm_bind_ioctl_signal_fences(), after this returns.
+	 */
+	if (ufence) {
+		spin_lock(&ufence->eudebug.lock);
+		kref_get(&d->ref);
+		ufence->eudebug.debugger = d;
+		ufence->eudebug.bind_ref_seqno = bind_seqno;
+		spin_unlock(&ufence->eudebug.lock);
+	}
+
 out_err:
 	/*
 	 * -ENOENT is vm_bind_event() not finding the vm: a racing
@@ -1691,6 +2032,42 @@ static long xe_eudebug_read_event(struct xe_eudebug *d,
 	return ret;
 }
 
+static long
+xe_eudebug_ack_event_ioctl(struct xe_eudebug *d,
+			   const u64 arg)
+{
+	struct drm_xe_eudebug_ack __user * const user_ptr =
+		u64_to_user_ptr(arg);
+	struct drm_xe_eudebug_ack user_arg;
+	struct xe_eudebug_ack *ack;
+	struct xe_device *xe = d->xe;
+
+	if (XE_IOCTL_DBG(xe, copy_from_user(&user_arg,
+					    user_ptr,
+					    sizeof(user_arg))))
+		return -EFAULT;
+
+	if (XE_IOCTL_DBG(xe, user_arg.type))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, user_arg.flags))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, user_arg.reserved))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, xe_eudebug_is_detached(d)))
+		return -ENOTCONN;
+
+	ack = remove_ack(d, user_arg.seqno);
+	if (XE_IOCTL_DBG(xe, !ack))
+		return -EINVAL;
+
+	handle_ack(d, ack, false);
+
+	return 0;
+}
+
 /**
  * xe_eudebug_ioctl - Issue a command to eudebug interface
  *
@@ -1715,6 +2092,10 @@ static long xe_eudebug_ioctl(struct file *file,
 		ret = xe_eudebug_read_event(d, arg,
 					    !(file->f_flags & O_NONBLOCK));
 		break;
+	case DRM_XE_EUDEBUG_IOCTL_ACK_EVENT:
+		ret = xe_eudebug_ack_event_ioctl(d, arg);
+		eu_dbg(d, "ioctl cmd=EVENT_ACK ret=%ld\n", ret);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
@@ -1789,6 +2170,8 @@ xe_eudebug_connect(struct xe_device *xe,
 
 	INIT_WORK(&d->disconnect_work, disconnect_work_fn);
 
+	d->acks.tree = RB_ROOT;
+
 	err = xe_eudebug_resources_init(d);
 	if (XE_IOCTL_DBG(xe, err)) {
 		mutex_destroy(&d->lock);
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
index c85f86322c89..fc46d80a0b60 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.h
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -59,6 +59,10 @@ void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q)
 
 void xe_eudebug_vm_bind_execute(struct xe_vm *vm, struct xe_vma_ops *ops);
 
+void xe_eudebug_ufence_init(struct xe_user_fence *ufence);
+void xe_eudebug_ufence_fini(struct xe_user_fence *ufence);
+bool xe_eudebug_ufence_track(struct xe_user_fence *ufence);
+
 #else
 
 static inline int xe_eudebug_connect_ioctl(struct drm_device *dev,
@@ -78,6 +82,11 @@ static inline void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_e
 static inline void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q) { }
 
 static inline void xe_eudebug_vm_bind_execute(struct xe_vm *vm, struct xe_vma_ops *ops) { }
+
+static inline void xe_eudebug_ufence_init(struct xe_user_fence *ufence) { }
+static inline void xe_eudebug_ufence_fini(struct xe_user_fence *ufence) { }
+static inline bool xe_eudebug_ufence_track(struct xe_user_fence *ufence) { return false; }
+
 #endif /* CONFIG_DRM_XE_EUDEBUG */
 
 #endif /* _XE_EUDEBUG_H_ */
diff --git a/drivers/gpu/drm/xe/xe_eudebug_types.h b/drivers/gpu/drm/xe/xe_eudebug_types.h
index 008fa4bdb316..a8a440c62c4f 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_types.h
+++ b/drivers/gpu/drm/xe/xe_eudebug_types.h
@@ -9,6 +9,7 @@
 #include <linux/kfifo.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
+#include <linux/rbtree.h>
 #include <linux/rhashtable.h>
 #include <linux/sizes.h>
 #include <linux/wait.h>
@@ -32,7 +33,7 @@ enum xe_eudebug_cap_state {
 	XE_EUDEBUG_CAP_ENABLED,
 };
 
-#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_VM_BIND_OP_DEBUG_DATA
+#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_VM_BIND_UFENCE
 
 /**
  * struct xe_eudebug_handle - eudebug resource handle
@@ -175,6 +176,12 @@ struct xe_eudebug {
 		 */
 		atomic64_t seqno;
 	} events;
+
+	/** @acks: user fence acks tracked by this debugger */
+	struct {
+		/** @acks.tree: pending acks by seqnos */
+		struct rb_root tree;
+	} acks;
 };
 
 #endif /* _XE_EUDEBUG_TYPES_H_ */
diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index 48a38d64a42a..3812420a5b97 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -17,27 +17,20 @@
 #include <uapi/drm/xe_drm.h>
 
 #include "xe_device.h"
+#include "xe_eudebug.h"
 #include "xe_exec_queue.h"
 #include "xe_macros.h"
 #include "xe_sched_job_types.h"
 
-struct xe_user_fence {
-	struct xe_device *xe;
-	struct kref refcount;
-	struct dma_fence_cb cb;
-	struct work_struct worker;
-	struct mm_struct *mm;
-	u64 __user *addr;
-	u64 value;
-	int signalled;
-};
-
 static void user_fence_destroy(struct kref *kref)
 {
 	struct xe_user_fence *ufence = container_of(kref, struct xe_user_fence,
 						 refcount);
 
 	mmdrop(ufence->mm);
+
+	xe_eudebug_ufence_fini(ufence);
+
 	kfree(ufence);
 }
 
@@ -51,7 +44,8 @@ static void user_fence_put(struct xe_user_fence *ufence)
 	kref_put(&ufence->refcount, user_fence_destroy);
 }
 
-static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
+static struct xe_user_fence *user_fence_create(struct xe_device *xe,
+					       u64 addr,
 					       u64 value)
 {
 	struct xe_user_fence *ufence;
@@ -72,14 +66,23 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
 	ufence->mm = current->mm;
 	mmgrab(ufence->mm);
 
+	xe_eudebug_ufence_init(ufence);
+
 	return ufence;
 }
 
-static void user_fence_worker(struct work_struct *w)
+void xe_sync_ufence_signal(struct xe_user_fence *ufence)
 {
-	struct xe_user_fence *ufence = container_of(w, struct xe_user_fence, worker);
+	/*
+	 * Each ufence has one signaller: user_fence_worker() for one the
+	 * debugger does not track, and ufence_signal_worker() for one it
+	 * does, which handle_ack() queues only once. The xchg() makes
+	 * signalling idempotent regardless. Waiters are woken only after the
+	 * state update, so the UMD can reuse the ufence without hitting -EBUSY.
+	 */
+	if (xchg(&ufence->signalled, 1))
+		return;
 
-	WRITE_ONCE(ufence->signalled, 1);
 	if (mmget_not_zero(ufence->mm)) {
 		kthread_use_mm(ufence->mm);
 		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
@@ -90,11 +93,17 @@ static void user_fence_worker(struct work_struct *w)
 		drm_dbg(&ufence->xe->drm, "mmget_not_zero() failed, ufence wasn't signaled\n");
 	}
 
-	/*
-	 * Wake up waiters only after updating the ufence state, allowing the UMD
-	 * to safely reuse the same ufence without encountering -EBUSY errors.
-	 */
 	wake_up_all(&ufence->xe->ufence_wq);
+}
+
+static void user_fence_worker(struct work_struct *w)
+{
+	struct xe_user_fence *ufence = container_of(w, struct xe_user_fence, worker);
+
+	/* Lets see if debugger wants to track this */
+	if (!xe_eudebug_ufence_track(ufence))
+		xe_sync_ufence_signal(ufence);
+
 	user_fence_put(ufence);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_sync.h b/drivers/gpu/drm/xe/xe_sync.h
index 6b949194acff..457480656794 100644
--- a/drivers/gpu/drm/xe/xe_sync.h
+++ b/drivers/gpu/drm/xe/xe_sync.h
@@ -8,7 +8,9 @@
 
 #include "xe_sync_types.h"
 
+struct dma_fence;
 struct drm_syncobj;
+struct drm_xe_sync;
 struct xe_device;
 struct xe_exec_queue;
 struct xe_file;
@@ -45,5 +47,6 @@ struct xe_user_fence *__xe_sync_ufence_get(struct xe_user_fence *ufence);
 struct xe_user_fence *xe_sync_ufence_get(struct xe_sync_entry *sync);
 void xe_sync_ufence_put(struct xe_user_fence *ufence);
 int xe_sync_ufence_get_status(struct xe_user_fence *ufence);
+void xe_sync_ufence_signal(struct xe_user_fence *ufence);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sync_types.h b/drivers/gpu/drm/xe/xe_sync_types.h
index b88f1833e28c..aa5fff7b89c2 100644
--- a/drivers/gpu/drm/xe/xe_sync_types.h
+++ b/drivers/gpu/drm/xe/xe_sync_types.h
@@ -6,13 +6,32 @@
 #ifndef _XE_SYNC_TYPES_H_
 #define _XE_SYNC_TYPES_H_
 
+#include <linux/dma-fence-array.h>
+#include <linux/kref.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
-struct drm_syncobj;
-struct dma_fence;
-struct dma_fence_chain;
-struct drm_xe_sync;
-struct user_fence;
+struct xe_user_fence {
+	struct xe_device *xe;
+	struct kref refcount;
+	struct dma_fence_cb cb;
+	struct work_struct worker;
+	struct mm_struct *mm;
+	u64 __user *addr;
+	u64 value;
+	int signalled;
+
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+	struct {
+		/** @lock: guards access to eudebug struct members */
+		spinlock_t lock;
+		struct xe_eudebug *debugger;
+		u64 bind_ref_seqno;
+		u64 signalled_seqno;
+		struct work_struct worker;
+	} eudebug;
+#endif
+};
 
 struct xe_sync_entry {
 	struct drm_syncobj *syncobj;
diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
index 8d0b424be20d..f5ac97b5ebf9 100644
--- a/include/uapi/drm/xe_drm_eudebug.h
+++ b/include/uapi/drm/xe_drm_eudebug.h
@@ -39,6 +39,7 @@ extern "C" {
  * assume it saw everything the target did.
  */
 #define DRM_XE_EUDEBUG_IOCTL_READ_EVENT		_IOWR('j', 0x40, struct drm_xe_eudebug_event)
+#define DRM_XE_EUDEBUG_IOCTL_ACK_EVENT		_IOW('j', 0x41, struct drm_xe_eudebug_ack)
 
 /**
  * struct drm_xe_eudebug_event - Base type of event delivered by xe_eudebug.
@@ -61,6 +62,10 @@ extern "C" {
  * created, destroyed, or if its state changed. Must be zero in the read
  * request.
  *
+ * If DRM_XE_EUDEBUG_EVENT_NEED_ACK is set, xe_eudebug
+ * will hold the said resource until it is acked by userspace
+ * using the acking ioctl with the seqno of the said event.
+ *
  * %DRM_XE_EUDEBUG_EVENT_NONE and %DRM_XE_EUDEBUG_EVENT_READ are never
  * delivered: the first is unused and the second is the request type for
  * the read ioctl.
@@ -82,12 +87,14 @@ struct drm_xe_eudebug_event {
 #define DRM_XE_EUDEBUG_EVENT_EXEC_QUEUE		3
 #define DRM_XE_EUDEBUG_EVENT_VM_BIND		4
 #define DRM_XE_EUDEBUG_EVENT_VM_BIND_OP_DEBUG_DATA	5
+#define DRM_XE_EUDEBUG_EVENT_VM_BIND_UFENCE	6
 
 	/** @flags: Flags */
 	__u16 flags;
 #define DRM_XE_EUDEBUG_EVENT_CREATE		(1 << 0)
 #define DRM_XE_EUDEBUG_EVENT_DESTROY		(1 << 1)
 #define DRM_XE_EUDEBUG_EVENT_STATE_CHANGE	(1 << 2)
+#define DRM_XE_EUDEBUG_EVENT_NEED_ACK		(1 << 3)
 
 	/**
 	 * @seqno: Sequence number, for the debugger to construct a timeline.
@@ -104,8 +111,10 @@ struct drm_xe_eudebug_event {
 	 * instead of silently dropping it.
 	 *
 	 * Use this to order and correlate the events that have been read,
-	 * which is what timeline means here. Do not use it as a delivery
-	 * order guarantee.
+	 * which is what timeline means here, and to refer back to an earlier
+	 * event: %DRM_XE_EUDEBUG_EVENT_VM_BIND_UFENCE and
+	 * &drm_xe_eudebug_ack.seqno identify the event they belong to this
+	 * way. Do not use it as a delivery order guarantee.
 	 */
 	__u64 seqno;
 
@@ -167,15 +176,19 @@ struct drm_xe_eudebug_event_exec_queue {
  * sequence will be created (for the debugger)::
  *
  *  ┌───────────────────────┐
- *  │  EVENT_VM_BIND        ├──────────────────┬─┐
- *  └───────────────────────┘                  │ │
- *      ┌──────────────────────────────────┐   │ │
- *      │ EVENT_VM_BIND_OP_DEBUG_DATA #1   ├───┘ │
- *      └──────────────────────────────────┘     │
- *                      ...                      │
- *      ┌──────────────────────────────────┐     │
- *      │ EVENT_VM_BIND_OP_DEBUG_DATA #n   ├─────┘
- *      └──────────────────────────────────┘
+ *  │  EVENT_VM_BIND        ├──────────────────┬─┬┄┐
+ *  └───────────────────────┘                  │ │ ┊
+ *      ┌──────────────────────────────────┐   │ │ ┊
+ *      │ EVENT_VM_BIND_OP_DEBUG_DATA #1   ├───┘ │ ┊
+ *      └──────────────────────────────────┘     │ ┊
+ *                      ...                      │ ┊
+ *      ┌──────────────────────────────────┐     │ ┊
+ *      │ EVENT_VM_BIND_OP_DEBUG_DATA #n   ├─────┘ ┊
+ *      └──────────────────────────────────┘       ┊
+ *                                                 ┊
+ *      ┌┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┐       ┊
+ *      ┊ EVENT_UFENCE                     ├┄┄┄┄┄┄┄┘
+ *      └┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┘
  *
  * Discovery replays the debug data a vm already has the same way: one
  * VM_BIND for the vm, with @flags zero, followed by an
@@ -184,6 +197,30 @@ struct drm_xe_eudebug_event_exec_queue {
  *
  * All the events below VM_BIND will reference the VM_BIND
  * they associate with, by field .vm_bind_ref_seqno.
+ *
+ * EVENT_UFENCE only follows a VM_BIND with
+ * %DRM_XE_EUDEBUG_EVENT_VM_BIND_FLAG_UFENCE set in @flags, which is set
+ * when the client attached a sync of type %DRM_XE_SYNC_TYPE_USER_FENCE to
+ * its vm_bind_ioctl(). The user fence of a bind without debug data
+ * operations, which sends no VM_BIND, is neither reported nor held.
+ * EVENT_UFENCE is not sent, even with the flag set, if the
+ * vm_bind_ioctl() fails after the ops were executed and the fence is
+ * never signalled.
+ *
+ * When EVENT_UFENCE is sent by the driver, all the operations of the
+ * original vm_bind_ioctl() have completed, not only its debug data ones.
+ * Memory in a debug data [addr, range] is then present if this bind or an
+ * earlier one mapped it. Accessing it before the related EVENT_UFENCE
+ * leads to undefined results, as bind operations are asynchronous and the
+ * backing storage might not be there yet when VM_BIND is received.
+ *
+ * Client's UFENCE sync will be held by the driver: client's
+ * drm_xe_wait_ufence will not complete and the value of the ufence
+ * won't appear until ufence is acked by the debugger process calling
+ * DRM_XE_EUDEBUG_IOCTL_ACK_EVENT with the event_ufence.base.seqno.
+ * This will signal the fence, .value will update and the wait will
+ * complete allowing the client to continue.
+ *
  */
 struct drm_xe_eudebug_event_vm_bind {
 	/** @base: Base event */
@@ -192,8 +229,14 @@ struct drm_xe_eudebug_event_vm_bind {
 	/** @vm_handle: VM handle for this bind */
 	__u64 vm_handle;
 
-	/** @flags: Bind specific flags, none are defined yet so always zero */
+	/**
+	 * @flags: Bind specific flags
+	 *
+	 * %DRM_XE_EUDEBUG_EVENT_VM_BIND_FLAG_UFENCE: the bind has a user
+	 * fence attached, so EVENT_UFENCE may follow, see above.
+	 */
 	__u32 flags;
+#define DRM_XE_EUDEBUG_EVENT_VM_BIND_FLAG_UFENCE (1 << 0)
 
 	/** @num_bind_ops: How many [ADD|REMOVE]_DEBUG_DATA operations this bind has */
 	__u32 num_bind_ops;
@@ -251,6 +294,56 @@ struct drm_xe_eudebug_event_vm_bind_op_debug_data {
 	char pathname[];
 };
 
+/**
+ * struct drm_xe_eudebug_event_vm_bind_ufence - User Fence Event
+ *
+ * Delivered when the operations of a vm bind reported as a
+ * %DRM_XE_EUDEBUG_EVENT_VM_BIND with
+ * %DRM_XE_EUDEBUG_EVENT_VM_BIND_FLAG_UFENCE have completed, before the
+ * client's user fence for that bind is signalled. See
+ * :c:type:`drm_xe_eudebug_event_vm_bind`. This event will have
+ * %DRM_XE_EUDEBUG_EVENT_CREATE and %DRM_XE_EUDEBUG_EVENT_NEED_ACK set in
+ * :c:member:`drm_xe_eudebug_event.flags` and upon receiving this event
+ * you need to ack it with DRM_XE_EUDEBUG_IOCTL_ACK_EVENT, see
+ * :c:type:`drm_xe_eudebug_ack`.
+ */
+struct drm_xe_eudebug_event_vm_bind_ufence {
+	/** @base: Base event */
+	struct drm_xe_eudebug_event base;
+
+	/** @vm_bind_ref_seqno: Parent :c:member:`drm_xe_eudebug_event_vm_bind.base.seqno` */
+	__u64 vm_bind_ref_seqno;
+};
+
+/**
+ * struct drm_xe_eudebug_ack - Deliver ack for an event
+ *
+ * If event base.flags has DRM_XE_EUDEBUG_EVENT_NEED_ACK set,
+ * then the associated resource processing is held for client and
+ * thus held for the debugger. In order to release the client,
+ * ack needs to be delivered with DRM_XE_EUDEBUG_IOCTL_ACK_EVENT.
+ * Each such event is acked once. When the connection is disconnected,
+ * including by the debugger closing it, everything still held is
+ * released as if acked.
+ *
+ * The ioctl returns -EINVAL if @seqno is not that of an event waiting for an
+ * ack, which includes one already acked, and -ENOTCONN once the
+ * connection has been disconnected.
+ */
+struct drm_xe_eudebug_ack {
+	/** @type: Type, must be zero */
+	__u32 type;
+
+	/** @flags: Flags, must be zero */
+	__u32 flags;
+
+	/** @seqno: Seqno of event that is to be acked */
+	__u64 seqno;
+
+	/** @reserved: Reserved field, must be zero. */
+	__u64 reserved;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.53.0

