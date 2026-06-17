Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE640CD98F1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A8A10E9EC;
	Wed, 17 Jun 2026 11:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iYolreY+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9953910E9EC
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:40:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C992B6001D;
 Wed, 17 Jun 2026 11:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5991F000E9;
 Wed, 17 Jun 2026 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781696416;
 bh=owNG76UdExRUTO7rwDJokS36Z9bfJpGMsliRsXsb+9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iYolreY+v13sc1kIywQ6cGvRiUUTwYKzOO8sYydG7aSW2Kqwl5hW08M2NGv6xv0JC
 miufrlixkXwK4Rhlff3kG5wEofVTdFM7C38clY5ptxfLkmiSBhVTKe+Q6p3dozwoP+
 Wo24b4PIVAGxAYMOeaLX6culXmT54cOPzM7GQxQogwATdA0SU+YNEtJLt6bxYDVh0a
 hoJKIJM7wfZwcpmX5qYGxSg0uTq2LLhKiTIvDDV+4nb2F3nFe/pPsDYiM8OTcqgPu7
 1a3yO7gwZzxTuNOAECzplWdSZd86oscJ7vq94DKBLT1hhFd5x+Rq1DYV4lB6w117NR
 dwiDVriZScexw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/sysfb: Return errno code from
 drm_sysfb_get_visible_size()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617112932.511657-3-tzimmermann@suse.de>
References: <20260617112932.511657-1-tzimmermann@suse.de>
 <20260617112932.511657-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 11:40:15 +0000
Message-Id: <20260617114016.5A5991F000E9@smtp.kernel.org>
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
- [High] 32-bit integer overflow in `height * stride` calculation leading t=
o out-of-bounds I/O memory mapping and subsequent out-of-bounds writes.
- [Medium] Truncation of `div64_u64` result when passed to the `u32 max` pa=
rameter of `drm_sysfb_get_validated_int0`.
--

commit caeaafe04348540484a7b3b0bfa6ff4db7c32a32
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: Return errno code from drm_sysfb_get_visible_size()
   =20
Change the return type of drm_sysfb_get_visible_size() to s64 so
that it returns a possible errno code from _get_validated_size0().
Fix callers to handle the errno code.

> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/=
drm/sysfb/drm_sysfb_screen_info.c
> index 361b7233600c2..40b4f7883b9bc 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> @@ -64,7 +64,7 @@ int drm_sysfb_get_stride_si(struct drm_device *dev, con=
st struct screen_info *si
>  }
>  EXPORT_SYMBOL(drm_sysfb_get_stride_si);
> =20
> -u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct s=
creen_info *si,
> +s64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct s=
creen_info *si,
>  				  unsigned int height, unsigned int stride, u64 size)
>  {
>  	u64 vsize =3D height * stride;

[Severity: High]
This is a pre-existing issue, but does this calculation overflow if height
and stride are large?

Both height and stride are passed as 32-bit unsigned integers to
drm_sysfb_get_visible_size_si(), so their product is computed as a 32-bit
unsigned integer before being implicitly extended to the 64-bit vsize.

If they overflow (e.g., height up to U16_MAX and stride up to U16_MAX * 4),
the truncated 32-bit value could bypass the bounds check in
drm_sysfb_get_validated_size0(). This could result in requesting and mapping
a falsely small I/O memory region for the framebuffer, potentially leading
to an out-of-bounds memory write later.

Could explicit 64-bit casting or mul_u32_u32() be used to prevent this?

[Severity: Medium]
This isn't a bug introduced by this patch, but looking at
drm_sysfb_get_stride_si() located just above this in
drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c:

int drm_sysfb_get_stride_si(...)
{
    ...
    return drm_sysfb_get_validated_int0(dev, "stride", lfb_linelength,
                                        div64_u64(size, height));
}

Could the result of div64_u64(size, height) be truncated when passed to
drm_sysfb_get_validated_int0()?

The max parameter of drm_sysfb_get_validated_int0() is typed as u32. If
the total resource size is large and the height is small (for example,
size =3D 4GB and height =3D 1), the division result would overflow the u32 =
type
and truncate to 0.

This would cause drm_sysfb_get_validated_int0() to use a max value of 0,
falsely rejecting a valid configuration with -EINVAL.

>  	return drm_sysfb_get_validated_size0(dev, "visible size", vsize, size);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617112932.5116=
57-1-tzimmermann@suse.de?part=3D2
