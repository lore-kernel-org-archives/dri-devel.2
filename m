Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EE606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKNDBXrd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74A710FAB5;
	Wed, 25 Nov 2026 10:08:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D886310E2B2;
 Wed, 25 Nov 2026 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795601275; x=1827137275;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O471qYqK7zzo3vxo3o50F807nmuwvHPPeHEMJDu7Baw=;
 b=PKNDBXrdBQWlw/NzW80P7a7RCRWShL+28BSSVhLVQVGchqzs4TU+7xZZ
 KpwWaBY3PXqczWoDxKIH4VKixPYCPgUSgbc1NiUPg2tnyClo7fbzXTHFu
 aa1bqRcqzuEhu/0vC90Odf/bohTjBgdvDAHUVgSho+MAB0oC1ilI9c/0q
 aZpUVKs3wTHKrvdPrbkEMivKsFy23MSpbhGBGSMiQJS0lyi7rCLKlAQpk
 Iuu8KuUkXDUnVkPtC/EbZ9PlC2F2eKP4cHvEHuydPF4B+78qdOX/g9lKN
 S8GBP9ibW1j3OEz44Bx8XyM3+HE4bwUhYUgqh6I0yVuQQoOTdFjQpMCAE w==;
X-CSE-ConnectionGUID: 54uwslqpShyQkYSiFp3DvQ==
X-CSE-MsgGUID: 6iPlD9jNRfmTwFZ8ytVvcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4450573"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4450573"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 02:07:55 -0800
X-CSE-ConnectionGUID: h3zZC9+SRE+RmXr+c6fNcA==
X-CSE-MsgGUID: xIOI8HO/Rfe6CnKbOytYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="12136432"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 02:07:52 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 tejas.upadhyay@intel.com
Subject: [PATCH] drm/xe/vm: Cancel pending rebind work before freeing the VM
Date: Wed, 25 Nov 2026 15:37:44 +0530
Message-ID: <20261125100744.1440957-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
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

vm_destroy_work_func() runs on xe->destroy_wq and flushes rebind work
on xe->ordered_wq. The destroy queue has WQ_MEM_RECLAIM, but the
ordered queue has no rescuer. The kernel warns because this wait can
stall memory reclaim.

The VM is already closed, so a pending rebind would return immediately.
Use cancel_work_sync() to cancel pending work and wait for a running
rebind to finish before freeing the VM.

[  727.067318] ------------[ cut here ]------------
[  727.067552] workqueue: WQ_MEM_RECLAIM xe-destroy-wq:vm_destroy_work_func [xe] is flushing !WQ_MEM_RECLAIM xe-ordered-wq:preempt_rebind_work_func [xe]
[  727.067726] WARNING: kernel/workqueue.c:4043 at check_flush_dependency.part.0+0xd9/0x110, CPU#1: kworker/1:0/33641
[  727.067876] Workqueue: xe-destroy-wq vm_destroy_work_func [xe]
[  727.067963] Call Trace:
[  727.067964]  <TASK>
[  727.067967]  __flush_work+0x44b/0x660
[  727.067970]  ? __lock_acquire+0x584/0x29c0
[  727.067974]  ? lock_is_held_type+0xa3/0x130
[  727.067980]  flush_work+0x28/0x40
[  727.067982]  vm_destroy_work_func+0x1a9/0x350 [xe]
[  727.068061]  ? lock_release+0xd0/0x2c0
[  727.068065]  process_one_work+0x2ad/0x890
[  727.068071]  worker_thread+0x200/0x3f0
[  727.068074]  ? __pfx_worker_thread+0x10/0x10
[  727.068077]  kthread+0x113/0x150
[  727.068079]  ? __pfx_kthread+0x10/0x10
[  727.068081]  ret_from_fork+0x3bf/0x470
[  727.068085]  ? __pfx_kthread+0x10/0x10
[  727.068087]  ret_from_fork_asm+0x1a/0x30
[  727.068096]  </TASK>
[  727.068108] ---[ end trace 0000000000000000 ]---

Fixes: 61e18525023a ("drm/xe: Route deferred xe_vma/xe_vm teardown off system_dfl_wq")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index dd855876f571..2ba99c083db8 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2091,7 +2091,7 @@ static void vm_destroy_work_func(struct work_struct *w)
 	xe_assert(xe, !vm->size);
 
 	if (xe_vm_in_preempt_fence_mode(vm))
-		flush_work(&vm->preempt.rebind_work);
+		cancel_work_sync(&vm->preempt.rebind_work);
 
 	mutex_destroy(&vm->snap_mutex);
 
-- 
2.43.0

