Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DB8CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022F410E72B;
	Wed, 10 Jun 2026 06:19:34 +0000 (UTC)
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com
 [209.85.160.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B24D410E72B
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:19:32 +0000 (UTC)
Received: by mail-oa1-f78.google.com with SMTP id
 586e51a60fabf-43d34274233so7946676fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 23:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781072372; x=1781677172;
 h=content-transfer-encoding:to:from:subject:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zq6dIrNKFUl4fpnAHhFyrc9THsE98U1AyDAj4fNNJhY=;
 b=Fs4NX73MnW02Z+vsRFZB2i0d2nDv2wUL/Ux9h7xMmnYpr03sq29l2rAxZ2JTCLCuEY
 Yro3mM6gYcXm1FBLc3PnKDMQb7jtCxf1rDZ3NZAKPHC7DdGCpQ37+Z5dcWbmYvRgAAgB
 oEo9HIafA4TBBn2T/DN7gWAEJTUFgz2eDlNwxu44EzFhGuh4GtayR9hY3EYUx2qzAMbX
 ytcZG9irWGvxIuRkr3moFqmYzk/UVzARqXbJAsrwJ1Yle1ENyHc2x+5GMllhZ4GoCy+S
 sCsirbvOQ26u/h7U+urhLk5Of/TXQbXECqYdORTs4iKk/EVwmi1OUZgBl34bG6fxI7Jt
 ukuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m/5IURDC/1jzJ5yXnB7hUeLNWnY0z6wYTezrToO74WHQYeI5b9+v9TOcKoVP7A1rTVypCkDZ3o1o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBApW4rHy0QqmiqU2f+aMxQXMYWaE5O5YrIFK2xrGsXrTgkd9P
 LMnpl3raIoSI4mhbqmfmrwA+/5loYGMY+AfH4PI4OZqlQ7PW+0OC1JE4rOJYsKqLPB+F8lD8WpX
 bsQ1b5aF/7zH5UeSLIMpZHKf8Rl8DfKckD2/MqNRdXMvnOtzdVEGE4T46qio=
MIME-Version: 1.0
X-Received: by 2002:a4a:e64a:0:b0:694:96b2:9943 with SMTP id
 006d021491bc7-69e68c20c2cmr11074425eaf.37.1781072372043; Tue, 09 Jun 2026
 23:19:32 -0700 (PDT)
Date: Tue, 09 Jun 2026 23:19:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2901f4.39669fcc.33b062.00b4.GAE@google.com>
Subject: [syzbot] [fbdev?] KASAN: slab-use-after-free Read in fb_mode_is_equal
From: syzbot <syzbot+81c7c6b52649fd07299d@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
 syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

HEAD commit:    9154c4af7829 Merge tag 'mmc-v7.1-rc3' of git://git.kernel..=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16022bec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e4d2284f2ffa41
dashboard link: https://syzkaller.appspot.com/bug?extid=3D81c7c6b52649fd072=
99d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05514c1c6f79/disk-=
9154c4af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a4514820c96/vmlinux-=
9154c4af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6cfe00f3884/bzI=
mage-9154c4af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+81c7c6b52649fd07299d@syzkaller.appspotmail.com

input: j=03J=07=C7=B8-=EF=BF=BD=EF=BF=BD=EF=BF=BD9=EF=BF=BD%v=EF=BF=BD=EF=
=BF=BD=EF=BF=BDJ86=EF=BF=BD=1C=EF=BF=BD as /devices/virtual/input/input23
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in fb_mode_is_equal+0x280/0x2f0 drivers/vid=
eo/fbdev/core/modedb.c:934
Read of size 4 at addr ffff88802666219c by task syz.6.4102/26504

CPU: 0 UID: 0 PID: 26504 Comm: syz.6.4102 Tainted: G             L      syz=
kaller #0 PREEMPT(full)=20
Tainted: [L]=3DSOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 04/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 fb_mode_is_equal+0x280/0x2f0 drivers/video/fbdev/core/modedb.c:934
 fbcon_mode_deleted+0x146/0x1e0 drivers/video/fbdev/core/fbcon.c:2750
 fb_set_var+0xe76/0x11b0 drivers/video/fbdev/core/fbmem.c:248
 do_fb_ioctl+0x734/0x7e0 drivers/video/fbdev/core/fb_chrdev.c:90
 fb_ioctl+0xe5/0x150 drivers/video/fbdev/core/fb_chrdev.c:169
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f828819ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8285fb2028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8288416270 RCX: 00007f828819ce59
RDX: 0000200000000080 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 00007f8288232d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8288416308 R14: 00007f8288416270 R15: 00007fffc117b3a8
 </TASK>

Allocated by task 19562:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5296 [inline]
 __kmalloc_noprof+0x301/0x850 mm/slub.c:5308
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 cfg80211_inform_single_bss_data+0x557/0x1de0 net/wireless/scan.c:2344
 cfg80211_inform_bss_data+0x237/0x3a00 net/wireless/scan.c:3229
 cfg80211_inform_bss_frame_data+0x247/0x780 net/wireless/scan.c:3320
 ieee80211_bss_info_update+0x310/0xab0 net/mac80211/scan.c:230
 ieee80211_rx_bss_info net/mac80211/ibss.c:1088 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1569 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1922/0x2f80 net/mac80211/ibss.c:1596
 ieee80211_iface_process_skb net/mac80211/iface.c:1795 [inline]
 ieee80211_iface_work+0xbff/0x13e0 net/mac80211/iface.c:1849
 cfg80211_wiphy_work+0x410/0x570 net/wireless/core.c:513
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 15:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 __rcu_free_sheaf_prepare+0x5d/0x2f0 mm/slub.c:2940
 rcu_free_sheaf+0x1a/0xe0 mm/slub.c:5850
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2869
 handle_softirqs+0x1ea/0xa00 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1076 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1068
 smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888026662180
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 28 bytes inside of
 freed 96-byte region [ffff888026662180, ffff8880266621e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26662
flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88813fe30280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GF=
P_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2995,=
 tgid 2995 (kworker/u8:8), ts 29285253194, free_ts 29284937714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x11a6/0x3410 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab mm/slub.c:3467 [inline]
 new_slab+0xa6/0x6c0 mm/slub.c:3525
 refill_objects+0x277/0x420 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x375/0x650 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 __kmalloc_cache_node_noprof+0x5a3/0x770 mm/slub.c:5428
 kmalloc_node_noprof include/linux/slab.h:1077 [inline]
 __get_vm_area_node+0x101/0x330 mm/vmalloc.c:3215
 __vmalloc_node_range_noprof+0x228/0x1630 mm/vmalloc.c:4024
 __vmalloc_node_noprof+0xad/0xf0 mm/vmalloc.c:4124
 alloc_thread_stack_node kernel/fork.c:357 [inline]
 dup_task_struct kernel/fork.c:926 [inline]
 copy_process+0x7fb/0x7ed0 kernel/fork.c:2090
 kernel_clone+0x176/0x9e0 kernel/fork.c:2722
 user_mode_thread+0xcc/0x110 kernel/fork.c:2798
 call_usermodehelper_exec_work kernel/umh.c:171 [inline]
 call_usermodehelper_exec_work+0xcb/0x180 kernel/umh.c:157
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
page last free pid 2995 tgid 2995 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0x794/0x10a0 mm/page_alloc.c:2938
 ___free_pages_bulk mm/kasan/shadow.c:333 [inline]
 __kasan_populate_vmalloc_do mm/kasan/shadow.c:385 [inline]
 __kasan_populate_vmalloc+0x164/0x210 mm/kasan/shadow.c:424
 kasan_populate_vmalloc include/linux/kasan.h:580 [inline]
 alloc_vmap_area+0x95d/0x2b70 mm/vmalloc.c:2123
 __get_vm_area_node+0x1ca/0x330 mm/vmalloc.c:3226
 __vmalloc_node_range_noprof+0x228/0x1630 mm/vmalloc.c:4024
 __vmalloc_node_noprof+0xad/0xf0 mm/vmalloc.c:4124
 alloc_thread_stack_node kernel/fork.c:357 [inline]
 dup_task_struct kernel/fork.c:926 [inline]
 copy_process+0x7fb/0x7ed0 kernel/fork.c:2090
 kernel_clone+0x176/0x9e0 kernel/fork.c:2722
 user_mode_thread+0xcc/0x110 kernel/fork.c:2798
 call_usermodehelper_exec_work kernel/umh.c:171 [inline]
 call_usermodehelper_exec_work+0xcb/0x180 kernel/umh.c:157
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888026662080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888026662100: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff888026662180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888026662200: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888026662280: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
