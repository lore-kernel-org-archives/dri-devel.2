Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F246FCD98D8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9B410F544;
	Fri, 12 Jun 2026 13:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IwA3Vtka";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C66C10F531;
 Fri, 12 Jun 2026 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781272470; x=1812808470;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x0WBenL+tYyEWxbwyAiUMsF2Sul7xYWiNZv7X+Mi0zg=;
 b=IwA3Vtka3Nru8qDFotg72QmkOEBvakfsVveFqrGBcnBbbeltG8I5Zqc4
 Nq5Zg/lzXOx8CgW8YSb/UUytoleLcIrlspI9FkPobs36cjcFyIkvaXFfB
 IYFYNPKha4TN/ga+6v+XB5oK3HV6xrYAIT3lb8SCKuhfzs5obnfoaqhO3
 U64+sjkaJGCAIW7/VHKnlQtZMyD023WLD9RsDV4NIGXsg+xR1EgCNBqYa
 tzY+o6XuJrxBpGcgQVvsrJgFinJAjqFOdhcgNKj/LWg3RsCIH9qUOGXdm
 LkVdYWEMvWPk/aEhqzfihwVjT+lgcf303aoT6yBAtorAnkKjCR3pgS4vz A==;
X-CSE-ConnectionGUID: NwgQK1G4Q6O1FVfFW7GcBw==
X-CSE-MsgGUID: QpVLjpgySNiC7IbAfx8Usg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82163324"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82163324"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:30 -0700
X-CSE-ConnectionGUID: QJv0tLjURmi95u1C2Gmu3w==
X-CSE-MsgGUID: VqeW38znQPysJkw45T3XMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="242446604"
Received: from slindbla-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.68])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:26 -0700
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
Subject: [PATCH 4/4] drm/xe: Add watch_queue-based device event notification
Date: Fri, 12 Jun 2026 15:53:40 +0200
Message-ID: <20260612135340.116100-5-thomas.hellstrom@linux.intel.com>
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

Add a watch_queue notification channel tied to struct xe_file so that
userspace can subscribe to asynchronous GPU device events via the
general kernel notification mechanism.

Introduce DRM_IOCTL_XE_WATCH_QUEUE to let userspace subscribe a
notification pipe (opened with pipe2(O_NOTIFICATION_PIPE)) to the device
event stream.  Embed the watch_id field (0-255) in the WATCH_INFO_ID
field of every notification, allowing multiple watches to share a single
pipe and be told apart by the reader.

Deliver notifications as struct drm_xe_watch_notification records, with
type always set to WATCH_TYPE_DRM_XE_NOTIFY and subtype drawn from enum
drm_xe_watch_event.  Define DRM_XE_WATCH_EVENT_VM_ERR as the first
event, posted by the preempt-rebind worker when a VM encounters an
unrecoverable error.  Expose xe_watch_queue_post_vm_err_event() as the
in-kernel posting API.

Add event definitions in a separate uapi header, <drm/xe_drm_events.h>.
The main reason is that the header needs to include <linux/watch_queue.h>
which in turn includes <linux/fcntl.h> which may conflict with the
system <fcntl.h>. Hence user-space must pay special attention when
including this file.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 MAINTAINERS                          |   1 +
 drivers/gpu/drm/xe/Kconfig           |   1 +
 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/xe_device.c       |   7 ++
 drivers/gpu/drm/xe/xe_device_types.h |   6 ++
 drivers/gpu/drm/xe/xe_vm.c           |   4 +
 drivers/gpu/drm/xe/xe_vm_types.h     |   2 +
 drivers/gpu/drm/xe/xe_watch_queue.c  | 111 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_watch_queue.h  |  20 +++++
 include/uapi/drm/xe_drm.h            |  45 +++++++++++
 include/uapi/drm/xe_drm_events.h     |  62 +++++++++++++++
 11 files changed, 260 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.c
 create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.h
 create mode 100644 include/uapi/drm/xe_drm_events.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c0d9965c636..b7e02cfa692b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12900,6 +12900,7 @@ F:	Documentation/gpu/xe/
 F:	drivers/gpu/drm/xe/
 F:	include/drm/intel/
 F:	include/uapi/drm/xe_drm.h
+F:	include/uapi/drm/xe_drm_events.h
 
 INTEL ELKHART LAKE PSE I/O DRIVER
 M:	Raag Jadav <raag.jadav@intel.com>
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4d7dcaff2b91..dbdc2fb49c53 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -25,6 +25,7 @@ config DRM_XE
 	select DRM_MIPI_DSI
 	select RELAY
 	select IRQ_WORK
+	select WATCH_QUEUE
 	# xe depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
 	select BACKLIGHT_CLASS_DEVICE if ACPI
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 8e7b146880f4..fc8b4023a044 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -150,6 +150,7 @@ xe-y += xe_bb.o \
 	xe_vsec.o \
 	xe_wa.o \
 	xe_wait_user_fence.o \
+	xe_watch_queue.o \
 	xe_wopcm.o
 
 xe-$(CONFIG_I2C)	+= xe_i2c.o
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 867d7c55dc03..788ef2fbd6e5 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/fault-inject.h>
 #include <linux/units.h>
+#include <linux/watch_queue.h>
 
 #include <drm/drm_client.h>
 #include <drm/drm_gem_ttm_helper.h>
@@ -77,6 +78,7 @@
 #include "xe_vsec.h"
 #include "xe_wait_user_fence.h"
 #include "xe_wa.h"
+#include "xe_watch_queue.h"
 
 #include <generated/xe_device_wa_oob.h>
 #include <generated/xe_wa_oob.h>
@@ -112,6 +114,8 @@ static int xe_file_open(struct drm_device *dev, struct drm_file *file)
 	file->driver_priv = xef;
 	kref_init(&xef->refcount);
 
+	init_watch_list(&xef->watch_list, NULL);
+
 	task = get_pid_task(rcu_access_pointer(file->pid), PIDTYPE_PID);
 	if (task) {
 		xef->process_name = kstrdup(task->comm, GFP_KERNEL);
@@ -126,6 +130,8 @@ static void xe_file_destroy(struct kref *ref)
 {
 	struct xe_file *xef = container_of(ref, struct xe_file, refcount);
 
+	remove_watch_from_object(&xef->watch_list, NULL, 0, true);
+
 	xa_destroy(&xef->exec_queue.xa);
 	mutex_destroy(&xef->exec_queue.lock);
 	xa_destroy(&xef->vm.xa);
@@ -216,6 +222,7 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(XE_VM_GET_PROPERTY, xe_vm_get_property_ioctl,
 			  DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(XE_VM_RESTART, xe_vm_restart_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XE_WATCH_QUEUE, xe_watch_queue_ioctl, DRM_RENDER_ALLOW),
 };
 
 static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 32dd2ffbc796..ca726ada30a7 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -11,6 +11,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
 #include <drm/ttm/ttm_device.h>
+#include <linux/watch_queue.h>
 
 #include "xe_devcoredump_types.h"
 #include "xe_drm_ras_types.h"
@@ -632,6 +633,11 @@ struct xe_file {
 
 	/** @refcount: ref count of this xe file */
 	struct kref refcount;
+
+#ifdef CONFIG_WATCH_QUEUE
+	/** @watch_list: per-file notification source for device events */
+	struct watch_list watch_list;
+#endif
 };
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index b69a2e5bd9c9..232de0d948d2 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -13,6 +13,7 @@
 #include <drm/drm_print.h>
 #include <drm/ttm/ttm_tt.h>
 #include <uapi/drm/xe_drm.h>
+#include <uapi/drm/xe_drm_events.h>
 #include <linux/ascii85.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
@@ -45,6 +46,7 @@
 #include "xe_trace_bo.h"
 #include "xe_vm_madvise.h"
 #include "xe_wa.h"
+#include "xe_watch_queue.h"
 
 #ifdef CONFIG_FAULT_INJECTION
 static DECLARE_FAULT_ATTR(rebind_enospc);
@@ -584,6 +586,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	}
 
 	if (err) {
+		xe_watch_queue_post_vm_err_event(vm->xef, vm->id, err);
 		if ((err == -ENOMEM || err == -ENOSPC) && xe_vm_is_restartable(vm)) {
 			vm->preempt.rebind_deactivated = true;
 			drm_dbg(&vm->xe->drm, "Rebind deactivated VM on error %pe\n",
@@ -2229,6 +2232,7 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 	if (err)
 		goto err_close_and_put;
 
+	vm->id = id;
 	args->vm_id = id;
 
 	return 0;
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 7d295c3b8456..19a673099588 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -407,6 +407,8 @@ struct xe_vm {
 	bool batch_invalidate_tlb;
 	/** @xef: Xe file handle for tracking this VM's drm client */
 	struct xe_file *xef;
+	/** @id: The id of the VM in the VM table of @xef. */
+	u32 id;
 };
 
 /** struct xe_vma_op_map - VMA map operation */
diff --git a/drivers/gpu/drm/xe/xe_watch_queue.c b/drivers/gpu/drm/xe/xe_watch_queue.c
new file mode 100644
index 000000000000..32763591075b
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_watch_queue.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
+#include <linux/watch_queue.h>
+
+#include <uapi/drm/xe_drm.h>
+#include <uapi/drm/xe_drm_events.h>
+
+#include "xe_device.h"
+#include "xe_device_types.h"
+#include "xe_macros.h"
+#include "xe_watch_queue.h"
+
+/**
+ * struct xe_watch_notification_vm_err - kernel-side VM error event notification
+ * @base: common watch notification header; type is %WATCH_TYPE_DRM_XE_NOTIFY,
+ *        subtype is %DRM_XE_WATCH_EVENT_VM_ERR
+ * @vm_id: ID of the VM that hit error
+ * @error_code: error code describing the error condition (negative errno)
+ * @timestamp_ns: CLOCK_MONOTONIC timestamp in nanoseconds at the point the
+ *                error was detected
+ *
+ * Layout mirrors &struct drm_xe_watch_notification_vm_err.
+ */
+struct xe_watch_notification_vm_err {
+	struct watch_notification base;
+	u32 vm_id;
+	s32 error_code;
+	u64 timestamp_ns;
+};
+
+/**
+ * xe_watch_queue_ioctl() - Subscribe a pipe to per-file device event notifications
+ * @dev: DRM device
+ * @data: pointer to &struct drm_xe_watch_queue from userspace
+ * @file: DRM file handle of the subscribing process
+ *
+ * Subscribes a notification pipe to receive Xe device events for the calling
+ * process's file handle.  Only events scoped to this file (e.g. VM error on a
+ * VM owned by this file) are delivered.  The pipe must have been opened with
+ * O_NOTIFICATION_PIPE and sized with %IOC_WATCH_QUEUE_SET_SIZE before calling
+ * this IOCTL.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int xe_watch_queue_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
+{
+	struct xe_file *xef = file->driver_priv;
+	struct xe_device *xe = to_xe_device(dev);
+	struct drm_xe_watch_queue *args = data;
+	struct watch_queue *wqueue;
+	struct watch *watch;
+	int ret;
+
+	if (XE_IOCTL_DBG(xe, args->flags || args->pad))
+		return -EINVAL;
+	if (XE_IOCTL_DBG(xe, args->watch_id > 0xff))
+		return -EINVAL;
+
+	wqueue = get_watch_queue(args->fd);
+	if (XE_IOCTL_DBG(xe, IS_ERR(wqueue)))
+		return PTR_ERR(wqueue);
+
+	watch = kzalloc_obj(*watch, GFP_KERNEL | __GFP_ACCOUNT);
+	if (XE_IOCTL_DBG(xe, !watch)) {
+		ret = -ENOMEM;
+		goto out_put_queue;
+	}
+
+	init_watch(watch, wqueue);
+	watch->id = 0;
+	watch->info_id = (u32)args->watch_id << WATCH_INFO_ID__SHIFT;
+
+	ret = add_watch_to_object(watch, &xef->watch_list);
+	if (XE_IOCTL_DBG(xe, ret))
+		kfree(watch);
+
+out_put_queue:
+	put_watch_queue(wqueue);
+	return ret;
+}
+
+/**
+ * xe_watch_queue_post_vm_err_event() - Post a VM error event
+ * @xef: xe file handle that owns the VM
+ * @vm_id: userspace ID of the VM that hit error
+ * @error_code: error code describing the error condition (negative errno)
+ *
+ * Posts a %DRM_XE_WATCH_EVENT_VM_ERR notification carrying @vm_id and
+ * @error_code to every pipe that @xef has subscribed via
+ * %DRM_IOCTL_XE_WATCH_QUEUE.  Only the owning process is notified,
+ * preventing information leaks to other clients.
+ */
+void xe_watch_queue_post_vm_err_event(struct xe_file *xef, u32 vm_id,
+				      int error_code)
+{
+	struct xe_watch_notification_vm_err n = {};
+
+	n.base.type    = WATCH_TYPE_DRM_XE_NOTIFY;
+	n.base.subtype = DRM_XE_WATCH_EVENT_VM_ERR;
+	n.base.info    = watch_sizeof(struct xe_watch_notification_vm_err);
+	n.vm_id        = vm_id;
+	n.error_code   = error_code;
+	n.timestamp_ns = ktime_get_ns();
+
+	post_watch_notification(&xef->watch_list, &n.base, current_cred(), 0);
+}
diff --git a/drivers/gpu/drm/xe/xe_watch_queue.h b/drivers/gpu/drm/xe/xe_watch_queue.h
new file mode 100644
index 000000000000..ad199ee68205
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_watch_queue.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _XE_WATCH_QUEUE_H_
+#define _XE_WATCH_QUEUE_H_
+
+#include <linux/types.h>
+
+struct drm_device;
+struct drm_file;
+struct xe_file;
+
+int xe_watch_queue_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *file);
+void xe_watch_queue_post_vm_err_event(struct xe_file *xef, u32 vm_id,
+				      int error_code);
+
+#endif /* _XE_WATCH_QUEUE_H_ */
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 8d5e3f06b8d4..0083dd712f7e 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -86,6 +86,7 @@ extern "C" {
  *  - &DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY
  *  - &DRM_IOCTL_XE_VM_GET_PROPERTY
  *  - &DRM_IOCTL_XE_VM_RESTART
+ *  - &DRM_IOCTL_XE_WATCH_QUEUE
  */
 
 /*
@@ -112,6 +113,7 @@ extern "C" {
 #define DRM_XE_EXEC_QUEUE_SET_PROPERTY	0x0e
 #define DRM_XE_VM_GET_PROPERTY		0x0f
 #define DRM_XE_VM_RESTART		0x10
+#define DRM_XE_WATCH_QUEUE		0x11
 
 /* Must be kept compact -- no holes */
 
@@ -132,6 +134,7 @@ extern "C" {
 #define DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY	DRM_IOW(DRM_COMMAND_BASE + DRM_XE_EXEC_QUEUE_SET_PROPERTY, struct drm_xe_exec_queue_set_property)
 #define DRM_IOCTL_XE_VM_GET_PROPERTY		DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_GET_PROPERTY, struct drm_xe_vm_get_property)
 #define DRM_IOCTL_XE_VM_RESTART			DRM_IOW(DRM_COMMAND_BASE + DRM_XE_VM_RESTART, struct drm_xe_vm_restart)
+#define DRM_IOCTL_XE_WATCH_QUEUE		DRM_IOW(DRM_COMMAND_BASE + DRM_XE_WATCH_QUEUE, struct drm_xe_watch_queue)
 
 /**
  * DOC: Xe IOCTL Extensions
@@ -2653,6 +2656,48 @@ enum drm_xe_ras_error_component {
 	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL] = "soc-internal"		\
 }
 
+/**
+ * DOC: DRM_XE_WATCH_QUEUE
+ *
+ * Subscribe a notification pipe to receive device events for the calling
+ * process's DRM file handle.  Events are scoped to the subscribing file:
+ * only events that belong to that file (for example, VM error on a VM created
+ * through the same file) are delivered, preventing information leaks between
+ * processes sharing the same GPU device.
+ *
+ * The pipe must first be opened with O_NOTIFICATION_PIPE (i.e. O_EXCL passed
+ * to pipe2()) and sized via %IOC_WATCH_QUEUE_SET_SIZE before subscribing.
+ *
+ * Events are delivered as notification records read from the pipe.  The
+ * @watch_id field is embedded in the notification info field and can be used
+ * to distinguish multiple watches sharing a pipe.
+ *
+ * Currently defined event subtypes:
+ *  - %DRM_XE_WATCH_EVENT_VM_ERR - a VM owned by this file has encountered an error
+ */
+
+/**
+ * struct drm_xe_watch_queue - subscribe to device event notifications
+ *
+ * Used with %DRM_IOCTL_XE_WATCH_QUEUE.  Notifications are scoped to the
+ * DRM file handle used to issue this IOCTL.
+ */
+struct drm_xe_watch_queue {
+	/** @fd: file descriptor of pipe opened with O_NOTIFICATION_PIPE */
+	__u32 fd;
+
+	/**
+	 * @watch_id: identifier (0–255) embedded in the watch notification
+	 * info field; allows multiplexing several watches on one pipe
+	 */
+	__u32 watch_id;
+
+	/** @flags: must be zero */
+	__u32 flags;
+
+	/** @pad: reserved, must be zero */
+	__u32 pad;
+};
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/uapi/drm/xe_drm_events.h b/include/uapi/drm/xe_drm_events.h
new file mode 100644
index 000000000000..6cc7528bfb9b
--- /dev/null
+++ b/include/uapi/drm/xe_drm_events.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _UAPI_XE_DRM_EVENTS_H_
+#define _UAPI_XE_DRM_EVENTS_H_
+
+#include <linux/types.h>
+#include <linux/watch_queue.h>
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/**
+ * enum drm_xe_watch_event - Xe device watch event subtypes
+ *
+ * Subtypes for notifications delivered via %WATCH_TYPE_DRM_XE_NOTIFY when
+ * reading from a pipe subscribed with %DRM_IOCTL_XE_WATCH_QUEUE.
+ */
+enum drm_xe_watch_event {
+	/**
+	 * @DRM_XE_WATCH_EVENT_VM_ERR: a VM has encountered an error.
+	 *
+	 * Indicates that a fatal or resource error occurred within the given
+	 * VM.  The vm_id of the affected VM is carried in the
+	 * @drm_xe_watch_notification_vm_err::vm_id field of the extended
+	 * notification record.
+	 */
+	DRM_XE_WATCH_EVENT_VM_ERR = 0,
+};
+
+/**
+ * struct drm_xe_watch_notification_vm_err - VM error event notification
+ *
+ * Notification record delivered for %DRM_XE_WATCH_EVENT_VM_ERR.
+ * The record type is always %WATCH_TYPE_DRM_XE_NOTIFY and the subtype is
+ * %DRM_XE_WATCH_EVENT_VM_ERR.
+ */
+struct drm_xe_watch_notification_vm_err {
+	/** @base: common watch notification header */
+	struct watch_notification base;
+
+	/** @vm_id: ID of the VM that encountered an error */
+	__u32 vm_id;
+
+	/** @error_code: error code describing the error condition (negative errno) */
+	__s32 error_code;
+
+	/**
+	 * @timestamp_ns: CLOCK_MONOTONIC timestamp in nanoseconds at the
+	 * point the error was detected
+	 */
+	__u64 timestamp_ns;
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* _UAPI_XE_DRM_EVENTS_H_ */
-- 
2.54.0

