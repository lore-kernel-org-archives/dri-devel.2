Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EF1CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AB010EFB4;
	Wed, 17 Jun 2026 11:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cHvvX9bV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5E210EFB4
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:40:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 82DE460052;
 Wed, 17 Jun 2026 11:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2A71F000E9;
 Wed, 17 Jun 2026 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781696427;
 bh=sJJBmYKvRNeuh0RDZ27226S7oEi7Sq+z7i87GS3vf18=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cHvvX9bVn9N0ZZkf5Zd4qQsvdZvaa917Cd14Jo2JPPhJI+mBVir+3KgjEiKwvKKEQ
 +drmKppp0eK2myLCuYW77SvX5wD3lmp3KJn01KjCOXI0wJvGgb38MLBSDW6v21BG0L
 jFXUPu3fnqRgHsTs6OAz8mDLmh5uaJi2RbDFbjiVHkPItRpxviHx4puQL4RVrVrM6I
 Fi3VDqfXlkPbDosmRlvRuW+OZlZH7IH6pJgzYDd3wWnWd3MTlAnUW1naSCihWE4VcL
 5cXlX7KD5FOfm2B+w5+A7v7eYjlifZwtqupoRjc9j9+4VatFFnXd1x91xBEZJSU36y
 b87KMTt1yZ1kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/sysfb: Do not page-align visible size of the
 framebuffer
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617112932.511657-2-tzimmermann@suse.de>
References: <20260617112932.511657-1-tzimmermann@suse.de>
 <20260617112932.511657-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 11:40:26 +0000
Message-Id: <20260617114027.1F2A71F000E9@smtp.kernel.org>
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
- [High] 32-bit integer overflow in `height * stride` calculation causes tr=
uncated visible size for framebuffers >4GB, leading to out-of-bounds kernel=
 memory accesses.
--

commit e0fef2d92fd416a597acb169f1514b97e1eff546
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: Do not page-align visible size of the framebuffer

This commit stops page-aligning the visible size of the system
framebuffer in drm_sysfb_get_visible_size_si(). Drivers use this size
value for reserving access to framebuffer memory, and increasing the
value can make later attempts to reserve memory fail.

> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/=
drm/sysfb/drm_sysfb_screen_info.c
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
This is a pre-existing issue, but does this calculation overflow on 32-bit
arithmetic before assignment?

Both height and stride are passed as unsigned int. If the system provides a
framebuffer resource larger than 4GB, the height * stride product could
overflow and truncate before being zero-extended to u64 vsize.

This truncated value could pass validation against the resource bounds
and lead to an undersized devm_ioremap_wc(). Could this cause out-of-bounds
kernel memory accesses during subsequent DRM operations, such as
drm_fb_memcpy(), if they iterate using the original non-truncated dimension=
s?

> =20
>  	return drm_sysfb_get_validated_size0(dev, "visible size", vsize, size);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617112932.5116=
57-1-tzimmermann@suse.de?part=3D1
