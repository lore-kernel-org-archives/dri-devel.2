Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA0EC79FA3
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A53F10E67D;
	Mon,  7 Sep 2026 07:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="G3FygjuK";
	dkim-atps=neutral
X-Greylist: delayed 462 seconds by postgrey-1.36 at gabe;
 Mon, 07 Sep 2026 05:30:57 UTC
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA78C10E446;
 Mon,  7 Sep 2026 05:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1788759026;
 bh=uFH3b64f428IPwDsNKHXwSIzUHdO77yydhieXr76KjE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=G3FygjuKV/I+bfR69Kg9Rn50YZu5XuLiVUC5Lg9w4+VTO4N0MFhLXgau6kV1xujAy
 SBc8tQcxliSy32thd1BfWVu1qHbkBwFYF3pjcknFourL3Eq7J/1w4KRltZyD+exSQ3
 xg40ltQmlLr/3GXhDVCFWmXNzxBETarPWbdHxfyM=
X-QQ-mid: zesmtpgz6t1788758578t17da2d8d
X-QQ-Originating-IP: xuQrscUMOjxBAU/r1aC7L+4v4cjSpqJ2E2qbYJqzduA=
Received: from hepeiyang-vm.wu.lxd ( [36.152.24.145])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 07 Sep 2026 13:22:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6035130705786141
EX-QQ-RecipientCnt: 8
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, airlied@redhat.com,
 Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is in
 TTM_PL_SYSTEM
Date: Mon,  7 Sep 2026 13:22:04 +0800
Message-ID: <0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Obfty5iaetlmdtFwcR2SwwQV3sZ3ir6NeU5zelna620nry1WykS8+zVg
 6CkwtAJFMz2ozn6+IlJdfamQK7zQIH1gsE7gkp+47yW+MJ1NMIfioqz/VLQlvNvVrNBByB5
 2OwCXDKBDDEtimT0s4Djel06DNNuDRW8QQ4cARHd1WxyIMHpfTepVM0r7SaIsGIAnwYCEa4
 r9M18AmXfRpIIHQ0TAH1ynHBXCRPCEsOzWtHE3n/P9uhkrp2a0bd49SdT1Awv5LSgdvfokn
 WWVYyvw5uz9A0HWuJK5IU/mJwdUjUmmlt8geTzWiATEWw9Jub2p7o5kzArcC40+UV45WfXb
 EgQ5FjwEQAj1hTsLqqikZDg9emVuFjpcRNP4fYxw+rcQwwXDRU15cda2rgIJTw4uixI8Xko
 /1KFwoE1PQJ4qEBLo+P9Tz5s5b+Kl7Rs18YuoFRfcvug9SkVIPVt9ypdMawkfDz3tHMLdZ0
 4QKwZldXgmMBlQklBKruCXbqZm9tgCwkcSO0grkAefGfK+qRwc8urkXHwOL5Ie0miPDfYsz
 +FO/C7dPUUckPHr0OtUG0A2cy032a6d+ER+ZLyo42NfiG2UBW0STJQYmDf9X4OKPsLhcXkW
 TSEcM21d2M9o7LXpJ2rKb+PsI58JX5xE5vonBVsTWV5MMoyJNZ4QDkK+2PkqV5elY5tTitq
 LKJTW0W4gtx/7yW6zlEBrE4s5VJdnIe1IHu2XC8pKImzfsII04MIRnmC9022hE/1WQZuFc2
 jThb3gGnBfAYBczuv74ttPgXjUDDWeBCGkj1Utq3ZONjFrW1LsfxuU4Crkqn3Ib6A63Ev/K
 xZ4QEB+wUuFxbddosR9rwPTg9jRQHrvdbx2yH1zg41zFaRvs/N27XkGTElIBepkKn6O9u2v
 /HO/DfInxrer6QCaPFxWzdeZXvVGao8HLqWJfqxSAP68e7knpOJPTMmWmRXLZxK97Ni/uD0
 5/7DfRluScaG3a1sPlJInJT2LqFSLL+TncRiE8FFA8upyO2qLUQhnjDy9j7hUBrcnrsee1C
 hLRvQTa+dYoDVZUMbRvHZ71ru1aXnvgmMTOeiUcibe/St6xypcO6Y+e88OOnw=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

nouveau_uvmm_sm() calls op_map(), which passes bo->resource through
nouveau_mem() to nouveau_uvma_map(). nouveau_uvmm_vmm_map() then reads
mem->mem.type.

But this is only valid when bo->resource is backed by struct nouveau_mem,
as is the case for VRAM and TT resources. If the BO is left in
TTM_PL_SYSTEM, bo->resource is only a struct ttm_resource. Treating it
as struct nouveau_mem makes the mem->mem.type read past the end of the
resource, causing a KASAN: slab-use-after-free Read in nouveau_uvmm_sm
report:

BUG: KASAN: slab-use-after-free in nouveau_uvmm_vmm_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:152 [inline]
BUG: KASAN: slab-use-after-free in nouveau_uvma_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:199 [inline]
BUG: KASAN: slab-use-after-free in op_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:849 [inline]
BUG: KASAN: slab-use-after-free in nouveau_uvmm_sm.constprop.0+0x6ab/0x900 drivers/gpu/drm/nouveau/nouveau_uvmm.c:903
Read of size 1 at addr ffff888127d3e3a0 by task kworker/0:1/11

CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.2.0 #5 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: nouveau_sched_wq_2224 drm_sched_run_job_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x95/0xe0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcb/0x5a0 mm/kasan/report.c:482
 kasan_report+0xca/0x100 mm/kasan/report.c:595
 nouveau_uvmm_vmm_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:152 [inline]
 nouveau_uvma_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:199 [inline]
 op_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:849 [inline]
 nouveau_uvmm_sm.constprop.0+0x6ab/0x900 drivers/gpu/drm/nouveau/nouveau_uvmm.c:903
 nouveau_uvmm_sm_unmap drivers/gpu/drm/nouveau/nouveau_uvmm.c:932 [inline]
 nouveau_uvmm_bind_job_run+0xd6/0x250 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1532
 nouveau_job_run drivers/gpu/drm/nouveau/nouveau_sched.c:350 [inline]
 nouveau_sched_run_job+0x62/0xd0 drivers/gpu/drm/nouveau/nouveau_sched.c:364
 drm_sched_run_job_work+0x356/0xa10 drivers/gpu/drm/scheduler/sched_main.c:1061
 process_one_work+0x8a5/0x1900 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5dd/0xd80 kernel/workqueue.c:3486
 kthread+0x31d/0x420 kernel/kthread.c:436
 ret_from_fork+0x662/0x940 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 2224 on cpu 0 at 66.550027s:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
 kasan_save_track+0x17/0x60 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_noprof+0x304/0x7c0 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 dma_resv_list_alloc+0x27/0x90 drivers/dma-buf/dma-resv.c:106
 dma_resv_reserve_fences+0x60e/0xa30 drivers/dma-buf/dma-resv.c:205
 ttm_bo_alloc_resource+0x12c/0xbd0 drivers/gpu/drm/ttm/ttm_bo.c:721
 ttm_bo_validate+0x1bc/0x4a0 drivers/gpu/drm/ttm/ttm_bo.c:856
 ttm_bo_init_reserved+0x2c3/0x570 drivers/gpu/drm/ttm/ttm_bo.c:970
 nouveau_bo_init+0x159/0x2c0 drivers/gpu/drm/nouveau/nouveau_bo.c:359
 nouveau_gem_new+0x234/0x5f0 drivers/gpu/drm/nouveau/nouveau_gem.c:272
 nouveau_gem_ioctl_new+0x1eb/0x420 drivers/gpu/drm/nouveau/nouveau_gem.c:352
 drm_ioctl_kernel+0x192/0x350 drivers/gpu/drm/drm_ioctl.c:817
 drm_ioctl+0x4f8/0xb40 drivers/gpu/drm/drm_ioctl.c:914
 nouveau_drm_ioctl+0xea/0x2c0 drivers/gpu/drm/nouveau/nouveau_drm.c:1338
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x180/0x1d0 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 2223 on cpu 0 at 66.554063s:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
 kasan_save_track+0x17/0x60 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x61/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 __rcu_free_sheaf_prepare+0xb6/0x2e0 mm/slub.c:2928
 rcu_free_sheaf+0x1b/0x120 mm/slub.c:5978
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x521/0x1490 kernel/rcu/tree.c:2897
 handle_softirqs+0x1b1/0x8a0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x70/0x80 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

The buggy address belongs to the object at ffff888127d3e380
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 32 bytes inside of
 freed 96-byte region [ffff888127d3e380, ffff888127d3e3e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x127d3e
flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff888100041280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888127d3e280: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888127d3e300: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff888127d3e380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                               ^
 ffff888127d3e400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888127d3e480: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc

Fix by resetting the placement to the BO's valid domains before
calling nouveau_bo_validate(), matching the handling in
nouveau_uvmm_bo_validate(), so map jobs do not run for SYSTEM resources;
Reject BO that cannot reside in VRAM or GART;
Also skip op_map() when the GPUVA has been invalidated, matching the
handling in the unmap and remap paths.

Found when fuzzing the nouveau driver with a modified Syzkaller.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index fc125fd44a9b..2026fe6b48c6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -846,6 +846,9 @@ op_map(struct nouveau_uvma *uvma)
 {
 	struct nouveau_bo *nvbo = nouveau_gem_object(uvma->va.gem.obj);
 
+	if (drm_gpuva_invalidated(&uvma->va))
+		return;
+
 	nouveau_uvma_map(uvma, nouveau_mem(nvbo->bo.resource));
 }
 
@@ -1232,6 +1235,7 @@ bind_lock_validate(struct nouveau_job *job, struct drm_exec *exec,
 
 		drm_gpuva_for_each_op(va_op, op->ops) {
 			struct drm_gem_object *obj = op_gem_obj(va_op);
+			struct nouveau_bo *nvbo;
 
 			if (unlikely(!obj))
 				continue;
@@ -1246,8 +1250,13 @@ bind_lock_validate(struct nouveau_job *job, struct drm_exec *exec,
 			if (va_op->op == DRM_GPUVA_OP_UNMAP)
 				continue;
 
-			ret = nouveau_bo_validate(nouveau_gem_object(obj),
-						  true, false);
+			nvbo = nouveau_gem_object(obj);
+			if (!(nvbo->valid_domains &
+			      (NOUVEAU_GEM_DOMAIN_VRAM | NOUVEAU_GEM_DOMAIN_GART)))
+				return -EINVAL;
+
+			nouveau_bo_placement_set(nvbo, nvbo->valid_domains, 0);
+			ret = nouveau_bo_validate(nvbo, true, false);
 			if (ret)
 				return ret;
 		}
 	}
 
