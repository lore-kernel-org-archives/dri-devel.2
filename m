Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2922C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AE510E175;
	Mon, 21 Sep 2026 18:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ocZ2ukdp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB2E10E175
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:18:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28286407FD;
 Mon, 21 Sep 2026 18:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAF41F000FF;
 Mon, 21 Sep 2026 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790014712;
 bh=M7ateVFiPALYwzw8bgmJ2hJXH17NKXukdZYVGyvKoeE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ocZ2ukdpA/V+uSlpeWimTGVyXhUgRcNabCk3mSAWwhIGwsdqzgKo3HIu4+kPU+TVS
 8uIqHDVSuvVOkhv9W8+kGlVhF5e0FrsIjhDiDq93E56kAs/RTiBD49vXZDS6Nqe6nS
 iW8f0YjQxwoWQoX0xk8XkEK9mvLLrBOA1fEr+moD/8XQ69DOc7YfDJFtX9iv1Q3zdj
 6RIDj7VQU6PIEOrJuoe+d6tLR/ejEOlM9B0MkI1uxSHaD+M+sv7qrO5ywQ44/v2IMa
 aP3rvlxIO5KsWNrW7JcsmaXZ9nNAeBmy89CzFYP3+wzUvEwnbbSSvnrPlAoVis6mRt
 ii8EbbL1YIZ2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: fbtft-bus: remove space before close
 parenthesis
To: UgwuRhema <hikarialiyev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921181350.89925-1-hikarialiyev@gmail.com>
References: <20260921181350.89925-1-hikarialiyev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:18:31 +0000
Message-Id: <20260921181831.DDAF41F000FF@smtp.kernel.org>
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
- [Low] staging/fbtft: build failure due to missing macro argument
--

commit b334de9ec8bff5176150c0abed3949be6aea7f81
Author: UgwuRhema <hikarialiyev@gmail.com>

staging: fbtft: fbtft-bus: remove space before close parenthesis

This commit removes spaces before closing parentheses in fbtft-bus.c to fix
warnings from checkpatch.pl.

> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..409770891c548 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                       =
      \
>  EXPORT_SYMBOL(func);
> =20
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)

[Severity: Low]
Does this cause a build failure? The macro define_fbtft_write_reg is
defined to take exactly 4 parameters:

#define define_fbtft_write_reg(func, buffer_type, data_type, modifier)

Removing the trailing comma means the macro is now invoked with only 3
arguments, which violates C preprocessor rules and results in a fatal
compiler error.

>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)

[Severity: Low]
Does this also cause a preprocessor error for the same reason? The 4th
argument is missing here as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921181350.8992=
5-1-hikarialiyev@gmail.com?part=3D1
