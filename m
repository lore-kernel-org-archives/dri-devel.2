Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0899C4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C817210E0CF;
	Tue, 14 Jul 2026 19:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iB5+Tjyl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E64B10E0CF
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:48:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7B8341FC5;
 Tue, 14 Jul 2026 19:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2CA1F000E9;
 Tue, 14 Jul 2026 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784058502;
 bh=Ysy1j4NnlT/nPqS3a7fmG3akhWBRuHjAb1bb6Vqp06E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iB5+TjylW0rUwjIesqV0WQWeFmpKcgvDaHakx9P5xaeXlt8ajOkIa/z2oWEpgIE5s
 aVh/7lQiWII0mtS2THKe28JK9vavC/D+HTbQ4mgxvDZcM3zq4rsRBkQQ3Bkv2aa/7z
 vOhalmzTzqn02McC4b7jJp4sSPzzNMVGhSA/bPGcgVP5iKv39CWULBkO4h/3kqut09
 iuruYnbwjj7mVQ6et1o7tz6Nr34z7HlImXBmN04OcPb3+Be7dUSg5mjDno/xQNAVNT
 Ik+u9mKEtbLHjaErAJiGR0FThsiFytxlnsTmX3JeAQTPXcel1j7rY18KOwZ7NR7nDb
 pWJL3e3PsN78Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] staging: fbtft: Replace udelay with usleep_range
To: "Panagiotis Gravias" <graviaspanagiotis1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714190958.219437-6-graviaspanagiotis1@gmail.com>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
 <20260714190958.219437-6-graviaspanagiotis1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:48:22 +0000
Message-Id: <20260714194822.8D2CA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If a SPI write fails in `write_reg8_bus8`, the function returns ea=
rly without restoring `par->fbtftops.write` to its original value, permanen=
tly downgrading the SPI interface speed.
- [High] The `txbuf16` pointer in `write_vmem16_bus8` is assigned to an odd=
-aligned address, causing unaligned memory writes that can trigger a kernel=
 panic on strict architectures.
--

--- Patch [3]: [PATCH 3/3] staging: fbtft: Replace udelay with usleep_range=
 ---
commit 7f6e8faf1241a2de5c5b0d51aa0632d9694e2167
Author: Panagiotis Gravias <graviaspanagiotis1@gmail.com>

staging: fbtft: Replace udelay with usleep_range

This commit replaces calls to udelay() with usleep_range() in the fbtft=20
driver. This addresses checkpatch warnings and provides an upper bound to=20
allow the scheduler to coalesce timer interrupts.

> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb=
_ra8875.c
> index 0ab1de6647d07..d2400bb44f1c6 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
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
This isn't a bug introduced by this patch, but I noticed something about the
error handling in write_reg8_bus8() related to the SPI speed restore.

When par->fbtftops.write() fails earlier in this function, it returns=20
immediately:

if (ret < 0) {
        va_end(args);
        dev_err(par->info->device, "write() failed and returned %dn", ret);
        return;
}

Does this leave par->fbtftops.write permanently assigned to the slow
write_spi function? It appears that if a register write fails, the driver
never restores the fast fbtft_write_spi pointer, which might severely impact
the performance of all future bulk video memory writes.

[Severity: High]
This is also a pre-existing issue, but looking at the neighboring=20
write_vmem16_bus8() function in the same file:

write_vmem16_bus8() {
    ...
    txbuf16 =3D par->txbuf.buf + 1;
    ...
    for (i =3D 0; i < to_copy; i++)
        txbuf16[i] =3D cpu_to_be16(vmem16[i]);
}

Is there a risk of an alignment fault here? The txbuf16 pointer is assigned=
=20
an odd-aligned address (buf + 1). On architectures that do not support=20
unaligned memory access in hardware (which is common for systems with SPI=20
displays), would these 16-bit writes trigger a kernel panic? Should this=20
be using put_unaligned_be16() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714190958.2194=
37-2-graviaspanagiotis1@gmail.com?part=3D3
