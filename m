Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797CAC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B85410F171;
	Thu, 27 Aug 2026 19:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="Fig+fjJl";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bugs.sh header.i=@bugs.sh header.b="FeS1aP51";
	dkim-atps=neutral
X-Greylist: delayed 321 seconds by postgrey-1.36 at gabe;
 Thu, 27 Aug 2026 12:48:14 UTC
Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org
 [104.30.16.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AE110F000
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org;
 c=relaxed/relaxed; 
 h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
 :resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
 :list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
 :list-owner:list-archive; t=1787834894; x=1788439694; bh=vFpdbsdJZfeFKcTVUZ
 5ghk7Kj1Khv5U+q9Ot+oG5kFQ=; b=Fig+fjJlcehUM12vhjLdGEr3UJMnRaCIgHvP7UewtUqMr
 abL/bFBLFe/ahsKZkxX927qzm5DOXPa82FkdwOmf5gU5+7esT4B9ZS06IrzqlZTL6HsGxIXZypp
 kvAJg/WmzTcRtBSQND4f5totFvMRILuMT1nmD/kItWW7oPIZv49Wj4uVY8wMCBVSp4jlAt/VTG+
 yobHTCB3B0383bcC5JGeA2ZppIaUFurMY3d/DAo29mVh1Z8AZWKBDX9LXivDE8NkDZTeCUgHJvX
 0Ut+wO7kyrrT1f0Y1vZ82o1d2+XWazlX5LQj5H/3WmdKgalitdrhNd0mKfDcaHVfQN7KhD2w==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed; 
 h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
 :resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
 :list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
 :list-owner:list-archive; t=1787834894; x=1788439694; bh=vFpdbsdJZfeFKcTVUZ
 5ghk7Kj1Khv5U+q9Ot+oG5kFQ=; b=FeS1aP51tr6+pzwdCEWvE2NSwR08zuZ7V1OdOd92zwZs2
 Wo1xBx1tDpSODcdeZUTIbI//ye1yfp+KJyTKIUKbjuXUwhKWCbog4nSoFScRasJyZ4MKaf32QoM
 LmWDhKjCCyFf98frBKoPY5oKd4s0CTAbHg9Uve7BqmUSHp+SVkABOpp2Vk1XYa/w32pNa+tRsCp
 fRgem/CilC+LKfXaY/inTMPxfaohh3xQTgWyIcn8nnX2gSaMO4JQz1dBrGmHc8OkpG/X/l/9lF/
 XDlB1oH1xJSy7wNiAXZP//3hfiWggJ6K1fItg6Ld3EleXLMm+n/9AFimVYj5n3/fRtTuVAbQ==;
Feedback-ID: bugs.sh:5:6:Cloudflare
Message-ID: <1jSCSNaDKmuUG7h40rTsSl1rMaSwdlJef4rp@bugs.sh>
From: co <co+ed9902f2e44184d9@bugs.sh>
Date: Thu, 27 Aug 2026 12:42:49 +0000
Subject: [BUG] drivers/video: use-after-free in fb_videomode_to_var()
To: dri-devel@lists.freedesktop.org, "Helge Deller" <deller@gmx.de>, "Bernie
 Thompson" <bernie@plugable.com>, "Greg Kroah-Hartman" <gregkh@suse.de>,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:08:24 +0000
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

We found a bug reachable in:

    path    drivers/video/fbdev
    crash   use-after-free in fb_videomode_to_var()
    commit  3cd8b194bf34 ("Merge tag 'v7.1-rc-part1-smbdirect-fixes' of git=
://git.samba.org/ksmbd")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+ed9902f2e44184d9@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/ed9902f2e44184d9/patch.diff
        report.md   https://bugs.sh/b/ed9902f2e44184d9/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  3cd8b194bf34 ("Merge tag 'v7.1-rc-part1-smbdirect-fixes'=
 of git://git.samba.org/ksmbd")
    VM setup       https://bugs.sh/b/ed9902f2e44184d9/run.sh
    config         https://bugs.sh/b/ed9902f2e44184d9/config.gz
    poc            https://bugs.sh/b/ed9902f2e44184d9/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in fb_videomode_to_var (drivers/video/fbdev=
/core/modedb.c:906)
Read of size 4 at addr ffff88801057471c by task kworker/1:2/113
CPU: 1 UID: 0 PID: 113 Comm: kworker/1:2 Not tainted 7.0.0+ #1 PREEMPT(lazy)
Workqueue: events console_callback
Call Trace:
dump_stack_lvl (lib/dump_stack.c:123)
print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:597)
fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:906)
display_to_var (drivers/video/fbdev/core/fbcon.c:1000)
fbcon_switch (drivers/video/fbdev/core/fbcon.c:2190)
redraw_screen (drivers/tty/vt/vt.c:995)
complete_change_console (drivers/tty/vt/vt_ioctl.c:1149)
change_console (drivers/tty/vt/vt_ioctl.c:1263)
console_callback (drivers/tty/vt/vt.c:3320)
process_one_work (kernel/workqueue.c:3307)
worker_thread (kernel/workqueue.c:3379 (discriminator 2) kernel/workqueue.c=
:3466 (discriminator 2))
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:164)
ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
Allocated by task 12:
kasan_save_stack (mm/kasan/common.c:58)
kasan_save_track (mm/kasan/common.c:70 (discriminator 1) mm/kasan/common.c:=
79 (discriminator 1))
__kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
fb_add_videomode (./include/linux/slab.h:950 drivers/video/fbdev/core/moded=
b.c:1073)
dlfb_setup_modes (drivers/video/fbdev/udlfb.c:1316 (discriminator 2))
dlfb_usb_probe (drivers/video/fbdev/udlfb.c:1685)
usb_probe_interface (drivers/usb/core/driver.c:397)
really_probe (drivers/base/dd.c:631 drivers/base/dd.c:709)
__driver_probe_device (drivers/base/dd.c:851)
driver_probe_device (drivers/base/dd.c:882)
__device_attach_driver (drivers/base/dd.c:1010)
bus_for_each_drv (drivers/base/bus.c:500)
__device_attach (drivers/base/dd.c:1083)
device_initial_probe (drivers/base/dd.c:1136)
bus_probe_device (drivers/base/bus.c:615)
device_add (drivers/base/core.c:3698)
usb_new_device (drivers/usb/core/hub.c:2696)
hub_event (drivers/usb/core/hub.c:5568 drivers/usb/core/hub.c:5707 drivers/=
usb/core/hub.c:5871 drivers/usb/core/hub.c:5953)
process_one_work (kernel/workqueue.c:3307)
worker_thread (kernel/workqueue.c:3379 (discriminator 2) kernel/workqueue.c=
:3466 (discriminator 2))
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:164)
ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
Freed by task 173:
kasan_save_stack (mm/kasan/common.c:58)
kasan_save_track (mm/kasan/common.c:70 (discriminator 1) mm/kasan/common.c:=
79 (discriminator 1))
kasan_save_free_info (mm/kasan/generic.c:587 (discriminator 1))
__kasan_slab_free (mm/kasan/common.c:287)
kfree (mm/slub.c:6246 (discriminator 3) mm/slub.c:6561 (discriminator 3))
fb_destroy_modelist (drivers/video/fbdev/core/modedb.c:1116 (discriminator =
3))
dlfb_setup_modes (drivers/video/fbdev/udlfb.c:1268)
edid_store (drivers/video/fbdev/udlfb.c:1456)
sysfs_kf_bin_write (fs/sysfs/file.c:164)
kernfs_fop_write_iter (fs/kernfs/file.c:88 fs/kernfs/file.c:356)
vfs_write (fs/read_write.c:596 (discriminator 1) fs/read_write.c:688 (discr=
iminator 1))
ksys_write (fs/read_write.c:741)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/en=
try/syscall_64.c:94 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
The buggy address belongs to the object at ffff888010574700
which belongs to the cache kmalloc-96 of size 96
The buggy address is located 28 bytes inside of


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


