Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C27CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF5910F272;
	Thu, 25 Jun 2026 11:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JOBNGHal";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D9610E209
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:16:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2E4260018;
 Thu, 25 Jun 2026 11:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438761F000E9;
 Thu, 25 Jun 2026 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782386162;
 bh=7elxOrSoxphV1JlBy+bW2qPFP02wnv6Q1WL1ahz+jSk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JOBNGHala55kZ8eZQaXxGhqsFfj/U1ZSIr8CsEOWc9YLEXleDu7RR5hUOONNzqM7Z
 V/FNuszgrSb7F9tTCpDMUbNaFTNKnPdPiqESGTpHTvJcm7RIrjgsbuH72TPVak8IM8
 ZQ8iu0/F+g8VsIdDHe8L5bIlzSmKETZ25LzjlEcK9ObTO+vG38pHH5Z0Ip2zDQn8u5
 NEyar8fQaclIT602wx85zV8QyaQ7rNHo800Dg0j80MftXkSTKUAXks3I8iscX1uPxu
 sGXX4TKp+VRKaFOq/NQ4J21dzqz3u45Y0ld+IjH2SVdDd6grN8nv9fp781/CNXGkiM
 7Pvph57D3tbBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is
 byte-offset
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625110237.304435-1-suryasaimadhu369@gmail.com>
References: <20260625104220.21E5A1F00A3D@smtp.kernel.org>
 <20260625110237.304435-1-suryasaimadhu369@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 11:16:01 +0000
Message-Id: <20260625111602.438761F000E9@smtp.kernel.org>
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
- [Low] Missing `#include <linux/unaligned.h>` in `fbtft-bus.c`.

Pre-existing issues:
- [High] Unaligned memory stores in `define_fbtft_write_reg` macro when `st=
artbyte` is used.
- [High] An integer underflow in `tx_array_size` leads to an out-of-bounds =
heap write if the `txbuflen` device property is set to a small value.
- [High] Missing NULL check for `par->txbuf.buf` in `fb_ra8875.c` leads to =
a NULL pointer dereference on Big Endian systems.
--

commit 57041cf8757e7586efa49957106ff7e0611f087c
Author: suryasaimadhu <suryasaimadhu369@gmail.com>

staging: fbtft: fix unaligned vmem writes when txbuf is byte-offset

This commit addresses unaligned memory access in the fbtft driver. It
updates write_vmem16_bus8() in both fb_ra8875.c and fbtft-bus.c to use
put_unaligned() when storing 16-bit pixel data.

> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb=
_ra8875.c
> index 0ab1de6647d07..5b95b00953994 100644
> --- a/drivers/staging/fbtft/fb_ra8875.c
> +++ b/drivers/staging/fbtft/fb_ra8875.c
> @@ -10,6 +10,7 @@
>  #include <linux/delay.h>
> =20
>  #include <linux/gpio/consumer.h>
> +#include <linux/unaligned.h>
>  #include "fbtft.h"
> =20
>  #define DRVNAME "fb_ra8875"

[Severity: High]
This is a pre-existing issue, but does write_vmem16_bus8() have a potential
null pointer dereference here?

fb_ra8875.c:write_vmem16_bus8() {
    ...
    txbuf16 =3D par->txbuf.buf + 1;
    tx_array_size -=3D 2;
    *(u8 *)(par->txbuf.buf) =3D 0x00;
    ...
}

If the txbuflen device property is 0, par->txbuf.buf remains null on big
endian systems because the fallback allocation is gated by a little endian
check.

Could this cause a crash when assigning 0x00 unconditionally?


[Severity: High]
This is a pre-existing issue, but could tx_array_size underflow and cause
an out-of-bounds heap write?

fb_ra8875.c:write_vmem16_bus8() {
    ...
    tx_array_size =3D par->txbuf.len / 2;
    txbuf16 =3D par->txbuf.buf + 1;
    tx_array_size -=3D 2;
    ...
    while (remain) {
        to_copy =3D min(tx_array_size, remain);
    ...
}

If par->txbuf.len is set to a small value like 2 via the device tree,
tx_array_size evaluates to 1. Subtracting 2 causes it to underflow to a
huge value.

Would the min() check then just use remain, causing the loop to write past
the end of the allocated heap buffer?

> @@ -262,7 +263,7 @@ static int write_vmem16_bus8(struct fbtft_par *par, s=
ize_t offset, size_t len)
>  			to_copy, remain - to_copy);
> =20
>  		for (i =3D 0; i < to_copy; i++)
> -			txbuf16[i] =3D cpu_to_be16(vmem16[i]);
> +			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
> =20
>  		vmem16 =3D vmem16 + to_copy;
>  		ret =3D par->fbtftops.write(par, par->txbuf.buf,
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..9e25c19ec9ada 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c

[Severity: High]
This is a pre-existing issue, but does the define_fbtft_write_reg macro
also suffer from unaligned stores?

fbtft-bus.c:define_fbtft_write_reg() {
    ...
    if (par->startbyte)
        *buf++ =3D par->startbyte | (((size & 0xF) + 1) << 4);
    ...
    *buf =3D modifier((data_type)va_arg(args, unsigned int));
    ...
}

If par->startbyte is used, buf is offset by 1 byte. If data_type is a
16-bit type, would this dereference create a misaligned store and fault
on strict-alignment architectures?


[Severity: High]
This is a pre-existing issue, but fbtft_write_vmem16_bus8() shares the same
integer underflow behavior as fb_ra8875.c:

fbtft-bus.c:fbtft_write_vmem16_bus8() {
    ...
    tx_array_size =3D par->txbuf.len / 2;
    if (par->startbyte) {
        ...
        tx_array_size -=3D 2;
    ...
    while (remain) {
        to_copy =3D min(tx_array_size, remain);
    ...
}

Could this similarly overwrite memory beyond the heap buffer if a small
txbuflen is provided?

> @@ -154,7 +154,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, si=
ze_t offset, size_t len)
>  			to_copy, remain - to_copy);
> =20
>  		for (i =3D 0; i < to_copy; i++)
> -			txbuf16[i] =3D cpu_to_be16(vmem16[i]);
> +			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);

[Severity: Low]
Does this file need to include linux/unaligned.h?

Since the header was included in fb_ra8875.c but not added here, could
this cause build failures on architectures where put_unaligned() isn't
transitively included by other headers?

> =20
>  		vmem16 =3D vmem16 + to_copy;
>  		ret =3D par->fbtftops.write(par, par->txbuf.buf,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625110237.3044=
35-1-suryasaimadhu369@gmail.com?part=3D1
