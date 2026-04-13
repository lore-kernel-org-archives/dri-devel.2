Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF53DF34C6F
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2419810E4E0;
	Mon, 13 Apr 2026 17:16:39 +0000 (UTC)
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com
 [209.85.210.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D2210E4DD
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 17:16:37 +0000 (UTC)
Received: by mail-ot1-f80.google.com with SMTP id
 46e09a7af769-7dbb6b95836so10977658a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 10:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100596; x=1776705396;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GQ7F6hnbsEIckeyfC98dBjyoawgXwUlZ9CS0xO3gO28=;
 b=g3dHZWy+36W3qjROiJk5O7LbFgysyPOcbn1M4cfOXVYOYkArTXyITXzAy02sIny4YH
 JVAg7dn8nRDTuZf42ioui3jXCTV2K8gKHpcm1b55Wa07Lp4tNL7Ugz85ok2TTS3g5BlH
 Qa3zR0+7jDI5WRbmYrmFfYpDLRgHlMribh6e6bynr2seTztrfH5kN2KBDY5MXLo1zaRm
 OYRa6FYlnid5tl4eKN9JMEuBM47qlZumeealZLxKMbpt6Y+kPX/m9KIkMAbrQ5RehCNv
 sFaSmzNC2f6lm4Ur1kKSi7QQKRotu4pyYMEZTdljlkGI/7WRjO6fN8/muyYodU4IeCZ3
 G0rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+bmxqpSVG2DxMjBO/ilrBashjpKBsqYXrbTzhTprIdaZhdVMCMj8n503aOdpu9irsewEPd1rm2n8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvnnGj6ceELTsN6qwHSYHihiJN/mVvd7CQ40i3P9vx+Vpr9hve
 EjRCmc2fbMNrO6GW0fvuHsl7K2sLziSnYLNkbJcBUDwP1xJO70fivsV3Gcb5aWkm3b/7ofGg4Du
 rl0QxfEcfnGnLD2dNBZ3N/4bfIOfrBedTnJxeCbjuhwsM1EocwwRVg4Lfm2A=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b1a:b0:67e:3f0d:422a with SMTP id
 006d021491bc7-68be5e56d2emr7113796eaf.8.1776100596187; Mon, 13 Apr 2026
 10:16:36 -0700 (PDT)
Date: Mon, 13 Apr 2026 10:16:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69dd24f4.a00a0220.468cb.004a.GAE@google.com>
Subject: [syzbot] [dri?] KASAN: slab-use-after-free Read in
 drm_gem_object_release_handle
From: syzbot <syzbot+b2e951687503f32f74ce@syzkaller.appspotmail.com>
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, simona@ffwll.ch, syzkaller-bugs@googlegroups.com, 
 tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
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

syzbot found the following issue on:

HEAD commit:    f5459048c38a Merge tag 'i2c-for-7.0-final' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1028d106580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91
dashboard link: https://syzkaller.appspot.com/bug?extid=b2e951687503f32f74ce
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1428d106580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17509036580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/530844b89fdc/disk-f5459048.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/551ba51d047c/vmlinux-f5459048.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e6a44490566/bzImage-f5459048.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2e951687503f32f74ce@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in drm_gem_object_release_handle+0x4b/0x1e0 drivers/gpu/drm/drm_gem.c:374
Read of size 8 at addr ffff88806c6ffa88 by task syz.1.18/6089

CPU: 1 UID: 0 PID: 6089 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 drm_gem_object_release_handle+0x4b/0x1e0 drivers/gpu/drm/drm_gem.c:374
 idr_for_each+0x1c6/0x2a0 lib/idr.c:210
 drm_gem_release+0x28/0x40 drivers/gpu/drm/drm_gem.c:1088
 drm_file_free+0x729/0xa00 drivers/gpu/drm/drm_file.c:261
 drm_close_helper drivers/gpu/drm/drm_file.c:290 [inline]
 drm_release+0x2de/0x3f0 drivers/gpu/drm/drm_file.c:438
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc3279c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc28821858 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffc28821940 RCX: 00007efc3279c819
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000001956f R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2f520000 R11: 0000000000000246 R12: 00007ffc28821980
R13: 00007efc32a1609c R14: 00000000000195b1 R15: 00007efc32a16090
 </TASK>

Allocated by task 6090:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5380
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 __drm_gem_shmem_create+0xc4/0x2e0 drivers/gpu/drm/drm_gem_shmem_helper.c:130
 drm_gem_shmem_create drivers/gpu/drm/drm_gem_shmem_helper.c:157 [inline]
 drm_gem_shmem_create_with_handle drivers/gpu/drm/drm_gem_shmem_helper.c:460 [inline]
 drm_gem_shmem_dumb_create+0x72/0x120 drivers/gpu/drm/drm_gem_shmem_helper.c:549
 drm_mode_create_dumb drivers/gpu/drm/drm_dumb_buffers.c:227 [inline]
 drm_mode_create_dumb_ioctl+0x2bd/0x340 drivers/gpu/drm/drm_dumb_buffers.c:236
 drm_ioctl_kernel+0x2df/0x3b0 drivers/gpu/drm/drm_ioctl.c:804
 drm_ioctl+0x6ba/0xb80 drivers/gpu/drm/drm_ioctl.c:901
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6093:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kfree+0x1c1/0x630 mm/slub.c:6483
 drm_gem_object_release_handle+0xc2/0x1e0 drivers/gpu/drm/drm_gem.c:385
 drm_gem_handle_delete+0x7b/0xb0 drivers/gpu/drm/drm_gem.c:413
 drm_ioctl_kernel+0x2df/0x3b0 drivers/gpu/drm/drm_ioctl.c:804
 drm_ioctl+0x6ba/0xb80 drivers/gpu/drm/drm_ioctl.c:901
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88806c6ff800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 648 bytes inside of
 freed 1024-byte region [ffff88806c6ff800, ffff88806c6ffc00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6c6f8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fea6dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fea6dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001b1be01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5954, tgid 5954 (syz-executor), ts 103695420380, free_ts 92416780237
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x2e6/0x730 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __do_kmalloc_node mm/slub.c:5259 [inline]
 __kmalloc_node_noprof+0x577/0x7c0 mm/slub.c:5266
 kmalloc_node_noprof include/linux/slab.h:1081 [inline]
 qdisc_alloc+0x92/0x9e0 net/sched/sch_generic.c:951
 qdisc_create_dflt+0x8e/0x510 net/sched/sch_generic.c:1006
 attach_one_default_qdisc net/sched/sch_generic.c:1172 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2684 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1190 [inline]
 dev_activate+0x378/0x1150 net/sched/sch_generic.c:1249
 __dev_open+0x67a/0x830 net/core/dev.c:1711
 __dev_change_flags+0x1f7/0x690 net/core/dev.c:9781
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9844
 do_setlink+0xf82/0x4590 net/core/rtnetlink.c:3180
 rtnl_changelink net/core/rtnetlink.c:3798 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
 rtnl_newlink+0x15ad/0x1bb0 net/core/rtnetlink.c:4108
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
page last free pid 5854 tgid 5854 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 vfree+0x25a/0x400 mm/vmalloc.c:3479
 kcov_put kernel/kcov.c:442 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:543
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x70f/0x23c0 kernel/exit.c:976
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1118
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88806c6ff980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806c6ffa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806c6ffa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88806c6ffb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806c6ffb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
