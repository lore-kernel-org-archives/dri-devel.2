Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E4AF53D6D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B42F10E488;
	Mon, 16 Mar 2026 16:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DogpF8Pi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B6810E31F;
 Mon, 16 Mar 2026 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773678037; x=1805214037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xzR4xFHq43qJ/uoOx5DLMHnQId6PD5EbtJDHw0fss7M=;
 b=DogpF8PiNIs/ifAHrQ1YRCyJ7+1/t4H1hJK8xpbYA7l3/Gam8JxRM0/O
 Lp4ytctv8lj/SC4EglwwMNJBgzyj5gXnfHfam9sfeb/6MaEGFQXx4USvi
 Rhd48OzXyDjoLPB2AQdeYCT2bnVVgqoKWpUgcsgnAf2EZXZ1hHyz7ScxM
 qnqO/njNNuKVWgPieKfSUnHfsdRHbwPhxSCclxZmSQI6XPr7gMIc9j+H+
 4VuKcAMwLGKWaT3NaMmypFOpag/oEsh+ch3Qzf5JRKRI/gQ3SSnE3WqDw
 mvB551hNZ3ZCmYUzmlEM595dprlhim1cgb2HkE/EwwpRN6cSULDMx0Bo3 A==;
X-CSE-ConnectionGUID: cHjPYZjoTWunlp7Xca2k5A==
X-CSE-MsgGUID: ZV1hLjMMT8GxfI4QgIWFSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74884832"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74884832"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:20:37 -0700
X-CSE-ConnectionGUID: fWyCDtNUTX+MhqK8BntZow==
X-CSE-MsgGUID: KK1RZRXJS7iKve+jCvKVig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="244993963"
Received: from zzombora-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.233])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:20:34 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/xe: Don't unload the driver until all drm devices are
 freed
Date: Mon, 16 Mar 2026 17:20:02 +0100
Message-ID: <20260316162002.13479-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316162002.13479-1-thomas.hellstrom@linux.intel.com>
References: <20260316162002.13479-1-thomas.hellstrom@linux.intel.com>
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

Don't unload the driver until all drm devices are freed.
This will help ensure that helper components don't need to
maintain a module reference while holding a drm device reference.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_device.c | 19 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.h |  2 ++
 drivers/gpu/drm/xe/xe_module.c |  5 ++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 3462645ca13c..738124a73064 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -415,6 +415,8 @@ static struct drm_driver driver = {
 	.patchlevel = DRIVER_PATCHLEVEL,
 };
 
+static atomic_t xe_device_count;
+
 static void xe_device_destroy(struct drm_device *dev, void *dummy)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -434,6 +436,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
 		destroy_workqueue(xe->destroy_wq);
 
 	ttm_device_fini(&xe->ttm);
+
+	if (atomic_dec_and_test(&xe_device_count))
+		wake_up_var(&xe_device_count);
 }
 
 struct xe_device *xe_device_create(struct pci_dev *pdev,
@@ -459,6 +464,7 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 		return ERR_PTR(err);
 
 	xe_bo_dev_init(&xe->bo_device);
+	atomic_inc(&xe_device_count);
 	err = drmm_add_action_or_reset(&xe->drm, xe_device_destroy, NULL);
 	if (err)
 		return ERR_PTR(err);
@@ -1397,3 +1403,16 @@ struct xe_vm *xe_device_asid_to_vm(struct xe_device *xe, u32 asid)
 
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
+	/* Wait for all devices to be freed. */
+	wait_var_event(&xe_device_count, !atomic_read(&xe_device_count));
+	/* Wait for any driver release callbacks to complete */
+	drm_dev_release_barrier();
+}
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index 39464650533b..d827a443e3d4 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -206,6 +206,8 @@ bool xe_is_xe_file(const struct file *file);
 
 struct xe_vm *xe_device_asid_to_vm(struct xe_device *xe, u32 asid);
 
+void xe_device_exit(void);
+
 /*
  * Occasionally it is seen that the G2H worker starts running after a delay of more than
  * a second even after being queued and activated by the Linux workqueue subsystem. This
diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 4cb578182912..816e02f4bdaf 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -11,7 +11,7 @@
 #include <drm/drm_module.h>
 
 #include "xe_defaults.h"
-#include "xe_device_types.h"
+#include "xe_device.h"
 #include "xe_drv.h"
 #include "xe_configfs.h"
 #include "xe_hw_fence.h"
@@ -97,6 +97,9 @@ struct init_funcs {
 };
 
 static const struct init_funcs init_funcs[] = {
+	{
+		.exit = xe_device_exit,
+	},
 	{
 		.init = xe_check_nomodeset,
 	},
-- 
2.53.0

