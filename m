Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276B1C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7562910F168;
	Thu, 27 Aug 2026 19:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="VmPJo+us";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bugs.sh header.i=@bugs.sh header.b="ApveSRD6";
	dkim-atps=neutral
Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org
 [104.30.16.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BD010F000
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org;
 c=relaxed/relaxed; 
 h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
 :resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
 :list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
 :list-owner:list-archive; t=1787834938; x=1788439738; bh=ybdv1l55cYdaAZRHPa
 yzjZTPrUKjnSWWBRLovv9blPg=; b=VmPJo+usCyWYVDv8VgqWHqhvV2AVKEv/+YdA2xh3FEsLI
 l2mAIrJc0375d99tg0BvyiYP9sfgEPgVUubW7X60FI6Ln8awpYujU7JqO3XxoXuWrPgoTfl/98/
 Z/pH5jS6Qr2Y7XRsHLL5oTjFNbTDE4ToN3KDeibGgYOun2gWhzZT9YwbaNYCWgUMNG4DG3GRfEe
 uv3w+1W//5+Sqm0S1DlwoZjt6g6aKDRkT0b1dVF3sGaOy0nY6W6S7g3f5+Zrqpx9YGcDVBZemCK
 OU9R8nE8rlO1aPypxJkY54S7rUmanyDLDFo+kPVtlkLnPP4SvHF1IgvMpsSqLVnvnqm1oE9A==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed; 
 h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
 :resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
 :list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
 :list-owner:list-archive; t=1787834938; x=1788439738; bh=ybdv1l55cYdaAZRHPa
 yzjZTPrUKjnSWWBRLovv9blPg=; b=ApveSRD6mKyJ9Npe567lBlHNmEWJedAGUNDcqGTCRLIYL
 Lo2DrSFHVSebZV5S4d8TFj1LqZJM+rVz+U0/nf9W3EK0dvgNXHtd7kvoPLMDYMGddcfjBEngfZS
 x51go43hplC3LkDT3tsxyz6z8plm9HiXnExoiKD9nhS30W2KuyVOsCVkmrc47kAHq2c896zPZD6
 ol+PFVTTKsKkve0zaO93r+rT39lfirLVcQusmBZUDo/lCeSIPaobgXi7e6MDfoXG+DjN8SyyLmP
 ZK3F3igfv58dbUK3H7ndFDOO8UQepN5WUWfxE718c+lhmXrx67Pc6NDSbmQpA8VLP7pEG4nQ==;
Feedback-ID: bugs.sh:5:6:Cloudflare
Message-ID: <eI5CjpXt3iSkALGbLLgJa6Pj4lq2BbU7Fmjj@bugs.sh>
From: co <co+1875dd47169bd757@bugs.sh>
Date: Thu, 27 Aug 2026 12:43:33 +0000
Subject: [BUG] drivers/video: out-of-bounds in tile_putcs()
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, "Helge
 Deller" <deller@gmx.de>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Simona
 Vetter" <simona@ffwll.ch>, linux-kernel@vger.kernel.org
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

    path    drivers/video/fbdev/core/tileblit.c`, `drivers/video/fbdev/core
    crash   out-of-bounds in tile_putcs()
    commit  843bc34db94b

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+1875dd47169bd757@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/1875dd47169bd757/patch.diff
        report.md   https://bugs.sh/b/1875dd47169bd757/report.md

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
    VM setup       https://bugs.sh/b/1875dd47169bd757/run.sh
    config         https://bugs.sh/b/1875dd47169bd757/config.gz
    poc            https://bugs.sh/b/1875dd47169bd757/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in tile_putcs (drivers/video/fbdev/core/tile=
blit.c:69)
Write of size 4 at addr ffff88800c622000 by task exploit/143
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
tile_putcs (drivers/video/fbdev/core/tileblit.c:69)
fbcon_putcs (drivers/video/fbdev/core/fbcon.c:1392 (discriminator 3))
do_update_region (drivers/tty/vt/vt.c:656)
redraw_screen (drivers/tty/vt/vt.c:1008)
fbcon_blank (drivers/video/fbdev/core/fbcon.c:2315)
do_unblank_screen (drivers/tty/vt/vt.c:4756 drivers/tty/vt/vt.c:4724)
vt_ioctl (drivers/tty/vt/vt_ioctl.c:276 drivers/tty/vt/vt_ioctl.c:381 drive=
rs/tty/vt/vt_ioctl.c:743)
tty_ioctl (drivers/tty/tty_io.c:2792)
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Allocated by task 143:
__kmalloc_cache_noprof (include/linux/kasan.h:263 mm/slub.c:5515)
do_register_framebuffer (include/linux/slab.h:969 drivers/video/fbdev/core/=
fbmem.c:502)
register_framebuffer (drivers/video/fbdev/core/fbmem.c:602)
ark_pci_probe (drivers/video/fbdev/arkfb.c:1051)
local_pci_probe (drivers/pci/pci-driver.c:332)
pci_device_probe (drivers/pci/pci-driver.c:394 drivers/pci/pci-driver.c:455=
 drivers/pci/pci-driver.c:489)
really_probe (drivers/base/dd.c:628 drivers/base/dd.c:706)
__driver_probe_device (drivers/base/dd.c:868)
driver_probe_device (drivers/base/dd.c:898)
__driver_attach (drivers/base/dd.c:1292)
bus_for_each_dev (drivers/base/bus.c:383)
new_id_store (drivers/pci/pci-driver.c:249)
kernfs_fop_write_iter (fs/kernfs/file.c:345)
vfs_write (fs/read_write.c:595 fs/read_write.c:687)
ksys_write (fs/read_write.c:739)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff88800c620000
which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 0 bytes to the right of


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


