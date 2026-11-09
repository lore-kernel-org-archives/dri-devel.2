Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08E606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UtujZNFo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90F910F2F5;
	Mon,  9 Nov 2026 13:56:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FEE410F304;
 Mon,  9 Nov 2026 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232600; x=1825768600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U+f+UwV0XGXv5aNtTLdMqa5MM0PVHLtBrbBSre5qUvM=;
 b=UtujZNFoUO/Hu25MpGFr+R4O55ugBOXcake3Wzmc8RzqbPQX/+L8BwKc
 hCGO5kjr7f5wYzyUrvx9yuFTcdexhUKhS50UyR1ulebzCCAP2gkibCmo7
 FTyyF1eHQZ05d/gz05fRunYjssfvIeoC3kFwazqeOtCNnlH14v1onoHzs
 Uo7KPVT2OiNosJOZDpbANUdgy8CmOqnrTCawaoCwFQAYwF3InrPI54VE4
 A4ZkDhEVP7zzYIZvpTePgvGBWlFprR5I6jRAOF883wJwAF6UQhmXbX/CO
 aQukVQU2XzHnS5rrVQa0BjHOQm/1Rdb2yRbEAKDe42c9NLIuL4PhpLbZ/ Q==;
X-CSE-ConnectionGUID: +cpULnYsSfmV0MFBRFf2Gw==
X-CSE-MsgGUID: hNUYHpeOTEGRYiwhYCV6dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850736"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850736"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:39 -0800
X-CSE-ConnectionGUID: u++JnvgQRne5awGCbBCAyQ==
X-CSE-MsgGUID: L8ka/mn7SC6bJBpQqCTyaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202653"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:33 -0800
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
 Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Subject: [PATCH 06/20] drm/xe/eudebug: Introduce discovery for resources
Date: Mon,  9 Nov 2026 15:55:31 +0200
Message-ID: <20261109135549.4128280-7-mika.kuoppala@linux.intel.com>
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

A debugger connection can occur after a client has created
and destroyed an arbitrary number of resources. To support
this, we need to relay all currently existing resources to
the debugger. The client is held on selected ioctls until
this discovery process, run in the connect ioctl, is complete.

Based on discovery work by Maciej Patelczyk for the i915 driver.

v2: - use rw_semaphore to block DRM ioctls during discovery (Matthew)
    - only lock according to ioctl at play (Dominik)
v4: - s/discovery_lock/ioctl_lock
    - change lock to be per xe_file as is connections
v5: - helper to get eudebug instance during discovery (Maciej)
v6: - complete_all even if no client (Sashiko)
    - don't flush on detach (Sashiko)
v7: - guard close with ioctl lock (Sashiko)
v8: - discovery lock comment fix (Maciej)
v9: - disconnect on failed discovery (Sashiko)
    - avoid close race (Sashiko)
v10: - unordered discovery workqueue (Sashiko)
v11: - -EBUSY only from the ioctls that wait for discovery, keep
       -ENOTTY (review-prompts)
v12: - discover in the connect ioctl, no worker, killable gate (Mika)
v13: - exec queue uapi, helpers and exports moved to their users (Sashiko)
     - scoped ioctl_lock in attach, no goto next to __free() (Sashiko)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Co-developed-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Acked-by: Matthew Brost <matthew.brost@intel.com> #locking
---
 drivers/gpu/drm/xe/xe_device.c       | 24 +++++++-
 drivers/gpu/drm/xe/xe_device.h       | 53 ++++++++++++++++
 drivers/gpu/drm/xe/xe_device_types.h | 12 ++++
 drivers/gpu/drm/xe/xe_eudebug.c      | 90 +++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_eudebug.h      |  1 +
 include/uapi/drm/xe_drm.h            |  8 +++
 6 files changed, 183 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index ed28abc4f37f..d11429a69325 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -117,6 +117,10 @@ static int xe_file_open(struct drm_device *dev, struct drm_file *file)
 
 	mutex_init(&xef->mmio_gem.lock);
 
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+	init_rwsem(&xef->eudebug.ioctl_lock);
+#endif
+
 	file->driver_priv = xef;
 	kref_init(&xef->refcount);
 
@@ -248,8 +252,16 @@ static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
 	ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
-	if (ret >= 0)
+	if (ret >= 0) {
+		int lock = xe_eudebug_discovery_lock(file, cmd);
+
+		if (lock < 0)
+			return lock;
+
 		ret = drm_ioctl(file, cmd, arg);
+		if (lock)
+			xe_eudebug_discovery_unlock(file, cmd);
+	}
 
 	return ret;
 }
@@ -266,8 +278,16 @@ static long xe_drm_compat_ioctl(struct file *file, unsigned int cmd, unsigned lo
 
 	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
 	ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
-	if (ret >= 0)
+	if (ret >= 0) {
+		int lock = xe_eudebug_discovery_lock(file, cmd);
+
+		if (lock < 0)
+			return lock;
+
 		ret = drm_compat_ioctl(file, cmd, arg);
+		if (lock)
+			xe_eudebug_discovery_unlock(file, cmd);
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index 6df60edcb8f8..8409db81e99d 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -7,6 +7,7 @@
 #define _XE_DEVICE_H_
 
 #include <drm/drm_util.h>
+#include <drm/drm_ioctl.h>
 
 #include "xe_device_types.h"
 #include "xe_gt_types.h"
@@ -293,4 +294,56 @@ void xe_device_exit(void);
 #define LNL_FLUSH_WORK(wrk__) \
 	flush_work(wrk__)
 
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+static inline bool xe_eudebug_needs_ioctl_lock(const unsigned int cmd)
+{
+	const unsigned int xe_cmd = DRM_IOCTL_NR(cmd) - DRM_COMMAND_BASE;
+
+	switch (xe_cmd) {
+	case DRM_XE_VM_CREATE:
+	case DRM_XE_VM_DESTROY:
+	case DRM_XE_VM_BIND:
+	case DRM_XE_EXEC_QUEUE_CREATE:
+	case DRM_XE_EXEC_QUEUE_DESTROY:
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * A connect waiting for the write side holds new readers off, and a client
+ * killed meanwhile must not go on to create resources once let in: exec
+ * queue creation, for one, cannot start its scheduler's rescuer thread
+ * with a fatal signal pending.
+ *
+ * Return: 1 if the lock was taken, 0 if @cmd does not need it, -EINTR on a
+ * fatal signal.
+ */
+static inline int xe_eudebug_discovery_lock(struct file *file, unsigned int cmd)
+{
+	struct drm_file *file_priv = file->private_data;
+	struct xe_file *xef = file_priv->driver_priv;
+
+	if (!xe_eudebug_needs_ioctl_lock(cmd))
+		return 0;
+
+	if (down_read_killable(&xef->eudebug.ioctl_lock))
+		return -EINTR;
+
+	return 1;
+}
+
+static inline void xe_eudebug_discovery_unlock(struct file *file, unsigned int cmd)
+{
+	struct drm_file *file_priv = file->private_data;
+	struct xe_file *xef = file_priv->driver_priv;
+
+	up_read(&xef->eudebug.ioctl_lock);
+}
+#else
+static inline int xe_eudebug_discovery_lock(struct file *file, unsigned int cmd) { return 0; }
+static inline void xe_eudebug_discovery_unlock(struct file *file, unsigned int cmd) { }
+#endif /* CONFIG_DRM_XE_EUDEBUG */
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 000bf91bc5f0..6375a74414d3 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -735,6 +735,18 @@ struct xe_file {
 	struct {
 		/** @eudebug.debugger: the debugger connection into this xe_file */
 		struct xe_eudebug *debugger;
+
+		/**
+		 * @eudebug.ioctl_lock: excludes the ioctls that mutate the
+		 * eudebug visible resources of this client, so that a writer
+		 * sees a stable set of vms and exec queues. Taken for read
+		 * around the whole ioctl by xe_eudebug_discovery_lock(), for
+		 * the ioctls named in xe_eudebug_needs_ioctl_lock(), and for
+		 * write by the connect ioctl, across discovery, and by file
+		 * close. Held across an entire ioctl, so it nests outside
+		 * every lock those ioctls take.
+		 */
+		struct rw_semaphore ioctl_lock;
 	} eudebug;
 #endif
 };
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index ad8e1c02f20b..e0ef34588d3d 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -46,6 +46,14 @@
  * :ref:`File Descriptor Acquisition Methods <fd_acquisition_methods>` for
  * details on how to obtain the target's fd.
  *
+ * All existing resources that the target Xe DRM client already has are
+ * sent as events, as if they had been created right after the
+ * connection. This is referred to as discovery. The events are queued
+ * before the connect ioctl returns, so every eudebug ioctl can be used
+ * on the connection right away. To have a stable set of resources, the
+ * connect waits for the target's resource ioctls in flight to finish,
+ * and holds off new ones until discovery is done.
+ *
  */
 
 /**
@@ -392,7 +400,7 @@ bool xe_eudebug_is_enabled(struct xe_device *xe)
 }
 
 static struct xe_eudebug *
-xe_eudebug_get(struct xe_file *xef)
+__xe_eudebug_get(struct xe_file *xef)
 {
 	struct xe_device *xe = xef->xe;
 	struct xe_eudebug *d;
@@ -411,6 +419,19 @@ xe_eudebug_get(struct xe_file *xef)
 	return d;
 }
 
+/*
+ * The connect ioctl publishes the debugger and runs discovery under the
+ * target's ioctl_lock held for write, so a caller holding it for read
+ * only ever sees a debugger that discovery is done with.
+ */
+static struct xe_eudebug *
+xe_eudebug_get(struct xe_file *xef)
+{
+	lockdep_assert_held(&xef->eudebug.ioctl_lock);
+
+	return __xe_eudebug_get(xef);
+}
+
 static int xe_eudebug_queue_event(struct xe_eudebug *d,
 				  struct drm_xe_eudebug_event *event)
 {
@@ -778,6 +799,48 @@ void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm)
 	xe_eudebug_put(d);
 }
 
+/*
+ * All the relevant ioctls that manipulate the xe_file resources eudebug
+ * cares about are gated behind down_read(&xef->eudebug.ioctl_lock). The
+ * caller holds it for write, which excludes all those ioctls and lets us
+ * peek into the resource lists without taking their individual locks.
+ */
+static int discover_client(struct xe_eudebug *d, struct xe_file *xef)
+{
+	struct xe_vm *vm;
+	unsigned long i;
+	unsigned int vm_count = 0;
+	int err = 0;
+
+	lockdep_assert_held_write(&xef->eudebug.ioctl_lock);
+
+	eu_dbg(d, "Discovery start for %llu", d->session);
+
+	/* vm lifetime guaranteed by the ioctl_lock */
+	xa_for_each(&xef->vm.xa, i, vm) {
+		/* Only fault mode vms are announced, see xe_eudebug_vm_create() */
+		if (!xe_vm_in_fault_mode(vm))
+			continue;
+
+		err = vm_create_event(d, vm);
+		if (err)
+			goto out;
+		vm_count++;
+	}
+
+out:
+	if (vm_count)
+		eu_dbg(d, "Discovery found %u vms",
+		       vm_count);
+
+	eu_dbg(d, "Discovery end for %llu: %d", d->session, err);
+
+	if (err < 0)
+		xe_eudebug_disconnect(d, err);
+
+	return err;
+}
+
 static int add_debugger(struct xe_device *xe, struct xe_eudebug *d,
 			struct drm_file *target)
 {
@@ -835,6 +898,22 @@ xe_eudebug_attach(struct xe_device *xe, struct drm_file *parent_file,
 	if (XE_IOCTL_DBG(xe, xe != target_xef->xe))
 		return -EINVAL;
 
+	/*
+	 * Keep the target's resource ioctls out from before the debugger is
+	 * published until discovery has queued what already exists, so that
+	 * each resource is reported exactly once: either here, or by the
+	 * ioctl that creates it. Discovery relies on this to walk the
+	 * resource lists unlocked, see discover_client(). The file reference
+	 * keeps target_xef alive until we are done with it.
+	 *
+	 * This waits for the gated ioctls already in flight, which can stall
+	 * in their user copies. Killable, so that the debugger can give up.
+	 */
+	ACQUIRE(rwsem_write_kill, ioctl_lock)(&target_xef->eudebug.ioctl_lock);
+	ret = ACQUIRE_ERR(rwsem_write_kill, &ioctl_lock);
+	if (ret)
+		return ret;
+
 	ret = add_debugger(xe, d, drm_file);
 	if (XE_IOCTL_DBG(xe, ret))
 		return ret;
@@ -842,7 +921,8 @@ xe_eudebug_attach(struct xe_device *xe, struct drm_file *parent_file,
 	eu_dbg(d, "session %llu attached to %s", d->session,
 	       parent_file == drm_file ? "self" : "remote");
 
-	return 0;
+	/* On failure, discovery has disconnected us already */
+	return discover_client(d, target_xef);
 }
 
 static int xe_eudebug_release(struct inode *inode, struct file *file)
@@ -1195,11 +1275,15 @@ void xe_eudebug_file_close(struct xe_file *xef)
 {
 	struct xe_eudebug *d;
 
-	d = xe_eudebug_get(xef);
+	down_write(&xef->eudebug.ioctl_lock);
+
+	d = __xe_eudebug_get(xef);
 	if (d) {
 		xe_eudebug_detach(d, 0);
 		xe_eudebug_put(d);
 	}
+
+	up_write(&xef->eudebug.ioctl_lock);
 }
 
 static int xe_eudebug_enable(struct xe_device *xe, bool enable)
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
index 91e604c39814..413a45129193 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.h
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -14,6 +14,7 @@ struct drm_file;
 struct xe_device;
 struct xe_file;
 struct xe_vm;
+struct xe_eudebug;
 
 #if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
 
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 942a7fe81f4b..e84b11324f08 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -2641,6 +2641,14 @@ enum drm_xe_ras_error_component {
  * struct drm_xe_eudebug_connect - Input of &DRM_IOCTL_XE_EUDEBUG_CONNECT
  *
  * This structure is used to connect to an eudebug interface of target drm file.
+ *
+ * On connect, the resources the target already has are first relayed to
+ * the debugger as events. This is called discovery. The events are
+ * queued before the ioctl returns. If they do not fit the event queue,
+ * the ioctl fails with -ENOSPC.
+ *
+ * The ioctl waits for the target's resource ioctls in flight to finish,
+ * and fails with -EINTR if a fatal signal arrives meanwhile.
  */
 struct drm_xe_eudebug_connect {
 	/** @extensions: Pointer to the first extension struct, if any */
-- 
2.53.0

