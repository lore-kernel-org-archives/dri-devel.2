Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A558C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A51010E0B1;
	Thu,  3 Sep 2026 07:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mQEufEq/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8734410E0B1
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:47:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA89B600D1;
 Thu,  3 Sep 2026 07:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C471F000E9;
 Thu,  3 Sep 2026 07:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788421677;
 bh=W4elmSmQ2ag9PwsqDzimP/rXHzqd1LW2OEQNDN54L1M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mQEufEq/ndFRYBhkxQnEzd1mBPqOeOg3gLjrNGBRUC+sFj3UyPdEsaKeL2WwENoOF
 7CJhhGY7MwPIbA3LKM4K/PigStzsap+WAZLfiBPYXXKb88ukUL5OIHzKaAVQhdCybE
 2l9UkIMp4hAIdiFer225nYnefh0Auc3gekzj3x3I5sIFXyTG3qPdAFXK2rVCsRUDof
 k4E3B687j3LpXbFxUCE0c+5VVXGRcbFle0bAIPSJBU07yL/Q333TO57LvcFaKGpD+f
 3SzF6XX/dnI9Aq5edL3KPz6kNrKwRSzp6/87yLQPjyF7yVnngggqFcxH9zDOaaJL3a
 crbNKokw0xVew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
To: "Anshika Jain" <anshikajain196872@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902045026.7442-1-anshikajain196872@gmail.com>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:47:56 +0000
Message-Id: <20260903074757.51C471F000E9@smtp.kernel.org>
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
- [High] Incorrect transfer size calculation in `define_fbtft_write_reg` ca=
uses an out-of-bounds read of `par->buf` and transmits uninitialized memory.
- [High] Unaligned pointer dereference in `define_fbtft_write_reg` when `st=
artbyte` is used with 16-bit data types.
--

commit fc3573259bc5556dbb41e0e35027f130ca8f6b63
Author: Anshika Jain <anshikajain196872@gmail.com>

staging: fbtft: fix len<=3D0 buffer overflow in define_fbtft_write_reg()

If len is 0 or negative when a define_fbtft_write_reg()-generated
function is called, len-- underflows to -1, causing the subsequent
while (i--) loop to run approximately 2^31 times and write far past
the end of buf.

Link: https://sashiko.dev/#/patchset/20260830161529.14500-1-anshikajain1968=
72@gmail.com?part=3D1

> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..0927877249e74 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -19,6 +19,9 @@ void func(struct fbtft_par *par, int len, ...)         =
                       \
>  	int offset =3D 0;                                                      =
 \
>  	buffer_type *buf =3D (buffer_type *)par->buf;                          =
 \
>  									      \
> +	if (len <=3D 0)                                                        =
 \
> +		return;                                                       \
> +									      \

[Severity: High]
This is a pre-existing issue, but I noticed an unaligned pointer dereference
when startbyte is used with 16-bit data types in define_fbtft_write_reg().

When par->startbyte is true, buf is assigned an offset address:

    if (par->startbyte) {
        *(u8 *)par->buf =3D par->startbyte;
        buf =3D (buffer_type *)(par->buf + 1);
        offset =3D 1;
    }

Since par->buf is an aligned allocation, adding 1 byte produces an odd
(unaligned) memory address. When buffer_type is a 16-bit type (e.g., __be16=
),
operations later in the function perform unaligned 16-bit stores:

    *buf =3D modifier((data_type)va_arg(args, unsigned int));
    ...
    *buf++ =3D modifier((data_type)va_arg(args, unsigned int));

On strict-alignment architectures, this could trigger an alignment fault and
lead to a kernel panic. Should this use the put_unaligned() family of helpe=
rs
instead?

[Severity: High]
This is also a pre-existing issue, but is the transfer size calculation in
define_fbtft_write_reg() causing an out-of-bounds read of par->buf?

The macro computes the buffer size to transmit via fbtft_write_buf_dc() as:

    fbtft_write_buf_dc(par, par->buf,
                       len * (sizeof(data_type) + offset), 1);

Because of the parentheses, this incorrectly multiplies the offset by the
remaining length instead of calculating len * sizeof(data_type) + offset.

For example, if the device tree enables the startbyte property for a display
using a 16-bit write_reg macro, len can reach 64 during fbtft_init_display(=
).
After decrementing, len =3D 63, offset =3D 1, and sizeof(u16) =3D 2. This r=
esults
in calculating an outbound transmission of 189 bytes.

Since par->buf is allocated as exactly 128 bytes, this reads past the end
of the buffer. Could this leak adjacent SLUB objects to the SPI hardware and
corrupt the display initialization sequence with garbage data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902045026.7442=
-1-anshikajain196872@gmail.com?part=3D1
