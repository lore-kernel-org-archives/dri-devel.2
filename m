Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAA5CD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 20:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE0B10E0D5;
	Sun,  7 Jun 2026 20:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="geQfM2BU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4108410E0D5
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 20:20:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAE5C60018;
 Sun,  7 Jun 2026 20:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8D01F00893;
 Sun,  7 Jun 2026 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780863652;
 bh=VtMoXtK5hH8h11VyuptKLp9vqOVjFjWzsDQBrcNWirk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=geQfM2BUBNyi9ABc/TmEM5mslMKLRoVP8KEqiaksl9E4USIclnQ3VanDZtOsuq8OS
 PhT9QgoK3b3OXqLW3TFBorJ6hUIFTOAMKrGvpqDzjy41xcJj1UaBOSny75Y7rsQr40
 YpQatHP8XhGnZDGGPrgyE3hthgqEPBDaNSBHD+fX1FCFspL9atRpCmDATuRWJ1hhH4
 IVJ+DD19Xj0J+KAHWbEQnm5XMAS7bWX7dA6jXBQNqt/FH8zbGsW1cfvs+0WZHgz76p
 LbsZf2IODEiBs2DWbbXchSLteqlJtMo85zMgEzWANrFBKMqZPi9fzFJdf5oljnqN6m
 o2wKX/eG1TV9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] staging: fbtft: fbtft-bus: remove prohibited space
 before close parenthesis
To: "Georgii Druzhinin" <ilovelinuxgames@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260607201708.88644-2-ilovelinuxgames@gmail.com>
References: <20260607201708.88644-2-ilovelinuxgames@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 20:20:51 +0000
Message-Id: <20260607202052.3D8D01F00893@smtp.kernel.org>
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
- [Low] Removing the trailing comma from macro invocations results in passi=
ng 3 arguments to a 4-argument macro, breaking the build.
--

commit 4aa037560eff822608a285dbbf3f02e9ec0544be
Author: Georgii Druzhinin <ilovelinuxgames@gmail.com>

staging: fbtft: fbtft-bus: remove prohibited space before close parenthesis

This commit attempts to resolve a checkpatch.pl formatting warning by
removing what appears to be an empty argument and trailing comma from calls
to the define_fbtft_write_reg macro.

> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> index 30e436ff19e4c..409770891c548 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
[ ... ]
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                       =
      \
>  EXPORT_SYMBOL(func);
> =20
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)

[Severity: Low]
Does removing this comma break the build?=20

The define_fbtft_write_reg macro is defined to take exactly four parameters:
func, buffer_type, data_type, and modifier. By removing the trailing comma,
only three arguments are passed to the macro. This will result in a
preprocessor error for passing too few arguments.

>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)

[Severity: Low]
Will this invocation also fail to compile for the same missing argument
reason?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607201708.8864=
4-1-ilovelinuxgames@gmail.com?part=3D2
