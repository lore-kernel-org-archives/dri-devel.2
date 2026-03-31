Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926EBFF60C6
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 04:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB84110E823;
	Tue, 31 Mar 2026 04:43:22 +0000 (UTC)
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com
 [209.85.161.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B2310E823
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 04:43:21 +0000 (UTC)
Received: by mail-oo1-f80.google.com with SMTP id
 006d021491bc7-66b612efb4aso15075536eaf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 21:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774932201; x=1775537001;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y3SAskOJ/bWxDwzsOktfEo5XLwdw0r8wqpRtm1ie+dA=;
 b=WxZHKPXDL3lyTyWWgllg5meozUhvh5HpCZacKwgZYfWeXIp903Xi6OebIPwjO3Sl3z
 koxesf+zcU1N4bS67pvu4zKSvP1CImHQwbOUVtgZSJy+FDNG7Nf/pqWAMRMYrDpvPLn3
 yNV8rq0jVaaZY4vyvaqBYMDACBh1SDOthCkegbYwDltOKuWBPyGc+sEsUAClx/83Lebj
 K1Ier/etHmJ7GcXF3R5qwpO4KDODiZMkIaBp62woTJWlvaregQXx80MyhtPuSgsBOWSg
 NKmYqb6X/8ccuNhjfemWwgdO1tskWaj/gnMoTdwQAx64EPY5ux2ZELBIL80TrqEUjVAB
 PaHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlnreWjW05HbrW5JICoN8LI1VMm03Hwbrusz6JT88MbrSQdvuNnLDhG77bpyRdsrwCFlMo26FXg68=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/XzhsnlgmcNrfud+QyJ0Q1FLlrqYMHzs1iMmRnZLdJAJmqR+a
 tFXn2H+20bslFHkJhmAiAPaZH9v81zwgh+PkBcsi6Go5eC/BgxXtyE4/Y5poqQAfx35BkBIksAS
 ZDjlSvv5FiAPKmpDMg7cRBZpgOMnpOgH0NM4OQymr8pWxK2EV/5DfhIkWsh4=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3089:b0:67d:e8b6:fb4d with SMTP id
 006d021491bc7-67e3d8f26dfmr1109222eaf.13.1774932200921; Mon, 30 Mar 2026
 21:43:20 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:43:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cb50e8.050a0220.183828.0023.GAE@google.com>
Subject: [syzbot] [dri?] possible deadlock in drm_gem_shmem_mmap
From: syzbot <syzbot+8e5917193162e7485fa5@syzkaller.appspotmail.com>
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

HEAD commit:    46b513250491 Merge tag 'v7.0-rc5-smb3-client-fix' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113fefef980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91
dashboard link: https://syzkaller.appspot.com/bug?extid=8e5917193162e7485fa5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df13ddb9df40/disk-46b51325.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f54064bfb25/vmlinux-46b51325.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09adc502c1f7/bzImage-46b51325.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e5917193162e7485fa5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.3.5649/22096 is trying to acquire lock:
ffff8880343251a8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: dma_resv_lock include/linux/dma-resv.h:345 [inline]
ffff8880343251a8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: drm_gem_shmem_mmap+0x18b/0x440 drivers/gpu/drm/drm_gem_shmem_helper.c:687

but task is already holding lock:
ffff888035ca1bc0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
ffff888035ca1bc0 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x234/0x4f0 mm/util.c:579

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault+0xcb/0x130 mm/memory.c:7218
       _copy_from_iter+0x100/0x1670 lib/iov_iter.c:271
       copy_from_iter include/linux/uio.h:228 [inline]
       copy_from_iter_full include/linux/uio.h:245 [inline]
       skb_do_copy_data_nocache include/net/sock.h:2300 [inline]
       skb_copy_to_page_nocache include/net/sock.h:2326 [inline]
       tcp_sendmsg_locked+0x2151/0x5490 net/ipv4/tcp.c:1324
       tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1465
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       sock_write_iter+0x406/0x4f0 net/socket.c:1195
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x61d/0xb90 fs/read_write.c:688
       ksys_write+0x150/0x270 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x48/0x100 net/core/sock.c:3780
       lock_sock include/net/sock.h:1709 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:919
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       recv_work+0x1c7f/0x1d90 drivers/block/nbd.c:1021
       process_one_work kernel/workqueue.c:3276 [inline]
       process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
       worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x37b/0x1100 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa70 block/blk-core.c:753
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2444
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:723
       adfspart_check_ICS+0xa5/0xa40 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7ba/0x1550 block/partitions/core.c:694
       blkdev_get_whole+0x380/0x510 block/bdev.c:764
       bdev_open+0x31e/0xd30 block/bdev.c:973
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:949
       vfs_open+0x3b/0x340 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4830
       do_file_open+0x23e/0x4a0 fs/namei.c:4859
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       nbd_queue_rq+0xc6/0x1100 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa70 block/blk-core.c:753
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2444
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:723
       adfspart_check_ICS+0xa5/0xa40 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7ba/0x1550 block/partitions/core.c:694
       blkdev_get_whole+0x380/0x510 block/bdev.c:764
       bdev_open+0x31e/0xd30 block/bdev.c:973
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:949
       vfs_open+0x3b/0x340 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4830
       do_file_open+0x23e/0x4a0 fs/namei.c:4859
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xca/0x300 kernel/rcu/srcutree.c:1481
       elevator_switch+0x1e8/0x7a0 block/elevator.c:576
       elevator_change+0x2cc/0x450 block/elevator.c:681
       elevator_set_default+0x36c/0x430 block/elevator.c:754
       blk_register_queue+0x366/0x430 block/blk-sysfs.c:946
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfb/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:785 [inline]
       nbd_dev_add+0x72c/0xb50 drivers/block/nbd.c:1984
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x8d0 init/main.c:1382
       do_initcall_level+0x104/0x190 init/main.c:1444
       do_initcalls+0x59/0xa0 init/main.c:1460
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1692
       kernel_init+0x1d/0x1d0 init/main.c:1582
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       elevator_change+0x1b3/0x450 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5110 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5155 [inline]
       blk_mq_update_nr_hw_queues+0x5e7/0x1a60 block/blk-mq.c:5220
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1489
       nbd_genl_connect+0x165b/0x1cf0 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2592
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
       __sys_sendmsg net/socket.c:2678 [inline]
       __do_sys_sendmsg net/socket.c:2683 [inline]
       __se_sys_sendmsg net/socket.c:2681 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       blk_alloc_queue+0x546/0x680 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4429 [inline]
       __blk_mq_alloc_disk+0x197/0x390 block/blk-mq.c:4476
       nbd_dev_add+0x499/0xb50 drivers/block/nbd.c:1954
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x8d0 init/main.c:1382
       do_initcall_level+0x104/0x190 init/main.c:1444
       do_initcalls+0x59/0xa0 init/main.c:1460
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1692
       kernel_init+0x1d/0x1d0 init/main.c:1582
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4362
       dma_resv_lockdep+0x341/0x610 drivers/dma-buf/dma-resv.c:795
       do_one_initcall+0x250/0x8d0 init/main.c:1382
       do_initcall_level+0x104/0x190 init/main.c:1444
       do_initcalls+0x59/0xa0 init/main.c:1460
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1692
       kernel_init+0x1d/0x1d0 init/main.c:1582
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (reservation_ww_class_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __ww_mutex_lock+0x20d/0x2a20 kernel/locking/mutex.c:783
       ww_mutex_lock+0x3f/0x1c0 kernel/locking/mutex.c:901
       dma_resv_lock include/linux/dma-resv.h:345 [inline]
       drm_gem_shmem_mmap+0x18b/0x440 drivers/gpu/drm/drm_gem_shmem_helper.c:687
       drm_gem_mmap_obj+0x18a/0x4c0 drivers/gpu/drm/drm_gem.c:1209
       drm_gem_mmap+0xc5/0x1a0 drivers/gpu/drm/drm_gem.c:1352
       vfs_mmap include/linux/fs.h:2070 [inline]
       mmap_file mm/internal.h:167 [inline]
       __mmap_new_file_vma mm/vma.c:2468 [inline]
       __mmap_new_vma mm/vma.c:2532 [inline]
       __mmap_region mm/vma.c:2759 [inline]
       mmap_region+0x18fe/0x2240 mm/vma.c:2837
       do_mmap+0xc39/0x10c0 mm/mmap.c:559
       vm_mmap_pgoff+0x2c9/0x4f0 mm/util.c:581
       ksys_mmap_pgoff+0x51e/0x760 mm/mmap.c:605
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  reservation_ww_class_mutex --> sk_lock-AF_INET --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(sk_lock-AF_INET);
                               lock(&mm->mmap_lock);
  lock(reservation_ww_class_mutex);

 *** DEADLOCK ***

1 lock held by syz.3.5649/22096:
 #0: ffff888035ca1bc0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
 #0: ffff888035ca1bc0 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x234/0x4f0 mm/util.c:579

stack backtrace:
CPU: 0 UID: 0 PID: 22096 Comm: syz.3.5649 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __ww_mutex_lock+0x20d/0x2a20 kernel/locking/mutex.c:783
 ww_mutex_lock+0x3f/0x1c0 kernel/locking/mutex.c:901
 dma_resv_lock include/linux/dma-resv.h:345 [inline]
 drm_gem_shmem_mmap+0x18b/0x440 drivers/gpu/drm/drm_gem_shmem_helper.c:687
 drm_gem_mmap_obj+0x18a/0x4c0 drivers/gpu/drm/drm_gem.c:1209
 drm_gem_mmap+0xc5/0x1a0 drivers/gpu/drm/drm_gem.c:1352
 vfs_mmap include/linux/fs.h:2070 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2468 [inline]
 __mmap_new_vma mm/vma.c:2532 [inline]
 __mmap_region mm/vma.c:2759 [inline]
 mmap_region+0x18fe/0x2240 mm/vma.c:2837
 do_mmap+0xc39/0x10c0 mm/mmap.c:559
 vm_mmap_pgoff+0x2c9/0x4f0 mm/util.c:581
 ksys_mmap_pgoff+0x51e/0x760 mm/mmap.c:605
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdcc399c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdcc4808028 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fdcc3c15fa0 RCX: 00007fdcc399c799
RDX: 0000000000000004 RSI: 0000000000004000 RDI: 0000200000001000
RBP: 00007fdcc3a32c99 R08: 0000000000000003 R09: 0000000100000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdcc3c16038 R14: 00007fdcc3c15fa0 R15: 00007ffe9bf4e188
 </TASK>


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
