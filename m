Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A71C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C2A10E2E5;
	Mon, 17 Aug 2026 03:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PR7bjGnd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8BA10E2E5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 03:26:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A561F4369C;
 Mon, 17 Aug 2026 03:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FE91F000E9;
 Mon, 17 Aug 2026 03:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786937206;
 bh=obfwsYvB28jENRTdqYfK2jHTL3z6XZzPJupFEPekzlM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PR7bjGndekm/FT5OiVotxqZBChw7kfm+O2xhl65q1KCI4lcbBtVVhSwfxYAPJIC/E
 RIxZGAhEYElLcKoNtPD1XoQuqAHJyXLDoE7+7W3HkbcwN+ChrEaOrCXSXKg46Lw6iv
 Y6JONFdi+sRzNrgFyObaAxn1SSGxm33mb5+cFNlD8mNSc8r+Gf2dYyHO/PvJU0EjWq
 +SrytfnhqiVibNaxKXEQeh7cjlFWuTtEgMglw0Lzm8qo4EcfZQrftSHuOP40lQjFPU
 ObKwNRQAhC6ORtBYR6KTkp5GGRCe7F5nQlnNalvpehb0hmp4fhNUv7L8x3OuhG6Yd6
 vlnLViTQxndlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: platinumfb: replace strcpy with strscpy
To: yuebingkun <yuebingkun@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817031816.188833-1-yuebingkun@kylinos.cn>
References: <20260817031816.188833-1-yuebingkun@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 03:26:45 +0000
Message-Id: <20260817032646.66FE91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return values of `ioremap()` and `ioremap_wt()` are not checke=
d in `platinumfb_probe()`. If these memory mappings fail, the driver will d=
ereference NULL pointers, leading to a kernel panic or memory corruption.
--

--- Patch [1]: [PATCH] fbdev: platinumfb: replace strcpy with strscpy ---
commit 6966c7026a255de8bfc9e604d65d483193521ed1
Author: yuebingkun <yuebingkun@kylinos.cn>

fbdev: platinumfb: replace strcpy with strscpy

strcpy() is deprecated for use on fixed-size buffers. Replace it with
strscpy() to avoid potential buffer overflow issues.

> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/plati=
numfb.c
> index a08d955d9b439..fa27a3a4f05b2 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -320,7 +320,7 @@ static void platinum_init_info(struct fb_info *info,
>  	fb_alloc_cmap(&info->cmap, 256, 0);
> =20
>  	/* Fill fix common fields */
> -	strcpy(info->fix.id, "platinum");
> +	strscpy(info->fix.id, "platinum", sizeof(info->fix.id));

[Severity: High]
This isn't a bug introduced by this patch, but I noticed there are missing
checks for the return values of memory mapping functions in the same file.

If ioremap() or ioremap_wt() fails during device probe, they return NULL.
This could lead to a NULL pointer dereference in the same function:

drivers/video/fbdev/platinumfb.c:platinumfb_probe() {
	...
	pinfo->frame_buffer =3D ioremap_wt(pinfo->rsrc_fb.start, 0x400000);
	pinfo->base_frame_buffer =3D pinfo->frame_buffer;
	...
	pinfo->platinum_regs =3D ioremap(pinfo->rsrc_reg.start, 0x1000);
	...
	out_be32(&pinfo->platinum_regs->reg[16].r, (unsigned)pinfo->frame_buffer_p=
hys);
	...
	fbuffer =3D pinfo->base_frame_buffer;
	fbuffer[0x100000] =3D 0x34;
	...
}

Should the return values of ioremap_wt() and ioremap() be checked before
dereferencing these pointers?

>  	info->fix.mmio_start =3D pinfo->platinum_regs_phys;
>  	info->fix.mmio_len =3D 0x1000;
>  	info->fix.type =3D FB_TYPE_PACKED_PIXELS;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817031816.1888=
33-1-yuebingkun@kylinos.cn?part=3D1
