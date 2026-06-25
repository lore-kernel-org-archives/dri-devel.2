Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A31ACDE007
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52BD10E1E7;
	Thu, 25 Jun 2026 11:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fDY1/fcM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EEB10E1E7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:54:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 939B860139;
 Thu, 25 Jun 2026 11:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0E91F000E9;
 Thu, 25 Jun 2026 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782388456;
 bh=44cNFSKoutWoH8F9UqLBKH4h09yIebj+MSyAZ1yLiS4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fDY1/fcMJT2C1Z6LH9JAEllcdTBHHj79HljgMsnzoYLYs4oOXSa0QlPsewX1r5tGt
 tlMLsnlbdqELHag7qIRx4SYTBGIHE9hjJpa4bLddK+HA8A1jQrSlwW/aHJdMv6RzVp
 4hlISTR8JId3M3ELodyZb3TDz+TYAqn2sxbGkEepZp+uXw5bC+NXDURyoUNy8WGIs1
 p18DgMMlmsm7gkEabUT9BUq0EvmG5dcsQr4KSgYG5olWlLha3gtkPSJUO2hwD23oga
 OkVlSp3YQ0wgEocvRUuwa3YQ7rrOChBA9Z85buD5rckUYHTAkCjZRA00YMq1YnseOA
 mhjr9sq2gATvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned access and txbuf safety
 issues
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625114215.325973-1-suryasaimadhu369@gmail.com>
References: <20260625111602.438761F000E9@smtp.kernel.org>
 <20260625114215.325973-1-suryasaimadhu369@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 11:54:15 +0000
Message-Id: <20260625115416.1A0E91F000E9@smtp.kernel.org>
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
- [High] Hardware protocol violation in unbuffered SPI write fallback paths.
--

commit 3d08e05dccbf9cbe108bf3c042c710ace7899fe1
Author: suryasaimadhu <suryasaimadhu369@gmail.com>

staging: fbtft: fix unaligned access and txbuf safety issues

This commit fixes unaligned access issues during register writes and pixel
data copies in the fbtft driver. It also adds bounds checking and fallbacks
for when the transmit buffer size underflows or is missing.

> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb=
_ra8875.c
> index 0ab1de6647d07..06f650aacc204 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -250,7 +251,14 @@ static int write_vmem16_bus8(struct fbtft_par *par, =
size_t offset, size_t len)
> =20
>  	remain =3D len / 2;
>  	vmem16 =3D (u16 *)(par->info->screen_buffer + offset);
> +
> +	if (!par->txbuf.buf)
> +		return par->fbtftops.write(par, vmem16, len);
> +
>  	tx_array_size =3D par->txbuf.len / 2;
> +	if (tx_array_size <=3D 2)
> +		return par->fbtftops.write(par, vmem16, len);
> +

[Severity: High]
Does this fallback bypass the 0x00 command prefix required by the RA8875
hardware?

Since vmem16 points directly to the framebuffer memory, this direct write
will omit the prefix, which might cause the display controller to
misinterpret the first pixel as a command.

Additionally, could this skip the cpu_to_be16() conversion on
little-endian CPUs, sending pixels in the wrong byte order?

Would it be safer to return an error if the required transmission buffer
is unavailable or too small to prepend the hardware protocol prefix?

>  	txbuf16 =3D par->txbuf.buf + 1;
>  	tx_array_size -=3D 2;
>  	*(u8 *)(par->txbuf.buf) =3D 0x00;

[ ... ]

> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..52a0c5c0cbaed 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c

[ ... ]

> @@ -142,19 +146,24 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, =
size_t offset, size_t len)
>  	tx_array_size =3D par->txbuf.len / 2;
> =20
>  	if (par->startbyte) {
> +		if (tx_array_size <=3D 2)
> +			return par->fbtftops.write(par, vmem16, len);

[Severity: High]
Does this skip prepending the par->startbyte prefix when the buffer is
too small, despite the prefix being explicitly required?

Like the RA8875 case above, this fallback bypasses both the command
prefix and endianness conversions.

>  		txbuf16 =3D par->txbuf.buf + 1;
>  		tx_array_size -=3D 2;
>  		*(u8 *)(par->txbuf.buf) =3D par->startbyte | 0x2;
>  		startbyte_size =3D 1;
>  	}
> =20
> +	if (!tx_array_size)
> +		return par->fbtftops.write(par, vmem16, len);
> +

[Severity: High]
Could this result in the same issue of bypassing necessary prefixes and
endianness conversions if tx_array_size evaluates to zero?

Should we return an error instead of silently sending incorrectly
formatted data?

>  	while (remain) {
>  		to_copy =3D min(tx_array_size, remain);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625114215.3259=
73-1-suryasaimadhu369@gmail.com?part=3D1
