Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D69606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SvI4Pa/7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C64E10E331;
	Mon, 16 Nov 2026 06:28:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E71110E331;
 Mon, 16 Nov 2026 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794810499; x=1826346499;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gjlBDMWL+HwgcoG0WSX2PAY/Pcy2a5iOGgAQjKmvld8=;
 b=SvI4Pa/7kseiJl9z41gGI+ZjNQLLG8OmJewmGuSl4nKrQcWZMPeMEFUe
 W2LU6VAk8B03trv9fwqyx6n6gn/DU03r0c4TyjZRVezrCWNfxUEn4p1rQ
 m8Tav74A2wlOXaiA0+dnkGEeiHmoqvCYPL59P36+P4MpximfuC5juH391
 IqPSNe+fTPtGd9MP/sDolAUHSd4qlq8PzQ2xSUgxtuzvRMOgg9dHQnGn1
 WFGIDr09z8YmYiVCrdz1olJba9UuyyE7QnXR1Beda0ZqbszXZME/guLLT
 DkIybqSu+Va8e/2lwDK5zKDdKqIRyKCQ9alRrMH7am7VtRRRmlsCM04pl g==;
X-CSE-ConnectionGUID: t7UChSefRjaw5BM9IKj4qQ==
X-CSE-MsgGUID: QIjhz213R/a52+ApspNWww==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3575730"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3575730"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 22:28:18 -0800
X-CSE-ConnectionGUID: SY7pVK8RTz2FPRlK1V2ayg==
X-CSE-MsgGUID: MPqLe/8AQWGvtUJaN7LCcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9344694"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 22:28:16 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 sanjay.kumar.yadav@intel.com, tejas.upadhyay@intel.com,
 daniel.charles@intel.com
Subject: [PATCH v3 1/3] drm/xe: Hold a device reference across deferred VM
 destruction
Date: Mon, 16 Nov 2026 11:58:02 +0530
Message-ID: <20261116062804.1242511-2-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116062804.1242511-1-arvind.yadav@intel.com>
References: <20261116062804.1242511-1-arvind.yadav@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe_vm_free() queues vm_destroy_work_func() and returns.
drm_gpuvm_free() then drops its device reference, but the worker
still accesses device state while finishing VM destruction.

Take a device reference before queueing the work and release it
after the worker has finished using the device.

Run the worker on the module-lifetime destroy workqueue. Releasing
the last device reference can call xe_device_destroy(), which drains
xe->destroy_wq. Running on that per-device workqueue would make the
worker wait for itself.

v3:
- Move final VM destruction to the module-lifetime destroy workqueue
  in this patch to avoid self-deadlock on the last device put. (Sashiko)

Fixes: 61e18525023a ("drm/xe: Route deferred xe_vma/xe_vm teardown off system_dfl_wq")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Daniel Charles <daniel.charles@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Assisted-by: LLM
Tested-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index dd855876f571..12afb3363e79 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2109,6 +2109,8 @@ static void vm_destroy_work_func(struct work_struct *w)
 		xe_file_put(vm->xef);
 
 	kfree(vm);
+
+	drm_dev_put(&xe->drm);
 }
 
 static void xe_vm_free(struct drm_gpuvm *gpuvm)
@@ -2116,11 +2118,18 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
 	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
 
 	/*
-	 * To destroy the VM we need to be able to sleep.
-	 * drm_gpuvm keeps at least one device reference at this
-	 * point so xe->destroy_wq must still be alive.
+	 * drm_gpuvm drops its device reference as soon as this callback
+	 * returns, but vm_destroy_work_func() still uses device state. Hold a
+	 * reference across the deferred work.
+	 */
+	drm_dev_get(&vm->xe->drm);
+
+	/*
+	 * The worker may release the last device reference. Use the
+	 * module-lifetime workqueue so device destruction cannot drain
+	 * the workqueue running this worker.
 	 */
-	queue_work(vm->xe->destroy_wq, &vm->destroy_work);
+	xe_destroy_wq_queue(&vm->destroy_work);
 }
 
 struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
-- 
2.43.0

