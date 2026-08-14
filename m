Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A28C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8795210E2DF;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="NZuQSUXr";
	dkim-atps=neutral
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com
 [203.205.221.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2128610F6AE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786726926; bh=/ycu+Mz1AYOaiJzr4JJnqRYKXbW0j7jVDsOSI2to+Zc=;
 h=Date:To:Cc:From:Subject;
 b=NZuQSUXr1AjUxnI8pddUMZp7jpaXxKd+YBt8A821jx4qGwFJTh8lhDlYBXsi1mckV
 DOaN6QDMkYITGNaMpDw9HyDaEA26W8zdOAcBjYOeAUL1W0hmtimY0y2EQSFbI9qQZI
 d7GWy153H3Lg5NnEcTEuOkkNQqNeoJDgZFBPjHLA=
Received: from [IPV6:240e:604:312:765:1c20:8d58:5c0a:697e]
 ([240e:604:312:765:1c20:8d58:5c0a:697e])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 3807618; Sat, 15 Aug 2026 01:00:56 +0800
X-QQ-mid: xmsmtpt1786726856twd5idnn0
Message-ID: <tencent_6D8BD584B67A439FC9CEA4A59A660B78C50A@qq.com>
X-QQ-XMAILINFO: OHxUmJMhaUaq4R4ae6SDFyVEf3AqIue+q0kuzGA0RjGAEGZZ/vTB0C241/QnW5
 ZuQOd8OblnUsFjEXa8hD6anl21/FQk7NySl6la2lVyov0LZnfrZcT2mxIIlmKTWjRrmFa9x+W4aU
 VH12oDxZ9L8YIJhALSx8HDc7uzuAkxlKzUWwSSDTzXDFMMqGImxcsRwRYBXYDpueZZ1kp81QoTD+
 C3V4lAZAUJ8nA6eIQeLLREEuBD42R6x9eTU9DHYXuZE13dFmw2/bxM0ZNzBIWEyGfdTT7Pfvbvdh
 GJ0SJsrCMbYzA4Op2sfTPwdb3e4uj4DfUo8788dIhLeVYPeLXLTj3XRTe/cZ5HNnK3Az1q/mXRTO
 6KDXnr1+0YbEDTYBf0SlZX3xYY4EiZ6wWndRqAS287kDP0/2mHaocqzBnobKnXUHXsTNXuoGNRIN
 3Jpi7WclyRyP7khKPEx2h0O34AyI2t/avAjnQhGpMSnKYT2TVwvs3AKTr0bTPJ5zKWMWKw6pdfbw
 JfwUu6Labih2Ekz4MurQKtoRIAQWzlhXW3lbYtK5Ytk8SbGZjL5UNG3loA1EccJBn/qwSC/sekNo
 wtFP787iCrpC6cxhrigSy5Upl9B7Gdp1njJghJUDXTYQX39ebMHV7uxyU/tbn4TFhYoxIaemGA0A
 IWQ6CjT6TXsQKsEwx6ZxpVF5rye354M8ygHzTktDiwvr4kP6hMrYo4VYFjFlgX/xF/mZaKUM+PdW
 5YWXpq9aQjgzIMwh4ASwwlB0mBqEVQNjeHlDVSIofjv0FKfjC7hfK/4gESKbYV74IPxCFcx206RI
 mK4v+7MRQq+IPC6ab5sWWGGgCDuAegk4+tL51f73WbWQ3khO0Roa/396GK5BCX06Grw2pJ4TjDp+
 c6+B1mDyiS7jE4s9BBW6iKVlwVFOErosO+iVPCZTaLbzBxKBe/NVCy3DrQYjJ6xS6e4hj9Tk9S8P
 fRjQDvJdeKRKvNkluD/RT5wK8lcFvy/r8RWEbNiHCqzYEuC6DFphDQcZk6MdaZqrN+RazNtS9fgq
 y2Il6vRetihkmA6oRECHiSPw6ThcXTWa6892U839ZvHmxPfd6xUrH/Gdzw/u2QNUxKqISO+QZj8t
 oPXx3L
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <b27b0c6f-1ee1-44fa-a6ca-57b8a3b54032@qq.com>
Date: Sat, 15 Aug 2026 01:00:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [BUG] KASAN: slab-use-after-free Read in drm_buddy_alloc_blocks
 [amdgpu] [syzkaller]
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

While fuzzing the amdgpu driver on Linux 6.19.10 with a hardware-free
device-model approach on syzkaller, I found a slab-use-after-free (read) 
in the DRM buddy allocator. The faulting object is a drm_buddy_block from 
the drm_buddy_block slab cache (80-byte region).

The bug is reached through DRM_IOCTL_MODE_CREATE_DUMB on amdgpu, but the root
cause is in the generic DRM buddy allocator (drivers/gpu/drm/drm_buddy.c), not
in amdgpu itself.

Root cause analysis:

During a single drm_buddy_alloc_blocks() request, a block B is allocated and
then trimmed via drm_buddy_block_trim(), which marks B free, detaches its
parent, and calls __alloc_range() over B's subtree. __alloc_range() repeatedly
splits blocks (split_block) and pushes the left/right children onto its DFS
list. When a deeper split_block() fails, control reaches the err_undo path
(drm_buddy.c:885), which calls __drm_buddy_free() on a still-free block. The
merge loop in __drm_buddy_free() (drm_buddy.c:209-213) frees the current block
and its buddy via drm_block_free() and climbs upward, re-inserting the merged
block into the free tree.

The problem is that a stale reference to one of the just-freed child blocks
survives in the allocator's traversal/bookkeeping. When the outer allocation
loop then allocates again, it revisits that already-freed block and calls
mark_allocated() -> rbtree_remove() -> rb_erase(&block->rb, root)
(drm_buddy.c:112), reading from the freed rb-node. This is the reported UAF.

Relevant call stacks from the KASAN report:

Use (read), drm_buddy_alloc_blocks -> mark_allocated -> rbtree_remove
(drm_buddy.c:112) -> rb_erase.
Freed, drm_buddy_alloc_blocks -> drm_buddy_block_trim -> __alloc_range
(drm_buddy.c:885) -> __drm_buddy_free -> drm_block_free.
Allocated, drm_buddy_alloc_blocks -> split_block -> drm_block_alloc.
The free task and the use task are the same, so the entire free-then-use cycle
happens within one drm_buddy_alloc_blocks() invocation.

I also found a closely related slab-use-after-free (write) in __drm_buddy_free()
via the amdgpu_vram_mgr free path, which appears to share the same underlying
allocator rollback defect. I am reporting it separately.

The crash report attached below:

==================================================================
BUG: KASAN: slab-use-after-free in __rb_change_child include/linux/rbtree_augmented.h:199 [inline]
BUG: KASAN: slab-use-after-free in __rb_erase_augmented include/linux/rbtree_augmented.h:242 [inline]
BUG: KASAN: slab-use-after-free in rb_erase+0x135/0xe20 lib/rbtree.c:443
Read of size 8 at addr ffff888107266ea8 by task syz.0.131/1294

CPU: 0 UID: 0 PID: 1294 Comm: syz.0.131 Not tainted 6.19.10 #3 PREEMPT(voluntary) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-2-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xa2/0xd0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xbc/0x260 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __rb_change_child include/linux/rbtree_augmented.h:199 [inline]
 __rb_erase_augmented include/linux/rbtree_augmented.h:242 [inline]
 rb_erase+0x135/0xe20 lib/rbtree.c:443
 rbtree_remove drivers/gpu/drm/drm_buddy.c:112 [inline]
 mark_allocated drivers/gpu/drm/drm_buddy.c:132 [inline]
 drm_buddy_alloc_blocks+0x642/0xce0 drivers/gpu/drm/drm_buddy.c:1210
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
RIP: 0033:0x7f38d47a9c6d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38d2ddeff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f38d49d5fa0 RCX: 00007f38d47a9c6d
RDX: 0000200000000040 RSI: 00000000c02064b2 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f38d49d5fac
R13: 0000000000000000 R14: 00007f38d2ddfce4 R15: 00007ffd443c5027
 </TASK>

Allocated by task 1292:
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
 __alloc_range+0x4c8/0xa30 drivers/gpu/drm/drm_buddy.c:857
 drm_buddy_block_trim+0x721/0x8e0 drivers/gpu/drm/drm_buddy.c:1055
 drm_buddy_alloc_blocks+0xadb/0xce0 drivers/gpu/drm/drm_buddy.c:1241
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

Freed by task 1292:
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
 __alloc_range+0x9ff/0xa30 drivers/gpu/drm/drm_buddy.c:885
 drm_buddy_block_trim+0x721/0x8e0 drivers/gpu/drm/drm_buddy.c:1055
 drm_buddy_alloc_blocks+0xadb/0xce0 drivers/gpu/drm/drm_buddy.c:1241
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

The buggy address belongs to the object at ffff888107266e70
 which belongs to the cache drm_buddy_block of size 80
The buggy address is located 56 bytes inside of
 freed 80-byte region [ffff888107266e70, ffff888107266ec0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107266
anon flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff88810497a780 ffffea0004257d00 dead000000000003
raw: 0000000000000000 0000000000240024 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888107266d80: fc fc fa fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888107266e00: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
>ffff888107266e80: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
                                  ^
 ffff888107266f00: fb fb fb fb fb fb fc fc fc fc 00 00 00 00 00 00
 ffff888107266f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Regards,
Yang Zi

