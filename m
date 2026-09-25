Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69E3C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF15810FAAD;
	Fri, 25 Sep 2026 13:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Iu30Ga0s";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8E110FA9F;
 Fri, 25 Sep 2026 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790343252; x=1821879252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Wiue+KTeqP/K+JVKvZRB/tXA1RwS3Pr9Wyh09a/xoo=;
 b=Iu30Ga0s6Q15Vsh3w012/2lFaXhsv5LYMJVer8t8uGNinwBfLtS63DH2
 dwIHT0eKjC8TZYHomSpth8PXQp/uFkfeUU+5YszeZMNqlVWQzSGLYdqNh
 Or5Ydm1Zilg4gMfruvhEZvWj+GqceBs3uaDtz1CwfzoPetf3bps9XHYaZ
 INnBXQkEQCNVriDhHhlIfWEXpHWBXySJCX6v6mqF7F7kwtJcPf2ujR9Qw
 ykiO31Ey01t9XnqXNVfiKhOb/8EBuEJPat16gKZRg/mYdu91unZsWlnHg
 WMFEyd8ztymO5kM+InvtNQhXG7iQ0izFUUy4pmNI6j/FjTGojNfx21c3U A==;
X-CSE-ConnectionGUID: jbzeWpYGQK++7O7eWIP5Jw==
X-CSE-MsgGUID: W62RyoOWT/6kXx4hWO/KrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="100461163"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="100461163"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:34:12 -0700
X-CSE-ConnectionGUID: 5AOeNnGWRh2g+7WsauasTw==
X-CSE-MsgGUID: t8rdJVPVSAe4a/MvH5gtSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273888335"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.245.121])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:34:09 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 2/3] drm/xe: Don't unload the driver until all drm devices
 are freed
Date: Fri, 25 Sep 2026 15:33:34 +0200
Message-ID: <20260925133335.149679-3-thomas.hellstrom@linux.intel.com>
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

drm_dev_release_barrier() uses a single, global SRCU domain shared by
all drivers, so xe's wait for its own release callbacks may
occasionally end up blocking on an unrelated driver's release path
too, a trade-off accepted in favor of not requiring each driver to set
up and tear down its own SRCU domain.

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

v3:
- drm_dev_release_barrier() no longer takes a &drm_driver argument
  since it now uses a single, global SRCU domain; drop the
  &drm_driver.release_srcu registration on both xe drm_driver
  instances accordingly (Christian König)

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: LLM
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c | 32 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.h |  2 ++
 drivers/gpu/drm/xe/xe_module.c | 18 +++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 205cb4e7f9e8..c54d734bd890 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -372,6 +372,9 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
 }
 #endif
 
+/* Number of allocated struct xe_device */
+static atomic_t xe_device_count;
+
 static void xe_device_destroy(struct drm_device *dev, void *dummy)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -391,6 +394,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
 		destroy_workqueue(xe->destroy_wq);
 
 	ttm_device_fini(&xe->ttm);
+
+	if (atomic_dec_and_test(&xe_device_count))
+		wake_up_var(&xe_device_count);
 }
 
 /**
@@ -461,6 +467,7 @@ int xe_device_init_early(struct xe_device *xe)
 		return err;
 
 	xe_bo_dev_init(&xe->bo_device);
+	atomic_inc(&xe_device_count);
 	err = drmm_add_action_or_reset(&xe->drm, xe_device_destroy, NULL);
 	if (err)
 		return err;
@@ -1501,3 +1508,28 @@ struct xe_vm *xe_device_asid_to_vm(struct xe_device *xe, u32 asid)
 
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
+	drm_dev_release_barrier();
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

