Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ECFC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF49B10F26D;
	Thu, 13 Aug 2026 09:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="BVyK5heX";
	dkim-atps=neutral
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5812610E32E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786551391; bh=dsG9ahFwV1mPnqdnf9gmeOs14gR6uNkhKm+yXcozET8=;
 h=Date:To:Cc:From:Subject;
 b=BVyK5heXd73X4q3iDDAzeHfrwPS7lDf2bX1SHCsdmNwEBqnC4ena4nT34qzcL9R3x
 MYVooG2shFASsg4mBAtPA5AmwelSJUhCvku6iT25aHCt+2WH3CvzhZyZnbCnO41HAu
 d1eaUx0QqQENcL1nctw2GIlQ/h9WY2vefvlI3D+s=
Received: from [IPV6:2409:8a00:7894:a160:585d:605d:694d:91cf]
 ([2409:8a00:7894:a160:585d:605d:694d:91cf])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 41DA9807; Thu, 13 Aug 2026 00:16:29 +0800
X-QQ-mid: xmsmtpt1786551389tnpoud43u
Message-ID: <tencent_0EF2A17BDEF067CC33A7A937D96E5E6D6208@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahE8FPdqOAv0MOfZq7pL7W9hbR22Kj4LSzbM+VV65uaJX/m5bOQF
 o5X8dRnLaEutekJrjuZZK41eL2Esgvh563yphUmTRL7NPQHHGjx0uyELw63hZnK/NxN4Uq3HVGZe
 bz4+WdbuAyYUP/Q+D5OXGGMuMZ+0JaaWhSy1YTXgJGS10OwlFGL6u9WUUfwAhRN+iKRZS/HuJJuj
 YhHUuQMKMNoHQtdinyi8nPetwdpJy+jUSwRsLmxGIFbBgnuFD1raYOX2sQL95ZLF9DH+l+6ZoODL
 ZaYDLOrsokyYeHLCbMHVA5sUxCClr0jw9g4cfYt+aHzWFnj2SBJino1yBNMnWehCALFWVJR0LokQ
 tjj4AQx2tgsI3HxPDYwjKsg/OuXfNFn8PPFQ6aMC6wY0Fkji8gG2zlBQ0DGmW8JpOlw5kYIF1nvC
 EyKzF1shpjgEnmERcDDFe2/7rxdjtAQDSWqmyi+MPK9xQS5reSZkRlkzffOYuk4M+iRWxR66fgLM
 PjobW/8E8UIm27UHGONdYyInWKIB3IJKRzuTn8mcPYONUUEwGa0oN0nnS3AjpWJOnHXYFdik0Eix
 /UzxKtwNnL4gWWWY/7NVg7X1NsviYA1ezO2POgAYFbHvALvzf3JE48RZteiXPQ1dc+ETxIYE+q7w
 WJC+ipJJl0nhlq/Z/bTGACw/otP5Kh62JH8TWM0D1AY3/PEO8QJ016uYqpWZJOngX3tzF+SSFNRo
 X/zXuGNJynCih0GnDZU7B54Lgq+bm97DUGKDxAeb/+aTsijxbLazR/O7XfS4IErm1w2wRwQu3XjL
 Gj+/mov9LCXgt2McBbd49spUpH8L56AIweg74SGXpsHaif1z7zGja53r0Q1N5tsVGWYrypVZGLuV
 WVzaal+aspa9cytfLkcZwDAj7b/jqoWWJ53ReE4A+Qw4Nl3X5XzAiXJrob5kgzsn6mClSFlf7jRR
 EAihIXd1dwelZ1p1qYWlwU3Aa259EfNaOAWX/w+p7kp0Yz6QEsPDVMOaxZrdKDUd95Z8e4R+t4f5
 +zRMXc6ohHWrK7awUZkD5rp5tIVDhMwc+2LN8zRDp8q592R4/Iomzt4L5rv8s=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <ad56f2f2-bcf5-43c8-895d-8b2ee319d9f5@qq.com>
Date: Thu, 13 Aug 2026 00:16:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [BUG] KASAN: wild-memory-access in device_release_driver_internal
 (mgdl) driver / uncancelled timer on unload [mgag200] [syzkaller]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

While fuzzing the kernel v7.1 with syzkaller (KASAN), we hit a Wild Memory Access
in the device-release path, caused by the mgag200 driver not cancelling its timer 
before the device structures are torn down.

Reproducer summary (see attached report/log):

    BUG: KASAN: wild-memory-access in device_unbind_cleanup drivers/base/md.c:498 [inline]
    BUG: KASAN: wild-memory-access in __device_release_driver drivers/base/md.c:1357 [inline]
    BUG: KASAN: wild-memory-access in device_release_driver_internal+0x381/0x540 drivers/base/md.c:1375
    Read of size 8 at addr 0855e8e7894c0090 by task syz.0.5/824

    Oops: general protection fault, probably for non-canonical address 0x855e8e7894c0090: 0000 [#1] SMP KASAN NOPTI
    RIP: 0010:device_unbind_cleanup ... mov 0x90(%r15),%r13   <-- R15 = 0x855e8e7894c0000

The module table shows `mgag200(+) ... [last unloaded: mgag200]`: the driver is
loaded and unloaded in a loop. In `mgag200_pci_remove` -> `drm_dev_unregister`.
the associated timer is not cancelled (`del_timer_sync` missing). When the device
objects are destroyed the pending timer softirq still writes to the freed slab,
overwriting the `struct device` / devres pointer fields with a non-canonical
value (0x855e8e...). A subsequent device unbind (`device_release_driver_internal`
-> `device_unbind_cleanup`) dereferences that corrupted pointer and faults.

Root-cause: the driver-facing bug is the missing timer teardown on
remove/hot-unplug; the crash surfaces as a corrupted `struct device` in the
driver-core unbind path. This is a use-after-free spreading from the mg201000
timer into the device-driver model (taint shows BAD_PAGE after the first enjoy).

The crash report attached below:

BUG: KASAN: wild-memory-access in device_unbind_cleanup drivers/base/dd.c:599 [inline]
BUG: KASAN: wild-memory-access in __device_release_driver drivers/base/dd.c:1357 [inline]
BUG: KASAN: wild-memory-access in device_release_driver_internal+0x381/0x540 drivers/base/dd.c:1375
Read of size 8 at addr 0855e8e7894c0090 by task syz.0.5/824

CPU: 0 UID: 0 PID: 824 Comm: syz.0.5 Tainted: G        W  O        7.1.0 #2 PREEMPT(lazy) 
Tainted: [W]=WARN, [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0xa2/0xd0 lib/dump_stack.c:120
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 device_unbind_cleanup drivers/base/dd.c:599 [inline]
 __device_release_driver drivers/base/dd.c:1357 [inline]
 device_release_driver_internal+0x381/0x540 drivers/base/dd.c:1375
 device_unbind_cleanup drivers/base/dd.c:598 [inline]
 __device_release_driver drivers/base/dd.c:1357 [inline]
 device_release_driver_internal+0x369/0x540 drivers/base/dd.c:1375
 </IRQ>
 <TASK>
 </TASK>
==================================================================
Oops: general protection fault, probably for non-canonical address 0x855e8e7894c0090: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 824 Comm: syz.0.5 Tainted: G    B   W  O        7.1.0 #2 PREEMPT(lazy) 
Tainted: [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:device_unbind_cleanup drivers/base/dd.c:599 [inline]
RIP: 0010:__device_release_driver drivers/base/dd.c:1357 [inline]
RIP: 0010:device_release_driver_internal+0x381/0x540 drivers/base/dd.c:1375
Code: 76 d8 fe eb 05 e8 6f 76 d8 fe 4c 89 f7 e8 47 ae 00 00 4c 89 e7 e8 0f 08 01 ff 4d 8b 7e 68 49 8d bf 90 00 00 00 e8 ff 07 01 ff <4d> 8b af 90 00 00 00 4d 85 ed 74 13 e8 3e 76 d8 fe 4c 89 f7 4d 89
RSP: 0018:ffff88806ce08df0 EFLAGS: 00010286
RAX: ffff8880171e9b01 RBX: 0000000000000100 RCX: ffff8880171e9b40
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff863e0fe7 R09: 1ffffffff0c7c1fc
R10: dffffc0000000000 R11: fffffbfff0c7c1fd R12: ffff888017ddc8c0
R13: 0000000000000000 R14: ffffffff828422c9 R15: 0855e8e7894c0000
FS:  000055557f72d500(0000) GS:ffff8880e6a8d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbcbeece820 CR3: 000000001861d000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 device_unbind_cleanup drivers/base/dd.c:598 [inline]
 __device_release_driver drivers/base/dd.c:1357 [inline]
 device_release_driver_internal+0x369/0x540 drivers/base/dd.c:1375
 </IRQ>
 <TASK>
 </TASK>
Modules linked in: mgag200(+) gadgetfs udc_core sit tunnel4 ip_tunnel geneve ip6_udp_tunnel udp_tunnel macsec macvtap tap ipvlan macvlan virt_wifi veth nlmon dummy team bonding tun rfuzzer_device(O) i2c_dev qrtr iTCO_wdt intel_pmc_bxt ppdev watchdog vga16fb vgastate parport_pc lpc_ich mfd_core parport bochs mousedev serio_raw tpm_tis tpm_tis_core tpm dm_mod dax dmi_sysfs qemu_fw_cfg virtio_rng kt_runtime(O) uio_pci_kerneltracker_driver(O) [last unloaded: mgag200]
---[ end trace 0000000000000000 ]---
RIP: 0010:device_unbind_cleanup drivers/base/dd.c:599 [inline]
RIP: 0010:__device_release_driver drivers/base/dd.c:1357 [inline]
RIP: 0010:device_release_driver_internal+0x381/0x540 drivers/base/dd.c:1375
Code: 76 d8 fe eb 05 e8 6f 76 d8 fe 4c 89 f7 e8 47 ae 00 00 4c 89 e7 e8 0f 08 01 ff 4d 8b 7e 68 49 8d bf 90 00 00 00 e8 ff 07 01 ff <4d> 8b af 90 00 00 00 4d 85 ed 74 13 e8 3e 76 d8 fe 4c 89 f7 4d 89
RSP: 0018:ffff88806ce08df0 EFLAGS: 00010286
RAX: ffff8880171e9b01 RBX: 0000000000000100 RCX: ffff8880171e9b40
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff863e0fe7 R09: 1ffffffff0c7c1fc
R10: dffffc0000000000 R11: fffffbfff0c7c1fd R12: ffff888017ddc8c0
R13: 0000000000000000 R14: ffffffff828422c9 R15: 0855e8e7894c0000
FS:  000055557f72d500(0000) GS:ffff8880e6a8d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbcbeece820 CR3: 000000001861d000 CR4: 00000000000006f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	d8 fe                	fdivr  %st(6),%st
   2:	eb 05                	jmp    0x9
   4:	e8 6f 76 d8 fe       	call   0xfed87678
   9:	4c 89 f7             	mov    %r14,%rdi
   c:	e8 47 ae 00 00       	call   0xae58
  11:	4c 89 e7             	mov    %r12,%rdi
  14:	e8 0f 08 01 ff       	call   0xff010828
  19:	4d 8b 7e 68          	mov    0x68(%r14),%r15
  1d:	49 8d bf 90 00 00 00 	lea    0x90(%r15),%rdi
  24:	e8 ff 07 01 ff       	call   0xff010828
* 29:	4d 8b af 90 00 00 00 	mov    0x90(%r15),%r13 <-- trapping instruction
  30:	4d 85 ed             	test   %r13,%r13
  33:	74 13                	je     0x48
  35:	e8 3e 76 d8 fe       	call   0xfed87678
  3a:	4c 89 f7             	mov    %r14,%rdi
  3d:	4d                   	rex.WRB
  3e:	89                   	.byte 0x89


Regards,
Yang Zi

