Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902F4CA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D4E10E672;
	Wed,  7 Oct 2026 20:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FpL8dCKN";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B1F10E675
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:03:56 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso22248835ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791403435; x=1792008235; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s7lDZIBY8lMNVjYdiqzEHceMRcM1xIgWuBduaZnZSEc=;
 b=FpL8dCKNZS80OEtG+u5k4RuFl3Fi4wMvRHBhZ2WyOK3MgoTufcK/v6dM1FbL6ryxtg
 J2110uhps+u8LW/WXxVeWU9xGH7fTxeUPRfHMh7MuCr5H2uu3FwMYGF6lyQs4KToP1vE
 Rz4Pji1d1Cq1bws+M4yZePyQDKO42yYboDwRSHhQ0RQJBKlAH+uQQpkzusMC1r555nf6
 qY5tZNuT2ZoDg5B8YfGznT8mcUgEP2afM5WC/i7B2BdQ02bOof3Q5l/jbXoP2cZQ+9D3
 pLbf1CMX/H1Ir7s9CilVKGupz+ORl3doJzTqbinpo7auhMQzxkK+7Ol+0yeBDKijfNCc
 iUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791403435; x=1792008235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s7lDZIBY8lMNVjYdiqzEHceMRcM1xIgWuBduaZnZSEc=;
 b=UtohMNqxcOimqG3Ya9p3GMFyofffIE54Ad/YM3KeYV8ed/evgqsWsYqydLs37GtZDD
 pp3BZyFjvHcfw+sEemppCWMP8RNAL3DIeA8js2cWzO588fyMFwDndawrvW3eimq/mujE
 tEBPu+oYqPkGclwNjYf2R1cM3nchnoRte4fYR5CF4wA8P0EWBZGDuy0ZETrnnVU9f6Et
 7hyU6FFZDlkTGv52WpTUt7IfEuJfZhmBnvq1aR3vy5sGzFo86+elvfUSgFLvASI2y1XC
 4/xwwIRR64MnL1w5RVml4n5xD6cRaozOHXeMy+zQ6ucze1206xoVbB8ubX8oNR3o3+pw
 wPOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz42/I4cZgT0rjAypMQX6YTfLziSZ+HLMUMFY3YAutLC8eWVb/wZ1eTehg1g6aXjUTawDH1VTXwi78=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLyLnoFvfvjAmUhd6C640fYCTus2Ss0aZykj8H/yEuWcnsDC16u
 IH+hewJwcrT6oarsLgHwSYPg8KtfaBsvYBii4vT5uAoC1G/1mVphI94/
X-Gm-Gg: AYBFou1bZl1sUg3J1VJaJbl146wQSFushhYkLDxUgyDJ1noOGc/DOPCqyLDZBRrRyTH
 YAneR3AqfiuKC4suCy3wLXw0nQbH5HGo9To7JGgaUuqYPEOuy1opBzim28DkcdbUxZLnIYFiYas
 kgAaMYapKkKESv68AIqcP9ml1qwNu8HbqWo2P1+Yqg+eu/+AFRc0RbTchyvY8+yTH45Cp8xZCsL
 lFWCuC4Tzetg1lgzNF86nMPLILKMsL4THT8dG7tokQAhA9zK8gdC/D7yvJmxkn+m2zkk3owIIk4
 WXqK+gPjqcp9ScZUwWuAwV8Nq+C7DhVmOI/FIj2ZEKJrhbERcKUEuVAyOYCA4uf4yg3zcK7ixpw
 27jc8sRP4LM6VRlLB2xDZpERcBbEYlQshoCtTqJGnBHcr/SxSqV9Twu6ut32zcQz1sU7zud/6fk
 6Gccbfv9jjq1FNMZnqF8dqGK4liGDZDbj5IgHBoIgtU/reZbNsblJPKHgvrXuxn61/
X-Received: by 2002:a17:902:f54c:b0:2df:8f19:5db8 with SMTP id
 d9443c01a7336-2e6005e2f9dmr27584935ad.59.1791403435502; 
 Wed, 07 Oct 2026 13:03:55 -0700 (PDT)
Received: from zeus.home ([101.98.37.30]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e604720e92sm16386455ad.38.2026.10.07.13.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:03:54 -0700 (PDT)
From: John Fisher <jfisher84@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, John Fisher <jfisher84@gmail.com>,
 stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
Date: Thu,  8 Oct 2026 09:03:45 +1300
Message-ID: <20261007200345.417281-1-jfisher84@gmail.com>
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
walks the reservation with DMA_RESV_USAGE_READ, and the VM's own page
table jobs (the root clear from amdgpu_vm_init(), and the PD/PT clears
and the seq64 mapping from the render node's open) are added by
amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP. The CPU path's own
waits (amdgpu_vm_cpu_update(), amdgpu_bo_kmap()) use
DMA_RESV_USAGE_KERNEL. None of them waits for a clear that is still
queued.

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

Wait for every fence on the root PD's reservation before switching the
update functions. With this the same client reads the handler 10 of 10
times, 8 busy queues on the 4 compute slots complete in 5 of 5 runs
(1 of 6 before), and two processes with 8 queues each complete together,
with no fault.

Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the dependent read fences")
Cc: stable@vger.kernel.org # v6.16+
Cc: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: John Fisher <jfisher84@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 29187fabc..8d0c03a40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		  "CPU update of VM recommended only for large BAR system\n");
 
 	if (vm->use_cpu_for_update) {
-		/* Sync with last SDMA update/clear before switching to CPU */
-		r = amdgpu_bo_sync_wait(vm->root.bo,
-					AMDGPU_FENCE_OWNER_UNDEFINED, true);
-		if (r)
+		/*
+		 * Sync with the last SDMA update/clear before switching to CPU
+		 * updates. The VM's own page table updates are tracked with
+		 * DMA_RESV_USAGE_BOOKKEEP on the root PD, which
+		 * amdgpu_bo_sync_wait() does not wait for: a clear of a PD still
+		 * pending here lands after the CPU has written its entries.
+		 */
+		long t = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					       DMA_RESV_USAGE_BOOKKEEP, true,
+					       MAX_SCHEDULE_TIMEOUT);
+		if (t < 0) {
+			r = t;
 			goto unreserve_bo;
+		}
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 		r = amdgpu_vm_pt_map_tables(adev, vm);
-- 
2.55.0

