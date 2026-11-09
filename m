Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037F606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cCmvXIRn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD09C10F329;
	Mon,  9 Nov 2026 13:57:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F9D10F312;
 Mon,  9 Nov 2026 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232624; x=1825768624;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=No7AJmzABo404AC4vG/5umCRfx/qYcirfFAU6TqYXFs=;
 b=cCmvXIRnstRCnJTFfZuBgQ5e2eiCfLIFRgYtOfwGvxH+NgENpbQpv+PO
 U5eJrrTvDad8cYx7t66r187AZu17+71rqEt6FJNezVYbrtFDJ1MqdUE/j
 mGaeZTJig5oH/fqrRBxFpeOok8ElKnS7b8puHGaJOhDuKmys35JKZ1r8O
 8efXPsbS6UmXjIC6Ns1EbY6sKi2v/lKmrK890o42qJIjJCtmkLPPLrSrS
 74HawG72eiKOgDyokWqNtWOhYOnXPcCBhMNAXqQjOHIJnoNISA3HOjvT6
 e8wCLxNrhFDUC1HCeZhddcyhFJIkgcDSqHdaNcTVzcBEFAa1znEfNfv4n Q==;
X-CSE-ConnectionGUID: TScT3yJIROiOMXfdgLHOMw==
X-CSE-MsgGUID: h/PFHQEoSjOjAtxQKVjdgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850851"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850851"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:04 -0800
X-CSE-ConnectionGUID: ZjDf6ZnBQemeeVPVjoM/Ng==
X-CSE-MsgGUID: +96Sn985Q86h5GoC/cHVxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202786"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:59 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Christoph Manszewski <christoph.manszewski@intel.com>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 11/20] drm/xe/eudebug: Introduce vm bind and vm bind debug
 data events
Date: Mon,  9 Nov 2026 15:55:36 +0200
Message-ID: <20261109135549.4128280-12-mika.kuoppala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christoph Manszewski <christoph.manszewski@intel.com>

Add events to track the bind ioctl and associated debug data add and
remove operations, as a single bind can involve multiple operations
and may fail mid-process.

Add a bind event to signal to the debugger when a bind operation is
executed. Further add debug data add and remove operations so the
debugger can keep track of regions where they reside. The bind event
is important as we will want to include the ufence event later in the
series and tie it to this bind.

Only deliver bind+operations to the debugger if the vm bind
op execution chain succeeds.

v2: - avoid sending bind if there are no operations (Mika)
    - documentation (Christoph, Mika)
v3: - use removed field dd for removing
v4: - fix potential null deref (Sashiko)
v5: - skip non lr vms in discovery (Sashiko)
v6: - look up the debugger under a spinlock of its own instead of
      eudebug.lock, which the vm bind cannot take under the reservation
      once eudebug enable checks for OA streams (lockdep) (Mika)
v7: - async disconnect under the debugger lock, wq moved here (Mika)
v8: - document the async disconnect window (Sashiko)

Signed-off-by: Christoph Manszewski <christoph.manszewski@intel.com>
Co-developed-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 Documentation/gpu/xe/xe_eudebug.rst   |   6 +
 drivers/gpu/drm/xe/xe_device.c        |   1 +
 drivers/gpu/drm/xe/xe_device_types.h  |  11 +
 drivers/gpu/drm/xe/xe_eudebug.c       | 344 +++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_eudebug.h       |   7 +
 drivers/gpu/drm/xe/xe_eudebug_types.h |  12 +-
 drivers/gpu/drm/xe/xe_vm.c            |   4 +
 include/uapi/drm/xe_drm_eudebug.h     |  98 +++++++-
 8 files changed, 470 insertions(+), 13 deletions(-)

diff --git a/Documentation/gpu/xe/xe_eudebug.rst b/Documentation/gpu/xe/xe_eudebug.rst
index f3152a13e250..71a8441e04cf 100644
--- a/Documentation/gpu/xe/xe_eudebug.rst
+++ b/Documentation/gpu/xe/xe_eudebug.rst
@@ -68,3 +68,9 @@ Resource Event Types
 
 .. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
    :identifiers: drm_xe_eudebug_event_exec_queue
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_event_vm_bind
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_event_vm_bind_op_debug_data
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index d11429a69325..6968ae9cc300 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -119,6 +119,7 @@ static int xe_file_open(struct drm_device *dev, struct drm_file *file)
 
 #if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
 	init_rwsem(&xef->eudebug.ioctl_lock);
+	spin_lock_init(&xef->eudebug.lock);
 #endif
 
 	file->driver_priv = xef;
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 6375a74414d3..72747cb6b4f6 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -639,6 +639,9 @@ struct xe_device {
 
 		/** @eudebug.lock: protects the eudebug state of this device */
 		struct mutex lock;
+
+		/** @eudebug.wq: used for the async session disconnect */
+		struct workqueue_struct *wq;
 	} eudebug;
 #endif
 
@@ -736,6 +739,14 @@ struct xe_file {
 		/** @eudebug.debugger: the debugger connection into this xe_file */
 		struct xe_eudebug *debugger;
 
+		/**
+		 * @eudebug.lock: protects @eudebug.debugger. Writers hold
+		 * xe->eudebug.lock as well, lookups take only this, so that
+		 * they nest inside any lock the caller holds, the vm
+		 * reservation of a vm bind included.
+		 */
+		spinlock_t lock;
+
 		/**
 		 * @eudebug.ioctl_lock: excludes the ioctls that mutate the
 		 * eudebug visible resources of this client, so that a writer
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index 0f8b0452f9ba..c6d08b27042d 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -5,6 +5,7 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/cleanup.h>
+#include <linux/dma-resv.h>
 #include <linux/poll.h>
 #include <linux/uaccess.h>
 
@@ -13,6 +14,7 @@
 #include <uapi/drm/xe_drm.h>
 
 #include "xe_assert.h"
+#include "xe_debug_data_types.h"
 #include "xe_device.h"
 #include "xe_eudebug.h"
 #include "xe_eudebug_types.h"
@@ -314,7 +316,8 @@ static bool xe_eudebug_detach(struct xe_eudebug *d,
 
 	if (target) {
 		XE_WARN_ON(target->eudebug.debugger != d);
-		target->eudebug.debugger = NULL;
+		scoped_guard(spinlock, &target->eudebug.lock)
+			target->eudebug.debugger = NULL;
 
 		d->xe->eudebug.attached--;
 
@@ -340,6 +343,44 @@ static bool xe_eudebug_detach(struct xe_eudebug *d,
 		       __disc_err, __func__, __LINE__); \
 })
 
+static void disconnect_work_fn(struct work_struct *work)
+{
+	struct xe_eudebug *d = container_of(work, typeof(*d), disconnect_work);
+	int err;
+
+	scoped_guard(mutex, &d->lock)
+		err = d->disconnect_err;
+
+	xe_eudebug_disconnect(d, err);
+	xe_eudebug_put(d);
+}
+
+/*
+ * xe_eudebug_detach() takes xe->eudebug.lock, which must not be taken
+ * under a vm reservation, see @eudebug.lock of struct xe_file. A producer
+ * that holds one, the vm bind, hands the detach to a worker instead. The
+ * first error is the one that broke the session, so only that is kept.
+ *
+ * Until the worker runs, the session still reads as attached: the
+ * debugger can read what was queued, and producers can still queue. That
+ * leaves nothing behind, the debugger discards the session on -ENOTCONN
+ * anyway.
+ */
+static void xe_eudebug_disconnect_async(struct xe_eudebug *d, int err)
+{
+	XE_WARN_ON(err >= 0);
+
+	scoped_guard(mutex, &d->lock) {
+		if (d->disconnect_err)
+			return;
+
+		d->disconnect_err = err;
+	}
+
+	kref_get(&d->ref);
+	queue_work(d->xe->eudebug.wq, &d->disconnect_work);
+}
+
 static int event_fifo_pending(struct xe_eudebug *d,
 			      struct drm_xe_eudebug_event **pending)
 {
@@ -404,14 +445,13 @@ bool xe_eudebug_is_enabled(struct xe_device *xe)
 static struct xe_eudebug *
 __xe_eudebug_get(struct xe_file *xef)
 {
-	struct xe_device *xe = xef->xe;
 	struct xe_eudebug *d;
 
-	mutex_lock(&xe->eudebug.lock);
+	spin_lock(&xef->eudebug.lock);
 	d = xef->eudebug.debugger;
 	if (d && !kref_get_unless_zero(&d->ref))
 		d = NULL;
-	mutex_unlock(&xe->eudebug.lock);
+	spin_unlock(&xef->eudebug.lock);
 
 	if (d && xe_eudebug_is_detached(d)) {
 		xe_eudebug_put(d);
@@ -706,7 +746,8 @@ xe_eudebug_prepare_event(struct xe_eudebug *d, u16 type, u64 seqno, u16 flags,
 {
 	const u16 known_flags =
 		DRM_XE_EUDEBUG_EVENT_CREATE |
-		DRM_XE_EUDEBUG_EVENT_DESTROY;
+		DRM_XE_EUDEBUG_EVENT_DESTROY |
+		DRM_XE_EUDEBUG_EVENT_STATE_CHANGE;
 	struct drm_xe_eudebug_event *event = d->events.staging;
 
 	lockdep_assert_held(&d->lock);
@@ -1061,6 +1102,252 @@ void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q)
 	xe_eudebug_put(d);
 }
 
+static int send_vm_bind_event(struct xe_eudebug *d,
+			      u64 vm_handle,
+			      u32 bind_flags,
+			      u32 num_ops, u64 seqno)
+{
+	struct drm_xe_eudebug_event_vm_bind *e;
+	struct drm_xe_eudebug_event *event;
+	const u32 sz = sizeof(*e);
+	const u32 base_flags = DRM_XE_EUDEBUG_EVENT_STATE_CHANGE;
+	int err;
+
+	mutex_lock(&d->lock);
+	event = xe_eudebug_prepare_event(d, DRM_XE_EUDEBUG_EVENT_VM_BIND,
+					 seqno, base_flags, sz);
+	e = cast_event(e, event);
+
+	e->vm_handle = vm_handle;
+	e->flags = bind_flags;
+	e->num_bind_ops = num_ops;
+
+	err = xe_eudebug_queue_event(d, event);
+	mutex_unlock(&d->lock);
+
+	return err;
+}
+
+static int vm_bind_event(struct xe_eudebug *d,
+			 struct xe_vm *vm,
+			 u32 flags,
+			 u32 num_ops,
+			 u64 *seqno)
+{
+	int h_vm;
+
+	/*
+	 * Stamped at generation, see @events.seqno in xe_eudebug_types.h,
+	 * and before the vm lookup: a vm handle still found here is destroyed
+	 * with a later seqno than this bind. One already gone drops the bind
+	 * with -ENOENT, see xe_eudebug_vm_bind_execute().
+	 */
+	*seqno = atomic64_inc_return(&d->events.seqno);
+
+	h_vm = find_handle(d, XE_EUDEBUG_RES_TYPE_VM, vm);
+	if (h_vm < 0)
+		return h_vm;
+
+	return send_vm_bind_event(d, h_vm, flags, num_ops, *seqno);
+}
+
+static int vm_bind_op_event(struct xe_eudebug *d,
+			    const u32 flags,
+			    const u64 bind_ref_seqno,
+			    const struct xe_debug_data *debug_data)
+{
+	struct drm_xe_eudebug_event_vm_bind_op_debug_data *e;
+	struct drm_xe_eudebug_event *event;
+	const bool pseudo = debug_data->flags & DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO;
+	/* NUL included, so that the debugger can read the tail as a string */
+	const size_t path_sz = pseudo ? 0 : strlen(debug_data->pathname) + 1;
+	const u32 sz = round_up(struct_size(e, pathname, path_sz), 8);
+	u64 seqno;
+	int err;
+
+	/* A path of the size the bind extension accepts has to fit an event */
+	BUILD_BUG_ON(sizeof(*e) +
+		     sizeof_field(struct drm_xe_vm_bind_op_ext_debug_data, pathname) >
+		     XE_EUDEBUG_EVENT_MAX_SIZE);
+
+	seqno = atomic64_inc_return(&d->events.seqno);
+
+	mutex_lock(&d->lock);
+	event = xe_eudebug_prepare_event(d, DRM_XE_EUDEBUG_EVENT_VM_BIND_OP_DEBUG_DATA,
+					 seqno, flags, sz);
+	e = cast_event(e, event);
+
+	e->vm_bind_ref_seqno = bind_ref_seqno;
+	e->addr = debug_data->addr;
+	e->range = debug_data->range;
+	e->flags = debug_data->flags;
+	e->offset = debug_data->offset;
+
+	/*
+	 * The event is sized to the path, and xe_eudebug_prepare_event() has
+	 * zeroed it, so the terminator and any alignment padding are there
+	 * without writing them.
+	 */
+	if (pseudo)
+		e->pseudopath = debug_data->pseudopath;
+	else
+		memcpy(e->pathname, debug_data->pathname, path_sz - 1);
+
+	err = xe_eudebug_queue_event(d, event);
+	mutex_unlock(&d->lock);
+
+	return err;
+}
+
+/*
+ * The debug data entry a bind op adds or removes, and the event flag for
+ * it, or NULL if the op is not a debug data op. vm_bind_ioctl_check_args()
+ * requires the extension, so a debug data op always has its entry here.
+ * Counting and sending both go through this, so that num_bind_ops always
+ * matches the op events that follow.
+ */
+static const struct xe_debug_data *bind_op_debug_data(struct xe_vma_op *op,
+						      u32 *flags)
+{
+	if (op->base.op != DRM_GPUVA_OP_DRIVER)
+		return NULL;
+
+	if (op->subop == XE_VMA_SUBOP_ADD_DEBUG_DATA) {
+		*flags = DRM_XE_EUDEBUG_EVENT_CREATE;
+		return op->modify_debug_data.added;
+	}
+
+	if (op->subop == XE_VMA_SUBOP_REMOVE_DEBUG_DATA) {
+		*flags = DRM_XE_EUDEBUG_EVENT_DESTROY;
+		return op->modify_debug_data.removed;
+	}
+
+	return NULL;
+}
+
+void xe_eudebug_vm_bind_execute(struct xe_vm *vm,
+				struct xe_vma_ops *ops)
+{
+	struct xe_eudebug *d;
+	struct xe_vma_op *op;
+	u64 bind_seqno = 0;
+	u32 num_ops;
+	int err;
+
+	if (!xe_vm_in_fault_mode(vm))
+		return;
+
+	d = xe_eudebug_get(vm->xef);
+	if (!d)
+		return;
+
+	num_ops = 0;
+	list_for_each_entry(op, &ops->list, link) {
+		u32 flags;
+
+		if (bind_op_debug_data(op, &flags))
+			num_ops++;
+	}
+
+	lockdep_assert_held(&vm->lock);
+
+	if (!num_ops) {
+		xe_eudebug_put(d);
+		return;
+	}
+
+	err = vm_bind_event(d, vm, 0,
+			    num_ops, &bind_seqno);
+	if (err)
+		goto out_err;
+
+	list_for_each_entry(op, &ops->list, link) {
+		const struct xe_debug_data *dd;
+		u32 flags;
+
+		dd = bind_op_debug_data(op, &flags);
+		if (!dd)
+			continue;
+
+		err = vm_bind_op_event(d, flags, bind_seqno, dd);
+		if (err)
+			goto out_err;
+	}
+
+out_err:
+	/*
+	 * -ENOENT is vm_bind_event() not finding the vm: a racing
+	 * DRM_XE_VM_DESTROY has already removed it and told the debugger, so
+	 * there is nothing left to report the bind against.
+	 */
+	if (err && err != -ENOENT)
+		xe_eudebug_disconnect_async(d, err);
+
+	xe_eudebug_put(d);
+}
+
+static int vm_discover_binds(struct xe_eudebug *d, struct xe_vm *vm,
+			     unsigned int *ops_count)
+{
+	struct xe_debug_data *dd;
+	struct list_head *pos;
+	unsigned int count;
+	u64 ref_seqno;
+	int err;
+
+	/*
+	 * Only fault mode vms are announced to the debugger, so only those
+	 * have a handle to reference here. Nothing stops a client adding
+	 * debug data to another vm, and without this the bind event below
+	 * would fail to resolve the vm and take down the whole discovery.
+	 * Matches xe_eudebug_vm_bind_execute().
+	 */
+	if (!xe_vm_in_fault_mode(vm))
+		return 0;
+
+	/*
+	 * Walked without vm->debug_data.lock. The caller holds the target's
+	 * eudebug.ioctl_lock for write, and everything that adds to or
+	 * removes from this list runs under DRM_XE_VM_BIND, which takes that
+	 * same rwsem for read, so the list cannot change under us here.
+	 */
+	if (list_empty(&vm->debug_data.list))
+		return 0;
+
+	count = 0;
+	list_for_each(pos, &vm->debug_data.list)
+		count++;
+
+	ref_seqno = 0;
+	err = vm_bind_event(d, vm, 0, count, &ref_seqno);
+	if (err) {
+		eu_dbg(d, "vm_bind_event error %d\n", err);
+		goto out_err;
+	}
+
+	list_for_each_entry(dd, &vm->debug_data.list, link) {
+		err = vm_bind_op_event(d, DRM_XE_EUDEBUG_EVENT_CREATE, ref_seqno, dd);
+		if (err) {
+			eu_dbg(d, "vm_bind_op_event error %d\n", err);
+			goto out_err;
+		}
+	}
+
+	*ops_count += count;
+
+	return 0;
+
+out_err:
+	/*
+	 * The event helpers leave the disconnect to their caller. Do it before
+	 * discovery lets the target's ioctls in again, as the other discovery
+	 * events do.
+	 */
+	xe_eudebug_disconnect(d, err);
+
+	return err;
+}
+
 /*
  * All the relevant ioctls that manipulate the xe_file resources eudebug
  * cares about are gated behind down_read(&xef->eudebug.ioctl_lock). The
@@ -1072,7 +1359,7 @@ static int discover_client(struct xe_eudebug *d, struct xe_file *xef)
 	struct xe_exec_queue *q;
 	struct xe_vm *vm;
 	unsigned long i;
-	unsigned int vm_count = 0, eq_count = 0;
+	unsigned int vm_count = 0, eq_count = 0, ops_count = 0;
 	int err = 0;
 
 	lockdep_assert_held_write(&xef->eudebug.ioctl_lock);
@@ -1089,6 +1376,10 @@ static int discover_client(struct xe_eudebug *d, struct xe_file *xef)
 		if (err)
 			goto out;
 		vm_count++;
+
+		err = vm_discover_binds(d, vm, &ops_count);
+		if (err)
+			goto out;
 	}
 
 	xa_for_each(&xef->exec_queue.xa, i, q) {
@@ -1103,9 +1394,9 @@ static int discover_client(struct xe_eudebug *d, struct xe_file *xef)
 	}
 
 out:
-	if (vm_count || eq_count)
-		eu_dbg(d, "Discovery found %u vms, %u exec_queues",
-		       vm_count, eq_count);
+	if (vm_count || eq_count || ops_count)
+		eu_dbg(d, "Discovery found %u vms, %u exec_queues, %u bind_ops",
+		       vm_count, eq_count, ops_count);
 
 	eu_dbg(d, "Discovery end for %llu: %d", d->session, err);
 
@@ -1132,7 +1423,8 @@ static int add_debugger(struct xe_device *xe, struct xe_eudebug *d,
 		d->target.xef = xe_file_get(xef);
 	d->target.pid = xef->pid;
 	kref_get(&d->ref);
-	xef->eudebug.debugger = d;
+	scoped_guard(spinlock, &xef->eudebug.lock)
+		xef->eudebug.debugger = d;
 
 	xe->eudebug.attached++;
 
@@ -1204,6 +1496,14 @@ static int xe_eudebug_release(struct inode *inode, struct file *file)
 	struct xe_eudebug *d = file->private_data;
 	struct drm_device *drm = &d->xe->drm;
 
+	/*
+	 * Let a pending disconnect record the error that broke the session.
+	 * One queued after this flush finds the session already detached; it
+	 * holds its own reference on d, and the final drm_dev_put() drains
+	 * eudebug.wq before eudebug.lock is destroyed or xe is freed.
+	 */
+	flush_work(&d->disconnect_work);
+
 	xe_eudebug_disconnect(d, 0);
 	xe_eudebug_put(d);
 
@@ -1433,17 +1733,25 @@ static const struct file_operations fops = {
 /*
  * Tell lockdep up front where the lock sits, so that a violation is
  * reported on the first run rather than once both paths have been seen.
- * Reclaim never takes it, so allocating under it is fine.
+ * It is taken under the vm reservation of a vm bind, and mmap_lock ranks
+ * above dma_resv, so touching user memory under it is caught. Reclaim
+ * never takes it, so allocating under it is fine.
  */
 static void xe_eudebug_lock_prime(struct xe_eudebug *d)
 {
+	struct dma_resv resv;
+
 	if (!IS_ENABLED(CONFIG_LOCKDEP))
 		return;
 
+	dma_resv_init(&resv);
+	dma_resv_lock(&resv, NULL);
 	mutex_lock(&d->lock);
 	fs_reclaim_acquire(GFP_KERNEL);
 	fs_reclaim_release(GFP_KERNEL);
 	mutex_unlock(&d->lock);
+	dma_resv_unlock(&resv);
+	dma_resv_fini(&resv);
 }
 
 static int
@@ -1479,6 +1787,8 @@ xe_eudebug_connect(struct xe_device *xe,
 	xe_eudebug_lock_prime(d);
 	init_waitqueue_head(&d->events.write_done);
 
+	INIT_WORK(&d->disconnect_work, disconnect_work_fn);
+
 	err = xe_eudebug_resources_init(d);
 	if (XE_IOCTL_DBG(xe, err)) {
 		mutex_destroy(&d->lock);
@@ -1655,6 +1965,7 @@ void xe_eudebug_init_early(struct xe_device *xe)
 void xe_eudebug_init(struct xe_device *xe)
 {
 	struct drm_device *dev = &xe->drm;
+	struct workqueue_struct *wq;
 	int err;
 
 	/* early init failed */
@@ -1666,6 +1977,17 @@ void xe_eudebug_init(struct xe_device *xe)
 		goto out_not_supported;
 	}
 
+	wq = alloc_workqueue("xe-eudebug", WQ_UNBOUND, 0);
+	if (!wq) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	err = drmm_add_action_or_reset(dev, __drmm_workqueue_release, wq);
+	if (err)
+		goto out_err;
+	xe->eudebug.wq = wq;
+
 	err = devm_add_action_or_reset(dev->dev, xe_eudebug_sysfs_fini, xe);
 	if (err)
 		goto out_err;
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
index ec07c567356d..c85f86322c89 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.h
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -11,10 +11,14 @@
 
 struct drm_device;
 struct drm_file;
+struct xe_debug_data;
 struct xe_device;
 struct xe_file;
 struct xe_vm;
 struct xe_exec_queue;
+struct xe_vma;
+struct xe_vma_ops;
+struct xe_user_fence;
 struct xe_eudebug;
 
 #if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
@@ -53,6 +57,8 @@ void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm);
 void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_exec_queue *q);
 void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q);
 
+void xe_eudebug_vm_bind_execute(struct xe_vm *vm, struct xe_vma_ops *ops);
+
 #else
 
 static inline int xe_eudebug_connect_ioctl(struct drm_device *dev,
@@ -71,6 +77,7 @@ static inline void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm)
 static inline void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_exec_queue *q) { }
 static inline void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q) { }
 
+static inline void xe_eudebug_vm_bind_execute(struct xe_vm *vm, struct xe_vma_ops *ops) { }
 #endif /* CONFIG_DRM_XE_EUDEBUG */
 
 #endif /* _XE_EUDEBUG_H_ */
diff --git a/drivers/gpu/drm/xe/xe_eudebug_types.h b/drivers/gpu/drm/xe/xe_eudebug_types.h
index 0cb1b3b678e4..008fa4bdb316 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_types.h
+++ b/drivers/gpu/drm/xe/xe_eudebug_types.h
@@ -12,6 +12,7 @@
 #include <linux/rhashtable.h>
 #include <linux/sizes.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 #include <linux/xarray.h>
 
 #include <uapi/drm/xe_drm_eudebug.h>
@@ -31,7 +32,7 @@ enum xe_eudebug_cap_state {
 	XE_EUDEBUG_CAP_ENABLED,
 };
 
-#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_EXEC_QUEUE
+#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_VM_BIND_OP_DEBUG_DATA
 
 /**
  * struct xe_eudebug_handle - eudebug resource handle
@@ -111,6 +112,15 @@ struct xe_eudebug {
 	/** @session: session number for this connection (for logs) */
 	u64 session;
 
+	/**
+	 * @disconnect_work: detaches the session for a producer that cannot
+	 * take xe->eudebug.lock, see xe_eudebug_disconnect_async()
+	 */
+	struct work_struct disconnect_work;
+
+	/** @disconnect_err: error @disconnect_work detaches with, first one wins */
+	int disconnect_err;
+
 	/** @events: kfifo queue of to-be-delivered events */
 	struct {
 #define XE_EUDEBUG_EVENT_MAX_SIZE SZ_64K
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 138ccdf87eb2..86929c6ad3dc 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3839,6 +3839,10 @@ static struct dma_fence *vm_bind_ioctl_ops_execute(struct xe_vm *vm,
 		xe_vm_set_validation_exec(vm, &exec);
 		fence = ops_execute(vm, vops);
 		xe_vm_set_validation_exec(vm, NULL);
+
+		if (!IS_ERR(fence) || PTR_ERR(fence) == -ENODATA)
+			xe_eudebug_vm_bind_execute(vm, vops);
+
 		if (IS_ERR(fence)) {
 			if (PTR_ERR(fence) == -ENODATA)
 				vm_bind_ioctl_ops_fini(vm, vops, NULL);
diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
index 12e905441f1d..8d0b424be20d 100644
--- a/include/uapi/drm/xe_drm_eudebug.h
+++ b/include/uapi/drm/xe_drm_eudebug.h
@@ -58,7 +58,8 @@ extern "C" {
  * order. Must be zero in the read request.
  *
  * :c:member:`drm_xe_eudebug_event.flags` will indicate if a resource was
- * created or destroyed. Must be zero in the read request.
+ * created, destroyed, or if its state changed. Must be zero in the read
+ * request.
  *
  * %DRM_XE_EUDEBUG_EVENT_NONE and %DRM_XE_EUDEBUG_EVENT_READ are never
  * delivered: the first is unused and the second is the request type for
@@ -79,11 +80,14 @@ struct drm_xe_eudebug_event {
 #define DRM_XE_EUDEBUG_EVENT_READ		1
 #define DRM_XE_EUDEBUG_EVENT_VM			2
 #define DRM_XE_EUDEBUG_EVENT_EXEC_QUEUE		3
+#define DRM_XE_EUDEBUG_EVENT_VM_BIND		4
+#define DRM_XE_EUDEBUG_EVENT_VM_BIND_OP_DEBUG_DATA	5
 
 	/** @flags: Flags */
 	__u16 flags;
 #define DRM_XE_EUDEBUG_EVENT_CREATE		(1 << 0)
 #define DRM_XE_EUDEBUG_EVENT_DESTROY		(1 << 1)
+#define DRM_XE_EUDEBUG_EVENT_STATE_CHANGE	(1 << 2)
 
 	/**
 	 * @seqno: Sequence number, for the debugger to construct a timeline.
@@ -155,6 +159,98 @@ struct drm_xe_eudebug_event_exec_queue {
 	__u64 lrc_handle[] __counted_by(width);
 };
 
+/**
+ * struct drm_xe_eudebug_event_vm_bind - VM Bind Event
+ *
+ * When the client (debuggee) calls the vm_bind_ioctl with the
+ * DRM_XE_VM_BIND_OP_[ADD|REMOVE]_DEBUG_DATA operation, the following event
+ * sequence will be created (for the debugger)::
+ *
+ *  ┌───────────────────────┐
+ *  │  EVENT_VM_BIND        ├──────────────────┬─┐
+ *  └───────────────────────┘                  │ │
+ *      ┌──────────────────────────────────┐   │ │
+ *      │ EVENT_VM_BIND_OP_DEBUG_DATA #1   ├───┘ │
+ *      └──────────────────────────────────┘     │
+ *                      ...                      │
+ *      ┌──────────────────────────────────┐     │
+ *      │ EVENT_VM_BIND_OP_DEBUG_DATA #n   ├─────┘
+ *      └──────────────────────────────────┘
+ *
+ * Discovery replays the debug data a vm already has the same way: one
+ * VM_BIND for the vm, with @flags zero, followed by an
+ * EVENT_VM_BIND_OP_DEBUG_DATA with %DRM_XE_EUDEBUG_EVENT_CREATE for each
+ * entry, as if a single bind had added them all.
+ *
+ * All the events below VM_BIND will reference the VM_BIND
+ * they associate with, by field .vm_bind_ref_seqno.
+ */
+struct drm_xe_eudebug_event_vm_bind {
+	/** @base: Base event */
+	struct drm_xe_eudebug_event base;
+
+	/** @vm_handle: VM handle for this bind */
+	__u64 vm_handle;
+
+	/** @flags: Bind specific flags, none are defined yet so always zero */
+	__u32 flags;
+
+	/** @num_bind_ops: How many [ADD|REMOVE]_DEBUG_DATA operations this bind has */
+	__u32 num_bind_ops;
+};
+
+/**
+ * struct drm_xe_eudebug_event_vm_bind_op_debug_data - VM Bind Op Debug Data Event
+ *
+ * When the target drm client issues a vm bind, each operation of type
+ * %DRM_XE_VM_BIND_OP_ADD_DEBUG_DATA or %DRM_XE_VM_BIND_OP_REMOVE_DEBUG_DATA
+ * will generate an event of this type. For reference see
+ * :c:type:`drm_xe_vm_bind_op_ext_debug_data`.
+ */
+struct drm_xe_eudebug_event_vm_bind_op_debug_data {
+	/** @base: Base event */
+	struct drm_xe_eudebug_event base;
+
+	/** @vm_bind_ref_seqno: Parent :c:member:`drm_xe_eudebug_event_vm_bind.base.seqno` */
+	__u64 vm_bind_ref_seqno;
+
+	/** @addr: Address of the debug data mapping */
+	__u64 addr;
+
+	/** @range: Range of the debug data mapping */
+	__u64 range;
+
+	/** @flags: Debug data flags */
+	__u64 flags;
+
+	/** @offset: Offset into the debug data file */
+	__u64 offset;
+
+	/** @reserved: Reserved, always zero */
+	__u64 reserved;
+
+	/**
+	 * @pseudopath: Pseudopath when
+	 * %DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO is set in @flags, zero
+	 * otherwise
+	 */
+	__u64 pseudopath;
+
+	/**
+	 * @pathname: Path to the debug data file
+	 *
+	 * Present only when %DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO is not
+	 * set in @flags, and covered by
+	 * :c:member:`drm_xe_eudebug_event.len` rather than by a fixed size:
+	 * the event is as long as the path it carries. The path is NUL
+	 * terminated and the terminator is included in @len, which may then
+	 * be padded with further zeroes to keep the event size aligned, so
+	 * read it as a string rather than taking the whole tail of the
+	 * event as the name.
+	 */
+	char pathname[];
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.53.0

