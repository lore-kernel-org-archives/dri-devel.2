Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0381C4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFCF10E07A;
	Tue, 14 Jul 2026 19:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dzMB0JYJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D4C10E07A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:33:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63A6F40B8C;
 Tue, 14 Jul 2026 19:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAD51F000E9;
 Tue, 14 Jul 2026 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784057616;
 bh=7m6dNZnf/89CMpn0yLcrIuJ16/Y51OvXQj0qnXcsQbg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dzMB0JYJOl3FZvYahMjaR0MAYaxsOW0zxEuMmOmTc8fIOMoJPb2FAwk8YXV12ktdx
 SohAG0TWe3Wa0xqGYobQ3amlk5g0rARnvse3pL6f8fI9rooOp0WMtLFCNoBh01ciXC
 kCn2copqdP6CouIWjYHvL5dzYCH4FqdWaG+gcw8ysBWJGp7SmTocC4cKW03THX2XG3
 CzsVw32OKoTTKH4eaZxIhnXz5DAsy8PMU4qcJIkET0Et6g4yPWxwYyP0GtUd/j2D6r
 80TapE9/ssGdrEq4xV0G8QkV4xV6S8ylPHQl/aFZ3Z24NSMCAEhrGZII/uLuNVBLU4
 eznhAmLzjlZwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] staging/fbtft: Remove prohibited space before close
 parenthesis
To: "Panagiotis Gravias" <graviaspanagiotis1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714190958.219437-4-graviaspanagiotis1@gmail.com>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
 <20260714190958.219437-4-graviaspanagiotis1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:33:35 +0000
Message-Id: <20260714193336.1BAD51F000E9@smtp.kernel.org>
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
- [High] Constructing and dereferencing unaligned 16-bit pointers causes un=
defined behavior and potential kernel panics on strict-alignment architectu=
res.
- [High] Incorrect SPI buffer size calculation transmits uninitialized memo=
ry when multiple parameters are sent with `startbyte` enabled.
--

--- Patch [1]: [PATCH 1/3] staging/fbtft: Remove prohibited space before cl=
ose parenthesis ---
commit b5aeca6fddf7088401c92f0dfc0d9c7d04fb863a
Author: Panagiotis Gravias <graviaspanagiotis1@gmail.com>

staging/fbtft: Remove prohibited space before close parenthesis

This commit cleans up a checkpatch error by removing a prohibited space
before the close parenthesis in the define_fbtft_write_reg macro
invocations.

> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..38697992f5e1b 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                       =
      \
>  EXPORT_SYMBOL(func);
> =20
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)

[Severity: High]
This is a pre-existing issue, but does expanding this macro for 16-bit
types like fbtft_write_reg16_bus16 create an unaligned pointer dereference?

In the define_fbtft_write_reg() macro definition, when a startbyte is used:

	if (par->startbyte) {
		*(u8 *)par->buf =3D par->startbyte;
		buf =3D (buffer_type *)(par->buf + 1);
		offset =3D 1;
	}

The pointer is advanced by 1 byte. When buffer_type is a 16-bit type, this
creates an odd-aligned pointer. Later, the macro writes to it:

	*buf =3D modifier((data_type)va_arg(args, unsigned int));

This can cause unaligned memory access faults and lead to kernel panics on
strict-alignment architectures. This same pattern also appears in
fbtft_write_vmem16_bus8() where par->txbuf.buf + 1 is cast to a 16-bit
pointer.

[Severity: High]
This is also a pre-existing issue within the same macro, but could the
SPI buffer size calculation send uninitialized memory?

When sending multiple parameters with a startbyte active, the macro packs
exactly one start byte followed by the parameters. However, the transmission
size is calculated as:

	if (len) {
		...
		fbtft_write_buf_dc(par, par->buf,
				   len * (sizeof(data_type) + offset), 1);
	}

Because offset is 1, if len is greater than 1, this calculates to
len * sizeof(data_type) + len, instead of the actual payload size of
1 + len * sizeof(data_type). Could this force the SPI core to transmit extra
uninitialized out-of-bounds bytes and potentially corrupt the display
controller's initialization state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714190958.2194=
37-2-graviaspanagiotis1@gmail.com?part=3D1
