Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B15CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A03410F1E2;
	Thu, 25 Jun 2026 09:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SAVEUCoF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747C910F1E2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:41:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5B9760018;
 Thu, 25 Jun 2026 09:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3703C1F000E9;
 Thu, 25 Jun 2026 09:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782380498;
 bh=YJM6HxXH8g3d2rMFU2qVmMGknrM18taxfpscqzNOiHE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SAVEUCoFL5MfPzcbKFm1koGcCK545AggU0mjuHxRrfgdN55d4ETLjiGYMAXSb3IGC
 wWvpIqRt6SmUeVjufMTHMin30QUbYMSRanRyekxy9WhaZ763hd20xXd7GtQc617HLs
 j1KY5Yz3I1mTfUs4wbVhBJkKZPjLery0FL1XmhxjVPrROHGMtwPFuEa88bZzsm7lXt
 EXrIJ0W1wBte9Nt6nArdEC4uR5eZ0e1XBiYeHtRMqOip9JXigS2JLF2GoQalcKFDGj
 87CrsFWMlthDL+lzqGwFTSqoIiOPrtBCEoutTvUgz5YV/hxSQ31Cakew8t8XAoM0MH
 Pa7TSE1X6irqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: replace empty modifier argument with
 no-op macro
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
References: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:41:37 +0000
Message-Id: <20260625094138.3703C1F000E9@smtp.kernel.org>
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
- [High] Incorrect buffer size calculation causes out-of-bounds read and in=
formation leak over SPI when `startbyte` is used.
- [High] Pointer arithmetic creates an unaligned pointer for 16-bit registe=
r writes when `startbyte` is used, causing an unaligned memory access.
--

commit 5efb24fc5a4ff6b0f2481a7887082d742684defc
Author: suryasaimadhu <suryasaimadhu369@gmail.com>

staging: fbtft: replace empty modifier argument with no-op macro

This commit defines an identity function fbtft_write_reg_no_modifier() and
uses it to replace empty modifier arguments in define_fbtft_write_reg()
macro calls to fix checkpatch errors.

> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..2169f8d1d1b83 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -11,6 +11,7 @@
>   *
>   ***********************************************************************=
******/
> =20
> +#define fbtft_write_reg_no_modifier(x) (x)
>  #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)  =
      \
>  void func(struct fbtft_par *par, int len, ...)                          =
      \
>  {                                                                       =
      \

[Severity: High]
This is a pre-existing issue, but does this pointer arithmetic create an
unaligned memory access on strict-alignment architectures?

When par->startbyte is non-zero, buf is advanced by one byte in
define_fbtft_write_reg():

	if (par->startbyte) {
		*(u8 *)par->buf =3D par->startbyte;
		buf =3D (buffer_type *)(par->buf + 1);
		offset =3D 1;
	}

Since buffer_type can be a 16-bit type like u16 or __be16 (for example, in
fbtft_write_reg16_bus8 or fbtft_write_reg16_bus16), adding 1 byte to the
aligned par->buf creates an odd address.

The code then dereferences this unaligned pointer:

	*buf =3D modifier((data_type)va_arg(args, unsigned int));

Could this trigger an alignment fault resulting in a kernel panic on
architectures that require strict alignment?

[ ... ]

> @@ -62,9 +63,9 @@ out:									      \
>  }                                                                       =
      \
>  EXPORT_SYMBOL(func);
> =20
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_write_reg_no=
_modifier)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_write_re=
g_no_modifier)

[Severity: High]
This is a pre-existing issue, but is there an out-of-bounds read when
calculating the length to send over SPI?

When startbyte is configured, offset is set to 1. The macro
define_fbtft_write_reg() uses the following size calculation for the final
transfer:

		fbtft_write_buf_dc(par, par->buf,
				   len * (sizeof(data_type) + offset), 1);

Because the parenthesis includes both sizeof(data_type) and offset, the size
grows too quickly. For example, with a len of 63, a 16-bit data_type, and an
offset of 1, the size evaluates to 63 * (2 + 1) =3D 189 bytes.

Does this result in reading past the end of par->buf and sending
uninitialized kernel heap memory to the display controller, potentially
causing a kernel panic if it crosses an unmapped page boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625092721.2383=
66-1-suryasaimadhu369@gmail.com?part=3D1
