Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8D5CCF2D4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 01:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD0110E11F;
	Mon, 19 Oct 2026 01:08:33 +0000 (UTC)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA97010E11F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 01:08:32 +0000 (UTC)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-46ac13882ccso1991900fac.1
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 18:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792372112; x=1792976912;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=10eExBUClpAaqEOeBS1LeHVWYKjEkHMLvsM4ks904So=;
 b=fw6hBpFJzojbqTzNYXIK4oJYTkvuJKFjDVFgIjKNaXsJ3ESJfT0/rWnZcGgzEcbezb
 FitcZwiBBOYsx88JzNtZRdg/QtVCkL3912ccteg0wHqWVB48o5vqRZZgYCyO8HEREx4e
 CA6s/bNJk31up56+yD3cOry+H7wdBvV9wQ+kyl2g1UQEcxXnnd60sDOr0M1rD+oSgLY6
 WO+U5rg8LEo3EVlEwcr1z2yp7DEjgAEBa66/MiIl/C8OonRSd6goPVuvt3H36EABkNbT
 uSXTAaPfOBmN5tLx/Ia6POJHzmJRteB7+DqprEDZqRwBCAI6OIHhIcD4INcR4/PTATFG
 tThg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCVr3uXUgRDlpHp4+IK7bGkOSk/lyJgqEWs8PRDBa7jkKfqTzZznbweMOZCxa2C+/kudy0Kg0tlzY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJYgoCXjOT9LhK4tblxOmO+zRaDXS36csDNGIF9hCc2PsZ0vlje
 nUvl/hkHAZVzaLWSajbJBVihpjmMGvo6MDN3Vis+tH1uhVjwMl1R3AxhqFeVnZJlC7LbP8R0Ayh
 hjVzVWU77QNKvOIK+HRZHcvC8zYlS14h3W8S7ULZuqi+peIDqvYO+DFR2qy8=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c40a:b0:4c3:bc6a:a328 with SMTP id
 5614622812f47-53ccca4217bmr4634545b6e.31.1792372111987; Sun, 18 Oct 2026
 18:08:31 -0700 (PDT)
Date: Sun, 18 Oct 2026 18:08:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad56d8f.6814cce4.34c49f.0143.GAE@google.com>
Subject: [syzbot] [dri?] KASAN: slab-use-after-free Read in
 drm_sysfs_hotplug_event (2)
From: syzbot <syzbot+f5ecf25277b844fd38f2@syzkaller.appspotmail.com>
To: airlied@gmail.com, airlied@redhat.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, sean@poorly.run, simona@ffwll.ch, 
 syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
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

HEAD commit:    0fcb05b72344 Merge tag 'libcrypto-fixes-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134e7a21580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4118aaa2d227be26
dashboard link: https://syzkaller.appspot.com/bug?extid=f5ecf25277b844fd38f2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7b208871bdb/disk-0fcb05b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc9896352195/vmlinux-0fcb05b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d6edb0c1319/bzImage-0fcb05b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5ecf25277b844fd38f2@syzkaller.appspotmail.com

udl 2-1:0.0: [drm] *ERROR* Read EDID byte 0 failed err ffffffb9
==================================================================
BUG: KASAN: slab-use-afte
BUG: KASAN: slab-use-after-free in get_kobj_path_length lib/kobject.c:119 [inline]
BUG: KASAN: slab-use-after-free in kobject_get_path+0x91/0x2f0 lib/kobject.c:158
Read of size 8 at addr ffff88802a29ee18 by task kworker/1:2/1654

CPU: 1 UID: 0 PID: 1654 Comm: kworker/1:2 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events output_poll_execute
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 get_kobj_path_length lib/kobject.c:119 [inline]
 kobject_get_path+0x91/0x2f0 lib/kobject.c:158
 kobject_uevent_env+0x29e/0x9e0 lib/kobject_uevent.c:548
 drm_sysfs_hotplug_event+0x10e/0x150 drivers/gpu/drm/drm_sysfs.c:451
 output_poll_execute+0x846/0xab0 drivers/gpu/drm/drm_probe_helper.c:854
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5684:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x321/0x600 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 class_dir_create_and_add drivers/base/core.c:3295 [inline]
 get_device_parent+0x255/0x3a0 drivers/base/core.c:3355
 device_add+0x2d4/0xb80 drivers/base/core.c:3685
 drm_minor_register+0x145/0x2e0 drivers/gpu/drm/drm_drv.c:195
 drm_dev_register+0x179/0xd80 drivers/gpu/drm/drm_drv.c:1093
 udl_usb_probe+0xb7/0x150 drivers/gpu/drm/udl/udl_drv.c:99
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 25:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6509 [inline]
 kfree+0x1c5/0x650 mm/slub.c:6802
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 cleanup_glue_dir+0x1b2/0x220 drivers/base/core.c:3487
 device_del+0x77d/0x8f0 drivers/base/core.c:3986
 drm_minor_unregister drivers/gpu/drm/drm_drv.c:226 [inline]
 drm_dev_unregister+0x436/0x700 drivers/gpu/drm/drm_drv.c:1185
 drm_dev_unplug+0x4b/0xb0 drivers/gpu/drm/drm_drv.c:507
 udl_usb_disconnect+0x3e/0x50 drivers/gpu/drm/udl/udl_drv.c:115
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1484
 usb_disconnect+0x346/0x9a0 drivers/usb/core/hub.c:2355
 hub_port_connect drivers/usb/core/hub.c:5425 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x1bbb/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802a29ee00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff88802a29ee00, ffff88802a29ee60)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a29e
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801c041280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 50, tgid 50 (kworker/u8:3), ts 7340126275
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2209/0x2280 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x217/0x5a0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7418
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __kmalloc_cache_noprof+0x39b/0x600 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 blk_mq_alloc_ctxs block/blk-mq.c:4367 [inline]
 blk_mq_init_allocated_queue+0xc2/0x13c0 block/blk-mq.c:4644
 blk_mq_alloc_queue+0x1ba/0x2e0 block/blk-mq.c:4435
 scsi_alloc_sdev+0x79d/0xc60 drivers/scsi/scsi_scan.c:339
 scsi_probe_and_add_lun+0x156/0x47b0 drivers/scsi/scsi_scan.c:1228
 __scsi_scan_target+0x199/0xd10 drivers/scsi/scsi_scan.c:1805
 scsi_scan_channel drivers/scsi/scsi_scan.c:1895 [inline]
 scsi_scan_host_selected+0x391/0x6c0 drivers/scsi/scsi_scan.c:1924
 do_scsi_scan_host drivers/scsi/scsi_scan.c:2057 [inline]
 do_scan_async+0x10e/0x660 drivers/scsi/scsi_scan.c:2067
 async_run_entry_fn+0x9d/0x430 kernel/async.c:129
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802a29ed00: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88802a29ed80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88802a29ee00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff88802a29ee80: 00 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc
 ffff88802a29ef00: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
==================================================================


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
