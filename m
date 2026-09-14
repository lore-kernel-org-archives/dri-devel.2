Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637E1C88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8792E10F21C;
	Mon, 14 Sep 2026 20:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SKL26mam";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6F210F21C;
 Mon, 14 Sep 2026 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=OIVWI+KDg8332cjgQZ/eY8952Xy/lXZvtrDcuD+XUY0=; b=SKL26mamb+giCfn2Jw82VvHf3w
 uH/ilha86Zx9Bf3BmIgT+TXIwwS1/W4E4Ls+dfdj71crguW7Latcbn8Am+qjAapAsDKq4Ajw/So/j
 oPo8NICdQ7dacS8dt+T+5K8jn1t0jc1FC9V4lFOzT1xz2LTW59v70XmWRzU7TRyPcRZV3WJzTcLCs
 QEzrx8Dx5IrQNSKasjN1EP9x13w1oK8OGf7CdTys13pGUcCHea6LkoG/iX1nw5IOjJzK6ND5Ss6op
 EGeHRAf0lpoz95XFaQmSoJTRAtymqcfXgXWkUfSihVbtyN4ClTneTtZ5BvwiHG3ayf7tVz2o3+FUx
 OXA0uKgQ==;
Received: from 179-125-70-185-dinamico.pombonet.net.br ([179.125.70.185]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6DFA-00258e-Sp; Mon, 14 Sep 2026 22:25:36 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 14 Sep 2026 17:25:07 -0300
Subject: [PATCH 4/4] drm/amdgpu: commit pending work when
 amdgpu_vm_ptes_update fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-amdgpu_vm_fixes-v1-4-d6d835591e0f@igalia.com>
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
In-Reply-To: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com, 
 Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.16-dev-62088
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

Otherwise, we might leak the SDMA job.

[ 2877.877264] kmemleak: unreferenced object 0xffff89b1f3cf0800 (size 1024):
[ 2877.877273] kmemleak:   comm "vm_always_valid", pid 3027, jiffies 4295714403
[ 2877.877275] kmemleak:   hex dump (first 32 bytes):
[ 2877.877277] kmemleak:     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 2877.877279] kmemleak:     00 03 da 52 b1 89 ff ff 38 25 5f cb b1 89 ff ff  ...R....8%_.....
[ 2877.877280] kmemleak:   backtrace (crc d52b9041):
[ 2877.877282] kmemleak:     __kmalloc_noprof+0x4b3/0x770
[ 2877.877288] kmemleak:     amdgpu_job_alloc+0x69/0x280 [amdgpu]
[ 2877.877668] kmemleak:     amdgpu_job_alloc_with_ib+0x55/0xf0 [amdgpu]
[ 2877.878023] kmemleak:     amdgpu_vm_sdma_prepare+0x4b/0xa0 [amdgpu]
[ 2877.878350] kmemleak:     amdgpu_vm_update_range+0x24f/0x940 [amdgpu]
[ 2877.878668] kmemleak:     amdgpu_vm_clear_freed+0x13b/0x290 [amdgpu]
[ 2877.878983] kmemleak:     amdgpu_gem_object_close+0x1ac/0x270 [amdgpu]
[ 2877.879300] kmemleak:     drm_gem_object_release_handle+0x35/0xd0
[ 2877.879305] kmemleak:     idr_for_each+0x70/0xe0
[ 2877.879310] kmemleak:     drm_gem_release+0x23/0x30
[ 2877.879311] kmemleak:     drm_file_free+0x217/0x2a0
[ 2877.879314] kmemleak:     drm_release+0x61/0xe0
[ 2877.879317] kmemleak:     amdgpu_drm_release+0x62/0xd0 [amdgpu]
[ 2877.879630] kmemleak:     __fput+0xfb/0x2d0
[ 2877.879634] kmemleak:     __x64_sys_close+0x3d/0x80
[ 2877.879637] kmemleak:     do_syscall_64+0x12d/0x6c0

Also, flush the TLB and free the entries in the local stack
tlb_flush_waitlist. Otherwise we might touch old stack addresses when
removing the entries when we finish the VM.

[ 2791.162517] ------------[ cut here ]------------
[ 2791.162519] list_del corruption. next->prev should be ffff89b27cf0b778, but was 0000000000000000. (next=ffffcacdc12e77c8)
[ 2791.162522] WARNING: lib/list_debug.c:65 at __list_del_entry_valid_or_report+0xea/0x100, CPU#1: vm_always_valid/3027
[ 2791.162659] CPU: 1 UID: 1000 PID: 3027 Comm: vm_always_valid Tainted: G        W           7.2.0-02902-g432c2ced2942 #11 PREEMPT  2356ac135df40d3c9080402059c7492776a63ecd
[ 2791.162663] Tainted: [W]=WARN
[ 2791.162665] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0133 08/05/2024
[ 2791.162668] RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x100
[...]
[ 2791.162688] Call Trace:
[ 2791.162690]  <TASK>
[ 2791.162694]  amdgpu_vm_pt_free+0x5d/0xa0 [amdgpu 09338d95446a22cfd002ef2392fde61d2ef7b139]
[ 2791.163070]  amdgpu_vm_pt_free_root+0xe3/0x130 [amdgpu 09338d95446a22cfd002ef2392fde61d2ef7b139]
[ 2791.163392]  amdgpu_vm_fini+0x320/0x5f0 [amdgpu 09338d95446a22cfd002ef2392fde61d2ef7b139]
[ 2791.163709]  ? __xa_erase+0x57/0xa0
[ 2791.163714]  ? _raw_spin_unlock_irqrestore+0x34/0x60
[ 2791.163718]  ? _raw_spin_unlock_irqrestore+0x34/0x60
[ 2791.163720]  ? trace_hardirqs_on+0x16/0xd0
[ 2791.163725]  ? _raw_spin_unlock_irqrestore+0x3f/0x60
[ 2791.163728]  amdgpu_driver_postclose_kms+0x1d1/0x2d0 [amdgpu 09338d95446a22cfd002ef2392fde61d2ef7b139]
[ 2791.164042]  drm_file_free+0x23a/0x2a0
[ 2791.164049]  drm_release+0x61/0xe0
[ 2791.164052]  amdgpu_drm_release+0x62/0xd0 [amdgpu 09338d95446a22cfd002ef2392fde61d2ef7b139]
[ 2791.164362]  __fput+0xfb/0x2d0
[ 2791.164367]  __x64_sys_close+0x3d/0x80
[ 2791.164371]  do_syscall_64+0x12d/0x6c0

This can be caused by VRAM memory pressure, where a PT BO allocation
fails during amdgpu_gem_va_ioctl.

Since the failure from amdgpu_vm_update_range is still returned,
amdgpu_vm_bo_update will leave the mappings at the invalids list and
amdgpu_vm_clear_freed will keep them at the freed list. This will allow
amdgpu_cs_ioctl to retry later.

Fixes: 81417bea8755 ("drm/amdgpu: explicitly sync VM update to PDs/PTs")
Fixes: c3546695830e ("drm/amdgpu: use the new VM backend for PTEs")
Fixes: b6c4f90b3819 ("drm/amdgpu: sync page table freeing with tlb flush")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5bde36754607..1495adaaacd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1235,7 +1235,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		tmp = start + num_entries;
 		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
 		if (r)
-			goto error_free;
+			break;
 
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;

-- 
2.47.3

