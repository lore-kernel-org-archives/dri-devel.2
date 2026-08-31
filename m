Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F99C624D2
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55B910EBB0;
	Tue,  1 Sep 2026 07:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="J7QZteHi";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AECC10E269;
 Mon, 31 Aug 2026 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1788171917;
 bh=HN7ZYFndlFzWF/4LHCcxX+J5bKHhHro+gAvSDxxhvus=;
 h=Message-ID:Date:MIME-Version:From:Subject:To;
 b=J7QZteHii3ah2Ja3JQLuzkSUv5UX71smt9yjGYIMqNkZEbLKrGn3IXtJ2KvQsokTR
 RUy+iCUavNQpIDJiR8V7F5Mivj0E8j2ZVS1DsZFp1cfZzIEjY5QkbMxzHsrH5wwBpE
 ubNA6hViAteJ0bd2LwEIrG3tpRRPTgoQVbTh9bjs=
X-QQ-mid: zesmtpgz9t1788171911t6e96afb4
X-QQ-Originating-IP: pdz5bx2PCuB7VaE6d0z/N9mhXIcrPStA16xeaeD2/YE=
Received: from [127.0.0.1] ( [180.98.43.87]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 31 Aug 2026 18:25:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14989090907872479450
Message-ID: <0101FF6B4641D94C+63f6ab39-aa06-4697-92fe-9241aef45218@smail.nju.edu.cn>
Date: Mon, 31 Aug 2026 18:25:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [BUG] nouveau: KASAN slab-use-after-free Read in nvif_object_mthd
To: lyude@redhat.com, dakr@kernel.org
Cc: nouveau@lists.freedesktop.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MjA5tsjrlPcvFCdmRXu4zcLreN71KtQPI1Kn3F93u54yn/nsuJC65M75
 tTD0d9C6rvbhBInyANfUaAuhg0/DDk1TjuDzpOyxuXjRNIv11+sjWFhdY0ygsgBq95/1hBi
 daAk0Ox8/gIVqpAk7UFuJT5Mhj96GMvy/ZdoPP8auhIYOfc+Bqeg+3cJcEIEQx9DI8WbwKM
 yaTYmPv+g38MvfdeF/tzyVbMq4fUz/3ZNATLt3y2rGtK4K6u+r/mPDsL/nI/zAXaGHpNpSl
 xk5pajDxgBpnYUOrYIQt2enWVcg5d3+h4kpzirF5G8QsshnBTrkflcsQMPD1Y17LGugF9Np
 X7rdOi5LT81Oz4bZLGZIH4NvnpnR51oL5/Wiy+EjqOLLUvsUzOALPzGq1EHKOUnBERzdSi1
 Gr6jMWSVWI3ABYGvGMVNSIdIcdtrSazza+JDRWYtWlH8sEQ2TId46h3bFH498G/GFprkM1M
 reJ8x/er6jY6HorYITK1DgiAeTw4tRxFs9+BFL5ymSchVdCNmltpqYYgj3vhotuTgz18QCg
 BxIrEYT3T6kAGXAULTyvyZhTawzXM1PSsRqyWzzInIGFfZCEiG/QEJVJZ0C6E1ulw7FgxAg
 NNd586w01IorxbEkMBQtkHMiCqCzy5UkjoBcldtwc5hpfGrDD4XqvPvgfW10Q/V6X6mUVkF
 HQZFrn2Rjbf/tAQnJhqOzXxpymtCJ9jkedyoxd+enCWn5P+I1s/2N6P2KYDQTFGVcznRvAS
 2HafFSd9hTbDQYd+jxkmjI4lhOv9BOyNRv0xii14wbOCpSgHPS95nseLZs8lhK26eL28W+f
 Jhj0qAobrTQhQD/xZFkl8ULIRrP9Q6yjk7Hh3hybSSkOe1kaxfTVIo1DjujKZlEm/x221gM
 bSd9fYhTRnAF5OWpMNVP774bw6VzKX6kA4fg4AbyQeFFJoFIe2n+CRECp88rPqYfb3b/t4g
 1pZ0U3Q4gXYpVz0DG9+ySzfQnp63PhPMLeaGIgIkpNJz3vH46g9cwaNDdm2DV7WcWAxBaNq
 Q2EXTJpAwjK/1rM1sLTI5VunDILOQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

Hello Linux kernel developers and maintainers,

We found a KASAN: slab-use-after-free Read in nvif_object_mthd
when fuzzing the nouveau driver with one research tool we built
on top of Syzkaller.

The version of the kernel under test is 8d3ae59288f1e7d58d76558a6ee96d533bc5019f (tag v7.2).
It is fuzzed inside a QEMU virtual machine using a GTX 1650 GPU
passed through from the host via VFIO.

We believe this UAF is a GPU VMA lifetime bug triggered by unusal syscall
sequence. A legacy per-client GPU mapping is created when the DRM client
is in legacy VMM mode. If userspace then switches the client into UVMM mode
with DRM_IOCTL_NOUVEAU_VM_INIT, nouveau_gem_object_close() takes an early return
for UVMM clients and never tears that legacy vma down, so it stays linked on nvbo->vma_list
with vma->vmm pointing at cli->vmm. If the backing BO is kept alive past
the client (e.g. it was exported as a PRIME dma-buf), closing the DRM fd
frees cli->vmm, and the later destruction of the shared BO walks the
stale vma and unmaps it against the freed vmm. The freed object is dereferenced
as an nvif_object, and its client pointer is read from freed memory,
thus triggering the KASAN report.

More detailed analysis will be given below.

================
Syzkaller report
================

BUG: KASAN: slab-use-after-free in nvif_object_mthd+0x59a/0x600
Read of size 8 at addr ffff88811fe29230 by task syz.0.71/2823

CPU: 1 UID: 0 PID: 2823 Comm: syz.0.71 Not tainted 7.2.0 #4 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x95/0xe0
 print_report+0xcb/0x5a0 report.c:-1
 kasan_report+0xca/0x100
 nvif_object_mthd+0x59a/0x600
 nvif_vmm_unmap+0x86/0xb0
 nouveau_vma_unmap+0x7b/0xe0
 nouveau_bo_move_ntfy+0x222/0x620 nouveau_bo.c:-1
 ttm_bo_cleanup_memtype_use+0x99/0x200 ttm_bo.c:-1
 ttm_bo_release+0x392/0x9e0 ttm_bo.c:-1
 ttm_bo_fini+0x55/0x80
 nouveau_gem_object_del+0xb2/0x1b0
 drm_gem_object_free+0x5f/0x90
 drm_gem_dmabuf_release+0xb9/0xd0
 dma_buf_release+0x140/0x2b0 dma-buf.c:-1
 dentry_kill+0x291/0xb10 dcache.c:-1
 finish_dput+0x20/0x180 dcache.c:-1
 dput+0x3b/0x40
 __fput+0x483/0xa60 file_table.c:-1
 task_work_run+0x15a/0x230
 exit_to_user_mode_loop+0x18d/0x440
 do_syscall_64+0x4f8/0x690
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f509a83594d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8f3056e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f509aac7da0 RCX: 00007f509a83594d
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ffd8f305788 R08: 0000001b2bf20219 R09: 30007f509a8dd1d4
R10: 0000001b2c320000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 00007f509aac5fac R14: 00007f509aac7da0 R15: 00007ffd8f3057b0
 </TASK>

Allocated by task 2824 on cpu 0 at 55.525014s:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x17/0x60
 __kasan_kmalloc+0xaa/0xb0
 __kmalloc_cache_noprof+0x299/0x630
 nouveau_drm_open+0x217/0x740 nouveau_drm.c:-1
 drm_file_alloc+0x5f2/0xad0
 drm_open_helper+0x1d7/0x4a0
 drm_open+0x190/0x3d0
 drm_stub_open+0x1f2/0x460 drm_drv.c:-1
 chrdev_open+0x21c/0x660 char_dev.c:-1
 do_dentry_open+0x59d/0x12b0 open.c:-1
 vfs_open+0x82/0x390
 path_openat+0x2345/0x3420 namei.c:-1
 do_file_open+0x207/0x460
 do_sys_openat2+0xd1/0x1d0 open.c:-1
 __x64_sys_openat+0x144/0x200
 do_syscall_64+0x115/0x690
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 2824 on cpu 0 at 55.617917s:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x17/0x60
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x61/0x80
 kfree+0x383/0x590
 nouveau_drm_postclose+0x270/0x3e0 nouveau_drm.c:-1
 drm_file_free.part.0+0x6d6/0xb60 drm_file.c:-1
 drm_close_helper.isra.0+0x11a/0x160 drm_file.c:-1
 drm_release+0x1ab/0x330
 __fput+0x39c/0xa60 file_table.c:-1
 fput_close_sync+0xf0/0x1f0
 __x64_sys_close+0x8a/0xf0
 do_syscall_64+0x115/0x690
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88811fe29000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 560 bytes inside of
 freed 2048-byte region [ffff88811fe29000, ffff88811fe29800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11fe28
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88811fe29100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811fe29180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88811fe29200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88811fe29280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811fe29300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

==========
Root cause
==========

MODE_CREATE_DUMB    /* client still legacy: cli->uvmm.ptr == NULL */
--> nouveau_gem_object_open
    --> !nouveau_cli_uvmm(cli) == true
        --> nouveau_vma_new
            --> vma->vmm = &cli->vmm
            --> list_add_tail(&vma->head, &nvbo->vma_list)

NOUVEAU_VM_INIT
--> nouveau_uvmm_ioctl_vm_init
    --> cli->uvmm.ptr = uvmm    /* client now UVMM */

PRIME_HANDLE_TO_FD(dumb)
--> drm_gem_prime_export    /* dma_buf holds a ref on the BO, the BO outlives client */

MODE_DESTROY_DUMB / GEM_CLOSE
--> nouveau_gem_object_close
    --> nouveau_cli_uvmm(cli) == true /* return early, vma NOT removed, still on nvbo->vma_list */

close(drm_fd)
--> nouveau_drm_postclose
    --> nouveau_cli_fini
        --> flush_work(&cli->work)    /* orphan vma not on queue */
        --> nouveau_vmm_fini(&cli->vmm)
            --> nvif_vmm_dtor(&cli->vmm.vmm)
    --> kfree(cli)    /* cli->vmm (vma->vmm) freed */

close(dma_buf_fd)    /* explicit, or at task exit */
--> __fput
    --> dma_buf_release
        --> drm_gem_dmabuf_release
            --> nouveau_gem_object_del
                --> ttm_bo_release
                    --> nouveau_bo_move_ntfy
                        --> list_for_each_entry(vma, &nvbo->vma_list, head)
                            --> nouveau_vma_unmap(vma)    /* the orphan vma */
                                --> nvif_vmm_unmap(&vma->vmm->vmm)    /* vma->vmm is freed */
                                    --> nvif_object_mthd
                                        --> nvif_object_ioctl
                                            --> client = object->client    /* UAF read of freed cli->vmm */

=============
Suggested fix
=============

From the comments in nouveau_gem_ioctl_new and nouveau_abi16_ioctl_channel_alloc:

    /* If uvmm wasn't initialized until now disable it completely to prevent
	 * userspace from mixing up UAPIs.

it seems the design intention is that legacy mode and UVMM mode should be mutually exclusive.
nouveau_gem_ioctl_new and nouveau_abi16_ioctl_channel_alloc do this by calling
__nouveau_cli_disable_uvmm_noinit(cli). So the minimum fix for this UAF is to add
the same calling in the dumb path:

  diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
  --- a/drivers/gpu/drm/nouveau/nouveau_display.c
  +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
  @@ -818,6 +818,11 @@ nouveau_display_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
        else
                domain = NOUVEAU_GEM_DOMAIN_GART;

  +     /* If uvmm wasn't initialized until now disable it completely to prevent
  +      * userspace from mixing up UAPIs.
  +      */
  +     nouveau_cli_disable_uvmm_noinit(cli);
        ret = nouveau_gem_new(cli, args->size, 0, domain, 0, 0, &bo);
        if (ret)
                return ret;

We are happy to send a patch if the fix is considered reasonable.

---
Best,
Peiyang
