Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F77CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 08:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0E710E5B0;
	Sun, 18 Oct 2026 08:58:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0B710E5B0
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 08:58:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64D3B4057D;
 Sun, 18 Oct 2026 08:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336A71F000C4;
 Sun, 18 Oct 2026 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792313924;
 bh=ueLNhszIhhEUnG+MWIbRaXbI+JkznJtidC3D3zLjzDE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GIJCyOjmD7hQixBcmbuiwwFa8f5As+YcIhVhj/JxBUrheyr3h9Dsad8zyQwHAjvO2
 WPBCvlAJvZ4Z3idLjBeD4v95EBE+PIUR0sgCfURBf52QZWQ3wUHu5IDfIT8+Lb4T+x
 NHInxSyt28/YSpl4qeBfo8YG3Bl5Fh892y2lyauWS6J/Zi1p6yTV+PsmsnlyzA+Iyf
 9lBIGTxFnq8U/rd6p6CorfKXbPIhA8s7ZlqcUexOoTdHQMggnoSTzdJ7cpLdRhWjqP
 dqobPvY2x7Q77m64wV4MgKi6C0474+pEZdDeS/yUOXD3XYQG/mo5Ucd9tDxW6Q+KSE
 78Kn4x4U+fbvw==
Message-ID: <sashiko-outbox-176013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: fix syntax errors in macros
To: wrmfwv@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261018085345.17619-1-wrmfwv@163.com>
References: <20261018085345.17619-1-wrmfwv@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 08:58:43 +0000
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
- [Low] staging: fbtft: missing argument in define_fbtft_write_reg() breaks=
 build
--

commit b28f14a98f84b888195dbf0a2f659dbf742f021c
Author: gtl-m <admin@micronull.cn>

staging: fbtft: fix syntax errors in macros

This commit removes trailing commas and spaces before closing parentheses in
two define_fbtft_write_reg() macro invocations to address checkpatch.pl
warnings.

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
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)

[Severity: Low]
Does removing the trailing comma break the build when CONFIG_FB_TFT is
enabled?

In drivers/staging/fbtft/fbtft-bus.c, define_fbtft_write_reg() is defined
as a 4-argument macro:

#define define_fbtft_write_reg(func, buffer_type, data_type, modifier)     =
   \
void func(struct fbtft_par *par, int len, ...)                             =
   \
{                                                                          =
   \
...
	*buf =3D modifier((data_type)va_arg(args, unsigned int));               \

For fbtft_write_reg8_bus8() and fbtft_write_reg16_bus16(), no byte-order
conversion modifier is needed, so the trailing comma intentionally passes an
empty fourth argument to the macro. Removing the comma passes only 3
arguments to a 4-parameter macro, causing the C preprocessor to fail the
build.

> =20
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018085345.1761=
9-1-wrmfwv@163.com?part=3D1
