Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB3606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I9ggAX1M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A215310F304;
	Mon,  9 Nov 2026 13:56:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F065110F306;
 Mon,  9 Nov 2026 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232609; x=1825768609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q7PYS5ahW27ntJhSKcXLcP1VEHCzvkfjeOC9nu0iKv4=;
 b=I9ggAX1MYm8PaZpOb/rzAVI3xlaQAVuk0TkAjAkaS0GI6zUTh12eFg9e
 s1HzbA990SynHHBYyYIdxaAw/fp815WuTgDVAyusPzIiBxvQV3Ng6BbSX
 p8E+205z4qn/en5cYmf5LIcKYtn0+o9f2AGv2qojzdrDlVUNHGOJ9p0Ul
 3HmW7zDwO3oQ64lmuX4YMbnwKhp6SAz9WxNTYgiDaaT0U9gwysAGb89XG
 bT9t4rQutqCyI9uS49PFnJRGcczKAkZUWEr3+frcE8yqLOYWKbjHQfmb5
 4llkvDyW+l6HIJGSkFZXzoj3vFRpfGGenDtekd2lKJlS+CB8ZH48mkx1K Q==;
X-CSE-ConnectionGUID: T2F/L1MjR1i1pbeI4oiFPA==
X-CSE-MsgGUID: GYuAjBrfS4i4YKkuHdl9zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850781"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850781"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:48 -0800
X-CSE-ConnectionGUID: r+4/ogOTTsCbxa7XoeAQDA==
X-CSE-MsgGUID: 3EvEW4HET7Ck/XnSDwvVWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202707"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:43 -0800
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
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 08/20] drm/xe/eudebug: Introduce exec_queue events
Date: Mon,  9 Nov 2026 15:55:33 +0200
Message-ID: <20261109135549.4128280-9-mika.kuoppala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Grzegorzek <dominik.grzegorzek@intel.com>

Add events to inform the debugger about the creation and destruction of
exec_queues. Use user engine class types instead of the internal
xe_engine_class enum in exec_queue events. During discovery, only advertise
exec_queues with render or compute class, excluding others.

v2: - Only track long running queues
    - Checkpatch (Tilak)
v3: __counted_by added
v4: - use helpers for filtering engines (Mika)
v5: - fix lrc handles memcpy size bug (Mika)
v6: - lookup for create event (Sashiko)
    - defer engine class lookup (Sashiko)
    - avoid uninitialized read on adding handle (Sashiko)
    - too strict warn on q->width check (Sashiko)
    - create eudebug eq event early (Claude)
    - dont drop session if vm is already gone (Claude)
v7: - lookups under the debugger lock (Mika)

Signed-off-by: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 Documentation/gpu/xe/xe_eudebug.rst   |   3 +
 drivers/gpu/drm/xe/xe_eudebug.c       | 282 +++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_eudebug.h       |   7 +
 drivers/gpu/drm/xe/xe_eudebug_types.h |   6 +-
 drivers/gpu/drm/xe/xe_exec_queue.c    |   8 +-
 include/uapi/drm/xe_drm_eudebug.h     |  31 +++
 6 files changed, 330 insertions(+), 7 deletions(-)

diff --git a/Documentation/gpu/xe/xe_eudebug.rst b/Documentation/gpu/xe/xe_eudebug.rst
index 9c6070784e84..f3152a13e250 100644
--- a/Documentation/gpu/xe/xe_eudebug.rst
+++ b/Documentation/gpu/xe/xe_eudebug.rst
@@ -65,3 +65,6 @@ Resource Event Types
 
 .. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
    :identifiers: drm_xe_eudebug_event_vm
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_event_exec_queue
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index e0ef34588d3d..0f8b0452f9ba 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -16,6 +16,8 @@
 #include "xe_device.h"
 #include "xe_eudebug.h"
 #include "xe_eudebug_types.h"
+#include "xe_exec_queue.h"
+#include "xe_hw_engine.h"
 #include "xe_macros.h"
 #include "xe_sriov_pf.h"
 #include "xe_vm.h"
@@ -486,6 +488,28 @@ __find_handle(struct xe_eudebug_resource *r,
 	return h;
 }
 
+static int find_handle(struct xe_eudebug *d,
+		       const int type,
+		       const void *p)
+{
+	const u64 key = (uintptr_t)p;
+	struct xe_eudebug_resource *r;
+	struct xe_eudebug_handle *h;
+	int id;
+
+	if (XE_WARN_ON(!key))
+		return -EINVAL;
+
+	r = resource_from_type(d, type);
+
+	mutex_lock(&d->lock);
+	h = __find_handle(r, key);
+	id = h ? h->id : -ENOENT;
+	mutex_unlock(&d->lock);
+
+	return id;
+}
+
 /*
  * Adding a handle is split around d->lock: handle_prepare() allocates the
  * handle and reserves its id, __handle_insert() publishes it and stamps
@@ -799,6 +823,244 @@ void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm)
 	xe_eudebug_put(d);
 }
 
+static const u16 xe_to_user_engine_class[] = {
+	[XE_ENGINE_CLASS_RENDER] = DRM_XE_ENGINE_CLASS_RENDER,
+	[XE_ENGINE_CLASS_COPY] = DRM_XE_ENGINE_CLASS_COPY,
+	[XE_ENGINE_CLASS_VIDEO_DECODE] = DRM_XE_ENGINE_CLASS_VIDEO_DECODE,
+	[XE_ENGINE_CLASS_VIDEO_ENHANCE] = DRM_XE_ENGINE_CLASS_VIDEO_ENHANCE,
+	[XE_ENGINE_CLASS_COMPUTE] = DRM_XE_ENGINE_CLASS_COMPUTE,
+};
+
+static int send_exec_queue_event(struct xe_eudebug *d, u32 flags,
+				 u64 vm_handle, u64 exec_queue_handle,
+				 enum xe_engine_class class,
+				 u32 width, u64 *lrc_handles, u64 seqno)
+{
+	struct drm_xe_eudebug_event *event;
+	struct drm_xe_eudebug_event_exec_queue *e;
+	const u32 sz = struct_size(e, lrc_handle, width);
+	u32 xe_engine_class;
+	int err;
+
+	if (!xe_engine_supports_eudebug(class))
+		return -EINVAL;
+
+	xe_engine_class = xe_to_user_engine_class[class];
+
+	mutex_lock(&d->lock);
+	event = xe_eudebug_prepare_event(d, DRM_XE_EUDEBUG_EVENT_EXEC_QUEUE,
+					 seqno, flags, sz);
+	e = cast_event(e, event);
+
+	e->vm_handle = vm_handle;
+	e->exec_queue_handle = exec_queue_handle;
+	e->engine_class = xe_engine_class;
+	e->width = width;
+
+	memcpy(e->lrc_handle, lrc_handles, width * sizeof(u64));
+
+	err = xe_eudebug_queue_event(d, event);
+	mutex_unlock(&d->lock);
+
+	return err;
+}
+
+/*
+ * A debuggable queue needs only an LR vm, and a fault mode vm can be
+ * destroyed while its queues live on: xe_vm_destroy_ioctl() only refuses
+ * a vm with preempt fence mode queues. The debugger has then already seen
+ * the vm go, so report such a queue against vm handle 0 rather than
+ * treating the missing handle as a diverged resource map.
+ *
+ * Looked up in the critical section that stamps the queue event's seqno.
+ * A vm destroy removes the handle and stamps its own seqno under the same
+ * lock, so the handle is gone exactly when the vm destroy came first in
+ * seqno order, and a debugger replaying the events never sees a queue
+ * event on a vm it has dropped, or vm 0 for one it has not.
+ */
+static int __exec_queue_vm_handle(struct xe_eudebug *d, struct xe_exec_queue *q)
+{
+	struct xe_eudebug_handle *h;
+
+	lockdep_assert_held(&d->lock);
+
+	h = __find_handle(resource_from_type(d, XE_EUDEBUG_RES_TYPE_VM),
+			  (uintptr_t)q->vm);
+
+	return h ? h->id : 0;
+}
+
+static int exec_queue_create_event(struct xe_eudebug *d,
+				   struct xe_file *xef, struct xe_exec_queue *q)
+{
+	struct xe_eudebug_handle *h;
+	int h_vm, h_queue;
+	u64 h_lrc[XE_HW_ENGINE_MAX_INSTANCE], seqno;
+	int i;
+	int ret;
+
+	if (!xe_exec_queue_is_debuggable(q))
+		return 0;
+
+	if (XE_WARN_ON(q->width > XE_HW_ENGINE_MAX_INSTANCE))
+		return -EINVAL;
+
+	ret = 0;
+	for (i = 0; i < q->width; i++) {
+		ret = _xe_eudebug_add_handle(d,
+					     XE_EUDEBUG_RES_TYPE_LRC,
+					     q->lrc[i],
+					     NULL);
+
+		if (ret < 0)
+			break;
+
+		XE_WARN_ON(!ret);
+
+		h_lrc[i] = ret;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	h = handle_prepare(d, XE_EUDEBUG_RES_TYPE_EXEC_QUEUE, q);
+	if (IS_ERR(h))
+		return PTR_ERR(h);
+
+	scoped_guard(mutex, &d->lock) {
+		h_queue = __handle_insert(d, XE_EUDEBUG_RES_TYPE_EXEC_QUEUE, h,
+					  &seqno);
+		h_vm = __exec_queue_vm_handle(d, q);
+	}
+
+	eu_dbg(d, "exec queue %p added: %d, vm %d\n", q, h_queue, h_vm);
+
+	if (h_queue < 0) {
+		handle_abort(d, XE_EUDEBUG_RES_TYPE_EXEC_QUEUE, h);
+		return h_queue;
+	}
+
+	/* No need to cleanup for added handles on error as if we fail
+	 * we disconnect
+	 */
+
+	ret = send_exec_queue_event(d, DRM_XE_EUDEBUG_EVENT_CREATE,
+				    h_vm, h_queue, q->class,
+				    q->width, h_lrc, seqno);
+
+	if (ret)
+		eu_dbg(d, "send_exec_queue_event create error %d", ret);
+
+	return ret;
+}
+
+static int exec_queue_destroy_event(struct xe_eudebug *d,
+				    struct xe_file *xef,
+				    struct xe_exec_queue *q)
+{
+	int h_vm, h_queue;
+	u64 h_lrc[XE_HW_ENGINE_MAX_INSTANCE], seqno;
+	int i;
+	int ret, err = 0;
+
+	if (!xe_exec_queue_is_debuggable(q))
+		return 0;
+
+	/*
+	 * A queue we never handed out to the debugger needs no destroy event.
+	 * The queue handle is added last on create, so its presence implies
+	 * the lrc handles are there too. Past this point a missing handle
+	 * means our resource map and the client have diverged, and that has
+	 * to drop the session. The exception is a concurrent detach, which
+	 * empties the maps without the ioctl_lock, but only after marking us
+	 * detached.
+	 */
+	if (find_handle(d, XE_EUDEBUG_RES_TYPE_EXEC_QUEUE, q) == -ENOENT)
+		return 0;
+
+	if (XE_WARN_ON(q->width > XE_HW_ENGINE_MAX_INSTANCE))
+		return -EINVAL;
+
+	for (i = 0; i < q->width; i++) {
+		ret = _xe_eudebug_remove_handle(d,
+						XE_EUDEBUG_RES_TYPE_LRC,
+						q->lrc[i],
+						NULL);
+		if (ret < 0) {
+			XE_WARN_ON(!xe_eudebug_is_detached(d));
+			if (!err)
+				err = ret;
+			h_lrc[i] = 0;
+			continue;
+		}
+
+		XE_WARN_ON(!ret);
+		h_lrc[i] = ret;
+	}
+
+	if (err)
+		return err;
+
+	scoped_guard(mutex, &d->lock) {
+		h_queue = __xe_eudebug_remove_handle(d,
+						     XE_EUDEBUG_RES_TYPE_EXEC_QUEUE,
+						     q, &seqno);
+		h_vm = __exec_queue_vm_handle(d, q);
+	}
+
+	eu_dbg(d, "exec queue %p removed: %d, vm %d\n", q, h_queue, h_vm);
+
+	if (h_queue < 0)
+		return h_queue;
+
+	ret = send_exec_queue_event(d, DRM_XE_EUDEBUG_EVENT_DESTROY,
+				    h_vm, h_queue, q->class,
+				    q->width, h_lrc, seqno);
+
+	if (ret)
+		eu_dbg(d, "send_exec_queue_event destroy error %d\n", ret);
+
+	return ret;
+}
+
+void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_exec_queue *q)
+{
+	struct xe_eudebug *d;
+	int err;
+
+	if (!xe_engine_supports_eudebug(q->class))
+		return;
+
+	d = xe_eudebug_get(xef);
+	if (!d)
+		return;
+
+	err = exec_queue_create_event(d, xef, q);
+	if (err)
+		xe_eudebug_disconnect(d, err);
+
+	xe_eudebug_put(d);
+}
+
+void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q)
+{
+	struct xe_eudebug *d;
+	int err;
+
+	if (!xe_engine_supports_eudebug(q->class))
+		return;
+
+	d = xe_eudebug_get(xef);
+	if (!d)
+		return;
+
+	err = exec_queue_destroy_event(d, xef, q);
+	if (err)
+		xe_eudebug_disconnect(d, err);
+
+	xe_eudebug_put(d);
+}
+
 /*
  * All the relevant ioctls that manipulate the xe_file resources eudebug
  * cares about are gated behind down_read(&xef->eudebug.ioctl_lock). The
@@ -807,9 +1069,10 @@ void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm)
  */
 static int discover_client(struct xe_eudebug *d, struct xe_file *xef)
 {
+	struct xe_exec_queue *q;
 	struct xe_vm *vm;
 	unsigned long i;
-	unsigned int vm_count = 0;
+	unsigned int vm_count = 0, eq_count = 0;
 	int err = 0;
 
 	lockdep_assert_held_write(&xef->eudebug.ioctl_lock);
@@ -828,10 +1091,21 @@ static int discover_client(struct xe_eudebug *d, struct xe_file *xef)
 		vm_count++;
 	}
 
+	xa_for_each(&xef->exec_queue.xa, i, q) {
+		if (!xe_engine_supports_eudebug(q->class))
+			continue;
+
+		err = exec_queue_create_event(d, xef, q);
+		if (err)
+			goto out;
+
+		eq_count++;
+	}
+
 out:
-	if (vm_count)
-		eu_dbg(d, "Discovery found %u vms",
-		       vm_count);
+	if (vm_count || eq_count)
+		eu_dbg(d, "Discovery found %u vms, %u exec_queues",
+		       vm_count, eq_count);
 
 	eu_dbg(d, "Discovery end for %llu: %d", d->session, err);
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
index 413a45129193..ec07c567356d 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.h
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -14,6 +14,7 @@ struct drm_file;
 struct xe_device;
 struct xe_file;
 struct xe_vm;
+struct xe_exec_queue;
 struct xe_eudebug;
 
 #if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
@@ -49,6 +50,9 @@ void xe_eudebug_file_close(struct xe_file *xef);
 void xe_eudebug_vm_create(struct xe_file *xef, struct xe_vm *vm);
 void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm);
 
+void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_exec_queue *q);
+void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q);
+
 #else
 
 static inline int xe_eudebug_connect_ioctl(struct drm_device *dev,
@@ -64,6 +68,9 @@ static inline void xe_eudebug_file_close(struct xe_file *xef) { }
 static inline void xe_eudebug_vm_create(struct xe_file *xef, struct xe_vm *vm) { }
 static inline void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm) { }
 
+static inline void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_exec_queue *q) { }
+static inline void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q) { }
+
 #endif /* CONFIG_DRM_XE_EUDEBUG */
 
 #endif /* _XE_EUDEBUG_H_ */
diff --git a/drivers/gpu/drm/xe/xe_eudebug_types.h b/drivers/gpu/drm/xe/xe_eudebug_types.h
index 598abb249195..0cb1b3b678e4 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_types.h
+++ b/drivers/gpu/drm/xe/xe_eudebug_types.h
@@ -31,7 +31,7 @@ enum xe_eudebug_cap_state {
 	XE_EUDEBUG_CAP_ENABLED,
 };
 
-#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_VM
+#define XE_EUDEBUG_MAX_EVENT_TYPE DRM_XE_EUDEBUG_EVENT_EXEC_QUEUE
 
 /**
  * struct xe_eudebug_handle - eudebug resource handle
@@ -62,7 +62,9 @@ struct xe_eudebug_resource {
 };
 
 #define XE_EUDEBUG_RES_TYPE_VM		0
-#define XE_EUDEBUG_RES_TYPE_COUNT	(XE_EUDEBUG_RES_TYPE_VM + 1)
+#define XE_EUDEBUG_RES_TYPE_EXEC_QUEUE  1
+#define XE_EUDEBUG_RES_TYPE_LRC		2
+#define XE_EUDEBUG_RES_TYPE_COUNT	(XE_EUDEBUG_RES_TYPE_LRC + 1)
 
 /**
  * struct xe_eudebug - Top level struct for eudebug: the connection
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index e65bda492e58..3eeb8a108b40 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -1548,10 +1548,14 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 	if (eci[0].engine_class != DRM_XE_ENGINE_CLASS_VM_BIND)
 		xe_vm_add_exec_queue(vm, q);
 
+	xe_eudebug_exec_queue_create(xef, q);
+
 	/* user id alloc must always be last in ioctl to prevent UAF */
 	err = xa_alloc(&xef->exec_queue.xa, &id, q, xa_limit_32b, GFP_KERNEL);
-	if (err)
+	if (err) {
+		xe_eudebug_exec_queue_destroy(xef, q);
 		goto del_hw_engine_group;
+	}
 
 	args->exec_queue_id = id;
 
@@ -1736,6 +1740,8 @@ int xe_exec_queue_destroy_ioctl(struct drm_device *dev, void *data,
 	if (q->vm && q->hwe->hw_engine_group)
 		xe_hw_engine_group_del_exec_queue(q->hwe->hw_engine_group, q);
 
+	xe_eudebug_exec_queue_destroy(xef, q);
+
 	xe_exec_queue_kill(q);
 
 	trace_xe_exec_queue_close(q);
diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
index 63f4a6142a1a..12e905441f1d 100644
--- a/include/uapi/drm/xe_drm_eudebug.h
+++ b/include/uapi/drm/xe_drm_eudebug.h
@@ -78,6 +78,7 @@ struct drm_xe_eudebug_event {
 #define DRM_XE_EUDEBUG_EVENT_NONE		0
 #define DRM_XE_EUDEBUG_EVENT_READ		1
 #define DRM_XE_EUDEBUG_EVENT_VM			2
+#define DRM_XE_EUDEBUG_EVENT_EXEC_QUEUE		3
 
 	/** @flags: Flags */
 	__u16 flags;
@@ -124,6 +125,36 @@ struct drm_xe_eudebug_event_vm {
 	__u64 vm_handle;
 };
 
+/**
+ * struct drm_xe_eudebug_event_exec_queue - Exec Queue resource event
+ *
+ * Resource creation/destruction event for an Exec Queue
+ */
+struct drm_xe_eudebug_event_exec_queue {
+	/** @base: base event */
+	struct drm_xe_eudebug_event base;
+
+	/**
+	 * @vm_handle: the vm handle this exec queue belongs to, or 0 if the
+	 * vm was destroyed before this event. A vm can be destroyed while
+	 * its exec queues live on, so a destroy event can carry 0 where the
+	 * create event carried the vm handle.
+	 */
+	__u64 vm_handle;
+
+	/** @exec_queue_handle: unique handle for this exec queue */
+	__u64 exec_queue_handle;
+
+	/** @engine_class: engine class, a %DRM_XE_ENGINE_CLASS_* value */
+	__u32 engine_class;
+
+	/** @width: width of exec queue, how many lrcs (handles) it has */
+	__u32 width;
+
+	/** @lrc_handle: array of lrc handles */
+	__u64 lrc_handle[] __counted_by(width);
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.53.0

