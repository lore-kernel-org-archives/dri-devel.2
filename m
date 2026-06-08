Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E0FCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D4910F0B2;
	Mon,  8 Jun 2026 10:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B5hulq8a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B4B10F0CA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:05:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E262C42AFF;
 Mon,  8 Jun 2026 10:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9021F0089A;
 Mon,  8 Jun 2026 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780913119;
 bh=VU5ZVrvds8hA8g77tN2c8AtC4cqRlSNe79vhIi6V+Bo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B5hulq8aIxrGUmeDYU9Bd6MQ+uJk/fHJ9ZG+M5j/UYx9Sew/+20L4RbIUKp6DwuKL
 lWrttqeroY2kAsSmgf5ZlAG19xjcs3WgGeunKHbJchWMAObv9rI6k1wCwVwFHVgMNu
 3uHa8ZrRYlIeKnz0/OIHd1l5gh4aUQvD51ey7KgQgpbdjDflaN1RWMtRfhgkmn1Ba3
 XxEid23/d3FgnzM60bGsPzrXOmyxsTYiaF/vEe+5J8nCdl56FKV1c0wS03/dtEfo38
 notWiGPQhWoDYxFKAQa6wMAM8dwSVWrVL0Xd28fuFiKA4YHT3fhPXV2NYikdOKHWAr
 7Cv/ojPHPziAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH next] drivers/video/fbdev/s3fb: Use strscpy() to copy
 strings into arrays
To: david.laight.linux@gmail.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608095523.2606-11-david.laight.linux@gmail.com>
References: <20260608095523.2606-11-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 10:05:19 +0000
Message-Id: <20260608100519.9F9021F0089A@smtp.kernel.org>
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
- [High] Out-of-bounds array read in `s3_names` due to unvalidated PCI `dri=
ver_data` provided via sysfs `new_id`.
--

commit b390c20a52cf582227c3e8af3febb7b07f89b2a7
Author: David Laight <david.laight.linux@gmail.com>

drivers/video/fbdev/s3fb: Use strscpy() to copy strings into arrays

This commit replaces strcpy() with strscpy() in s3_pci_probe() to ensure
that target buffer overflows cannot occur.

> diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
> index ba30e5568cabc..b679ccdb38e2c 100644
> --- a/drivers/video/fbdev/s3fb.c
> +++ b/drivers/video/fbdev/s3fb.c
[ ... ]
> @@ -1333,7 +1333,7 @@ static int s3_pci_probe(struct pci_dev *dev, const =
struct pci_device_id *id)
>  	vga_wcrt(par->state.vgabase, 0x38, cr38);
>  	vga_wcrt(par->state.vgabase, 0x39, cr39);
> =20
> -	strcpy(info->fix.id, s3_names [par->chip]);
> +	strscpy(info->fix.id, s3_names[par->chip]);

[Severity: High]
This is a pre-existing issue, but does this array access risk an
out-of-bounds read if a privileged user provides a dynamic PCI ID?

In s3_pci_probe() in drivers/video/fbdev/s3fb.c, par->chip is derived
from the PCI driver_data:

s3_pci_probe() {
        ...
        par->chip =3D id->driver_data & CHIP_MASK;
        par->rev =3D vga_rcrt(par->state.vgabase, 0x2f);
        if (par->chip & CHIP_UNDECIDED_FLAG)
                par->chip =3D s3_identification(par);
        ...
}

If a user binds the driver via the sysfs new_id interface and supplies
a driver_data value between 21 and 127, it safely bypasses the
CHIP_UNDECIDED_FLAG (0x80) check. This leaves par->chip unvalidated.

Since the s3_names array contains exactly 21 elements, using this
unvalidated par->chip as an index could result in reading past the
end of the array. Passing the resulting invalid pointer to strscpy()
could then trigger an invalid memory dereference.

Should we add a bounds check for par->chip before accessing s3_names[]?

>  	info->fix.mmio_start =3D 0;
>  	info->fix.mmio_len =3D 0;
>  	info->fix.type =3D FB_TYPE_PACKED_PIXELS;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608095523.2606=
-11-david.laight.linux@gmail.com?part=3D1
