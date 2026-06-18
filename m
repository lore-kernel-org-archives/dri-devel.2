Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398C8CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A4A10EB2B;
	Thu, 18 Jun 2026 14:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i9fhDrp3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F7910EB2B
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:20:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A072560008;
 Thu, 18 Jun 2026 14:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E321F000E9;
 Thu, 18 Jun 2026 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781792442;
 bh=h3ylYkJWh1rCkxBTBGW+4X00xSPRoSCa7jo4lYACGGc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i9fhDrp3Iqxj+aHn2Iv53j16U12hYR4EwjJKLrA8xmBxjgVWpTtUnqOgge6YX+M+W
 sYikMkKbBa939qxPKoPQlHaLNvNibUQ8pSS63dpoTjAWhSB2U9QuGTGg1JARViTDFH
 RcCCZJgdvhGyuuca85A2r9zds88j8nBb2JYKGX7gbxXppUn36AgFsH/BEO/QW1apt5
 TddnAvDaJjz1xtTxh4N+GzdYA3K2JuWgz9ZHA5Kdzz5tH8i9pWiYNzIwR0ZgNajV5J
 Ez/B/x/Wk2/Mkc8LJRsk+EF2kIL2e0ODY3g1HO8Mhd7+EhP2O/w+qMdaCMa90OGjpW
 y4HnEPzi9e9/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] drm/msm: Make msm_framebuffer_init() an internal
 interface again
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618141249.151338-7-tzimmermann@suse.de>
References: <20260618141249.151338-1-tzimmermann@suse.de>
 <20260618141249.151338-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 14:20:41 +0000
Message-Id: <20260618142042.36E321F000E9@smtp.kernel.org>
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
- [High] Missing cleanup in the error path of msm_framebuffer_prepare() lea=
ding to resource leaks and potential hardware faults.
--

commit 9c0f26778b6b3f337240eba05217d26a3010e217
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/msm: Make msm_framebuffer_init() an internal interface again

The patch makes msm_framebuffer_init() a static function since it is only
called from msm_framebuffer_create() within the same source file.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index dec550e6cf750..60c108d35d2a1 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
> @@ -134,10 +134,10 @@ const struct msm_format *msm_framebuffer_format(str=
uct drm_framebuffer *fb)
>  	return msm_fb->format;
>  }
> =20
> -struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
> -					     const struct drm_format_info *info,
> -					     const struct drm_mode_fb_cmd2 *mode_cmd,
> -					     struct drm_gem_object **bos)
> +static struct drm_framebuffer *
> +msm_framebuffer_init(struct drm_device *dev, const struct drm_format_inf=
o *info,
> +		     const struct drm_mode_fb_cmd2 *mode_cmd,
> +		     struct drm_gem_object **bos)

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file,
I noticed a missing cleanup in the error path of msm_framebuffer_prepare()
that can lead to resource leaks and potential regressions.

When msm_framebuffer_prepare() successfully pins some planes but fails on a
subsequent plane, it returns early:

drivers/gpu/drm/msm/msm_fb.c:msm_framebuffer_prepare() {
	...
	for (i =3D 0; i < n; i++) {
		msm_gem_vma_get(fb->obj[i]);
		ret =3D msm_gem_get_and_pin_iova(fb->obj[i], vm, &msm_fb->iova[i]);
		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
			      fb->base.id, i, msm_fb->iova[i], ret);
		if (ret)
			return ret;
	}
	...
}

Does returning immediately here fail to roll back the earlier pinned planes
and vma_get references?=20

Furthermore, DRM core's drm_atomic_helper_prepare_planes() skips calling
cleanup_fb() for the plane that failed its prepare_fb(). Since
msm_fb->prepare_count is incremented at the start of the function but not
decremented on this error path, will a subsequent attempt to use this
framebuffer evaluate atomic_inc_return(&msm_fb->prepare_count) > 1 as true?

If it falsely returns success without pinning the remaining planes, could
this result in an IOMMU fault or memory corruption during scanout when the
hardware attempts to access unmapped addresses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618141249.1513=
38-1-tzimmermann@suse.de?part=3D6
