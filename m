Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E02C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834E010E67F;
	Mon, 10 Aug 2026 06:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="jbG7gqwc";
	dkim-atps=neutral
X-Greylist: delayed 833 seconds by postgrey-1.36 at gabe;
 Sun, 09 Aug 2026 02:12:11 UTC
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com
 [203.205.221.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFF210E03E
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 02:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786241529; bh=N7vxRncBRehJkcP6rxLEXq+eJCPchj0g+guu7do411g=;
 h=Date:To:Cc:From:Subject;
 b=jbG7gqwcxn3l83848BIeQmlBjg7dmEPClnUn2K0pB6x0ow/GiXp/L7vm2G3Wi9vjg
 Dm8o4DQa7/XjDbjB2/olXrQfLXlJbBI6kJ70MBC0yHzBA7TgplTpw6tPr5sh0aScRp
 TeJogDoNezgozYJLM/wPmFXXlIGxU2g6zj5MaC2k=
Received: from [IPV6:2409:8a00:7893:9e40:542c:be54:7415:4303]
 ([2409:8a00:7893:9e40:542c:be54:7415:4303])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 3081FA50; Sun, 09 Aug 2026 10:12:08 +0800
X-QQ-mid: xmsmtpt1786241528t4q7wyk5f
Message-ID: <tencent_79C4EB414C2394CC3BE9EC7A46273524FB05@qq.com>
X-QQ-XMAILINFO: MLQF5pNkQhvx7ZLoepgDYOWWaZ1KYKJwUg2f0sMNIYqUtMCcMKQbrrKWWpeeJI
 zBV3YULiLnybnlk2G5lzXYm4SeSOYqCW5bENUYVCR1/GP/4Y6TQbVU9Zx9JBGvjNufc4YpvOKxjC
 d7Tm9rlEmKqjT8n/uczWJmuVYhtQfxB90/vFQQh5x0M+wts1yCFsCLVF2lvJDoriGEZ+EfWSkot/
 zG6gF7vuyu9MoWjj3oVuAnJeQ2V/4lO28OL7dg35I81wjMwyccSpFkxn+dS6wMBeknFbxwzR6SiE
 225zCLhl5elyhTeyEhS9b0iCXI4erxScA9e9i+1POymicm0ToOgDMLRkk+g4gRE3eNK0vw7S67vD
 PKxivZtABY29FZ+JWXwkVK4DqMyFfXbJN4GBv+9GBa73u/284vZhn3qHr5575XrRrwJ0wTCfUTME
 ZiF4bvl4Uoxk66OfsldWdMhnFHrgl1WPtUmtJVC1lwtvgZg1XesFlyClCG91jaQjmgo71mEDq+7u
 7LFQcXRRj0OIfxw2DTIe3GtnaCSSwT6i0vSBrLCYudDO6rFJFvOQ+BVPtu80KB90RE1fbvTOrmTX
 Zk4rwFngMUve8Z0sPovvZNE1U25mFHTlOkqJb8X0D32/l3y/PLB+J+fqTzp8CmdRrDNCCXP6Qpr2
 KVrjTQwk9wPWcjlGWqwfGDG6tLI8mXKsUHGyS6KHEJfFc+Y+F3h/CRf9yTgaBlclkhTiVUsv9iyS
 aA/C96dUDSq0vKOT9DNWVtQNW/zwhzcxkq21URoEDTyRo2FkkWIHyiV11P7xdZs3xuLve4LlAiID
 txPjXLDgqu8W411WHIgmAim3EEi736uE1y9ik1yU0Vu5otZzzYp5MUEFpqDhBdvPgfCWBrlQJfIF
 JZCoFsvABGnqJJePJrr+rM9Ii6GdXKNR+qSEMinL3QbvH2EsGPrd1rjgVqyFmlJUx8x2Ejvv97Ul
 OMPpbZPJlTIaRqrN/GGUnk3CeoynNrNpfshkvP4wsZvJxpFpU9QUVhYPu7jRrxXbhF2Huqfq/P+L
 Dn28pvyLp3/zzN6v3wm7BVjVLq2GbfDT7Tp5ksMwsQo6fA70nP3dMXkxPYXWlTSO0IqJg047HpuW
 pv9NmR
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <96511bce-fafc-4273-bb26-7325a905c46b@qq.com>
Date: Sun, 9 Aug 2026 10:12:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [BUG] KASAN: use-after-free in enqueue_timer (mgag200: IPv6 RS timer
 not cancelled on remove) [mgag200] [syzkaller]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi,

While fuzzing with syzkaller (KASAN) we hit a use-after-free in the timer
subsystem while unloading the mgag200 DRM driver.

Reproducer summary:

    BUG: KASAN: use-after-free in enqueue_timer kernel/time/timer.c:616
    [inline] hlist_add_head include/linux/list.h:1075
    BUG: KASAN: use-after-free in enqueue_timer+0x59/0x280
    Write of size 8 at addr ffff8880192808c8 by task (udev-worker)/829

Call chain (IRQ softirq):

    run_timer_softirq -> expire_timers -> call_timer_fn
       addrconf_rs_timer net/ipv6/addrconf.c:4061
       addrconf_mod_rs_timer addrconf.c:332
       __mod_timer -> enqueue_timer -> hlist_add_head   (Write 8B to freed page)

Root cause: the periodic IPv6 `addrconf_rs_timer` (re-armed in softirq via
`mod_timer`) is not cancelled when the device/interface that owns the timer
is released during mgag200 module removal. Once the object page is released
(refcount:0, KASAN shadow all 0xff), the softirq callback keeps re-queuing
the timer into a released page, causing the UAF, which then cascades into
scheduling-while-atomic / invalid opcode / NULL deref in VFS.

The crash report shows below:

BUG: KASAN: use-after-free in hlist_add_head include/linux/list.h:1075 [inline]
BUG: KASAN: use-after-free in enqueue_timer+0x59/0x280 kernel/time/timer.c:616
Write of size 8 at addr ffff8880192808c8 by task (udev-worker)/829

CPU: 0 UID: 0 PID: 829 Comm: (udev-worker) Tainted: G        W  O        7.1.0 #2 PREEMPT(lazy) 
Tainted: [W]=WARN, [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0xa2/0xd0 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 hlist_add_head include/linux/list.h:1075 [inline]
 enqueue_timer+0x59/0x280 kernel/time/timer.c:616
 __mod_timer+0x625/0x840 kernel/time/timer.c:-1
 addrconf_mod_rs_timer+0x36/0xd0 net/ipv6/addrconf.c:332
 addrconf_rs_timer+0x280/0x320 net/ipv6/addrconf.c:4061
 call_timer_fn+0xfb/0x2c0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x4ad/0x6d0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x32/0x70 kernel/time/timer.c:2405
 handle_softirqs+0x1a2/0x560 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xa7/0x180 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0x6e/0x80 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:98 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:115 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:140 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:172 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:191 [inline]
RIP: 0010:kasan_check_range+0x97/0x2c0 mm/kasan/generic.c:200
Code: 00 fc ff df 4d 8d 34 19 4d 89 f4 4d 29 dc 49 83 fc 10 7f 29 4d 85 e4 0f 84 3d 01 00 00 4c 89 cb 48 f7 d3 4c 01 fb 41 80 3b 00 <0f> 85 9e 01 00 00 49 ff c3 48 ff c3 75 ee e9 1d 01 00 00 44 89 dd
RSP: 0018:ffff88800bf6f9e8 EFLAGS: 00000246
RAX: ffffffff854d4501 RBX: ffffffffffffffff RCX: ffffffff81349e22
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff854d45d8
RBP: ffffffff85123ea0 R08: ffffffff854d45d9 R09: 1ffffffff0a9a8bb
R10: dffffc0000000000 R11: fffffbfff0a9a8bb R12: 0000000000000001
R13: 0000000000000002 R14: fffffbfff0a9a8bc R15: 1ffffffff0a9a8bb
 unwind_next_frame+0x382/0x14a0 arch/x86/kernel/unwind_orc.c:520
 arch_stack_walk+0x131/0x160 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x45/0x70 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x4b/0x60 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_noprof+0x17d/0x5c0 mm/slub.c:4906
 alloc_filename fs/namei.c:142 [inline]
 do_getname+0x2e/0x1c0 fs/namei.c:182
 getname include/linux/fs.h:2526 [inline]
 class_filename_constructor include/linux/fs.h:2553 [inline]
 do_sys_openat2+0x60/0x130 fs/open.c:1363
 do_sys_open fs/open.c:1370 [inline]
 __do_sys_openat fs/open.c:1386 [inline]
 __se_sys_openat fs/open.c:1381 [inline]
 __x64_sys_openat+0xf2/0x120 fs/open.c:1381
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14b/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbfd40d52e2
Code: 00 48 89 45 c8 31 c0 f6 c2 40 75 44 89 d0 45 31 d2 f7 d0 a9 00 00 41 00 74 36 80 3d 67 fd 0e 00 00 74 51 b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 8a 00 00 00 48 8b 55 c8 64 48 2b 14 25 28
RSP: 002b:00007ffe785a8c90 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffe785a905c RCX: 00007fbfd40d52e2
RDX: 00000000002a0000 RSI: 00005654b37462b0 RDI: 0000000000000015
RBP: 00007ffe785a8d00 R08: 0000000000000000 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000014 R14: 00005654b37462b0 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888019283a80 pfn:0x19280
flags: 0x100000000000000(node=0|zone=1)
raw: 0100000000000000 ffffea00004fd408 ffff88806ce3d4c0 0000000000000000
raw: ffff888019283a80 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888019280780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888019280800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888019280880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff888019280900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888019280980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Regards,
Yang Zi

