Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DC606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BxQABdCK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF21210FD4E;
	Wed, 21 Oct 2026 10:04:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F8C10F9CB;
 Wed, 21 Oct 2026 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577038; x=1824113038;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dhZMWtrjVy5Gy0jAW5Exa/cIUx/U1SS3jlHFaRwgLAo=;
 b=BxQABdCKgf70cRmTT7M1BG2RY2zjwBUAuBSThFfUq3LHkFxOmQtFG+5g
 FF4Ca1Ejy75bvdx4QhZP8OU4jFvbe8EE9P5JiN03T74bdHKP/ypRS9qvv
 ODREbSCY0Ww9QEhOFTGEqAY8UGN4Riu4FGkvK3CsDm9ELZ5VrZZjqtO7S
 Y1pZktCdNK1sRXAILyB4QqVluLIyY8xTEx4zmbJ/DanTaJVr/l0G5mVua
 l8FYq02cJN91yF+cYmbqRdoM3WGjtOqfwRmqULldpNNEU7nT2k/2BQ5ku
 H+WXGAKzLrYvVJiK5gSMC3T4R3gc0q3seDLeYyAWFvUGlv6zejhrcGyzm w==;
X-CSE-ConnectionGUID: TwbKrPNvRwm/yhxIfA2giw==
X-CSE-MsgGUID: LivjCH5pRmW6I2iSNuWW4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290298"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290298"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:58 -0700
X-CSE-ConnectionGUID: CvLf59lARQuMBKwg5VhYhA==
X-CSE-MsgGUID: 8m1sI3GZRsGDlkU0pbW/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382097"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:55 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 08/17] drm/xe: Skip VM close hardware access when device I/O
 is blocked
Date: Wed, 21 Oct 2026 15:33:09 +0530
Message-ID: <20261021100322.1014449-9-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe_vm_close() uses drm_dev_enter(), which only checks unplug. After a
permanent wedge, VM close can still write page tables in VRAM and request
TLB invalidation.

Use xe_device_io_get() around page-table clearing and TLB invalidation.
Skip these operations when device I/O is blocked or unplugged, while
still closing the VM and running software cleanup.

Take the gate after the pending-bind fence wait. Isolation waits for
hardware cleanup admitted before the block, without including that
fence wait in this function's gate.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 645c5e906224..0a8dfe23cc20 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1932,11 +1932,8 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 static void xe_vm_close(struct xe_vm *vm)
 {
 	struct xe_device *xe = vm->xe;
-	bool bound;
 	int idx;
 
-	bound = drm_dev_enter(&xe->drm, &idx);
-
 	down_write(&vm->lock);
 	xe_vm_lock(vm, false);
 
@@ -1955,13 +1952,15 @@ static void xe_vm_close(struct xe_vm *vm)
 				      DMA_RESV_USAGE_BOOKKEEP,
 				      false, MAX_SCHEDULE_TIMEOUT);
 
-		if (bound) {
+		if (!xe_device_io_get(xe, &idx)) {
 			for_each_tile(tile, xe, id)
 				if (vm->pt_root[id])
 					xe_pt_clear(xe, vm->pt_root[id]);
 
 			for_each_gt(gt, xe, id)
 				xe_tlb_inval_vm(&gt->tlb_inval, vm);
+
+			xe_device_io_put(idx);
 		}
 	}
 
@@ -1970,9 +1969,6 @@ static void xe_vm_close(struct xe_vm *vm)
 
 	xe_vm_unlock(vm);
 	up_write(&vm->lock);
-
-	if (bound)
-		drm_dev_exit(idx);
 }
 
 void xe_vm_close_and_put(struct xe_vm *vm)
-- 
2.43.0

