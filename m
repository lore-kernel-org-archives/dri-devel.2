Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42389C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEDF10F39B;
	Thu, 24 Sep 2026 08:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="amOblO8R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0D710F39A;
 Thu, 24 Sep 2026 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790237137; x=1821773137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GFMPn3sE9I3IhbRAr5tVSygIAjo9+YPbqxcDiSp4Kvc=;
 b=amOblO8Ro7MLNqCa4nhangcFtDM2sV4C7Mrpp+EAS3IFqFEjctnubOjz
 iB7HK9Tr5JFQ90ATH4XSdkavyKnFk9hS8tiB6DX3SimBEnbG6qz+zURDn
 ux2An55IHfws1x2bRS7jyZhlwnSg16BU3mTf9IrZ7no67T7yYaN9zNjjo
 kjkyfOJD4HVUEduVD3Dh4CiTwl8INVJ3MYqJ7GLe9KmBeE7JBKRWMYqLJ
 rcM7JiqsQVpUOBS/IoPz3bMNvrSmAk8sguZr9yclDeRIB4/bvCYWBSuI6
 3JFZ/0i61tFCV69x4m55xVsnQ2STCrlLnhC5Qx9g/LYp5XgzN6RfotgoU Q==;
X-CSE-ConnectionGUID: sO4p9GZESzy7iziG0YSGZA==
X-CSE-MsgGUID: wQ1ARC4oRH+CRxDfTZTiOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89771245"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="89771245"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 01:05:37 -0700
X-CSE-ConnectionGUID: SwKtoSMuRzikxd48p7VXEA==
X-CSE-MsgGUID: j6Q8RlAASrSHtlI2gKJowQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277702723"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.129])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 01:05:34 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 2/3] drm/xe: Don't unload the driver until all drm devices
 are freed
Date: Thu, 24 Sep 2026 10:04:54 +0200
Message-ID: <20260924080455.25458-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924080455.25458-1-thomas.hellstrom@linux.intel.com>
References: <20260924080455.25458-1-thomas.hellstrom@linux.intel.com>
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

xe, and shared helpers it uses such as drm_gpuvm, already take bare
drm_device references (drm_dev_get()) from several contexts, for
example GuC submission fence workers, EU stall, OA and PMU sampling
code, and drm_gpuvm's own vm object lifetime, without pairing them
with a module reference. Since xe_exit() is only invoked after the
module's own refcount has dropped to zero, none of these references
currently prevent `rmmod xe` from proceeding while they, or the
underlying xe_device release path they can trigger, are still
outstanding, i.e. driver code belonging to a module whose text is
being freed could still end up executing.

Close this gap by keeping a device-count and waiting for it to reach
zero at module unload, then waiting for any release callback that has
started executing to finish, using the drm_dev_release_barrier()
infrastructure introduced in the previous commit.

The wait for the device-count to reach zero at module unload is
unbounded and non-interruptible. Rather than blocking silently forever
if a reference is ever leaked, use wait_var_event_timeout() with a 20s
timeout, well above the typical maximum dma_fence signalling time, and
warn once if devices still remain by then, before falling back to an
unbounded wait_var_event() so a stuck rmmod is at least observable
instead of an indefinite, silent hang.

Note that if a reference genuinely leaks, this still ends up as an
indefinite uninterruptible sleep, which may eventually trip the
kernel's hung-task watchdog. The alternative would be for these bare
drm_device references to also take a module reference, which would
instead make the module unable to be unloaded unless all its devices are
manually unbound first. The wait-based approach is chosen here since it
keeps rmmod usable in the common case.

Register a driver-private SRCU domain via the new
&drm_driver.release_srcu field on both xe drm_driver instances, and
pass the driver to drm_dev_release_barrier(). This keeps xe's wait for
its own release callbacks to complete from blocking on unrelated
drivers' release paths.

xe_device_exit() is added as a new module exit hook. Its entry in the
init_funcs[] table is placed between xe_destroy_wq_module_init and
xe_register_pci_driver, so that (exit functions run in reverse array
order) it executes after xe_unregister_pci_driver() has forced all
devices to unbind, but before xe_destroy_wq_module_exit() tears down
the module-lifetime xe_destroy_wq. This preserves xe_destroy_wq's
existing teardown ordering relative to xe_sched_job_module_exit() and
xe_hw_fence_module_exit(), which destroy kmem_caches that work drained
from xe_destroy_wq relies on, while ensuring xe_destroy_wq itself is
only torn down once xe_device_exit() has confirmed no more work can be
queued onto it.

v2:
- Updated commit message to describe the actual implementation (a
  single 20s wait_var_event_timeout() followed by one pr_warn() and an
  unbounded wait_var_event(), rather than a loop retrying with a
  diagnostic every 10s) and its uninterruptible-sleep tradeoff
  (sashiko)

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: LLM
---
 drivers/gpu/drm/xe/xe_device.c | 42 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.h |  2 ++
 drivers/gpu/drm/xe/xe_module.c | 18 ++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 205cb4e7f9e8..bfb1b482d83d 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -8,6 +8,7 @@
 #include <linux/aperture.h>
 #include <linux/delay.h>
 #include <linux/fault-inject.h>
+#include <linux/srcu.h>
 #include <linux/units.h>
 
 #include <drm/drm_client.h>
@@ -311,6 +312,13 @@ bool xe_is_xe_file(const struct file *file)
 	return file->f_op == &xe_driver_fops;
 }
 
+/*
+ * Driver-owned SRCU domain used to synchronize completion of driver release
+ * callbacks with drm_dev_release_barrier(), so that xe_device_exit() doesn't
+ * have to wait on unrelated drivers' release paths.
+ */
+DEFINE_STATIC_SRCU(xe_dev_release_srcu);
+
 static const struct drm_driver regular_driver = {
 	.driver_features =
 	    XE_DISPLAY_DRIVER_FEATURES |
@@ -335,6 +343,7 @@ static const struct drm_driver regular_driver = {
 	.major = DRIVER_MAJOR,
 	.minor = DRIVER_MINOR,
 	.patchlevel = DRIVER_PATCHLEVEL,
+	.release_srcu = &xe_dev_release_srcu,
 	XE_DISPLAY_DRIVER_OPS,
 };
 
@@ -357,6 +366,7 @@ static const struct drm_driver admin_only_driver = {
 	.major = DRIVER_MAJOR,
 	.minor = DRIVER_MINOR,
 	.patchlevel = DRIVER_PATCHLEVEL,
+	.release_srcu = &xe_dev_release_srcu,
 };
 
 /**
@@ -372,6 +382,9 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
 }
 #endif
 
+/* Number of allocated struct xe_device */
+static atomic_t xe_device_count;
+
 static void xe_device_destroy(struct drm_device *dev, void *dummy)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -391,6 +404,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
 		destroy_workqueue(xe->destroy_wq);
 
 	ttm_device_fini(&xe->ttm);
+
+	if (atomic_dec_and_test(&xe_device_count))
+		wake_up_var(&xe_device_count);
 }
 
 /**
@@ -461,6 +477,7 @@ int xe_device_init_early(struct xe_device *xe)
 		return err;
 
 	xe_bo_dev_init(&xe->bo_device);
+	atomic_inc(&xe_device_count);
 	err = drmm_add_action_or_reset(&xe->drm, xe_device_destroy, NULL);
 	if (err)
 		return err;
@@ -1501,3 +1518,28 @@ struct xe_vm *xe_device_asid_to_vm(struct xe_device *xe, u32 asid)
 
 	return vm;
 }
+
+/**
+ * xe_device_exit() - Device subsystem exit function.
+ *
+ * Exit function to be called at module unload time.
+ */
+void xe_device_exit(void)
+{
+	/*
+	 * Wait for all devices to be freed. 20s is well above the typical
+	 * maximum dma_fence signalling time, so warn and keep waiting if
+	 * we're still not done by then, since it may indicate a leaked
+	 * xe_device reference is stalling module unload.
+	 */
+	if (!wait_var_event_timeout(&xe_device_count,
+				    !atomic_read(&xe_device_count),
+				    HZ * 20)) {
+		pr_warn("%s: Waiting for %d xe device(s) to be freed before unloading.\n",
+			DRIVER_NAME, atomic_read(&xe_device_count));
+		wait_var_event(&xe_device_count, !atomic_read(&xe_device_count));
+	}
+
+	/* Wait for any driver release callbacks to complete */
+	drm_dev_release_barrier(&regular_driver);
+}
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index 6d3d6d5eba29..83d6dafab53c 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -283,6 +283,8 @@ static inline bool xe_device_is_admin_only(const struct xe_device *xe)
 }
 #endif
 
+void xe_device_exit(void);
+
 /*
  * Occasionally it is seen that the G2H worker starts running after a delay of more than
  * a second even after being queued and activated by the Linux workqueue subsystem. This
diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 4bc28dfc1992..c61bd33546f2 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -12,7 +12,7 @@
 #include <drm/drm_module.h>
 
 #include "xe_defaults.h"
-#include "xe_device_types.h"
+#include "xe_device.h"
 #include "xe_drv.h"
 #include "xe_configfs.h"
 #include "xe_hw_fence.h"
@@ -162,6 +162,22 @@ static const struct init_funcs init_funcs[] = {
 		.init = xe_destroy_wq_module_init,
 		.exit = xe_destroy_wq_module_exit,
 	},
+	/*
+	 * xe_destroy_wq_module_exit() must run after xe_device_exit()
+	 * (below), since freeing a device can still queue work on
+	 * xe_destroy_wq that must be drained before the module can safely
+	 * unload. At the same time, xe_device_exit() must run after
+	 * xe_unregister_pci_driver() (below), and xe_destroy_wq_module_exit()
+	 * must run before xe_sched_job_module_exit() and
+	 * xe_hw_fence_module_exit() (above), whose kmem_caches are still used
+	 * by work drained from xe_destroy_wq. Exit functions run in reverse
+	 * array order, so this entry must sit between the
+	 * xe_destroy_wq_module_init entry above and the xe_register_pci_driver
+	 * entry below.
+	 */
+	{
+		.exit = xe_device_exit,
+	},
 	{
 		.init = xe_register_pci_driver,
 		.exit = xe_unregister_pci_driver,
-- 
2.55.0

