Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B4606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FIywR3wn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B603A11215F;
	Thu, 12 Nov 2026 15:03:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D115B10F53D;
 Thu, 12 Nov 2026 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794495804; x=1826031804;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=bFmx+j7o+B18+Dbrq9ZckC2j+dSEfJ/h0JsyABlOCWE=;
 b=FIywR3wn9JosWbjwy4ynJ4wfXvA/BDy3Gm8tp+BtC+wSVxpiEOXqbx+r
 OHBFI8eZ7dztasQFZZHSq/Ckv2xKylaNIa+yoWPZJQNlgNv+aWRwrA+G5
 a4ar9iD88ZL0eYRvrAbEqnUe1oYvXLqjr3QwA5qeuC3bZY2JgKU98tloB
 FPlj5v6vGaDjqPvKD6E+zWdkfa+rwXcyEJfr/tBcDNAc7GE/5mWt4A6Ut
 Nxnou81XeYdgBSngCg1L1kTbRQdUcJUoWiBe7pGKHPPvWqeOZc+UbQArB
 CCwNkpSci/s2vQRQorWDGXEAneQpGuQ6IIdhJdgBHAEISM1/666bLqYkQ w==;
X-CSE-ConnectionGUID: NiNPdKHQQI+PB1bjiBfgpA==
X-CSE-MsgGUID: X3xi0lUnSoSGj8FTwxe0Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3308444"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3308444"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 07:03:14 -0800
X-CSE-ConnectionGUID: hSjwLj13Tv+22UGasRfrbA==
X-CSE-MsgGUID: qOwVH2TsTV+x6H48tXjgrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8766914"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 07:03:11 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] CI_ONLY: Hold a device reference across deferred VM
Date: Thu, 12 Nov 2026 20:33:00 +0530
Message-ID: <20261112150302.3837896-2-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112150302.3837896-1-arvind.yadav@intel.com>
References: <20261112150302.3837896-1-arvind.yadav@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe_vm_free() is the drm_gpuvm vm_free callback. It hands the final
teardown to vm_destroy_work_func() on a workqueue and returns.

drm_gpuvm_free() drops its device reference immediately after the
callback returns:

	gpuvm->ops->vm_free(gpuvm);
	drm_dev_put(drm);

vm_destroy_work_func() then keeps using device state: xe_pm_runtime_put()
for an LR mode VM, ttm_lru_bulk_move_fini() on xe->ttm, and the tile
iteration. If the freed VM held the last device reference, the work runs
against a released xe_device.

Take a device reference in xe_vm_free() and drop it once
vm_destroy_work_func() has finished using the device.

Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index dd855876f571..d94a27db2cf4 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2109,6 +2109,8 @@ static void vm_destroy_work_func(struct work_struct *w)
 		xe_file_put(vm->xef);
 
 	kfree(vm);
+
+	drm_dev_put(&xe->drm);
 }
 
 static void xe_vm_free(struct drm_gpuvm *gpuvm)
@@ -2116,10 +2118,13 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
 	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
 
 	/*
-	 * To destroy the VM we need to be able to sleep.
-	 * drm_gpuvm keeps at least one device reference at this
-	 * point so xe->destroy_wq must still be alive.
+	 * drm_gpuvm drops its device reference as soon as this callback
+	 * returns, but vm_destroy_work_func() still uses device state. Hold a
+	 * reference across the deferred work.
 	 */
+	drm_dev_get(&vm->xe->drm);
+
+	/* To destroy the VM we need to be able to sleep */
 	queue_work(vm->xe->destroy_wq, &vm->destroy_work);
 }
 
-- 
2.43.0

