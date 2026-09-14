Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78432C88E6A
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800B210E189;
	Mon, 14 Sep 2026 09:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YtmLlm7G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6795510E189
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35F9243734;
 Mon, 14 Sep 2026 09:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25171F00893;
 Mon, 14 Sep 2026 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789377365;
 bh=OQ+t5MfXJMdKCqvcbYdcd57vS8CW/SpMIJbuFEd7BBs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YtmLlm7GinyFBceukm5sVNdwF/uGxhYt+TamEqlDVp0aV07+bRYKXty1mmA5t+rIW
 mExZBITiw73xeg5oDo+UppM7kucu6P0k4js9kExoCFgWy0rfDDmFT15tcuqRdzPbap
 HI2DM392TI3PTHSHt5ZmFoHFdFgbGjAbp4I0u8fkpcQ3sTkJS2DE3ZquCge69oojdw
 mOORtERgMztCRxVnQEDGAXX7U+DSaF9nG59aebckY4mzbT9UXZVY1M2AHuli3af9iI
 L8M2vkORc3Hp9xL8NOP8tLJz8MYKpEmQoRdDF0vD07IKTwxARoeAeWfTGCkcAu4U1l
 n+t0VGZl5e9UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: replace number with sizeof()
To: "Manuel Ebner" <manuelebnerli@mailbox.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914090858.9939-2-manuelebnerli@mailbox.org>
References: <20260914090858.9939-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:16:04 +0000
Message-Id: <20260914091604.E25171F00893@smtp.kernel.org>
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

New issues:
- [Medium] Replacing the literal buffer size of 8 with `sizeof(u64)` for a =
`u8` array obfuscates the code and fails to achieve its stated goal of prev=
enting truncation.

Pre-existing issues:
- [High] Using stack-allocated variables for SPI transfer buffers violates =
DMA rules and can cause memory corruption or kernel panics.
--

commit fbd50c90250b51626379149887d48d7f5eeb3c1e
Author: Manuel Ebner <manuelebnerli@mailbox.org>

staging: fbtft: replace number with sizeof()

This commit attempts to replace a literal integer with sizeof() to prevent
future truncation bugs in read_devicecode().

> diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/f=
b_ili9320.c
> index 050fc2367c122..41a3ae2f39571 100644
> --- a/drivers/staging/fbtft/fb_ili9320.c
> +++ b/drivers/staging/fbtft/fb_ili9320.c
> @@ -21,7 +21,7 @@
> =20
>  static unsigned int read_devicecode(struct fbtft_par *par)
>  {
> -	u8 rxbuf[8] =3D {0, };
> +	u8 rxbuf[sizeof(u64)] =3D {0, };

[Severity: High]
This is a pre-existing issue, but rxbuf is allocated on the stack and passed
down to the SPI subsystem for DMA via par->fbtftops.read(). This leads to
fbtft_read_spi() which also allocates txbuf on the stack:

drivers/staging/fbtft/fbtft-io.c:fbtft_read_spi() {
    ...
    u8 txbuf[32] =3D { 0, };
    ...
    ret =3D spi_sync(par->spi, &m);
    ...
}

Calling spi_sync() with stack-backed SPI transfers violates DMA mapping rul=
es
and can cause memory corruption or kernel panics, especially with
CONFIG_VMAP_STACK enabled.

[Severity: Medium]
Also, does sizing a u8 array using sizeof(u64) obfuscate the code? This see=
ms
semantically incorrect and fails to achieve the stated goal of preventing
truncation.

> =20
>  	write_reg(par, 0x0000);
>  	par->fbtftops.read(par, rxbuf, 4);

[Severity: Medium]
Does this read operation still use a hardcoded length of 4 instead of deriv=
ing
it dynamically from the buffer size (e.g., via ARRAY_SIZE())? Since the len=
gth
is hardcoded, it appears no truncation protection was actually added.

>  	return (rxbuf[2] << 8) | rxbuf[3];
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914090858.9939=
-2-manuelebnerli@mailbox.org?part=3D1
