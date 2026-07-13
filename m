Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B1C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4031C892F8;
	Mon, 13 Jul 2026 10:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="am83HcUZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B356892F8
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:34:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D3586013A;
 Mon, 13 Jul 2026 10:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DBA1F00A3A;
 Mon, 13 Jul 2026 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783938862;
 bh=6eAW5EnNQsFDd9v7MN7P+4yODIb8BL4tR8ZK8YWOBlw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=am83HcUZTe8JPFTFV4+q4qn+qhWm21iGX78+puBs8FTINMYJAPRJAqg6Qpyi8tYXk
 stnZO6sO8F8jLA019IoLgN3QN7/KqrpwZjMor6Nb59xawVCkiZJlaULveK8zjbziWP
 XnLa8QCTWVWQE5KTVjcJsgUeeZRJEZHatnwnRnNH7xvEAWej6fl9fQ0aiQCcZnA8TY
 yz7PBkJ24K8Jvpn+SXiibosfgaNxKWjYsL5K+//OSWMU1gaW47Kd9iqsUeYtmTJ1R6
 wVsnJdaTmnSP93f0vnoY0aLWav1dYTypkPOp0L+zUKrGh+UFvSFRfWEtq13ipEYDKH
 HvWhQijwa7laQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: pvr2fb: correct user pointer annotation and
 sentinel initializer
To: "Florian Fuchs" <fuchsfl@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713101638.600333-1-fuchsfl@gmail.com>
References: <20260713101638.600333-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:34:21 +0000
Message-Id: <20260713103422.33DBA1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds array read when calculating the `end` address for th=
e contiguity check.
- [High] DMA transfer completely ignores the user buffer's intra-page offse=
t and exact requested length.
- [High] The driver performs hardware DMA operations without any driver-lev=
el serialization.
- [High] The boundary check in the per-page DMA fallback loop does not acco=
unt for the write size, allowing out-of-bounds DMA writes past the end of t=
he mapped video memory.
- [High] An integer overflow in the bounds check calculation allows an atta=
cker to bypass the size check and perform an out-of-bounds DMA write.
- [Medium] `pvr2fb_write` improperly requests `FOLL_WRITE` permissions when=
 pinning the user buffer.
--

--- Patch [1]: [PATCH] fbdev: pvr2fb: correct user pointer annotation and s=
entinel initializer ---
commit 5cca64a0d87619ea95eacae8901003a474bb95a2
Author: Florian Fuchs <fuchsfl@gmail.com>

fbdev: pvr2fb: correct user pointer annotation and sentinel initializer

This commit adds a __user annotation to the buf argument in pvr2fb_write()
and uses an empty initializer for the board-table sentinel.

Link: https://lore.kernel.org/oe-kbuild-all/202607131247.fpQ6eTc7-lkp@intel=
.com/

> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index 9428716e2dc40..a6e7abca7a06f 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -639,7 +639,7 @@ static irqreturn_t __maybe_unused pvr2fb_interrupt(in=
t irq, void *dev_id)
>  }
> =20
>  #ifdef CONFIG_PVR2_DMA
> -static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
> +static ssize_t pvr2fb_write(struct fb_info *info, const char __user *buf,
>  			    size_t count, loff_t *ppos)
>  {
>  	unsigned long dst, start, end, len;

[Severity: Medium]
This isn't a bug introduced by this patch, but since we are modifying the
write function signature to annotate the user buffer, could we also look at
how it is pinned further down in this function?

pvr2fb_write() uses:

    ret =3D pin_user_pages_fast((unsigned long)buf, nr_pages, FOLL_WRITE, p=
ages);

Does requesting FOLL_WRITE here cause valid read-only user buffers (like
string literals) to fail with -EFAULT when passed to write()?

[Severity: High]
This is a pre-existing issue, but further down in pvr2fb_write(), there
appear to be concerns with how the transfer boundaries are calculated:

    start =3D (unsigned long)page_address(pages[0]);
    end   =3D (unsigned long)page_address(pages[nr_pages]);
    len   =3D nr_pages << PAGE_SHIFT;

Since the pages array only has nr_pages elements, wouldn't reading
pages[nr_pages] be an out-of-bounds array read that could panic the kernel?

Additionally, by ignoring the intra-page offset (buf & ~PAGE_MASK) and
calculating the length strictly from nr_pages, might this leak unrelated
memory by copying from the start of the physical page rather than the exact
user buffer offset?

[Severity: High]
This isn't a bug introduced by this patch, but the size check in
pvr2fb_write() seems susceptible to overflow:

    if ((*ppos + len) > fb_info->fix.smem_len) {
        ret =3D -ENOSPC;
        goto out_unmap;
    }

Given that *ppos is a 64-bit loff_t and len is a 32-bit unsigned int, could
a sufficiently large *ppos cause the addition to wrap around to a negative
value, bypassing the smem_len check and allowing an out-of-bounds DMA write?

[Severity: High]
This is a pre-existing issue, but when setting up the DMA transfers:

    dma_configure_channel(shdma, 0x12c1);
    ...
    dma_write(shdma, start, 0, len);
    dma_write(pvr2dma, 0, dst, len);
    dma_wait_for_completion(pvr2dma);

Are there any locks missing here? It looks like concurrent write() calls
could interleave DMA configurations on the shared shdma and pvr2dma
channels, which might corrupt hardware state.

[Severity: High]
This isn't a bug introduced by this patch, but the fallback loop for
non-contiguous pages has a potential bounds check gap:

    if ((*ppos + (i << PAGE_SHIFT)) > fb_info->fix.smem_len) {
        ret =3D -ENOSPC;
        goto out_unmap;
    }

    dma_write_page(shdma, (unsigned long)page_address(pages[i]), 0);
    dma_write_page(pvr2dma, 0, dst);

Because the check only verifies the start address (*ppos + (i << PAGE_SHIFT=
))
without accounting for the PAGE_SIZE transfer size of dma_write_page(), does
this allow an out-of-bounds DMA write of up to 4095 bytes past the end of t=
he
mapped video memory?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713101638.6003=
33-1-fuchsfl@gmail.com?part=3D1
