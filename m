Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAFCC9830C
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0FF10F089;
	Wed, 23 Sep 2026 14:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LWoKFB0u";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 520AB10F083;
 Wed, 23 Sep 2026 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790172566; x=1821708566;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BChQFet6oIwesbA1H2eB6f3CQ+7BQkmeUsZXA8y6XYY=;
 b=LWoKFB0uIs8bg0rczOVyC5tNU69sZhKWy4ILe2AMOgj6bJFR+NsoChSQ
 T507XAzQOElRwnMrBiLVlcHqGcB66/nPspUa3l5o+Cs2bHoIFdfs7qEo7
 PSXg7ycpTpBWlxOaxdBIiuXD5zgUzLWd7s1i/e6TAMX1MXkUsdRXG3SO8
 vSbBcp/uXLaV+ZP0PeugvAc2y2ONNQa3zbwj00aQKdzh2B92hdxdTNg4p
 lqIfjaflDxxspPjwhI1t4HcFYvuRu6yMB9oeSSo/aNsHdBqWmMuq7clPt
 2+LRkz2wS1RWe9VuKaqChlGa6gPvW+s+U+b54iXj0R5odjuncPdGqGDXN g==;
X-CSE-ConnectionGUID: Yk5ao+TRTVeOS5KQBEzGqA==
X-CSE-MsgGUID: em6YA22JStiWzpavwXPXqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101535319"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="101535319"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:09:26 -0700
X-CSE-ConnectionGUID: JjPl+y2zTvCws/OfAbB8yg==
X-CSE-MsgGUID: MuUSYUA0RJm1/AITld1KyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4885836"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.245.245])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:09:24 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm: Provide a drm_dev_release_barrier() function to wait
 for device release callbacks
Date: Wed, 23 Sep 2026 16:08:42 +0200
Message-ID: <20260923140844.390822-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923140844.390822-1-thomas.hellstrom@linux.intel.com>
References: <20260923140844.390822-1-thomas.hellstrom@linux.intel.com>
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

Driver and drm helper code is increasingly relying on holding a bare
&drm_device reference (drm_dev_get()) without also holding a module
reference on the module that created the device.

For example drm_gpuvm_init() takes a drm_dev_get() reference on the
&drm_gpuvm's behalf with no accompanying module reference at all, and
drm_gpuvm_free() later calls the driver-supplied gpuvm->ops->vm_free()
callback, which lives in the driver module, before dropping that
reference. xe also takes bare drm_device references itself from
several asynchronous contexts, such as GuC submission fence workers,
EU stall, OA and PMU sampling code, relying only on those references
being dropped before the underlying xe_device, and eventually the
driver module, can be torn down.

If the module that created such a device is unloaded while one of
these bare references is still outstanding, and the corresponding
drm_dev_put() only completes after the module has already been
removed, the driver's ->release() callback, any drm managed release
actions, or a driver callback such as gpuvm->ops->vm_free(), all of
which live in that module's, by then freed, code, can end up being
invoked out of memory that no longer contains valid code.

Requiring every one of these bare drm_device references to also take a
module reference, as drm_pagemap does today via try_module_get(),
doesn't scale to shared helpers and driver-internal code with many
call sites, and is easy to get wrong.

Fix this properly by letting drivers keep a drm device-count and
ensure the module isn't unloaded until that count has dropped to zero
and until any release callback that had already started executing has
also finished executing.

To help with the latter, add a drm_dev_release_barrier() function.
The function ensures that any caller that has started executing
device release callbacks has also finished executing them.

Use SRCU for the implementation.

Rather than a single SRCU domain shared by all drivers, which would
mean drm_dev_release_barrier() could unnecessarily block a driver's
module unload on unrelated drivers' release callbacks, require each
driver that wants to use drm_dev_release_barrier() to supply its own
SRCU domain via a new &drm_driver.release_srcu field. Drivers should
define a static SRCU domain (DEFINE_STATIC_SRCU()) and set this field
to point at it. Leaving the field unset means @release and drm managed
release actions for that driver's devices simply aren't synchronized
against, and calling drm_dev_release_barrier() for such a driver is a
no-op that triggers a warning.

Since &drm_driver.release_srcu is a new field, every existing struct
drm_driver instance in the tree was scanned to confirm none of them
would leave it uninitialized with indeterminate content. All in-tree
instances have static storage duration (plain or const static
file-scope objects), or are members of a KUnit test fixture zeroed via
kunit_kzalloc(); no instance is stack-allocated or heap-allocated
without zeroing. Objects with static storage duration are guaranteed
by the C standard to have any member without an explicit initializer
zero-initialized, so the new field is reliably NULL, and
drm_dev_release() simply skips the SRCU critical section, for all
drivers that don't set it.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: LLM
---
 drivers/gpu/drm/drm_drv.c | 56 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_drv.h     | 24 +++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 0cdc606af8d1..df32821e693a 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -921,18 +921,57 @@ EXPORT_SYMBOL(drm_dev_alloc);
 static void drm_dev_release(struct kref *ref)
 {
 	struct drm_device *dev = container_of(ref, struct drm_device, ref);
+	struct srcu_struct *srcu = dev->driver->release_srcu;
+	int idx = -1;
 
 	/* Just in case register/unregister was never called */
 	drm_debugfs_dev_fini(dev);
 
+	if (srcu)
+		idx = srcu_read_lock(srcu);
+
 	if (dev->driver->release)
 		dev->driver->release(dev);
 
 	drm_managed_release(dev);
 
+	if (srcu)
+		srcu_read_unlock(srcu, idx);
+
 	kfree(dev->managed.final_kfree);
 }
 
+/**
+ * drm_dev_release_barrier() - Ensure drm device release callbacks are finished
+ * @driver: driver whose release callbacks to wait for
+ *
+ * If a device release method or any of the drm managed release callbacks
+ * have been called for a device created with @driver, wait until all of
+ * them have finished executing. This function can be used to help determine
+ * whether it's safe to unload a driver module.
+ *
+ * Assume for example the driver maintains a device count which is decremented
+ * using a drmm callback or a device release callback. From a drm device
+ * lifetime POV, it's then safe to unload the driver when that device-count
+ * has reached zero and drm_dev_release_barrier() has been called.
+ *
+ * @driver must have &drm_driver.release_srcu set to a driver-owned
+ * &struct srcu_struct for this function to have anything to wait for.
+ *
+ * This function only waits for the &drm_driver.release callback and drm
+ * managed release actions to finish. It does not, by itself, guarantee that
+ * whoever called drm_dev_put() to drop the reference triggering that release
+ * has itself finished running. See drm_dev_put() for that invariant.
+ */
+void drm_dev_release_barrier(const struct drm_driver *driver)
+{
+	if (drm_WARN_ON_ONCE(NULL, !driver || !driver->release_srcu))
+		return;
+
+	synchronize_srcu(driver->release_srcu);
+}
+EXPORT_SYMBOL(drm_dev_release_barrier);
+
 /**
  * drm_dev_get - Take reference of a DRM device
  * @dev: device to take reference of or NULL
@@ -958,6 +997,23 @@ EXPORT_SYMBOL(drm_dev_get);
  *
  * This decreases the ref-count of @dev by one. The device is destroyed if the
  * ref-count drops to zero.
+ *
+ * If this call may drop the last reference, the calling code itself is
+ * responsible for ensuring it isn't unloaded (for example as part of a
+ * module) before this call has returned. This matters in particular for
+ * drivers relying on drm_dev_release_barrier() to determine when it's safe to
+ * unload, since that function only waits for the &drm_driver.release
+ * callback and drm managed release actions to finish, not for whoever calls
+ * drm_dev_put() to finish calling it.
+ *
+ * A common case is dropping the last reference from a deferred context, such
+ * as a workqueue item. In that case it's the responsibility of whoever
+ * queued that work item to guarantee it has run to completion before the
+ * module can unload, for example by draining a module-lifetime workqueue at
+ * module exit time. Holding a module reference only until the work item
+ * starts running is insufficient: that reference would already be dropped
+ * before this call runs, even though this call is what may still need the
+ * module's code to remain resident.
  */
 void drm_dev_put(struct drm_device *dev)
 {
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index b23830494ed4..30bb8727a896 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -48,6 +48,7 @@ struct drm_display_mode;
 struct drm_mode_create_dumb;
 struct drm_printer;
 struct sg_table;
+struct srcu_struct;
 
 /**
  * enum drm_driver_feature - feature flags
@@ -255,6 +256,28 @@ struct drm_driver {
 	 */
 	void (*release) (struct drm_device *);
 
+	/**
+	 * @release_srcu:
+	 *
+	 * Optional driver-owned SRCU domain used to synchronize completion of
+	 * the @release callback and drm managed release actions with
+	 * drm_dev_release_barrier().
+	 *
+	 * Left unset, @release and drm managed release actions for this
+	 * driver's devices aren't synchronized with drm_dev_release_barrier()
+	 * at all, and calling drm_dev_release_barrier() for this driver is a
+	 * no-op that triggers a warning.
+	 *
+	 * Drivers that want to use drm_dev_release_barrier(), for example to
+	 * help determine when it's safe to unload the driver module, should
+	 * define their own static SRCU domain (DEFINE_STATIC_SRCU()) and set
+	 * this field to point at it. Each driver should use its own domain,
+	 * so that drm_dev_release_barrier() only waits for that driver's own
+	 * release callbacks, rather than also for unrelated drivers sharing
+	 * the same domain.
+	 */
+	struct srcu_struct *release_srcu;
+
 	/**
 	 * @master_set:
 	 *
@@ -485,6 +508,7 @@ void drm_dev_exit(int idx);
 void drm_dev_unplug(struct drm_device *dev);
 int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 			 struct drm_wedge_task_info *info);
+void drm_dev_release_barrier(const struct drm_driver *driver);
 
 /**
  * drm_dev_is_unplugged - is a DRM device unplugged
-- 
2.55.0

