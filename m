Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF605C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A3FE10E9FF;
	Wed, 29 Jul 2026 11:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="obwYnJ6u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7184710E793
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:14:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1ABDC41433;
 Wed, 29 Jul 2026 11:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76F81F00A3E;
 Wed, 29 Jul 2026 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785323693;
 bh=ySvqNfih3GrylEYGbg3unFA+QCMxoQEqIs2DZ1KwEyQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=obwYnJ6uwMnJdcuDbWveOwrAWsqDFkx/ij0TaZtPbr69pvMBn+kco2RFZG4wOLBT8
 GE8Kos4RvE+0WFF+iK+9HODQgwd8bZIcugDcrp2NLKiqz42IJ41ADcy6cJ2IhZoWLp
 cZagIaVJwQ3ty0XyZDLVCnEbKNm1H0jUV/+XGpNuzGUE02RooXDqiWF2LhaYSY4mKS
 NelHaX+lyC+ESH/ma9KdrK4zavMOo9w24U3NhKAZDmHn7Sokfaa726G5IwjYYiTdMh
 OI1V5z5hKn0Ea10OG3/U6abogMw7RNUWyIVb2LblzA20GEcl/DAXD4QiZ9cAGZD2sc
 wSroqqopQ2sJA==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/sysfb: Do not page-align visible size of the
 framebuffer" has been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026072945-illusive-shut-752a@gregkh>
References: <2026072945-illusive-shut-752a@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:14:52 +0000
Message-Id: <20260729111452.C76F81F00A3E@smtp.kernel.org>
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
- [High] A 32-bit integer overflow in the `height * stride` calculation lea=
ds to a truncated mapping size, allowing a massive out-of-bounds write.
- [Medium] `drm_sysfb_get_validated_size0()` returns an `s64` error code (`=
-EINVAL`), which is implicitly cast to a huge positive `u64` value in `drm_=
sysfb_get_visible_size_si()`, bypassing caller error checks.
--

--- Patch [1]: Patch "drm/sysfb: Do not page-align visible size of the fram=
ebuffer" has been added to the 6.18-stable tree ---
commit 73e7b8e3b5af9020895060aed292665597f1df3d
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>

Patch "drm/sysfb: Do not page-align visible size of the framebuffer" has be=
en added to the 6.18-stable tree

This commit is a stable backport of a patch that stops page-aligning the
visible size of the system framebuffer in drm_sysfb_get_visible_size_si().
Only the actually visible size is returned.

Link: https://patch.msgid.link/20260618084327.46567-2-tzimmermann@suse.de

> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/=
drm/sysfb/drm_sysfb_screen_info.c
> index 885864168c54f..ebcb28f2b3359 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> @@ -67,7 +67,7 @@ EXPORT_SYMBOL(drm_sysfb_get_stride_si);
>  u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct s=
creen_info *si,
>  				  unsigned int height, unsigned int stride, u64 size)
>  {
> -	u64 vsize =3D PAGE_ALIGN(height * stride);
> +	u64 vsize =3D height * stride;

[Severity: High]
This isn't a bug introduced by this patch, but does the multiplication of
height and stride overflow here?

Both height and stride are unsigned int, so their multiplication is a 32-bit
operation that can overflow before being zero-extended to u64, resulting in=
 a
truncated vsize.

This could allow a truncated size to pass validation, while subsequent code
(like the DRM damage worker) uses the full dimensions, leading to a massive
out-of-bounds write in kernel virtual memory if malicious screen_info
parameters are provided by a bootloader or hypervisor.

> =20
>  	return drm_sysfb_get_validated_size0(dev, "visible size", vsize, size);

[Severity: Medium]
This is a pre-existing issue, but does this implicit cast to u64 bypass cal=
ler
error checks?

drm_sysfb_get_validated_size0() can return an s64 error code like -EINVAL.
Since drm_sysfb_get_visible_size_si() returns a u64, this negative value
becomes a huge positive number.

Callers fail to catch this because they only check for zero:

drivers/gpu/drm/sysfb/efidrm.c:efidrm_device_create() {
	...
	if (!vsize)
		return ERR_PTR(-EINVAL);
	...
}

Should the return type of drm_sysfb_get_visible_size_si() be s64?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026072945-illusive=
-shut-752a@gregkh?part=3D1
