Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB11AC982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C138B10E74C;
	Wed, 16 Sep 2026 09:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EAJXsSk7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3EB10E2D9;
 Wed, 16 Sep 2026 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789552430; x=1821088430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A8O1eM+hZU568ZXlI2orKtOBXaftl96z8TYROFcofdg=;
 b=EAJXsSk7P892PgEvG/+EMsdt92kk6PNnGRu428vDSw9GAFUP3MCYOLOd
 2Suv9Qt50mhcB8816kElFx7W+yKXhwp4dvdrP4Kjt5ihM9Ow549B5ErFn
 0eKR3slTADc/L2VEaxq7jVfGejz/UK9RoT4ekdedjwsYVMpEIVlFiGQF+
 1QQKNSb1KXaTShFI2fzFwJz2TgPrSrgowqfqHUzsGKMCWGQu++LYZ2KBA
 F5gaH1ijQ6Sq6OJpSW3palCPJV6v0HjBflORbVPb2saHQKgIMOTdm5ub+
 283mSW/6ee/Gz3c9G5vjz3y5CXtyhi0Ex944xwwTQ+9daANUURdr4+pk/ g==;
X-CSE-ConnectionGUID: 3L5RZYsoRguG9xtitsFefw==
X-CSE-MsgGUID: ndCeEU7bQsyFR5LvWL0Fgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="429593"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="429593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:50 -0700
X-CSE-ConnectionGUID: ncO11ik7S1CDHhxSAdp4aQ==
X-CSE-MsgGUID: bc/BLjsMSAiifEYzlYPFVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277415527"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:48 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH 1/5] drm/xe: Hold a device reference across deferred VM
 destruction
Date: Wed, 16 Sep 2026 15:23:33 +0530
Message-ID: <20260916095337.3104891-2-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916095337.3104891-1-arvind.yadav@intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
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

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index efa5ff6cc823..264bdab75de2 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2054,12 +2054,21 @@ static void vm_destroy_work_func(struct work_struct *w)
 		xe_file_put(vm->xef);
 
 	kfree(vm);
+
+	drm_dev_put(&xe->drm);
 }
 
 static void xe_vm_free(struct drm_gpuvm *gpuvm)
 {
 	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
 
+	/*
+	 * drm_gpuvm drops its device reference as soon as this callback
+	 * returns, but vm_destroy_work_func() still uses device state. Hold a
+	 * reference across the deferred work.
+	 */
+	drm_dev_get(&vm->xe->drm);
+
 	/* To destroy the VM we need to be able to sleep */
 	queue_work(system_dfl_wq, &vm->destroy_work);
 }
-- 
2.43.0

