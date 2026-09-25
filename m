Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C228C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C94910FA9C;
	Fri, 25 Sep 2026 13:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JbtdyyWQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF50410FA9C;
 Fri, 25 Sep 2026 13:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790343249; x=1821879249;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3uVgxO16E80pFDQCDMuae+BLgs8SKoNwryj3+Wbk1AQ=;
 b=JbtdyyWQJbcRxpEXZ7RKSv90+dSnJWU5lgZl5354l7Z77gn3MbVTm9nQ
 AN0INnP4AnryxNqjaZ1+a8prWOcbkgwMHLWuFWUNoOWOFtTM5gkk1wsfe
 tJBExLgItfEg9jUeXJkX1Z/1Gwbuzb+Qh6DxodTNajITWIpWEHennpsnJ
 hbgMZIXZh1vuQSI6oWbs8cgEl4cpNKHqZ1Lk/GjabOLbfQZajRuL77c9v
 J5gFr3BfxE+Ia96bG6s3WH4lSCjhUHfgj1yA511FqIfiNvvJ5hgWAIrFN
 ir06fqCAE6ISf5Tau7/IH2PFOvcla3BJjXaVKyuKNBOR1vBwyLfnFVq0K A==;
X-CSE-ConnectionGUID: yV2QBLsITVWskGjrLCSitg==
X-CSE-MsgGUID: 43xjeRJDQuaLAboj8vkzuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="100461156"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="100461156"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:34:09 -0700
X-CSE-ConnectionGUID: sOGUFsl1Ra6jGHet1SnqdQ==
X-CSE-MsgGUID: rQ3tU+jXTiSQM416pT8uwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273888299"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.245.121])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:34:07 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 1/3] drm: Provide a drm_dev_release_barrier() function to
 wait for device release callbacks
Date: Fri, 25 Sep 2026 15:33:33 +0200
Message-ID: <20260925133335.149679-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
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

Use SRCU for the implementation, with a single, global SRCU domain
shared by all drivers. This means a driver's call to
drm_dev_release_barrier() may occasionally end up waiting for an
unrelated driver's release callback to finish, but release callbacks
are expected to run quickly, and sharing one domain avoids the
bookkeeping that a per-driver SRCU domain would require, such as
adding a new &drm_driver field that every existing struct drm_driver
instance in the tree would need to be audited for, and initializing
and cleaning up that domain around driver (un)registration.

v2:
- Use plain WARN_ON_ONCE() instead of drm_WARN_ON_ONCE(NULL, ...) in
  drm_dev_release_barrier(), since passing a NULL drm_device caused
  the warning path itself to dereference that NULL pointer inside
  dev_driver_string()/dev_name() (sashiko)

v3:
- Use a single, global SRCU domain shared by all drivers instead of
  requiring each driver to supply its own via a new
  &drm_driver.release_srcu field, accepting that a driver's call to
  drm_dev_release_barrier() may then occasionally block on unrelated
  drivers' release callbacks (Christian König)

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: LLM
---
 drivers/gpu/drm/drm_drv.c | 61 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_drv.h     |  1 +
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 0cdc606af8d1..0641e61ee931 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -918,21 +918,65 @@ struct drm_device *drm_dev_alloc(const struct drm_driver *driver,
 }
 EXPORT_SYMBOL(drm_dev_alloc);
 
+/*
+ * Single, global SRCU domain used to synchronize completion of every
+ * driver's @release callback and drm managed release actions with
+ * drm_dev_release_barrier(). Sharing one domain across all drivers means a
+ * driver's call to drm_dev_release_barrier() may occasionally have to wait
+ * for unrelated drivers' release callbacks to finish, but that's a
+ * reasonable trade-off given that release callbacks are expected to run
+ * quickly, and it avoids the bookkeeping of a per-driver SRCU domain.
+ */
+DEFINE_STATIC_SRCU(drm_release_srcu);
+
 static void drm_dev_release(struct kref *ref)
 {
 	struct drm_device *dev = container_of(ref, struct drm_device, ref);
+	int idx;
 
 	/* Just in case register/unregister was never called */
 	drm_debugfs_dev_fini(dev);
 
+	idx = srcu_read_lock(&drm_release_srcu);
+
 	if (dev->driver->release)
 		dev->driver->release(dev);
 
 	drm_managed_release(dev);
 
+	srcu_read_unlock(&drm_release_srcu, idx);
+
 	kfree(dev->managed.final_kfree);
 }
 
+/**
+ * drm_dev_release_barrier() - Ensure drm device release callbacks are finished
+ *
+ * If a device release method or any of the drm managed release callbacks
+ * have been called for any drm_device, wait until all of them have finished
+ * executing. This function can be used to help determine whether it's safe
+ * to unload a driver module.
+ *
+ * Assume for example a driver maintains a device count which is decremented
+ * using a drmm callback or a device release callback. From a drm device
+ * lifetime POV, it's then safe to unload the driver when that device-count
+ * has reached zero and drm_dev_release_barrier() has been called.
+ *
+ * Since a single, global SRCU domain is used for all drivers, this function
+ * may also end up waiting for unrelated drivers' release callbacks to
+ * complete.
+ *
+ * This function only waits for the &drm_driver.release callback and drm
+ * managed release actions to finish. It does not, by itself, guarantee that
+ * whoever called drm_dev_put() to drop the reference triggering that release
+ * has itself finished running. See drm_dev_put() for that invariant.
+ */
+void drm_dev_release_barrier(void)
+{
+	synchronize_srcu(&drm_release_srcu);
+}
+EXPORT_SYMBOL(drm_dev_release_barrier);
+
 /**
  * drm_dev_get - Take reference of a DRM device
  * @dev: device to take reference of or NULL
@@ -958,6 +1002,23 @@ EXPORT_SYMBOL(drm_dev_get);
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
index b23830494ed4..169b404df54a 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -485,6 +485,7 @@ void drm_dev_exit(int idx);
 void drm_dev_unplug(struct drm_device *dev);
 int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 			 struct drm_wedge_task_info *info);
+void drm_dev_release_barrier(void);
 
 /**
  * drm_dev_is_unplugged - is a DRM device unplugged
-- 
2.55.0

