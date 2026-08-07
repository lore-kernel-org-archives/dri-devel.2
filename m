Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE443C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 20:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137D510E117;
	Fri,  7 Aug 2026 20:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ASSFExhY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADBF10E117
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 20:16:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF46A4340E;
 Fri,  7 Aug 2026 20:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7001F000E9;
 Fri,  7 Aug 2026 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786133808;
 bh=dnX0RUbhgS7aBIKdqZEV/ZrmyuH429jMlVNZNo5QXlI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ASSFExhYFFLpkfxazbaJ3osX07AD5/2d23qiyk8NYafd4b3ODccTHxbvIEjXi38jB
 +6q22KIhpMV2NTb3fR82NO2Lrb/e29hatyR081oQoqLwhN3qqwXik6W0Vt8g7WnYI+
 i+/qxrasUi4+4r6dmqunvAYpM2kGZT9Cx5eLZKQNSydfl80o9CUZ62sDMmUyaR5gZu
 e8PLXG0KfgfBBeKvhmDygQRGiem7VVCGYRPn8Tq8s6ARToGh9+8lfrvPvvk698okdS
 8sTrgjMyamZIXMf8nRuzybwPA6N/2dYyD9dzGRwoO8TAVKWxIjYGsvscRK1cFC1Bfn
 1+rqd8EPJey8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: vgaarb: Remove stale "not implemented" notes from
 docs
To: =?utf-8?b?Q2hyaXN0aWFuIE1lbGVuZGV6IE51w7Fleg==?= <chrismelnu@gmail.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260807200639.172487-1-chrismelnu@gmail.com>
References: <20260807200639.172487-1-chrismelnu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 20:16:47 +0000
Message-Id: <20260807201648.7D7001F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The commit incorrectly removes the 'not implemented' TODO for th=
e 'unlock all' command, even though its implementation remains fundamentall=
y broken.

Pre-existing issues:
- [High] Use-After-Free in vga_arb_release due to unreferenced pci_dev poin=
ters.
- [High] Permanent global VGA lock resource leak when MAX_USER_CARDS is exc=
eeded.
- [High] Data race and Use-After-Free during unprotected vga_list iteration=
 and concurrent FD accesses.
--

--- Patch [1]: [PATCH] PCI: vgaarb: Remove stale "not implemented" notes fr=
om docs ---
commit bbd78d4ec38a7ceee963b0e74ebab5896fceb191
Author: Christian Melendez Nu=C3=B1ez <chrismelnu@gmail.com>

PCI: vgaarb: Remove stale "not implemented" notes from docs

This commit updates the vgaarb documentation and kerneldoc to remove
"TODO: not implemented yet" notes for the "unlock all" and "target
default" commands. It states that these commands are already fully handled
in vga_arb_write().

> - "unlock all" is handled in vga_arb_write() via the "all"
>   strncmp branch, which releases both VGA_RSRC_LEGACY_IO and
>   VGA_RSRC_LEGACY_MEM.

[Severity: Medium]
Is the "unlock all" command fully implemented and working as expected?

Looking at vga_arb_write(), when the "all" branch is taken, it forces both
flags:

drivers/pci/vgaarb.c:vga_arb_write() {
    ...
    if (strncmp(curr_pos, "all", 3) =3D=3D 0)
        io_state =3D VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
    ...
}

But later in the same function, it checks if the user actually holds these
locks:

drivers/pci/vgaarb.c:vga_arb_write() {
    ...
    if (io_state & VGA_RSRC_LEGACY_MEM && uc->mem_cnt =3D=3D 0) {
        ret_val =3D -EINVAL;
        goto done;
    }
    ...
}

If the user holds only one type of lock, wouldn't this fail with -EINVAL
instead of unlocking the resources? Should the TODO disclaimer remain until
this logic is fixed?


> diff --git a/Documentation/gpu/vgaarbiter.rst b/Documentation/gpu/vgaarbi=
ter.rst
> index d1e953712cc29..c3a728130b545 100644
> --- a/Documentation/gpu/vgaarbiter.rst
> +++ b/Documentation/gpu/vgaarbiter.rst
> @@ -65,8 +65,7 @@ write
>          unlock <io_state>
>                  release locks on target
>          unlock all
> -                release all locks on target held by this user (not imple=
mented
> -                yet)
> +                release all locks on target held by this user

[Severity: High]
This is a pre-existing issue, but does closing the file descriptor lead to a
use-after-free here?

In vga_arb_write(), when a "target" command is processed, the code drops the
reference to the PCI device:

drivers/pci/vgaarb.c:vga_arb_write() {
    ...
    pci_dev_put(pdev);
    ...
}

If the target PCI device is subsequently hot-unplugged and freed by the PCI
subsystem, the pointers in priv->target and priv->cards[i].pdev are left
dangling.=20

When the user later closes the file descriptor, vga_arb_release() accesses
the device unconditionally:

drivers/pci/vgaarb.c:vga_arb_release() {
    ...
    vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt =3D=3D %d, uc->mem_cnt =3D=3D %d=
\n",
               uc->io_cnt, uc->mem_cnt);
    ...
}

Could this dereference the freed pointer if the device was removed?


[Severity: High]
This is a pre-existing issue, but can we permanently leak a global VGA lock
if MAX_USER_CARDS is exceeded?

When vga_arb_write() processes the "target" command, it sets priv->target
before checking if the tracking array is full:

drivers/pci/vgaarb.c:vga_arb_write() {
    ...
    priv->target =3D pdev;
    for (i =3D 0; i < MAX_USER_CARDS; i++) {
        ...
    if (i =3D=3D MAX_USER_CARDS) {
        ...
        ret_val =3D  -ENOMEM;
        goto done;
    }
    ...
}

If the user has 16 devices and targets a 17th, the function returns -ENOMEM
but leaves priv->target set to the new device.

If the user then sends a "lock io" command, it will acquire the global lock
for this new device. Because the device isn't tracked in priv->cards, does
vga_arb_release() fail to release this lock on close, leaking it permanentl=
y?


[Severity: High]
This is a pre-existing issue, but is it safe to traverse the global vga_list
without holding vga_lock?

In vga_arb_write(), when resolving a target device, it calls vgadev_find():

drivers/pci/vgaarb.c:vga_arb_write() {
    ...
    vgadev =3D vgadev_find(pdev);
    ...
}

Which traverses the global list:

drivers/pci/vgaarb.c:vgadev_find() {
    ...
    list_for_each_entry(vgadev, &vga_list, list) {
        ...
}

If a VGA device is concurrently hot-plugged or unplugged, could this
concurrent modification cause the iteration to dereference freed list nodes?

Additionally, should concurrent accesses to the user's private struct,
such as priv->target and priv->cards in vga_arb_write(), be protected by
priv->lock to prevent data corruption when accessed by multiple threads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807200639.1724=
87-1-chrismelnu@gmail.com?part=3D1
