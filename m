Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4573DC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF6C10E31F;
	Thu, 16 Jul 2026 11:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nps7qwPZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0302010E31F
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:19:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 215446001A;
 Thu, 16 Jul 2026 11:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DE81F000E9;
 Thu, 16 Jul 2026 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784200751;
 bh=B8vTsHnMG9AtvG2/FXXHSyKB6YWqrYZZG9Bv4/xFZ3s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nps7qwPZgVMbO/pVVVs3qTDAcKSdm2s1dyS++Nwnxb7rsSNbCEtVSLUy/boNefVQ8
 8vgjlCthlvFYDVC6Lx4gkawcf26RtMc4xReOPrnJb/R0S+9kZ2mWc/p1nqUZFltkve
 9lYG0ktpKoIrg6HnzS+AKTYqd1H+gOFci5Dm9plvKooD2lRx7NRnHNULhHEWXmJP0b
 2xNDIJ4xaXpl2zQ7KCUHmeu412NUMWD33JhrZgu6BfuQKAI31mMBP1inTaaaStViyh
 PqpTKZplOxQHf5KZrxcEx2sqhrH6BykbmwKGfbv/EFsTeYMbvTqs+JsNvhC0zfjRAZ
 DHcYGwaRq+rJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay with
 usleep_range
To: "Selby Mashiki" <mashikiselby@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716-staging-testing-v1-1-2ebc0c6bb27a@gmail.com>
References: <20260716-staging-testing-v1-1-2ebc0c6bb27a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 11:19:11 +0000
Message-Id: <20260716111911.99DE81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unconditional NULL Pointer Dereference on Big Endian Architect=
ures
- [High] Missing State Restoration on Error Path
- [High] Unaligned Memory Access causing alignment faults
--

--- Patch [1]: [PATCH] staging: fbtft: fb_ra8875: replace udelay with uslee=
p_range ---
commit 0b662df2d1169732bcf1a8f82e3c8a0905497245
Author: Selby Mashiki <mashikiselby@gmail.com>

staging: fbtft: fb_ra8875: replace udelay with usleep_range

udelay() busy-waits for the specified duration, consuming CPU cycles
unnecessarily. usleep_range() is preferred for delays that can sleep,
as it allows the scheduler to run other tasks during the wait.

> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb=
_ra8875.c
> index 0ab1de6647d07..d2400bb44f1c6 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, in=
t len, ...)
>  	}
>  	len--;
> =20
> -	udelay(100);
> +	usleep_range(100, 200);
> =20
>  	if (len) {
>  		buf =3D (u8 *)par->buf;
[ ... ]
> @@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, in=
t len, ...)
> =20
>  	/* restore user spi-speed */
>  	par->fbtftops.write =3D fbtft_write_spi;
> -	udelay(100);
> +	usleep_range(100, 200);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed the error paths
in write_reg8_bus8() return early:

write_reg8_bus8() {
    ...
    ret =3D par->fbtftops.write(par, par->buf, len + 1);
    if (ret < 0) {
        va_end(args);
        dev_err(par->info->device,
            "write() failed and returned %dn", ret);
        return;
    }
    ...
}

Does this early return leave par->fbtftops.write pointing to the slower
write_spi function, permanently degrading SPI performance? Should it restore
fbtft_write_spi before returning?

> =20
>  static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_=
t len)

[Severity: Critical]
This is a pre-existing issue, but does write_vmem16_bus8() unconditionally
dereference par->txbuf.buf?

write_vmem16_bus8() {
    ...
    *(u8 *)(par->txbuf.buf) =3D 0x00;
    ...
}

If par->txbuf.buf is only dynamically allocated on Little Endian architectu=
res
or when txbuflen > 0, could this cause a kernel panic on Big Endian systems
where it might be NULL?

[Severity: High]
Also a pre-existing issue in write_vmem16_bus8(): is there a risk of alignm=
ent
faults on architectures that do not support unaligned memory access?

write_vmem16_bus8() {
    ...
    txbuf16 =3D par->txbuf.buf + 1;
    ...
    for (i =3D 0; i < to_copy; i++)
        txbuf16[i] =3D cpu_to_be16(vmem16[i]);
    ...
}

Since txbuf16 is cast from an odd byte offset (par->txbuf.buf + 1), does the
16-bit assignment in the loop cause an unaligned access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-staging-te=
sting-v1-1-2ebc0c6bb27a@gmail.com?part=3D1
