Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71DAC5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2385810E2E4;
	Sun, 16 Aug 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="ElQvLIFw";
	dkim-atps=neutral
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com
 [203.205.221.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7637110F6A8
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786726647; bh=InnExR+ae8LlVMTrXbmxUmSOVVY9Ong/7vAv2Erkv00=;
 h=Date:From:Subject:To:Cc;
 b=ElQvLIFwPBvWWF9i6q+mHrdpwppbiesCjMFyS+FUWgoEwq5V5VtRgHYRMOmwRbZO0
 dWaHl/ApMda82FtNWtm682ry1ERt2OYiVD5d2T4/FnSUqWtoN7FS8yEXn3R66XC2je
 IFKAm+DYstEHWkK94AWcxxrSnPHcCFAVwUXuCr+U=
Received: from [IPV6:240e:604:312:765:1c20:8d58:5c0a:697e]
 ([240e:604:312:765:1c20:8d58:5c0a:697e])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id E592ACC2; Sat, 15 Aug 2026 00:57:25 +0800
X-QQ-mid: xmsmtpt1786726645tsclz3uz3
Message-ID: <tencent_3FD79BE8CC676628D531BBDE0B45EC353405@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRVM9oEWjk6jCCFkKc7eXDyUOtkXIBTLLuOkbwI7YL/r9UrrxGb/
 bpc+MJRw2XMc+obgvM4hdSPihjYEvndTUpR//w0IoKLaEVoXHC/Xdl9uZjRi0B8yg26WyVnn8R+z
 RZR42nBdnNQ2t1n0NO8Ci29b2JrERWvRiv07YAkw/2K0j7t5SxMRS6BcoRVnxHukpHwLIKv76wUy
 gWHtN5VIEwUBJh4P/jn1nyCZjhxGzeX6RavhSkTuPmRW3XaFGiNoQ35SQTcCgzlLW7bIRZzYY52s
 zmM+Cs5JQ66uEttgfZq+HHRaqDzMvpBlPi6Vo/Pi3Xwk/hNzEq17Tq4NGtEvtWat7p0jc7ybiG/y
 T2Ynsoa8LXTTUi2f6jYe30lKGwIJXqlys+Zo7ADkgIxA5X8qBZJcLnjrAaIUzKbONg0JqxbNyEI8
 EpIenK0LHTVLrxIxeRytG88QMfq48tIih/xo3Z14lHlKEAGSXZXUYveHClyvTGKKJmdBXMHqMotX
 cvmr7DQMaXc0zudXHq7jFFMxay87Accl1JetjRPMA+MAl8ACJT5JBvpuIC7/VYN9/Ir2mPH86P/K
 mVjxpvr15zrxEqnewpm3AcloetI3sHrr+rbulhi+3v42m1PadtuXeRLSMBsfRO5uhfFWJrQMqV2g
 dDYU8J+n5MVFiJhMyLd02xhE6nSRa7CSYjJ8KrLsJZXGCmenqxqjTuaZBUGlml3nu3uzc4nZLIKi
 E/P1ROJZmUfAbY9xspbiFfHQn+bloZQxvvwulKhyTJEKwxXd4pIYIgIcc1Wb6kwX6kzhKz3uePgg
 6d8dHUhJlKFmD8FIV50vPHyHsEsb6c1xK/4RmGHYrPqbkhhhIi9ST2C+SOIM7q18nJwJefjjq2m/
 YPXZjwhTd2u6lkXC7/bxVWNaWRkuQ8QnZWGIJWEIe23EA0JLX3chMGqO0Ii9NoyHi2KCCLCn+TN5
 AGR4VkEUrMnl6LqO6f8NDU2jWI4wZxh5mAESWeh4ioN53AHLOmDcgL3UGbGtLLPW3EnoI3BW/olC
 62xjv70fByOJrJsZAfzW17bRf7EMh9f0oAk5bMKQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <b9f23d2a-9f88-458a-b600-a076e78c778f@qq.com>
Date: Sat, 15 Aug 2026 00:57:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yang Zi <2959243019@qq.com>
Subject: [BUG] KASAN: slab-use-after-free Write in __drm_buddy_free [amdgpu]
 [syzkaller]
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Hello,

While fuzzing the amdgpu driver on Linux 6.19.10 with a hardware-free device-model approach, I found a slab-use-after-free (write) in the DRM buddy allocator. The faulting object is a drm_buddy_block from the drm_buddy_block slab cache (80-byte region); the write is 8 bytes into the freed rb-node field.

The bug is reached through amdgpu, but the root cause is in the generic DRM buddy allocator (drivers/gpu/drm/drm_buddy.c), not in amdgpu itself. It appears to be the write-side manifestation of the same allocator rollback defect as the slab-use-after-free (read) in drm_buddy_alloc_blocks that I am reporting separately.

Root cause analysis:

During a drm_buddy_alloc_blocks() request, __alloc_range_bias() splits blocks to satisfy a biased/ranged allocation (split_block at drm_buddy.c:437). On a split failure it takes a rollback path that calls __drm_buddy_free() (drm_buddy.c:213 via __alloc_range_bias at drm_buddy.c:689), which frees one or more child drm_buddy_block objects via drm_block_free() while merging upward.

A stale reference to a freed child block survives in the allocator's bookkeeping, so the resulting VRAM resource ends up referencing a dangling drm_buddy_block. Later, when user space closes the DRM fd, the release path amdgpu_driver_postclose_kms -> ttm_bo_release -> amdgpu_vram_mgr_del (amdgpu_vram_mgr.c:652) -> __drm_buddy_free_list (drm_buddy.c:560) -> __drm_buddy_free (drm_buddy.c:209) -> rbtree_remove (drm_buddy.c:112) walks that freed block and calls rb_erase(&block->rb, root), writing into the freed rb-node. This is the reported UAF write.

The crash report attached below:
BUG: KASAN: slab-use-after-free in __rb_erase_augmented include/linux/rbtree_augmented.h:251 [inline]
BUG: KASAN: slab-use-after-free in rb_erase+0x229/0xe20 lib/rbtree.c:443
Write of size 8 at addr ffff888111229178 by task syz.0.836/3355

CPU: 0 UID: 0 PID: 3355 Comm: syz.0.836 Not tainted 6.19.10 #3 PREEMPT(voluntary) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-2-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xa2/0xd0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xbc/0x260 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __rb_erase_augmented include/linux/rbtree_augmented.h:251 [inline]
 rb_erase+0x229/0xe20 lib/rbtree.c:443
 rbtree_remove drivers/gpu/drm/drm_buddy.c:112 [inline]
 __drm_buddy_free+0x32e/0x5a0 drivers/gpu/drm/drm_buddy.c:209
 drm_buddy_free_block drivers/gpu/drm/drm_buddy.c:542 [inline]
 __drm_buddy_free_list+0x23b/0x2e0 drivers/gpu/drm/drm_buddy.c:560
 amdgpu_vram_mgr_del+0x1cb/0x220 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:652
 ttm_resource_free+0x15c/0x1b0 drivers/gpu/drm/ttm/ttm_resource.c:422
 ttm_bo_cleanup_memtype_use drivers/gpu/drm/ttm/ttm_bo.c:188 [inline]
 ttm_bo_release drivers/gpu/drm/ttm/ttm_bo.c:315 [inline]
 kref_put include/linux/kref.h:65 [inline]
 ttm_bo_put+0x978/0xb50 drivers/gpu/drm/ttm/ttm_bo.c:326
 kref_put include/linux/kref.h:65 [inline]
 __drm_gem_object_put include/drm/drm_gem.h:526 [inline]
 drm_gem_object_put include/drm/drm_gem.h:539 [inline]
 amdgpu_bo_unref+0x60/0xb0 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:905
 amdgpu_driver_postclose_kms+0x39d/0x520 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:1536
 drm_file_free+0x6ca/0x910 drivers/gpu/drm/drm_file.c:270
 drm_close_helper drivers/gpu/drm/drm_file.c:293 [inline]
 drm_release+0x279/0x370 drivers/gpu/drm/drm_file.c:441
 amdgpu_drm_release+0x113/0x160 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2981
 __fput+0x41f/0xa40 fs/file_table.c:468
 task_work_run+0x18e/0x200 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xe3/0x460 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x29e/0x360 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f33d3659c6d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeec7e40e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffeec7e41b0 RCX: 00007f33d3659c6d
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f33d3887ba0 R08: 0000000000000000 R09: ffffffffffffffff
R10: 00007f33d34a0000 R11: 0000000000000246 R12: 00007f33d3885fac
R13: 00000000000003e8 R14: 0000000000034256 R15: 00007f33d3885fa0
 </TASK>

Allocated by task 3356:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x4b/0x60 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:5045 [inline]
 slab_alloc_node mm/slub.c:5355 [inline]
 kmem_cache_alloc_noprof+0x1f3/0x670 mm/slub.c:5362
 drm_block_alloc drivers/gpu/drm/drm_buddy.c:36 [inline]
 split_block+0xa6/0x7f0 drivers/gpu/drm/drm_buddy.c:437
 __alloc_range_bias+0x5f1/0x8d0 drivers/gpu/drm/drm_buddy.c:668
 drm_buddy_alloc_blocks+0x4d3/0xce0 drivers/gpu/drm/drm_buddy.c:1174
 amdgpu_vram_mgr_new+0x72c/0x10e0 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:539
 ttm_resource_alloc+0x13b/0x230 drivers/gpu/drm/ttm/ttm_resource.c:392
 ttm_bo_alloc_resource+0x2c7/0x8c0 drivers/gpu/drm/ttm/ttm_bo.c:742
 ttm_bo_validate+0x1e8/0x530 drivers/gpu/drm/ttm/ttm_bo.c:858
 ttm_bo_init_reserved+0x32e/0x480 drivers/gpu/drm/ttm/ttm_bo.c:972
 amdgpu_bo_create+0x6a2/0xe00 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:703
 amdgpu_bo_create_user+0x87/0x100 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:768
 amdgpu_gem_object_create drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:188 [inline]
 amdgpu_mode_dumb_create+0x250/0x400 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:1259
 drm_mode_create_dumb drivers/gpu/drm/drm_dumb_buffers.c:227 [inline]
 drm_mode_create_dumb_ioctl+0x211/0x2a0 drivers/gpu/drm/drm_dumb_buffers.c:236
 drm_ioctl_kernel+0x23f/0x300 drivers/gpu/drm/drm_ioctl.c:804
 drm_ioctl+0x644/0xac0 drivers/gpu/drm/drm_ioctl.c:901
 amdgpu_drm_ioctl+0xb0/0x120 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2996
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd8/0x360 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 3356:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x3a/0x60 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2580 [inline]
 slab_free mm/slub.c:6791 [inline]
 kmem_cache_free+0x180/0x560 mm/slub.c:6906
 drm_block_free drivers/gpu/drm/drm_buddy.c:53 [inline]
 __drm_buddy_free+0x357/0x5a0 drivers/gpu/drm/drm_buddy.c:213
 __alloc_range_bias+0x88c/0x8d0 drivers/gpu/drm/drm_buddy.c:689
 drm_buddy_alloc_blocks+0x4d3/0xce0 drivers/gpu/drm/drm_buddy.c:1174
 amdgpu_vram_mgr_new+0x72c/0x10e0 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:539
 ttm_resource_alloc+0x13b/0x230 drivers/gpu/drm/ttm/ttm_resource.c:392
 ttm_bo_alloc_resource+0x2c7/0x8c0 drivers/gpu/drm/ttm/ttm_bo.c:742
 ttm_bo_validate+0x1e8/0x530 drivers/gpu/drm/ttm/ttm_bo.c:858
 ttm_bo_init_reserved+0x32e/0x480 drivers/gpu/drm/ttm/ttm_bo.c:972
 amdgpu_bo_create+0x6a2/0xe00 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:703
 amdgpu_bo_create_user+0x87/0x100 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:768
 amdgpu_gem_object_create drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:188 [inline]
 amdgpu_mode_dumb_create+0x250/0x400 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:1259
 drm_mode_create_dumb drivers/gpu/drm/drm_dumb_buffers.c:227 [inline]
 drm_mode_create_dumb_ioctl+0x211/0x2a0 drivers/gpu/drm/drm_dumb_buffers.c:236
 drm_ioctl_kernel+0x23f/0x300 drivers/gpu/drm/drm_ioctl.c:804
 drm_ioctl+0x644/0xac0 drivers/gpu/drm/drm_ioctl.c:901
 amdgpu_drm_ioctl+0xb0/0x120 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2996
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd8/0x360 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888111229150
 which belongs to the cache drm_buddy_block of size 80
The buggy address is located 40 bytes inside of
 freed 80-byte region [ffff888111229150, ffff8881112291a0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x111229
flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff88810497a780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080240024 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888111229000: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
 ffff888111229080: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
>ffff888111229100: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
                                                                ^
 ffff888111229180: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888111229200: fb fb fc fc fc fc fa fb fb fb fb fb fb fb fb fb
==================================================================

Regards,
Yang Zi

