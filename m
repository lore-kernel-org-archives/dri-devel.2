Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B84C79FAD
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B603D10EA35;
	Tue,  8 Sep 2026 07:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="WOB0cWUT";
	dkim-atps=neutral
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FCA10E73D
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1788774721;
 bh=nT0DFS8LAju0Xn+vfmVdgnWaDILEh3Wf6WoUslVCNd4=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=WOB0cWUTIcbl+/RdIm5QJlTdX97CfFOWxnkklYOOf9OGhU97vDZeDJL8S6vLVXocw
 9Fp5p9ctEp7gDxSWeb/ROFGg4PAG2LRf16I1nXfy+J84wMkNaZ2indSFAb+gk3g0z3
 FcHYA5Qx3bUbej+ABPX/vE4A1jHhDEL2U0CNSeHs=
X-QQ-mid: esmtpsz21t1788774717tbc20d79d
X-QQ-Originating-IP: bByniv1608Lt6WdyD+Kx5VpWnWzPJGIiacN3aGpHcTI=
Received: from [127.0.0.1] ( [124.70.231.75]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 07 Sep 2026 17:51:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4810543286361634265
Message-ID: <B4383D47831D6091+9872b3fc-abcd-427f-a6b4-665fcc52bef6@smail.nju.edu.cn>
Date: Mon, 7 Sep 2026 17:51:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is
 in TTM_PL_SYSTEM
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn>
 <20260907054841.AA5FE1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <20260907054841.AA5FE1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MSeA89ZahR6EK4SmMOSZIyWFEdXaJVR2Kh+/oE9p4i9LBgNnFcZjnSXe
 BX5qRaVswM1SPQqe1D6hmzzy5aFSm+Fps72wgv+fG8SAZkm5H5H4rmChsl38Cqae/SK0rI1
 +Udw3b/dtd9b2KoIR7sAQAdjnFZopcZRxcjDU1Kwv9yu4p8azSn/jQF0gtoxl38dEDnHGt7
 puhSHzWr6Sfru8sqmauA8GFuO0cIsMxbNRS/M66Cr4rKLf9Bcw0fBZT952DvGwtWhR1U36d
 CUYJn3wkjBufku19AoDud3UIVfYQyw1LxklMwOXU+CxhhdJzFrxWwt6AecGoiOAT7ceeEv8
 8kbLp2avvU6ql67O0H6PN6QxseHg7qCzkRSIbCAJUiJQIv9dQeI/80+ZXJ3v9jHqbde7d5G
 jYQw51qrks+7EHBC71C+IClTSUp2KcJdUog5+CKLEOYowxDNHqdzI13MK+35vGeuhFMB13d
 P7OIm60mxejOv0+w07kPG77W71SBTWr38BTG9/echMbUPstQBMwpoBUFqgOGn1bfzah7nsg
 dA40MaSSy3ptIcTdFyovGkGFBqZ/T2XD8J9ArP3Cw/zVkUjfYU5YP9Z948YVVum0dklmLVS
 Aja2OdhEKa+kSMa+L63OP/mP3n4paMYl4O3zWLXEEbUN7sCCzMzPQqugNqcmuURhfVg6Rir
 XXVV0uupSQKR9KkWxqmxL+qOQHpfeca3+UOoGFLD4l0dUMrRjBIowS/v/p4VgNb0xPbGjKC
 8p3iJCJu+X7NVH6Zeib1Ld+pDnccDpKp8BQiGL4WSM3ImJpN3Qy72eSNPm3MBMExj6ltAIg
 qvTHtgoEefQrnK6Ff32USgs+rbF4k+RcXG1OJ4zUz1I/1hx3k0Y6AsDLyhTL+deb4r6R7Dv
 9yTihRYTG7oIKie7GM/j9hAacmhxTc/qCNXRMGC/ht4fAy3fDzJiz0+7lCfZGFCka7NSSZz
 fv56/tqYbng49q6cm3+SIk21EyhW3pyl1GyBX39zjaPk+35b0woLi2+2SVYCr/3dSQjz2jr
 pKYhyFzz418DcjtnrtSGqzKt0MkvA81NAkZh5xl2PhiS+Kgdif
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

On 2026/9/7 13:48, sashiko-bot@kernel.org wrote:
> [Severity: Critical]
> This is a pre-existing issue, but does this validation occur too late to
> prevent the out-of-bounds read?
> 
> When a VM map operation is submitted, nouveau_uvmm_bind_job_submit() first
> calls nouveau_uvmm_sm_map_prepare(), which internally calls
> select_page_shift(). If the operation has a smaller alignment,
> select_page_shift() falls back and accesses mem->mem.type:
> 
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:select_page_shift() {
>     ...
>     struct nouveau_mem *mem = nouveau_mem(nvbo->bo.resource);
>     ...
>     if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram)
>         continue;
>     ...
> }
> 
> Since select_page_shift() executes before bind_lock_validate() is called, if
> the BO is currently in TTM_PL_SYSTEM, bo->resource is still just a small
> struct ttm_resource. Casting it to struct nouveau_mem and reading
> mem->mem.type results in a KASAN slab-use-after-free.
> 
> Could the validation and placement update be performed earlier to ensure the
> BO is backed by a nouveau_mem before select_page_shift() accesses it?
> 
>>  			if (ret)
>>  				return ret;
>>  		}
> 

This seems to be related to another KASAN report we found during fuzzing:

BUG: KASAN: slab-use-after-free in select_page_shift+0x4ed/0x5b0 drivers/gpu/drm/nouveau/nouveau_uvmm.c:494
Read of size 1 at addr ffff88810d7e5a20 by task syz.2.66/2317

CPU: 0 UID: 0 PID: 2317 Comm: syz.2.66 Not tainted 7.2.0 #5 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x95/0xe0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcb/0x5a0 mm/kasan/report.c:482
 kasan_report+0xca/0x100 mm/kasan/report.c:595
 select_page_shift+0x4ed/0x5b0 drivers/gpu/drm/nouveau/nouveau_uvmm.c:494
 op_map_prepare+0x106/0x280 drivers/gpu/drm/nouveau/nouveau_uvmm.c:658
 nouveau_uvmm_sm_prepare+0x242/0x910 drivers/gpu/drm/nouveau/nouveau_uvmm.c:694
 nouveau_uvmm_sm_map_prepare drivers/gpu/drm/nouveau/nouveau_uvmm.c:813 [inline]
 nouveau_uvmm_bind_job_submit+0x19ba/0x2820 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1384
 nouveau_job_submit+0x70c/0x1240 drivers/gpu/drm/nouveau/nouveau_sched.c:301
 nouveau_uvmm_vm_bind drivers/gpu/drm/nouveau/nouveau_uvmm.c:1724 [inline]
 nouveau_uvmm_ioctl_vm_bind+0x8d6/0xd20 drivers/gpu/drm/nouveau/nouveau_uvmm.c:1817
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
RIP: 0033:0x7f5c847d594d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c83237008 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5c84a65fa0 RCX: 00007f5c847d594d
RDX: 0000200000000200 RSI: 00000000c0286451 RDI: 0000000000000003
RBP: 00007f5c8487c22b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5c84a66038 R14: 00007f5c84a65fa0 R15: 00007fffbeab9b20
 </TASK>

nouveau 0000:01:00.0: syz.0.65[2313]: multiple instances of buffer 1 on validation list
Allocated by task 152 on cpu 1 at 54.420744s:
nouveau 0000:01:00.0: syz.0.65[2313]: validate_init
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
nouveau 0000:01:00.0: syz.0.65[2313]: validate: -22
 kasan_save_track+0x17/0x60 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_noprof+0x304/0x7c0 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 ext4_htree_store_dirent+0x89/0x570 fs/ext4/dir.c:483
 htree_dirblock_to_tree+0x58c/0xa20 fs/ext4/namei.c:1109
 ext4_htree_fill_tree+0x2e4/0xc00 fs/ext4/namei.c:1188
 ext4_dx_readdir fs/ext4/dir.c:601 [inline]
 ext4_readdir+0x1a19/0x2880 fs/ext4/dir.c:147
 iterate_dir+0x1c6/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64 fs/readdir.c:384 [inline]
 __x64_sys_getdents64+0x133/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 152 on cpu 1 at 54.421504s:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
 kasan_save_track+0x17/0x60 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x61/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x383/0x590 mm/slub.c:6692
 free_rb_tree_fname+0x7c/0xe0 fs/ext4/dir.c:440
 ext4_htree_free_dir_info fs/ext4/dir.c:459 [inline]
 ext4_release_dir+0x3f/0x60 fs/ext4/dir.c:642
 __fput+0x39c/0xa60 fs/file_table.c:512
 fput_close_sync+0xf0/0x1f0 fs/file_table.c:617
 __do_sys_close fs/open.c:1511 [inline]
 __se_sys_close fs/open.c:1496 [inline]
 __x64_sys_close+0x8a/0xf0 fs/open.c:1496
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88810d7e5a00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 32 bytes inside of
 freed 96-byte region [ffff88810d7e5a00, ffff88810d7e5a60)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d7e5
flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff888100041280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810d7e5900: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff88810d7e5980: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff88810d7e5a00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                               ^
 ffff88810d7e5a80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88810d7e5b00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc

And there is a second path to trigger the same title KASAN UAF:

[   30.166385] BUG: KASAN: slab-use-after-free in select_page_shift+0x531/0x620
[   30.167084] Read of size 1 at addr ffff8881128aeca0 by task nouveau_uvmm_se/336

[   30.167965] CPU: 2 UID: 0 PID: 336 Comm: nouveau_uvmm_se Not tainted 7.2.0-dirty #5 PREEMPT(lazy) 
[   30.167972] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   30.167976] Call Trace:
[   30.167979]  <TASK>
[   30.167981]  dump_stack_lvl+0x95/0xe0
[   30.167990]  print_report+0xcb/0x5a0
[   30.167996]  ? __virt_addr_valid+0x21d/0x420
[   30.168002]  ? select_page_shift+0x531/0x620
[   30.168008]  ? select_page_shift+0x531/0x620
[   30.168013]  kasan_report+0xca/0x100
[   30.168019]  ? select_page_shift+0x531/0x620
[   30.168025]  select_page_shift+0x531/0x620
[   30.168032]  op_map_prepare+0x106/0x280
[   30.168037]  ? kasan_save_track+0x26/0x60
[   30.168042]  nouveau_uvmm_sm_prepare+0x242/0x910
[   30.168049]  ? __pfx_nouveau_uvmm_sm_prepare+0x10/0x10
[   30.168055]  ? drm_gpuvm_sm_map_ops_create+0x115/0x1a0
[   30.168063]  ? __pfx_drm_gpuvm_sm_map_ops_create+0x10/0x10
[   30.168072]  nouveau_uvmm_bind_job_submit+0x19ba/0x2820
[   30.168079]  ? __pfx_nouveau_uvmm_bind_job_submit+0x10/0x10
[   30.168089]  ? stack_trace_save+0x8e/0xc0
[   30.168096]  ? __pfx_nouveau_uvmm_bind_job_submit+0x10/0x10
[   30.168102]  nouveau_job_submit+0x70c/0x1240
[   30.168108]  ? do_raw_spin_lock+0x12b/0x270
[   30.168115]  ? nouveau_uvmm_ioctl_vm_bind+0x8bd/0xd20
[   30.168121]  ? drm_ioctl_kernel+0x192/0x350
[   30.168128]  ? __pfx_nouveau_job_submit+0x10/0x10
[   30.168133]  ? trace_irq_enable.constprop.0+0xfc/0x130
[   30.168143]  ? drm_sched_job_init+0x1cc/0x2e0
[   30.168149]  ? lockdep_init_map_type+0x4b/0x220
[   30.168155]  ? nouveau_job_init+0x481/0x9b0
[   30.168161]  nouveau_uvmm_ioctl_vm_bind+0x8d6/0xd20
[   30.168169]  ? __pfx_nouveau_uvmm_ioctl_vm_bind+0x10/0x10
[   30.168176]  ? drm_dev_exit+0x38/0x60
[   30.168182]  ? __drm_dev_dbg+0xa1/0x140
[   30.168187]  ? lock_release+0x1e2/0x290
[   30.168193]  drm_ioctl_kernel+0x192/0x350
[   30.168199]  ? __pfx_nouveau_uvmm_ioctl_vm_bind+0x10/0x10
[   30.168205]  ? lock_acquire+0x1a4/0x2e0
[   30.168210]  ? __pfx_drm_ioctl_kernel+0x10/0x10
[   30.168216]  ? __might_fault+0xbf/0x170
[   30.168224]  drm_ioctl+0x4f8/0xb40
[   30.168230]  ? __pfx_nouveau_uvmm_ioctl_vm_bind+0x10/0x10
[   30.168237]  ? __pfx_drm_ioctl+0x10/0x10
[   30.168244]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   30.168250]  ? lock_acquire+0x1a4/0x2e0
[   30.168255]  ? lock_release+0x1e2/0x290
[   30.168260]  ? lock_release+0x1e2/0x290
[   30.168265]  ? trace_irq_enable.constprop.0+0xfc/0x130
[   30.168271]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[   30.168277]  nouveau_drm_ioctl+0xea/0x2c0
[   30.168282]  ? __pfx_nouveau_drm_ioctl+0x10/0x10
[   30.168287]  __x64_sys_ioctl+0x180/0x1d0
[   30.168293]  do_syscall_64+0x115/0x690
[   30.168300]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   30.168305] RIP: 0033:0x424b5d
[   30.168309] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[   30.168315] RSP: 002b:00007f6c8f193060 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   30.168320] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000424b5d
[   30.168324] RDX: 00007f6c8f1930f0 RSI: 00000000c0286451 RDI: 0000000000000003
[   30.168327] RBP: 00007f6c8f1930b0 R08: 00007f6c8e9926c0 R09: 00007f6c8f192fd7
[   30.168330] R10: 0000000000000008 R11: 0000000000000246 R12: 000000001a36e720
[   30.168333] R13: 0000000000000101 R14: 00007f6c8f1930f0 R15: 00000000c0286451
[   30.168338]  </TASK>

[   30.202939] Allocated by task 335 on cpu 0 at 30.050436s:
[   30.203577]  kasan_save_stack+0x24/0x50
[   30.204053]  kasan_save_track+0x17/0x60
[   30.204521]  __kasan_kmalloc+0xaa/0xb0
[   30.204994]  __kmalloc_cache_noprof+0x299/0x630
[   30.205545]  nouveau_mem_new+0x52/0x150
[   30.206028]  nouveau_gart_manager_new+0x96/0x160
[   30.206568]  ttm_resource_alloc+0x160/0x390
[   30.207070]  ttm_bo_alloc_resource+0x332/0xbd0
[   30.207620]  ttm_bo_evict+0x1ea/0x3b0
[   30.208075]  ttm_bo_evict_cb+0x217/0x370
[   30.208553]  ttm_lru_walk_for_evict+0x11c/0x340
[   30.209112]  ttm_bo_alloc_resource+0x6fe/0xbd0
[   30.209660]  ttm_bo_validate+0x1bc/0x4a0
[   30.210143]  ttm_bo_init_reserved+0x433/0x570
[   30.210695]  nouveau_bo_init+0x159/0x2c0
[   30.211157]  nouveau_gem_new+0x426/0x5f0
[   30.211656]  nouveau_gem_ioctl_new+0x1eb/0x420
[   30.212204]  drm_ioctl_kernel+0x192/0x350
[   30.212701]  drm_ioctl+0x4f8/0xb40
[   30.213123]  nouveau_drm_ioctl+0xea/0x2c0
[   30.213618]  __x64_sys_ioctl+0x180/0x1d0
[   30.214098]  do_syscall_64+0x115/0x690
[   30.214570]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[   30.215390] Freed by task 337 on cpu 3 at 30.092154s:
[   30.216000]  kasan_save_stack+0x24/0x50
[   30.216471]  kasan_save_track+0x17/0x60
[   30.216945]  kasan_save_free_info+0x3b/0x60
[   30.217451]  __kasan_slab_free+0x61/0x80
[   30.217939]  kfree+0x383/0x590
[   30.218323]  ttm_resource_free+0x1fc/0x310
[   30.218839]  ttm_bo_release+0x392/0x9e0
[   30.219306]  ttm_bo_put+0x55/0x80
[   30.219704]  ttm_bo_move_accel_cleanup+0x2a1/0xa20
[   30.220248]  nouveau_bo_move+0x1290/0x1f60
[   30.220726]  ttm_bo_handle_move_mem+0x291/0x580
[   30.221246]  ttm_bo_validate+0x21e/0x4a0
[   30.221714]  nouveau_bo_validate+0xa6/0x100
[   30.222166]  nouveau_gem_ioctl_pushbuf+0x156b/0x5640
[   30.222724]  drm_ioctl_kernel+0x192/0x350
[   30.223143]  drm_ioctl+0x4f8/0xb40
[   30.223502]  nouveau_drm_ioctl+0xea/0x2c0
[   30.223921]  __x64_sys_ioctl+0x180/0x1d0
[   30.224328]  do_syscall_64+0x115/0x690
[   30.224730]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[   30.225414] The buggy address belongs to the object at ffff8881128aec00
                which belongs to the cache kmalloc-256 of size 256
[   30.226753] The buggy address is located 160 bytes inside of
                freed 256-byte region [ffff8881128aec00, ffff8881128aed00)

[   30.228213] The buggy address belongs to the physical page:
[   30.228763] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1128ae
[   30.229574] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   30.230341] flags: 0x200000000000040(head|node=0|zone=2)
[   30.231049] page_type: f5(slab)
[   30.231432] raw: 0200000000000040 ffff888100042b40 dead000000000100 dead000000000122
[   30.232177] raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
[   30.232926] head: 0200000000000040 ffff888100042b40 dead000000000100 dead000000000122
[   30.233701] head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
[   30.234540] head: 0200000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
[   30.235346] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   30.236149] page dumped because: kasan: bad access detected

[   30.236913] Memory state around the buggy address:
[   30.237413]  ffff8881128aeb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   30.238160]  ffff8881128aec00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   30.238921] >ffff8881128aec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   30.239636]                                ^
[   30.240066]  ffff8881128aed00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   30.240773]  ffff8881128aed80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

These two UAF share the same title, but look at the difference between kmalloc-96 (1st path) and kmalloc-256 (2nd path).
Note that struct ttm_resource is roughly 88B and struct nouveau_mem is roughly 216B.
The 1st path seems to be a type confusion between ttm_resource and nouveau_mem (same as [1], also suggested by Sashiko above);
The 2nd path seems to be a real UAF for the same type nouveau_mem objects, due to race beteen VM bind and nouveau_bo_move().
We will send a patch after researching both paths.

[1]: https://lore.kernel.org/all/0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn/
