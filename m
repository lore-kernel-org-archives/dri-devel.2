Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCAAC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49AE410E3E1;
	Sat, 18 Jul 2026 18:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LgRaqfpl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D72210E3E1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:29:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D441843D4D;
 Sat, 18 Jul 2026 18:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EC01F000E9;
 Sat, 18 Jul 2026 18:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784399394;
 bh=9szMFWzEdcokBl7SvTf0BxAkqegNcWwYzKhsXZZTDw0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LgRaqfplfMKShL6X/5dGII9OADTuaQ62dEsOwVBV7TAZuUceu2gVnl1f1qQJv/D51
 ecfflCC/ujgqLn88IWbwzzEMoAh0zULnD6uSfydxgzwFvrE/Wu7Cv/PDcq2b6cSZWW
 tQPmHmq58dd56k4AZIGCfdWZWdt0RddElXa88x4Nk7g7+LLRAvIyizfkkXAQMYPVtk
 6Bq/cQ+RWynGgu5cYPGVMRtOJTympYkNFCi5VUU5ilL+fxDQUHxahksoLAovT+NX+g
 xRsMCtJ4GvNkWNYqXLDCVpQr2+DZ4eMq2U1A6AIEbdMxgX9H4Kr2GcWrSV8tl1FldI
 aKp3jn+a5purw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c
To: Shivesh <chanelshivesh@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <6a5bc4a7.f1c1923d.2d2b59.05d9@mx.google.com>
References: <6a5bc4a7.f1c1923d.2d2b59.05d9@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 18:29:54 +0000
Message-Id: <20260718182954.92EC01F000E9@smtp.kernel.org>
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
- [Low] Removing the trailing comma from the `define_fbtft_write_reg` macro=
 invocations reduces the number of arguments passed from 4 to 3. Since the =
macro is defined with exactly 4 parameters, this will cause a C preprocesso=
r build failure.
--

--- Patch [1]: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c=
 ---
commit 282c7bb2732808bae2a5a39160285600d23aa964
Author: Shivesh <chanelshivesh@gmail.com>

staging: fbtft: fix checkpatch errors in fbtft-bus.c

This commit attempts to fix space-related checkpatch errors in fbtft-bus.c.
It does this by removing the trailing comma from macro invocations when the
modifier argument is empty.

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
Does removing the trailing comma here cause a build failure?

The define_fbtft_write_reg macro is defined earlier in the file to mandate
exactly 4 parameters:

#define define_fbtft_write_reg(func, buffer_type, data_type, modifier)

By removing the comma, the invocation for 8-bit bus writes only provides 3
arguments instead of 4, which will cause a C preprocessor error.

>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)

[Severity: Low]
Similarly, will this invocation fail to compile since it also drops the
argument count to 3 instead of the required 4?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6a5bc4a7.f1c1923d.2=
d2b59.05d9@mx.google.com?part=3D1
