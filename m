Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEA9C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD2510F17E;
	Thu, 27 Aug 2026 19:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="KXm2ZuOv";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bugs.sh header.i=@bugs.sh header.b="NIHakLEf";
	dkim-atps=neutral
Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org
 [104.30.16.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2545710F000
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org;
 c=relaxed/relaxed; 
 h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
 :resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
 :list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
 :list-owner:list-archive; t=1787834933; x=1788439733; bh=/SyfQl9CLBwpujeN1/
 3FRGnSEmpv2gLnAd/W66Uu8KE=; b=KXm2ZuOvPZTz6iawXCIDI5UFbdc+BTtIGQ8XvXH9Q2wLW
 wYpq5mZ/oMo/T+NQwNyJ/UpS/b2mpYZ2XzRlqR64eUwcX/i7cvAMZqECR4q5dWLDZqISzvWwN5b
 vpk6BVNciQ8hG84v6NKxvprHiv9Ltye8ZDZDY4Vwg7BwsQxAEsc/RmieUiZMbVKsMfmaHTtZT2a
 0OHgkFWeQcNZDuyhEWDQL2SayMi9GLSShtOGAgloV3UJGvl79HI9Yh7+4eb7gFZH9quUTXbpobj
 41NImDpiFmNO9+u0QY84vyVhA13N6wZLLkScPPGY+r182Dyk8HuzH8xcRewapLC9l7Wm06Gg==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed; 
 h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
 :resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
 :list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
 :list-owner:list-archive; t=1787834933; x=1788439733; bh=/SyfQl9CLBwpujeN1/
 3FRGnSEmpv2gLnAd/W66Uu8KE=; b=NIHakLEfeDdnZk6sVX1TAyrk1KLrKABCK7EKDR0I7D70v
 vpLjZpZA4LjUSROiTQ0Oe89Z7AfAbtmtZRFh7sXt4dbmal+E8irvKwBZ6cDNqRFlEGICnz8sURa
 fPyhzbRNIzSW6fDaG/SBvuvnlSO3TNYDG+V1Dhfu9qB65vaL8ptAZmUW84MCqWK+pXuuCMsmfll
 fZqaX6e5tNODwLu4oh4viv8j9hOE8rJ+vwXbCUR0cF8NexTIG43MmYLSihNEole5BUuVT1rdFC+
 JXmoYuLSC1EYOBFGZ+8GRb5aUlzlxard+gn8H+6USFgxnUH4um4uwE35Xaake0YoBAp6pKNQ==;
Feedback-ID: bugs.sh:5:6:Cloudflare
Message-ID: <f2Kf9GYn1lKR5S1dbvGVtykMxK1RlgP5z8sW@bugs.sh>
From: co <co+c25629c98ba36ebe@bugs.sh>
Date: Thu, 27 Aug 2026 12:43:25 +0000
Subject: [BUG] drivers/video: use-after-free in _copy_to_user()
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, "Simona
 Vetter" <simona@ffwll.ch>, "Helge Deller" <deller@gmx.de>,
 "Petr Mladek" <pmladek@suse.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Song
 Liu" <song@kernel.org>, "Biju Das" <biju.das.jz@bp.renesas.com>, "Oleg
 Nesterov" <oleg@redhat.com>, "Andrea Righi" <righi.andrea@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
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

    path    drivers/video/fbdev/core/fb_chrdev.c`, `drivers/video/fbdev/core
    crash   use-after-free in _copy_to_user()
    commit  843bc34db94b

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+c25629c98ba36ebe@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/c25629c98ba36ebe/patch.diff
        report.md   https://bugs.sh/b/c25629c98ba36ebe/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  843bc34db94b
    VM setup       https://bugs.sh/b/c25629c98ba36ebe/run.sh
    config         https://bugs.sh/b/c25629c98ba36ebe/config.gz
    poc            https://bugs.sh/b/c25629c98ba36ebe/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in _copy_to_user (include/linux/instrumente=
d.h:129 include/linux/uaccess.h:201 lib/usercopy.c:24)
Read of size 512 at addr ffff88800dd12800 by task exploit/147
CPU: 1 UID: 0 PID: 147 Comm: exploit Tainted: G        W           7.2.0-rc=
2+ #6 PREEMPTLAZY
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
_copy_to_user (include/linux/instrumented.h:129 include/linux/uaccess.h:201=
 lib/usercopy.c:24)
fb_cmap_to_user (include/linux/uaccess.h:230 drivers/video/fbdev/core/fbcma=
p.c:211)
do_fb_ioctl (drivers/video/fbdev/core/fb_chrdev.c:114)
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Allocated by task 1:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
__kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
__kmalloc_noprof (include/linux/kasan.h:263 mm/slub.c:5362 mm/slub.c:5387)
fb_alloc_cmap_gfp (include/linux/slab.h:973 include/linux/slab.h:1290 drive=
rs/video/fbdev/core/fbcmap.c:108)
vfb_probe (drivers/video/fbdev/vfb.c:459)
platform_probe (drivers/base/platform.c:1439)
really_probe (drivers/base/dd.c:628 drivers/base/dd.c:706)
__driver_probe_device (drivers/base/dd.c:868)
driver_probe_device (drivers/base/dd.c:898)
__device_attach_driver (drivers/base/dd.c:1026)
bus_for_each_drv (drivers/base/bus.c:500)
__device_attach (drivers/base/dd.c:1098)
device_initial_probe (drivers/base/dd.c:1153)
bus_probe_device (drivers/base/bus.c:620)
device_add (drivers/base/core.c:3772)
platform_device_add (drivers/base/platform.c:762)
vfb_init (drivers/video/fbdev/vfb.c:525)
do_one_initcall (init/main.c:1347)
kernel_init_freeable (init/main.c:1409 (discriminator 1) init/main.c:1425 (=
discriminator 1) init/main.c:1445 (discriminator 1) init/main.c:1658 (discr=
iminator 1))
kernel_init (init/main.c:1548)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
Freed by task 144:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:67=
20)
fb_dealloc_cmap (drivers/video/fbdev/core/fbcmap.c:151)
vfb_remove (drivers/video/fbdev/vfb.c:489)
device_release_driver_internal (drivers/base/dd.c:1349 drivers/base/dd.c:13=
72)
unbind_store (drivers/base/bus.c:244)
kernfs_fop_write_iter (fs/kernfs/file.c:345)
vfs_write (fs/read_write.c:595 fs/read_write.c:687)
ksys_write (fs/read_write.c:739)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff88800dd12800
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
freed 512-byte region [ffff88800dd12800, ffff88800dd12a00)
The buggy address belongs to the physical page:
page dumped because: kasan: bad access detected
Memory state around the buggy address:
ffff88800dd12700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88800dd12780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88800dd12800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88800dd12880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88800dd12900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb


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


