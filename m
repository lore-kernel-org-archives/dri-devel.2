Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ECBCDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AB910F240;
	Thu, 25 Jun 2026 10:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="URbbyfK6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9018210F240
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:42:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5978C43B56;
 Thu, 25 Jun 2026 10:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E5A1F00A3D;
 Thu, 25 Jun 2026 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782384140;
 bh=WgVjSmtMrAD31UHQkee6LjkXqu1YoJ1FFKYGwbmSAkk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=URbbyfK6LcSEu1MoyjtAIJh6NX4nCszLeb6b8Ma/BNo59DEdQ9Ms6J+fAGqIU0ywb
 FoCDvtVYSwY+J7GDeP8JuA9XaghOZul4two7jKjRBoN/kxjNCyVtWKjk+SdTvZQEFt
 1/GEkv1S+KdL0192HGNBX9yKfNn/gA9WlKFOSN5fHc1MTYkTve+I3SykN/L06NG7AP
 hanFI/J64qMqTDNuKprrlLsiWeKlkcut8KcCjGElCcZuVAgYFnB6yGiLbt4nvH4uOu
 pc85Li4r3ord7RjqvQKliUNWS65OyEEceI9dMg+I8vYU3dRtaNkmkh1PbfkWm3+orX
 cNQrcJjVy60kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned access and buffer size
 when startbyte is used
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
References: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:42:19 +0000
Message-Id: <20260625104220.21E5A1F00A3D@smtp.kernel.org>
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
- [High] The patch fixes unaligned pointer dereferences in `fbtft_write_reg=
` macros but misses identical unaligned accesses in `fbtft_write_vmem16_bus=
8()` and `write_vmem16_bus8()` (in `fb_ra8875.c`).
--

commit 41bf3a5882f6fd09bf60fb5460097488d5497b06
Author: suryasaimadhu <suryasaimadhu369@gmail.com>

staging: fbtft: fix unaligned access and buffer size when startbyte is used

This commit addresses an unaligned memory access in fbtft-bus.c macros
by replacing direct pointer dereferences with put_unaligned() when
par->startbyte is used. It also corrects a buffer size calculation.

> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..0314e450799de 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
[ ... ]
> @@ -39,7 +40,7 @@ void func(struct fbtft_par *par, int len, ...)         =
                       \
>  		offset =3D 1;                                                   \
>  	}                                                                     \
>  									      \
> -	*buf =3D modifier((data_type)va_arg(args, unsigned int));              =
 \
> +	put_unaligned(modifier((data_type)va_arg(args, unsigned int)), buf);  \
>  	ret =3D fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,  =
 \
>  				 0);                                          \

[Severity: High]
This is a pre-existing issue, but does this same unaligned access pattern
exist in other functions that use startbyte?

Looking at fbtft_write_vmem16_bus8(), when par->startbyte is non-zero,
txbuf16 is offset by 1 byte and directly dereferenced:

drivers/staging/fbtft/fbtft-bus.c:fbtft_write_vmem16_bus8() {
        ...
        txbuf16 =3D par->txbuf.buf + 1;
        ...
        for (i =3D 0; i < to_copy; i++)
                txbuf16[i] =3D cpu_to_be16(vmem16[i]);
        ...
}

Could this direct 16-bit store to an odd-aligned address still trigger
kernel panics on strict-alignment architectures during video memory updates?

A similar pattern also appears to exist in the ra8875 driver where
txbuf16 is unconditionally offset by 1 byte:

drivers/staging/fbtft/fb_ra8875.c:write_vmem16_bus8() {
        ...
        txbuf16 =3D par->txbuf.buf + 1;
        ...
        for (i =3D 0; i < to_copy; i++)
                txbuf16[i] =3D cpu_to_be16(vmem16[i]);
        ...
}

Should these locations also be updated to use put_unaligned() to ensure
all unaligned accesses are caught by this fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625103041.2811=
90-1-suryasaimadhu369@gmail.com?part=3D1
