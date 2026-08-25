Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6602BC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C177610E9DF;
	Tue, 25 Aug 2026 10:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ayqujR6/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE8710E9DF
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:54:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 793864139C;
 Tue, 25 Aug 2026 10:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B60D1F000E9;
 Tue, 25 Aug 2026 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787655270;
 bh=QBr5J++VdKuQH3Rum1uVfmll38hOh3aXMig1dbA6uZQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ayqujR6/1yNpZggauup+HvNmTxFDlLyE0/h/F8+M8iLB+S8bfB/qgsl4r7PP9/71m
 CXVJFBmjY9yNsiXZy/Axp0jWEKFEhLtBObRM6Gnq2kfzuKFfX0xyV1MMk3UsQWuCf7
 4AxsU8pT3OxSrSDpMp/ruHHvY54RQeHQ3/AO0pIFnKrPaK6qZ6UYaAoTEY4EZ+wtHl
 1YPrJYH9VFpUDDW8LVo3vmQLOmr4eTpzTMFmKda7lIEe8TuymO9Qi30ldsp+YW+c8O
 BDImRgnE0e19pELRt9Vo49mVYCMheLq9+hrsXswM08Xgj20x8r8p7NpAJb0xOz2gez
 vythoZahc72/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sysfb: ofdrm: Fix integer overflow in fb_size
 calculation
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825104134.669676-1-oushixiong1025@163.com>
References: <20260825104134.669676-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:54:29 +0000
Message-Id: <20260825105430.3B60D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver accepts any non-zero `linebytes` from the Device Tree w=
ithout ensuring it is at least as large as `width * bytes_per_pixel`.
- [High] The 64-bit result of `drm_format_info_min_pitch()` is silently tru=
ncated when assigned to the 32-bit `int linebytes` variable.
- [High] The `round_up(fb_size, PAGE_SIZE)` calculation can overflow to 0 o=
n 32-bit systems, leading to an undersized memory mapping.
- [High] On 32-bit architectures with 64-bit physical addresses (PAE/LPAE),=
 passing a 64-bit size to `ioremap` via `devm_ioremap` truncates it to a 32=
-bit `size_t`.
--

--- Patch [1]: [PATCH] drm/sysfb: ofdrm: Fix integer overflow in fb_size ca=
lculation ---
commit ad44f8947b62f451f5098acf1a574e6b16699aa6
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation

The framebuffer size calculation fb_size =3D linebytes * height can
overflow when both values are large (e.g., 46341 * 46341 > INT_MAX).
Since linebytes and height are both int types, the multiplication is
performed as int * int, which results in undefined behavior on overflow.

Use check_mul_overflow() to detect and prevent this overflow, consistent
with the approach used in simpledrm.c and corebootdrm.c.

> diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
> index 819aed466727e..a6dc34b9ec0f3 100644
> --- a/drivers/gpu/drm/sysfb/ofdrm.c
> +++ b/drivers/gpu/drm/sysfb/ofdrm.c
> @@ -913,7 +914,10 @@ static struct ofdrm_device *ofdrm_device_create(stru=
ct drm_driver *drv,
>  			return ERR_PTR(-EINVAL);
>  	}
> =20
> -	fb_size =3D linebytes * height;
> +	if (check_mul_overflow(linebytes, height, &fb_size)) {

[Severity: High]
This isn't a bug introduced by this patch, but does drm_format_info_min_pit=
ch()
called earlier in this function return a 64-bit value that is silently trun=
cated
when assigned to the 32-bit int linebytes variable?

	if (!linebytes) {
		linebytes =3D drm_format_info_min_pitch(format, 0, width);
		if (drm_WARN_ON(dev, !linebytes))
			return ERR_PTR(-EINVAL);
	}

If width is maliciously large (e.g., 0x40000001), the 64-bit result could be
truncated to 4, bypassing the !linebytes check and the new check_mul_overfl=
ow()
check.

[Severity: High]
This is a pre-existing issue, but is there a missing lower bound check for
linebytes in the same block above?=20

If the Device Tree provides a maliciously small but non-zero linebytes (e.g=
., 4),
it bypasses the !linebytes check. It would also pass the new
check_mul_overflow() check but could cause out-of-bounds memory writes
downstream when DRM plane updates write data based on the logical width.

[Severity: High]
This is a pre-existing issue, but on 32-bit systems where resource_size_t is
32-bit, could round_up(fb_size, PAGE_SIZE) computed later in this function
overflow and wrap around to 0?

	fb_pgbase =3D round_down(fb_base, PAGE_SIZE);
	fb_pgsize =3D fb_base - fb_pgbase + round_up(fb_size, PAGE_SIZE);

If fb_size is near U32_MAX, the overflow check succeeds, but this calculati=
on
would result in an undersized memory mapping.

[Severity: High]
This is a pre-existing issue, but on 32-bit architectures with 64-bit physi=
cal
addresses (PAE/LPAE), does devm_ioremap() silently truncate the 64-bit size=
 to a
32-bit size_t?=20

	screen_base =3D devm_ioremap(&pdev->dev, mem->start, resource_size(mem));

Since check_mul_overflow() checks against the 64-bit resource_size_t fb_siz=
e, a
massive size wouldn't be caught there, and would be truncated here, leading=
 to a
smaller mapping than the DRM core expects.

> +		drm_err(dev, "framebuffer size exceeds maximum\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> =20
>  	/*
>  	 * Try to figure out the address of the framebuffer. Unfortunately, Open

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825104134.6696=
76-1-oushixiong1025@163.com?part=3D1
