Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D3DCD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 20:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7F610EB79;
	Sun,  7 Jun 2026 20:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e19wLFGO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A318C10EB79
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 20:33:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CB7243BC1;
 Sun,  7 Jun 2026 20:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDD21F00893;
 Sun,  7 Jun 2026 20:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780864385;
 bh=p1RJNXeAsGmR6+OwONxvRtLzxnGOBcZAT8e+XiwXko0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e19wLFGOjUSnw4bn72500gWCYhsz4VsZQ7iAz4WA9maXyZVntzAaU1td5L5w5DLfZ
 3L28grm+4LiRf8pnMBTv4l0bPz0CXo0NyX4ci+7/WBn+aZyfhg11khSbybcsPzbSpI
 Y1HVRn9NL0A12QcYaGisbVN3kneiy8gpuCvqKLpTeB4RGKZduXtRde3wZSqu3qqByg
 pgiH6v5CYqcgbIM1fBg968OSF/Hk15eRfV7k04beyrJtXJ/DUkcjDkg0BcLVgKI2Bc
 ZH7Aqm7vsusA7xaFIJPQ0hx3K76PWq4sE8KTFG34aILFqE8KNPOwRuXmcpSmDQ0ujy
 p18aOF5NTRfFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] staging: fbtft: fb_ra8875: prefer usleep_range over
 udelay
To: "Georgii Druzhinin" <ilovelinuxgames@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
References: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 20:33:04 +0000
Message-Id: <20260607203305.0BDD21F00893@smtp.kernel.org>
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
- [High] Missing restoration of `par->fbtftops.write` on early error paths =
in `write_reg8_bus8()` permanently degrades performance.
- [High] Unaligned 16-bit memory access when writing to the transmit buffer.
--

commit f7268afc18ac218fe8bb9a291f101fccad374b35
Author: Georgii Druzhinin <ilovelinuxgames@gmail.com>

staging: fbtft: fb_ra8875: prefer usleep_range over udelay

This commit replaces udelay(100) with usleep_range(100, 120) in
write_reg8_bus8() to avoid busy-waiting and allow the scheduler to
utilize the CPU during the delay.

> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb=
_ra8875.c
> index 0ab1de6647d07..6058934e2ca2c 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, in=
t len, ...)
>  	}

[Severity: High]
This is a pre-existing issue, but returning early in the error paths
above this code seems to skip restoring the write function pointer.

If the SPI write fails earlier in write_reg8_bus8(), we return directly:

write_reg8_bus8() {
        ...
        par->fbtftops.write =3D write_spi;
        ...
        ret =3D par->fbtftops.write(par, par->buf, 2);
        if (ret < 0) {
                va_end(args);
                dev_err(...);
                return;
        }
        ...
}

Does this leave the device in a permanently degraded state where all
subsequent operations use the unoptimized write_spi function instead
of restoring fbtft_write_spi at the end of the function?

>  	len--;
> =20
> -	udelay(100);
> +	usleep_range(100, 120);
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
> +	usleep_range(100, 120);
>  }

While reviewing this file, I also noticed another pre-existing issue in
write_vmem16_bus8() that might need attention:

[Severity: High]
This is a pre-existing issue, but does write_vmem16_bus8() cause unaligned
memory accesses on the transmit buffer?

The txbuf16 pointer is initialized by adding 1 to a void pointer:

write_vmem16_bus8() {
        ...
        txbuf16 =3D par->txbuf.buf + 1;
        ...
        for (i =3D 0; i < to_copy; i++)
                txbuf16[i] =3D cpu_to_be16(vmem16[i]);
        ...
}

Since par->txbuf.buf is a void pointer, adding 1 increments it by exactly
1 byte, making the address strictly odd.

Will the subsequent 16-bit writes in the loop cause an alignment fault on
strict-alignment architectures like older ARM or MIPS often targeted by
these display drivers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607201708.8864=
4-1-ilovelinuxgames@gmail.com?part=3D1
