Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B839606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YgHB5iDM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7561E10FBF6;
	Wed, 28 Oct 2026 12:21:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7F210FBE8;
 Wed, 28 Oct 2026 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793190104; x=1824726104;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O5QHahmRGJ51IW4x+vcnPL2fUXpzAY0N+g/QuwM8mvg=;
 b=YgHB5iDM7UzhfdrbVFXq0Ug1vM1F84GSK2IilK8Atcp9tl3TUJgskv1p
 KrRHh92d4eMHB2K/mPY4stVA/2SqJpfS0IkdnH20ipLymyJQkq6FIJpYs
 qzcQUqj9/MntwoeHMQ+i4RDiP5fRo2/2ZMbvhnmdurqETPNkc+6UGqAqr
 /V8lnBJr19fkjpMt+kbR0aybBkqInvCRn7JgnOhk6plg+KrkIfu3uZ2cY
 CHZPeB7M8/4rmrUA6LV3k5lQVtvuVMv2uM/BoA6v6wxPkMdazc3l/n8na
 NwsbqJxe4+91tlBXsuBr1v7KYRP8D0JwBCcn3mMxKmDxx7trYcCknmEND A==;
X-CSE-ConnectionGUID: JB3chSQaSVGwEwsXhG5r5A==
X-CSE-MsgGUID: 0Vw0u4CVQaWNW4RchPLNTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1939032"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1939032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:21:43 -0700
X-CSE-ConnectionGUID: Lfa1dXMDSv6wn5c4+sYT6w==
X-CSE-MsgGUID: p55JPAKtS0+MdkGtyWhNzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4838480"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:21:42 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 sanjay.kumar.yadav@intel.com
Subject: [PATCH v2 1/4] drm/xe: Hold a device reference across deferred VM
 destruction
Date: Wed, 28 Oct 2026 17:51:22 +0530
Message-ID: <20261028122125.3772832-2-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028122125.3772832-1-arvind.yadav@intel.com>
References: <20261028122125.3772832-1-arvind.yadav@intel.com>
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
Assisted-by: LLM
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 823e264319a1..a1a4eaf3165f 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2108,6 +2108,8 @@ static void vm_destroy_work_func(struct work_struct *w)
 		xe_file_put(vm->xef);
 
 	kfree(vm);
+
+	drm_dev_put(&xe->drm);
 }
 
 static void xe_vm_free(struct drm_gpuvm *gpuvm)
@@ -2115,10 +2117,13 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
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

