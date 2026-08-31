Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8B4C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F3910E264;
	Mon, 31 Aug 2026 07:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ijo0M/Ef";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A57110E264
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:07:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A622601DB;
 Mon, 31 Aug 2026 07:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E750A1F000E9;
 Mon, 31 Aug 2026 07:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788160075;
 bh=Fk/qwSU2IChLyQK1mCFtmJA0Ki7zgOhYr5yU+IMp2mA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ijo0M/EfsdZJZm0eVLv8qJK2CNATfOZnPhzZ+/KTGT/Aaisl9TYPLlcKmQ/Is3zwD
 BEpH7auYdvV36HxqLBwmFcgI9Df+YHEYUUeXWw03tZWHyi3xcwRG1+TeWhLaX5E5rq
 8OGHsQLVIn+Ka8wKZ5zG6U6iwCa8kMz5uWEvAJRitbONEmVHgm/zOndaIOmO8cXLt+
 ruhO/3V+PdFR+QgtHLpQKVeEDkad8PObPKUWB55+gVidUOZEeKMIgZ9aj0tnBIF/VF
 37djdIF1BtXaC7mrhFEzNvqtOuAuhUo3p1E1D4lzTGyePuZWCzu6St+CS8SCuzYLsb
 qevIBLAFXzKMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: name the no-op endian modifier in
 define_fbtft_write_reg()
To: anshika <anshikajain196872@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260830161529.14500-1-anshikajain196872@gmail.com>
References: <20260830161529.14500-1-anshikajain196872@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:07:54 +0000
Message-Id: <20260831070754.E750A1F000E9@smtp.kernel.org>
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
- [High] The define_fbtft_write_reg macro causes a massive buffer overflow =
and infinite loop if called with len <=3D 0.
--

commit 058014a775580331d36d8dfcf906e23ec27ea3e9
Author: anshika <anshikajain196872@gmail.com>

staging: fbtft: name the no-op endian modifier in define_fbtft_write_reg()

This commit defines cpu_to_cpu_endian() to act as an explicit no-op endian
modifier. It replaces empty macro arguments in define_fbtft_write_reg()
instantiations to resolve checkpatch warnings about fragile macro usage.

Link: https://lkml.iu.edu/hypermail/linux/kernel/2602.0/01917.html

> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..e03aa251c452a 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c

[ ... ]

> @@ -62,9 +63,9 @@ out:									      \
>  }                                                                       =
      \
>  EXPORT_SYMBOL(func);
> =20
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, cpu_to_cpu_endian)

[Severity: High]
This isn't a bug introduced by this patch, but since you are modifying these
macro instantiations, I noticed a potential problem in the generated functi=
ons.

If any driver path invokes a generated function (such as fbtft_write_reg8_b=
us8)
with len <=3D 0, could it cause an infinite loop and an overflow on buf?

Inside the define_fbtft_write_reg() macro, there is no bounds check for=20
len <=3D 0 before decrementing it:

	len--;
=09
	if (par->startbyte)
		*(u8 *)par->buf =3D par->startbyte | 0x2;
	=09
	if (len) {
		i =3D len;
		while (i--)
			*buf++ =3D modifier((data_type)va_arg(args,
							    unsigned int));
	}

If len is <=3D 0, decrementing len underflows to -1. The check for if (len)
evaluates to true, and while (i--) will execute roughly 4 billion times,
writing out-of-bounds on each iteration.

Unlike fbtft_write_reg8_bus9(), which safely aborts on len <=3D 0, this mac=
ro=20
seems to lack a basic bounds check. Should an early check for len <=3D 0 be
added to the macro to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830161529.1450=
0-1-anshikajain196872@gmail.com?part=3D1
