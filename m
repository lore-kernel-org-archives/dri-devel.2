Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF38C5DF66
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 01:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675AD10E037;
	Fri, 14 Aug 2026 01:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nWxbANdn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A320E10E037
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 01:51:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADFF9600AD;
 Fri, 14 Aug 2026 01:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4574D1F000E9;
 Fri, 14 Aug 2026 01:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786672263;
 bh=v0XsBy8hA676LX31DlmvN1MbsYMGAh6sFTQCH/+ztfQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nWxbANdn9+pJ3NBiiLf9w8wwlOxidOdStoqdw9cYL/IBUTduXKrhPso6WLo9EoCQ2
 sw9c2d/pOSc2WiRtw34Ua1TBz5QMAnrXs8CCkCsByrnIRK3k7k7onW7GIxDhdmuLAd
 NIOYSfAvBuUBuCrnt3BMfMvVsS+Ntv2zfotTzmE5xZWZrpegohWpu9YkKqq5jWFi6U
 oBAYmA8GSK495AoqIa533GDx51sydaOxC1W8xx9FiXw2XAoiIAKKnrdkrmef8Oxa1y
 0mT/W/NF42Y9n8rOWh5kPjzX+XDIGqxauMFiNlS4/IWKyW9i/ZQB8HGCdYlp55QbOM
 t62e4xskmvjfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/03] fbdev: maxine: make functions static
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813232934.2718291-2-rdunlap@infradead.org>
References: <20260813232934.2718291-1-rdunlap@infradead.org>
 <20260813232934.2718291-2-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:50:59 +0000
Message-Id: <20260814015103.4574D1F000E9@smtp.kernel.org>
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
- [Low] Making the entirely unused function `maxinefb_ims332_read_register`=
 static introduces a new `-Wunused-function` compiler warning.
--

--- Patch [1]: [PATCH 01/03] fbdev: maxine: make functions static ---
commit dbf41183475fd7e7f21a5345da1fcb01f0239170
Author: Randy Dunlap <rdunlap@infradead.org>

fbdev: maxine: make functions static

This commit makes three functions static in the maxinefb driver to resolve
missing prototype warnings since they are not exposed via a header file.

> diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinef=
b.c
> index 52528eb4dfb41..a9410a553113d 100644
> --- a/drivers/video/fbdev/maxinefb.c
> +++ b/drivers/video/fbdev/maxinefb.c
[ ... ]
> @@ -71,7 +71,7 @@ void maxinefb_ims332_write_register(int regno, register=
 unsigned int val)
>  	*((volatile unsigned short *) (wptr)) =3D val;
>  }
> =20
> -unsigned int maxinefb_ims332_read_register(int regno)
> +static unsigned int maxinefb_ims332_read_register(int regno)

[Severity: Low]
Does making this function static introduce a new -Wunused-function compiler
warning?=20

It appears maxinefb_ims332_read_register() is never called anywhere in the=
=20
codebase. Adding the static keyword to an unused function transforms the=20
previous missing prototype warning into an unused function warning, which=20
can break builds that enable CONFIG_WERROR.=20

Would it be better to remove this unused code entirely rather than marking
it static?

>  {
>  	register unsigned char *regs =3D (char *) MAXINEFB_IMS332_ADDRESS;
>  	unsigned char *rptr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813232934.2718=
291-1-rdunlap@infradead.org?part=3D1
