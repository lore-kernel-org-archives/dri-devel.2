Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029C1CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C46D10ED29;
	Thu, 11 Jun 2026 07:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ctwK1sBY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBE810ED29
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:28:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E06860052;
 Thu, 11 Jun 2026 07:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A601F00893;
 Thu, 11 Jun 2026 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781162902;
 bh=rAzexnou8LfJbTHqBY9Em4HkTmY5BbRhFHgHdpDIN08=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ctwK1sBYvS9ZUjlS3PEtgi3ONnbFUz+2Nr+rWxCNBGEo1D1pMTIW8maVToR05FVy5
 RJMH5XCGxzDtMhy7NU22t5xJ4i51lKreAJhzCq2zpZg/5+BVkGSnfd/rTvRkrJj0yl
 DSY270SCN73MtvsO2pFpHl9wwR9EpU9hF0SgmNiP7jGAoYHEAn0QvzqPVmGXM43soi
 imv2rnJcvQqThLzk1/OyWikGDVvUD9dvskWHbzznEOvwr+DWcbYtjULBKxy1uc8JXC
 rzHPV5CxjdR3Q2Bv7QRixOa5KxFhKOmG6LLoMLHwXkjUdOfJN5g7AJLpFn4aqY1PVz
 XmhKfWJUsSDzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/armada: Make armada_framebuffer_create() an
 internal interface
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611072121.71492-4-tzimmermann@suse.de>
References: <20260611072121.71492-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 07:28:21 +0000
Message-Id: <20260611072821.F2A601F00893@smtp.kernel.org>
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
- [High] Reference leak of GEM object on error path in `armada_fb_create`
--

commit 6143d70290da395a0c8c1c0addd0695192664072
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/armada: Make armada_framebuffer_create() an internal interface

The only caller of armada_framebuffer_create() is armada_fb_create()
from the same source file. Declare the former as static.

> diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/=
armada_fb.c
> index b828bba419bfb..2f2348d543fd7 100644
> --- a/drivers/gpu/drm/armada/armada_fb.c
> +++ b/drivers/gpu/drm/armada/armada_fb.c
> @@ -18,10 +18,11 @@ static const struct drm_framebuffer_funcs armada_fb_f=
uncs =3D {
>  	.create_handle	=3D drm_gem_fb_create_handle,
>  };
> =20
> -struct armada_framebuffer *armada_framebuffer_create(struct drm_device *=
dev,
> -						     const struct drm_format_info *info,
> -						     const struct drm_mode_fb_cmd2 *mode,
> -						     struct armada_gem_object *obj)
> +static struct armada_framebuffer *
> +armada_framebuffer_create(struct drm_device *dev,
> +			  const struct drm_format_info *info,
> +			  const struct drm_mode_fb_cmd2 *mode,
> +			  struct armada_gem_object *obj)
>  {

[Severity: High]
This is a pre-existing issue, but while reviewing the caller of this newly
static function, it appears there might be a resource leak on the error pat=
h.

In armada_fb_create(), we get a reference to the GEM object:

	obj =3D armada_gem_object_lookup(dfile, mode->handles[0]);

But if the call to armada_framebuffer_create() fails, the code jumps to the
'err' label instead of 'err_unref':

	dfb =3D armada_framebuffer_create(dev, info, mode, obj);
	if (IS_ERR(dfb)) {
		ret =3D PTR_ERR(dfb);
		goto err;
	}

	drm_gem_object_put(&obj->obj);

	return &dfb->fb;

 err_unref:
	drm_gem_object_put(&obj->obj);
 err:
	DRM_ERROR("failed to initialize framebuffer: %d\n", ret);

Does this bypass the drm_gem_object_put() call and leak the GEM object
reference? Since armada_fb_create() is reachable from userspace via the
DRM_IOCTL_MODE_ADDFB2 ioctl, could a user repeatedly request invalid formats
to leak references and cause memory exhaustion?

>  	struct armada_framebuffer *dfb;
>  	uint8_t format, config;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611072121.7149=
2-1-tzimmermann@suse.de?part=3D3
