Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFB3CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BCF10FB79;
	Thu,  8 Oct 2026 20:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qHRN/ppN";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146DC10FB79
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 20:45:26 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso774835a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791492325; x=1792097125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t8+7YdessJC4L0ZspddIBLuS8kurtI2j+Ug8+4jdPNs=;
 b=qHRN/ppN242nWF0OPgT8PrT4BTVQMx0Gyo31oaQKJ7K4hCyNOUUebehCRCS99MEPAl
 u2sdwvzWsGgqqmHyEuQEsfuSBER49iQCn2WsKiVBzuMK7vkdtLkzuxDYlawWOm+2dEVG
 hlxugCJYlesvhnod4qXs0njIka9FbNm73xlMThrLWZ3GM9ci+163NPMFo0aj74nQd8PY
 yOsVVT1z+mg/3i2yOsGoxiU8/894vbYmE0Jq6mboCrdZBlmC6LfkCIIxLoF+Aoq/snkI
 PH4bhY59oxpifmNvPUVUJRwXA8IyeooklOAdlpyrKG1tX1EO9HJ6eOD50HOx8rShmdH/
 ftVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492325; x=1792097125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t8+7YdessJC4L0ZspddIBLuS8kurtI2j+Ug8+4jdPNs=;
 b=pX2MHvHWzUiUg18ai2bc7XS+aiGW4d9P+f8rTIfiUtgySV2ZAefFVblNn2Um/A/xQ2
 0H5Vtlc4db8jdQTFMaGfD11oKgpvSBbsBTlWFDIrcFBByfATH9r9Y/SJJSCjdFFRuE8X
 8hBPIP9cf5Ki8mNyHx6zMtJ9iKiXmQSJPrPBnGtJ3wh64Rk9g1DQ5VzlZtfCKcCsH9l6
 PF44kU2K+5gyC1IH4KGtyqbCqT3GJDFRGfeY9GOjEhgYY+XTnlcFze8pnTeYA5J1MgCd
 vspb1xEky+wkNvD8lFQA7eXCTIiqeldCYUTO+V9fK7Vgw8KUc/oovbZQQl8lbATTylBf
 m5RA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwh5yUI7spsU3bODuVPmCpeLw6Ad+y0OqbUh9KyvSISmnBbbtrTpT6X9WNBHwb3QW3MCKGzXxtacoE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKJ1X87VfcEy1qex3duWCfAwa87oKcbitxAPZzLEAGJabP9EX3v
 37poh/YwtKiun+481J9tsaqviqAoaYf9eUrFIAdHAepDhwNu7aqQbRfx
X-Gm-Gg: AYBFou3Dx7JHn+/hdRD9BFHIR1+Fbee/LmnuBEsekWxi4cVcK/5E7PH1XavANqreaCv
 Dcw4CLyXNOQKfdMdr6ygGHknRhxoFO8SiE9nARe97NBwZIRM3MWT8xlzDbneC8Jl3sOeRo/+xzW
 7oiCV0qSHR0OaSGRxFpLUm8YRFvK784D8KaLpv8Ko4nqo30yvjl9mLPVMvTKHyyvtLXgyXM8Uzb
 UgbZOwvSEtogzfUTZbmPR9QyAywKG7sC9lBl9zdmIJqTv1ab88Lak9X3pvbH7QV3DxfUPWyAxdh
 k2aOxrA+oKwUPL+W1+mCpaFaFgUAwtJojl6GDoGvFmX6XMVJhAR1mcPYt7FICbHSYgrnH6Ww7U4
 Vd7UnF0kHDOCyTzNv4IFoRgiZnSLmt19uskWsElgIRQB1wSLsWP7PUC1JKDcj0jXuXatDoh4MVO
 UcG2H7/R7GdzlYqVmJ+x2gVYtjKPhDN86mHehASnLb/uqN+1D0gG1i4QcTBe9c6BPP
X-Received: by 2002:a17:90a:d604:b0:3a7:ed4d:afeb with SMTP id
 98e67ed59e1d1-3ab3ab35683mr342a91.27.1791492325448; 
 Thu, 08 Oct 2026 13:45:25 -0700 (PDT)
Received: from zeus.home ([101.98.37.30]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab395e11a0sm107248a91.2.2026.10.08.13.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 13:45:24 -0700 (PDT)
From: John Fisher <jfisher84@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, John Fisher <jfisher84@gmail.com>,
 stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
Date: Fri,  9 Oct 2026 09:45:17 +1300
Message-ID: <20261008204517.392180-1-jfisher84@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
updates when a KFD process acquires it. It syncs "with the last SDMA
update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
the seq64 mapping allocates at the render node's open) are added there
by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update(),
amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
clear that is still queued.

When one is, the CPU writes the first entries of the new compute VM (the
KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, mapped
during ACQUIRE_VM) into a page directory the SDMA then clears. The
entries are gone, the handler's page is unmapped, and the first wave
save of any queue of the process faults in the SQC instruction fetch at
the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, and
the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the
queue is reset instead.

The window is the time between the render node's open and ACQUIRE_VM.
ROCr spends milliseconds there and is practically never hit; a minimal
KFD client that opens the render node and acquires the VM at once is hit
most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so
vm_update_mode defaults to CPU updates for compute VMs), a wave reading
the trap handler's page right after queue creation found it unmapped in
8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0
of 9, and the same sleep after queue creation instead 3 of 3.

The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
promote the implicit sync to the dependent read fences") narrowed
amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ;
the VM's page table jobs have been added with BOOKKEEP since commit
4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
them.

Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
with its updates, and wait for it, uninterruptibly, before switching the
update functions. The clears all go through vm->delayed, so the last one
covers the earlier ones; immediate clears are not recorded, as before.

With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of 5
runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
complete on 7.3-rc6, and two processes with 8 queues each complete
together on both, with no fault.

Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the dependent read fences")
Cc: stable@vger.kernel.org # v6.16+
Cc: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: John Fisher <jfisher84@gmail.com>
---
v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now records
    the clears, instead of every BOOKKEEP fence on the root PD; wait
    uninterruptibly without checking the result; keep the original
    comment (Christian)
v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 29187fabc..757a037ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	if (vm->use_cpu_for_update) {
 		/* Sync with last SDMA update/clear before switching to CPU */
-		r = amdgpu_bo_sync_wait(vm->root.bo,
-					AMDGPU_FENCE_OWNER_UNDEFINED, true);
-		if (r)
-			goto unreserve_bo;
+		dma_fence_wait(vm->last_update, false);
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 		r = amdgpu_vm_pt_map_tables(adev, vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c03327f12..cdbc2e931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto exit;
 
-	r = vm->update_funcs->commit(&params, NULL);
+	r = vm->update_funcs->commit(&params, &vm->last_update);
 exit:
 	drm_dev_exit(idx);
 	return r;
-- 
2.55.0

