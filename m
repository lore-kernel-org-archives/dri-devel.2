Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7544C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4097210E631;
	Wed, 29 Jul 2026 11:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZKrW5yeH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D541B10E631
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:16:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BF2C401A7;
 Wed, 29 Jul 2026 11:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8701F000E9;
 Wed, 29 Jul 2026 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785323810;
 bh=wXNO+WGHkIQHfI7jdpYH3atc6g9Q49Cs8pAyRCXe0dU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZKrW5yeHT4CDwawJSyxoYhUzNjcvqQnQk8UIAWUYBq8aNs1LLKh8N+QonYLasFaIv
 8onBeizZG48UawAdkOHE05hRwJ/XwpS7R/c1Ix0XY8XMQFInmAtWD2dfwJMQ0SlA0f
 6RDuEYzlxlHZxJLGV+cHW9oHOoZQhwZobGmo3h1e1VLyP+vNmoziUeozICQEpHOxlc
 bjpVOMCvpILr17EKvL5IKkbUSFd2ddRIrLLXkVw7STSnOGCMcAXeSoO0OqpjMilTmQ
 geTopjDqGh4HeiMGcFVzavKSwBdCN8kVUCfcSXeu4muUSFfmBLIAONYuk61U0T99X+
 rl8aocSlA0Yiw==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/sysfb: Avoid truncating maximum stride" has been
 added to the 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026072945-lather-carmaker-b8ca@gregkh>
References: <2026072945-lather-carmaker-b8ca@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:16:49 +0000
Message-Id: <20260729111650.4E8701F000E9@smtp.kernel.org>
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
- [High] Calculation of vsize inside drm_sysfb_get_visible_size_si suffers =
from a 32-bit integer overflow before PAGE_ALIGN, leading to a truncated me=
mory mapping.
- [High] drm_sysfb_get_visible_size_si implicitly casts a negative errno to=
 u64, bypassing the error checks in callers and causing resource registrati=
on corruption.
--

--- Patch [1]: Patch "drm/sysfb: Avoid truncating maximum stride" has been =
added to the 6.18-stable tree ---
commit afbe56da35160af0caa025f567da427b14e63119
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>

Patch "drm/sysfb: Avoid truncating maximum stride" has been added to the 6.=
18-stable tree

Passing a maximum as 64-bit type to drm_sysfb_get_validated_int0()
can truncate the value to 32 bits. Use drm_sysfb_get_validated_size0(),
which uses 64-bit arithmetics. Then test the returned stride against
the limits of int to avoid truncations in the returned value. A valid
stride is in the range of [1, INT_MAX] inclusive.

Link: https://patch.msgid.link/20260618084327.46567-5-tzimmermann@suse.de

> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/=
drm/sysfb/drm_sysfb_screen_info.c
> index 885864168c54f..7c336360556d1 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> @@ -56,11 +56,17 @@ int drm_sysfb_get_stride_si(struct drm_device *dev, c=
onst struct screen_info *si
>  			    unsigned int width, unsigned int height, u64 size)
>  {
>  	u64 lfb_linelength =3D si->lfb_linelength;
> +	s64 stride;
> =20
>  	if (!lfb_linelength)
>  		lfb_linelength =3D drm_format_info_min_pitch(format, 0, width);
> =20
> -	return drm_sysfb_get_validated_int0(dev, "stride", lfb_linelength, div6=
4_u64(size, height));
> +	stride =3D drm_sysfb_get_validated_size0(dev, "stride", lfb_linelength,
> +					       div64_u64(size, height));
> +	if (stride < INT_MIN || stride > INT_MAX)
> +		return -EINVAL;
> +
> +	return (int)stride; /* stride or negative errno code */
>  }
>  EXPORT_SYMBOL(drm_sysfb_get_stride_si);

[Severity: High]
This isn't a regression introduced by this patch, but looking at the next
function in this file, drm_sysfb_get_visible_size_si(), is there a 32-bit
overflow risk here?

drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c:drm_sysfb_get_visible_size_si=
() {
	u64 vsize =3D PAGE_ALIGN(height * stride);

Since height and stride are both 32-bit unsigned integers, their product is
calculated using 32-bit arithmetic before being passed to PAGE_ALIGN and
widened to u64.

If the bootloader supplies screen dimensions that cause the product to exce=
ed
4GB, would this overflow wrap around to a small size and cause the driver to
allocate and map an insufficient memory region?

[Severity: High]
This is also a pre-existing issue, but does this implicitly cast a negative
errno to u64?

drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c:drm_sysfb_get_visible_size_si=
() {
	...
	return drm_sysfb_get_validated_size0(dev, "visible size", vsize, size);
}

drm_sysfb_get_validated_size0() returns s64, which can be an error code like
-EINVAL.

Since drm_sysfb_get_visible_size_si() returns u64, -EINVAL is cast to a
massive positive number.

If the framebuffer size is not page-aligned, drm_sysfb_get_validated_size0()
returns -EINVAL.

Will callers that only check for zero fail to catch this?

For example, in drivers/gpu/drm/sysfb/efidrm.c:efidrm_device_create():

	if (!vsize)
		return ERR_PTR(-EINVAL);

Could this massive u64 value then be passed to
devm_aperture_acquire_for_platform_device(), resulting in the driver
registering a corrupt aperture that spans almost the entire physical address
space and spuriously detaches the primary firmware framebuffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026072945-lather-c=
armaker-b8ca@gregkh?part=3D1
