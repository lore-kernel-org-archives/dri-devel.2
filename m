Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574DBCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C69310EA4C;
	Fri, 12 Jun 2026 13:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bvj8IGOr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFA710EA4C;
 Fri, 12 Jun 2026 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781272459; x=1812808459;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xd4vQf1jFgQ6QbLvRZ+VlWHLkNR/Dv9QvYXejrJN10E=;
 b=bvj8IGOrskfQn6z5+5Ky7dYZ7rAlFgS290HJQKBb9KMTuFdk3NpPvGFG
 CFjXoGN5W+RWtS7Zs+TNd9hEthSyiwUw3Ep630QyqQuCpGjP8TvsZulz9
 i5jgdloE76rrfaJnjztP9tDPC2CHb7epXHZDEi4zkoz7/N5JfTJ6GnpIy
 PVxTgx96a9DmjZ9KwSZ9jefN88xBpBFLm4+SimvErrA/pUiPLuWXSxCYK
 PgyfTzIEcNHDwt63aulEFvUAelzGMhn6MXT5wnI2xe8cH/XEBiArCL6q4
 QC3/PqqMrmupMeHOtiap+oVDYbsvaBSULQa+i924jqcXbmtdGm1Uvg02f Q==;
X-CSE-ConnectionGUID: S7kx9mvJS76nZVUS+sqEYA==
X-CSE-MsgGUID: e1nRhD83TAiUrHm23pKmvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82163298"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82163298"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:19 -0700
X-CSE-ConnectionGUID: a8PQE+BcRiKR39lSG/Y8Ag==
X-CSE-MsgGUID: 9R1Ke0IXShGdMTPaRUArlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="242446533"
Received: from slindbla-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.68])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:14 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 John Falkowski <john.falkowski@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Lahtinen Joonas <joonas.lahtinen@linux.intel.com>,
 David Howells <dhowells@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, LMKL <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] drm/xe: Add DRM_IOCTL_XE_VM_RESTART IOCTL
Date: Fri, 12 Jun 2026 15:53:37 +0200
Message-ID: <20260612135340.116100-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
References: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
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

Add an async VM restart IOCTL that allows userspace to re-queue the
preempt-rebind worker for a VM that has been paused after a recoverable
error.

Add xe_vm_restart_ioctl() which:
- Looks up the VM by id via xe_vm_lookup()
- Returns -EINVAL if the VM is not in preempt-fence mode or not restartable
- Returns -EALREADY if the VM is not currently paused
- Queues the rebind worker via and returns 0

If the optional @timestamp_ns field is non-zero, logs the latency
between that timestamp and the point the worker is queued.

Add DRM_XE_VM_CREATE_FLAG_RESTARTABLE to opt a VM in to the restartable
behaviour: on recoverable errors (-ENOMEM, -ENOSPC) the rebind worker
is deactivated rather than the VM being killed. Requires
DRM_XE_VM_CREATE_FLAG_LR_MODE and may not be used with
DRM_XE_VM_CREATE_FLAG_FAULT_MODE.

Add struct drm_xe_vm_restart UAPI struct with vm_id, pad, timestamp_ns
and reserved fields, and register the IOCTL at slot 0x10.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 51e3a2dd7b22..867d7c55dc03 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -215,6 +215,7 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
 			  DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(XE_VM_GET_PROPERTY, xe_vm_get_property_ioctl,
 			  DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XE_VM_RESTART, xe_vm_restart_ioctl, DRM_RENDER_ALLOW),
 };

 static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 75841f3e9afa..86ed8f31a219 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -563,8 +563,14 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	}

 	if (err) {
-		drm_warn(&vm->xe->drm, "VM worker error: %d\n", err);
-		xe_vm_kill(vm, true);
+		if ((err == -ENOMEM || err == -ENOSPC) && xe_vm_is_restartable(vm)) {
+			vm->preempt.rebind_deactivated = true;
+			drm_dbg(&vm->xe->drm, "Rebind deactivated VM on error %pe\n",
+				ERR_PTR(err));
+		} else {
+			drm_warn(&vm->xe->drm, "VM worker error: %d\n", err);
+			xe_vm_kill(vm, true);
+		}
 	}
 	up_write(&vm->lock);

@@ -573,6 +579,85 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	trace_xe_vm_rebind_worker_exit(vm);
 }

+/**
+ * xe_vm_restart_ioctl() - Queue the preempt-rebind worker for a paused VM
+ * @dev: DRM device
+ * @data: pointer to &struct drm_xe_vm_restart from userspace
+ * @file: DRM file handle
+ *
+ * Looks up the VM identified by @vm_id and, if it is currently paused (its
+ * rebind worker was deactivated after a recoverable error), clears the paused
+ * state and queues the rebind worker.  Only valid for VMs in preempt-fence
+ * mode.
+ *
+ * If @timestamp_ns is non-zero, logs the latency between that timestamp and
+ * the point the vm lock is taken, regardless of whether the VM was paused.
+ *
+ * Return: 0 if the worker was queued, -EALREADY if the VM is not paused,
+ *         -EINVAL if the VM is not in preempt-fence mode or not restartable,
+ *         -ENOENT if the VM was not found.
+ */
+int xe_vm_restart_ioctl(struct drm_device *dev, void *data,
+			struct drm_file *file)
+{
+	struct xe_device *xe = to_xe_device(dev);
+	struct xe_file *xef = to_xe_file(file);
+	struct drm_xe_vm_restart *args = data;
+	struct xe_vm *vm;
+	int err = 0;
+
+	if (XE_IOCTL_DBG(xe, args->reserved || args->pad))
+		return -EINVAL;
+
+	vm = xe_vm_lookup(xef, args->vm_id);
+	if (XE_IOCTL_DBG(xe, !vm))
+		return -ENOENT;
+
+	if (XE_IOCTL_DBG(xe, !xe_vm_in_preempt_fence_mode(vm))) {
+		xe_vm_put(vm);
+		return -EINVAL;
+	}
+
+	if (XE_IOCTL_DBG(xe, !xe_vm_is_restartable(vm))) {
+		xe_vm_put(vm);
+		return -EINVAL;
+	}
+
+	err = down_read_interruptible(&vm->lock);
+	if (err)
+		goto out;
+
+	if (XE_IOCTL_DBG(xe, xe_vm_is_closed_or_banned(vm))) {
+		err = -ENOENT;
+		goto out_unlock_read;
+	}
+
+	if (args->timestamp_ns) {
+		u64 delay_us = (ktime_get_ns() - args->timestamp_ns) / NSEC_PER_USEC;
+
+		drm_dbg(&xe->drm, "VM %u restart latency: %llu us\n",
+			args->vm_id, delay_us);
+	}
+
+	err = xe_vm_lock(vm, true);
+	if (err)
+		goto out_unlock_read;
+
+	if (!vm->preempt.rebind_deactivated) {
+		err = -EALREADY;
+		goto out_unlock_resv;
+	}
+
+	xe_vm_reactivate_rebind(vm);
+out_unlock_resv:
+	xe_vm_unlock(vm);
+out_unlock_read:
+	up_read(&vm->lock);
+out:
+	xe_vm_put(vm);
+	return err;
+}
+
 /**
  * xe_vm_add_fault_entry_pf() - Add pagefault to vm fault list
  * @vm: The VM.
@@ -2049,7 +2134,8 @@ find_ufence_get(struct xe_sync_entry *syncs, u32 num_syncs)
 #define ALL_DRM_XE_VM_CREATE_FLAGS (DRM_XE_VM_CREATE_FLAG_SCRATCH_PAGE | \
 				    DRM_XE_VM_CREATE_FLAG_LR_MODE | \
 				    DRM_XE_VM_CREATE_FLAG_FAULT_MODE | \
-				    DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT)
+				    DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT | \
+				    DRM_XE_VM_CREATE_FLAG_RESTARTABLE)

 int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *file)
@@ -2092,6 +2178,11 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 			 args->flags & DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT))
 		return -EINVAL;

+	if (XE_IOCTL_DBG(xe, args->flags & DRM_XE_VM_CREATE_FLAG_RESTARTABLE &&
+			 (!(args->flags & DRM_XE_VM_CREATE_FLAG_LR_MODE) ||
+			  args->flags & DRM_XE_VM_CREATE_FLAG_FAULT_MODE)))
+		return -EINVAL;
+
 	if (args->flags & DRM_XE_VM_CREATE_FLAG_SCRATCH_PAGE)
 		flags |= XE_VM_FLAG_SCRATCH_PAGE;
 	if (args->flags & DRM_XE_VM_CREATE_FLAG_LR_MODE)
@@ -2100,6 +2191,8 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 		flags |= XE_VM_FLAG_FAULT_MODE;
 	if (args->flags & DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT)
 		flags |= XE_VM_FLAG_NO_VM_OVERCOMMIT;
+	if (args->flags & DRM_XE_VM_CREATE_FLAG_RESTARTABLE)
+		flags |= XE_VM_FLAG_RESTARTABLE;

 	vm = xe_vm_create(xe, flags, xef);
 	if (IS_ERR(vm))
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c5b900f38ded..9ee44599cacd 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -212,7 +212,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data,
 int xe_vm_query_vmas_attrs_ioctl(struct drm_device *dev, void *data, struct drm_file *file);
 int xe_vm_get_property_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *file);
-
+int xe_vm_restart_ioctl(struct drm_device *dev, void *data,
+			struct drm_file *file);
 void xe_vm_close_and_put(struct xe_vm *vm);

 static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
@@ -237,6 +238,11 @@ static inline bool xe_vm_allow_vm_eviction(struct xe_vm *vm)
 		 !(vm->flags & XE_VM_FLAG_NO_VM_OVERCOMMIT));
 }

+static inline bool xe_vm_is_restartable(struct xe_vm *vm)
+{
+	return vm->flags & XE_VM_FLAG_RESTARTABLE;
+}
+
 int xe_vm_add_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q);
 void xe_vm_remove_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q);

diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 635ed29b9a69..7d295c3b8456 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -264,6 +264,7 @@ struct xe_vm {
 #define XE_VM_FLAG_SET_TILE_ID(tile)	FIELD_PREP(GENMASK(7, 6), (tile)->id)
 #define XE_VM_FLAG_GSC			BIT(8)
 #define XE_VM_FLAG_NO_VM_OVERCOMMIT     BIT(9)
+#define XE_VM_FLAG_RESTARTABLE          BIT(10)
 	unsigned long flags;

 	/**
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 48e9f1fdb78d..bebb0167bd31 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -85,6 +85,7 @@ extern "C" {
  *  - &DRM_IOCTL_XE_VM_QUERY_MEM_RANGE_ATTRS
  *  - &DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY
  *  - &DRM_IOCTL_XE_VM_GET_PROPERTY
+ *  - &DRM_IOCTL_XE_VM_RESTART
  */

 /*
@@ -110,6 +111,7 @@ extern "C" {
 #define DRM_XE_VM_QUERY_MEM_RANGE_ATTRS	0x0d
 #define DRM_XE_EXEC_QUEUE_SET_PROPERTY	0x0e
 #define DRM_XE_VM_GET_PROPERTY		0x0f
+#define DRM_XE_VM_RESTART		0x10

 /* Must be kept compact -- no holes */

@@ -129,6 +131,7 @@ extern "C" {
 #define DRM_IOCTL_XE_VM_QUERY_MEM_RANGE_ATTRS	DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_QUERY_MEM_RANGE_ATTRS, struct drm_xe_vm_query_mem_range_attr)
 #define DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY	DRM_IOW(DRM_COMMAND_BASE + DRM_XE_EXEC_QUEUE_SET_PROPERTY, struct drm_xe_exec_queue_set_property)
 #define DRM_IOCTL_XE_VM_GET_PROPERTY		DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_GET_PROPERTY, struct drm_xe_vm_get_property)
+#define DRM_IOCTL_XE_VM_RESTART			DRM_IOW(DRM_COMMAND_BASE + DRM_XE_VM_RESTART, struct drm_xe_vm_restart)

 /**
  * DOC: Xe IOCTL Extensions
@@ -985,6 +988,10 @@ struct drm_xe_gem_mmap_offset {
  *    but only during a &DRM_IOCTL_XE_VM_BIND operation with the
  *    %DRM_XE_VM_BIND_FLAG_IMMEDIATE flag set. This may be useful for
  *    user-space naively probing the amount of available memory.
+ *  - %DRM_XE_VM_CREATE_FLAG_RESTARTABLE - Requires also
+ *    DRM_XE_VM_CREATE_FLAG_LR_MODE. Marks the VM as restartable, enabling
+ *    use of &DRM_IOCTL_XE_VM_RESTART to resume the preempt-rebind worker
+ *    after an error has paused it.
  */
 struct drm_xe_vm_create {
 	/** @extensions: Pointer to the first extension struct, if any */
@@ -994,6 +1001,7 @@ struct drm_xe_vm_create {
 #define DRM_XE_VM_CREATE_FLAG_LR_MODE	        (1 << 1)
 #define DRM_XE_VM_CREATE_FLAG_FAULT_MODE	(1 << 2)
 #define DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT  (1 << 3)
+#define DRM_XE_VM_CREATE_FLAG_RESTARTABLE       (1 << 4)
 	/** @flags: Flags */
 	__u32 flags;

@@ -2531,8 +2539,44 @@ struct drm_xe_exec_queue_set_property {
 };

 /**
- * DOC: Xe DRM RAS
+ * DOC: DRM_XE_VM_RESTART
+ *
+ * Restart a paused VM by queuing its preempt-rebind worker.  The VM must be
+ * in preempt-fence mode and must currently be paused (i.e. its rebind worker
+ * was deactivated after a recoverable error such as -ENOMEM or -ENOSPC).
+ *
+ * Returns 0 if the rebind worker was successfully queued.  Returns -EALREADY
+ * if the VM is not currently paused.  Returns -EINVAL if the VM is not in
+ * preempt-fence mode or not restartable.
  *
+ * An optional @timestamp_ns can be provided to measure the latency between
+ * event delivery and the point the worker is queued; the driver logs this
+ * once all sanity checks have passed.
+ */
+
+/**
+ * struct drm_xe_vm_restart - restart a VM's preempt-rebind worker
+ *
+ * Used with %DRM_IOCTL_XE_VM_RESTART.
+ */
+struct drm_xe_vm_restart {
+	/** @vm_id: ID of the VM to restart */
+	__u32 vm_id;
+	/** @pad: reserved, must be zero */
+	__u32 pad;
+	/**
+	 * @timestamp_ns: optional CLOCK_MONOTONIC timestamp in nanoseconds.
+	 * When non-zero, the driver logs the delay between this timestamp and
+	 * the point the vm lock is taken, regardless of whether the VM is
+	 * currently paused.  Pass zero to disable the logging.
+	 */
+	__u64 timestamp_ns;
+	/** @reserved: reserved, must be zero */
+	__u64 reserved;
+};
+
+/**
+ * DOC: Xe DRM RAS
  * The enums and strings defined below map to the attributes of the DRM RAS Netlink Interface.
  * Refer to Documentation/netlink/specs/drm_ras.yaml for complete interface specification.
  *
---
 drivers/gpu/drm/xe/xe_device.c   |  1 +
 drivers/gpu/drm/xe/xe_vm.c       | 99 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_vm.h       |  8 ++-
 drivers/gpu/drm/xe/xe_vm_types.h |  1 +
 include/uapi/drm/xe_drm.h        | 46 ++++++++++++++-
 5 files changed, 150 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 51e3a2dd7b22..867d7c55dc03 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -215,6 +215,7 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
 			  DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(XE_VM_GET_PROPERTY, xe_vm_get_property_ioctl,
 			  DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XE_VM_RESTART, xe_vm_restart_ioctl, DRM_RENDER_ALLOW),
 };
 
 static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 75841f3e9afa..86ed8f31a219 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -563,8 +563,14 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	}
 
 	if (err) {
-		drm_warn(&vm->xe->drm, "VM worker error: %d\n", err);
-		xe_vm_kill(vm, true);
+		if ((err == -ENOMEM || err == -ENOSPC) && xe_vm_is_restartable(vm)) {
+			vm->preempt.rebind_deactivated = true;
+			drm_dbg(&vm->xe->drm, "Rebind deactivated VM on error %pe\n",
+				ERR_PTR(err));
+		} else {
+			drm_warn(&vm->xe->drm, "VM worker error: %d\n", err);
+			xe_vm_kill(vm, true);
+		}
 	}
 	up_write(&vm->lock);
 
@@ -573,6 +579,85 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	trace_xe_vm_rebind_worker_exit(vm);
 }
 
+/**
+ * xe_vm_restart_ioctl() - Queue the preempt-rebind worker for a paused VM
+ * @dev: DRM device
+ * @data: pointer to &struct drm_xe_vm_restart from userspace
+ * @file: DRM file handle
+ *
+ * Looks up the VM identified by @vm_id and, if it is currently paused (its
+ * rebind worker was deactivated after a recoverable error), clears the paused
+ * state and queues the rebind worker.  Only valid for VMs in preempt-fence
+ * mode.
+ *
+ * If @timestamp_ns is non-zero, logs the latency between that timestamp and
+ * the point the vm lock is taken, regardless of whether the VM was paused.
+ *
+ * Return: 0 if the worker was queued, -EALREADY if the VM is not paused,
+ *         -EINVAL if the VM is not in preempt-fence mode or not restartable,
+ *         -ENOENT if the VM was not found.
+ */
+int xe_vm_restart_ioctl(struct drm_device *dev, void *data,
+			struct drm_file *file)
+{
+	struct xe_device *xe = to_xe_device(dev);
+	struct xe_file *xef = to_xe_file(file);
+	struct drm_xe_vm_restart *args = data;
+	struct xe_vm *vm;
+	int err = 0;
+
+	if (XE_IOCTL_DBG(xe, args->reserved || args->pad))
+		return -EINVAL;
+
+	vm = xe_vm_lookup(xef, args->vm_id);
+	if (XE_IOCTL_DBG(xe, !vm))
+		return -ENOENT;
+
+	if (XE_IOCTL_DBG(xe, !xe_vm_in_preempt_fence_mode(vm))) {
+		xe_vm_put(vm);
+		return -EINVAL;
+	}
+
+	if (XE_IOCTL_DBG(xe, !xe_vm_is_restartable(vm))) {
+		xe_vm_put(vm);
+		return -EINVAL;
+	}
+
+	err = down_read_interruptible(&vm->lock);
+	if (err)
+		goto out;
+
+	if (XE_IOCTL_DBG(xe, xe_vm_is_closed_or_banned(vm))) {
+		err = -ENOENT;
+		goto out_unlock_read;
+	}
+
+	if (args->timestamp_ns) {
+		u64 delay_us = (ktime_get_ns() - args->timestamp_ns) / NSEC_PER_USEC;
+
+		drm_dbg(&xe->drm, "VM %u restart latency: %llu us\n",
+			args->vm_id, delay_us);
+	}
+
+	err = xe_vm_lock(vm, true);
+	if (err)
+		goto out_unlock_read;
+
+	if (!vm->preempt.rebind_deactivated) {
+		err = -EALREADY;
+		goto out_unlock_resv;
+	}
+
+	xe_vm_reactivate_rebind(vm);
+out_unlock_resv:
+	xe_vm_unlock(vm);
+out_unlock_read:
+	up_read(&vm->lock);
+out:
+	xe_vm_put(vm);
+	return err;
+}
+
 /**
  * xe_vm_add_fault_entry_pf() - Add pagefault to vm fault list
  * @vm: The VM.
@@ -2049,7 +2134,8 @@ find_ufence_get(struct xe_sync_entry *syncs, u32 num_syncs)
 #define ALL_DRM_XE_VM_CREATE_FLAGS (DRM_XE_VM_CREATE_FLAG_SCRATCH_PAGE | \
 				    DRM_XE_VM_CREATE_FLAG_LR_MODE | \
 				    DRM_XE_VM_CREATE_FLAG_FAULT_MODE | \
-				    DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT)
+				    DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT | \
+				    DRM_XE_VM_CREATE_FLAG_RESTARTABLE)
 
 int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *file)
@@ -2092,6 +2178,11 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 			 args->flags & DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT))
 		return -EINVAL;
 
+	if (XE_IOCTL_DBG(xe, args->flags & DRM_XE_VM_CREATE_FLAG_RESTARTABLE &&
+			 (!(args->flags & DRM_XE_VM_CREATE_FLAG_LR_MODE) ||
+			  args->flags & DRM_XE_VM_CREATE_FLAG_FAULT_MODE)))
+		return -EINVAL;
+
 	if (args->flags & DRM_XE_VM_CREATE_FLAG_SCRATCH_PAGE)
 		flags |= XE_VM_FLAG_SCRATCH_PAGE;
 	if (args->flags & DRM_XE_VM_CREATE_FLAG_LR_MODE)
@@ -2100,6 +2191,8 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 		flags |= XE_VM_FLAG_FAULT_MODE;
 	if (args->flags & DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT)
 		flags |= XE_VM_FLAG_NO_VM_OVERCOMMIT;
+	if (args->flags & DRM_XE_VM_CREATE_FLAG_RESTARTABLE)
+		flags |= XE_VM_FLAG_RESTARTABLE;
 
 	vm = xe_vm_create(xe, flags, xef);
 	if (IS_ERR(vm))
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c5b900f38ded..9ee44599cacd 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -212,7 +212,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data,
 int xe_vm_query_vmas_attrs_ioctl(struct drm_device *dev, void *data, struct drm_file *file);
 int xe_vm_get_property_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *file);
-
+int xe_vm_restart_ioctl(struct drm_device *dev, void *data,
+			struct drm_file *file);
 void xe_vm_close_and_put(struct xe_vm *vm);
 
 static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
@@ -237,6 +238,11 @@ static inline bool xe_vm_allow_vm_eviction(struct xe_vm *vm)
 		 !(vm->flags & XE_VM_FLAG_NO_VM_OVERCOMMIT));
 }
 
+static inline bool xe_vm_is_restartable(struct xe_vm *vm)
+{
+	return vm->flags & XE_VM_FLAG_RESTARTABLE;
+}
+
 int xe_vm_add_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q);
 void xe_vm_remove_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q);
 
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 635ed29b9a69..7d295c3b8456 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -264,6 +264,7 @@ struct xe_vm {
 #define XE_VM_FLAG_SET_TILE_ID(tile)	FIELD_PREP(GENMASK(7, 6), (tile)->id)
 #define XE_VM_FLAG_GSC			BIT(8)
 #define XE_VM_FLAG_NO_VM_OVERCOMMIT     BIT(9)
+#define XE_VM_FLAG_RESTARTABLE          BIT(10)
 	unsigned long flags;
 
 	/**
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 48e9f1fdb78d..bebb0167bd31 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -85,6 +85,7 @@ extern "C" {
  *  - &DRM_IOCTL_XE_VM_QUERY_MEM_RANGE_ATTRS
  *  - &DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY
  *  - &DRM_IOCTL_XE_VM_GET_PROPERTY
+ *  - &DRM_IOCTL_XE_VM_RESTART
  */
 
 /*
@@ -110,6 +111,7 @@ extern "C" {
 #define DRM_XE_VM_QUERY_MEM_RANGE_ATTRS	0x0d
 #define DRM_XE_EXEC_QUEUE_SET_PROPERTY	0x0e
 #define DRM_XE_VM_GET_PROPERTY		0x0f
+#define DRM_XE_VM_RESTART		0x10
 
 /* Must be kept compact -- no holes */
 
@@ -129,6 +131,7 @@ extern "C" {
 #define DRM_IOCTL_XE_VM_QUERY_MEM_RANGE_ATTRS	DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_QUERY_MEM_RANGE_ATTRS, struct drm_xe_vm_query_mem_range_attr)
 #define DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY	DRM_IOW(DRM_COMMAND_BASE + DRM_XE_EXEC_QUEUE_SET_PROPERTY, struct drm_xe_exec_queue_set_property)
 #define DRM_IOCTL_XE_VM_GET_PROPERTY		DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_GET_PROPERTY, struct drm_xe_vm_get_property)
+#define DRM_IOCTL_XE_VM_RESTART			DRM_IOW(DRM_COMMAND_BASE + DRM_XE_VM_RESTART, struct drm_xe_vm_restart)
 
 /**
  * DOC: Xe IOCTL Extensions
@@ -985,6 +988,10 @@ struct drm_xe_gem_mmap_offset {
  *    but only during a &DRM_IOCTL_XE_VM_BIND operation with the
  *    %DRM_XE_VM_BIND_FLAG_IMMEDIATE flag set. This may be useful for
  *    user-space naively probing the amount of available memory.
+ *  - %DRM_XE_VM_CREATE_FLAG_RESTARTABLE - Requires also
+ *    DRM_XE_VM_CREATE_FLAG_LR_MODE. Marks the VM as restartable, enabling
+ *    use of &DRM_IOCTL_XE_VM_RESTART to resume the preempt-rebind worker
+ *    after an error has paused it.
  */
 struct drm_xe_vm_create {
 	/** @extensions: Pointer to the first extension struct, if any */
@@ -994,6 +1001,7 @@ struct drm_xe_vm_create {
 #define DRM_XE_VM_CREATE_FLAG_LR_MODE	        (1 << 1)
 #define DRM_XE_VM_CREATE_FLAG_FAULT_MODE	(1 << 2)
 #define DRM_XE_VM_CREATE_FLAG_NO_VM_OVERCOMMIT  (1 << 3)
+#define DRM_XE_VM_CREATE_FLAG_RESTARTABLE       (1 << 4)
 	/** @flags: Flags */
 	__u32 flags;
 
@@ -2531,8 +2539,44 @@ struct drm_xe_exec_queue_set_property {
 };
 
 /**
- * DOC: Xe DRM RAS
+ * DOC: DRM_XE_VM_RESTART
+ *
+ * Restart a paused VM by queuing its preempt-rebind worker.  The VM must be
+ * in preempt-fence mode and must currently be paused (i.e. its rebind worker
+ * was deactivated after a recoverable error such as -ENOMEM or -ENOSPC).
+ *
+ * Returns 0 if the rebind worker was successfully queued.  Returns -EALREADY
+ * if the VM is not currently paused.  Returns -EINVAL if the VM is not in
+ * preempt-fence mode or not restartable.
  *
+ * An optional @timestamp_ns can be provided to measure the latency between
+ * event delivery and the point the worker is queued; the driver logs this
+ * once all sanity checks have passed.
+ */
+
+/**
+ * struct drm_xe_vm_restart - restart a VM's preempt-rebind worker
+ *
+ * Used with %DRM_IOCTL_XE_VM_RESTART.
+ */
+struct drm_xe_vm_restart {
+	/** @vm_id: ID of the VM to restart */
+	__u32 vm_id;
+	/** @pad: reserved, must be zero */
+	__u32 pad;
+	/**
+	 * @timestamp_ns: optional CLOCK_MONOTONIC timestamp in nanoseconds.
+	 * When non-zero, the driver logs the delay between this timestamp and
+	 * the point the vm lock is taken, regardless of whether the VM is
+	 * currently paused.  Pass zero to disable the logging.
+	 */
+	__u64 timestamp_ns;
+	/** @reserved: reserved, must be zero */
+	__u64 reserved;
+};
+
+/**
+ * DOC: Xe DRM RAS
  * The enums and strings defined below map to the attributes of the DRM RAS Netlink Interface.
  * Refer to Documentation/netlink/specs/drm_ras.yaml for complete interface specification.
  *
-- 
2.54.0

