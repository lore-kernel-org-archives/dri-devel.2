Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E667C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530C610E09B;
	Thu,  3 Sep 2026 07:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kPhNFQD0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C6C10E09B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:30:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9286A600D1;
 Thu,  3 Sep 2026 07:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE551F000E9;
 Thu,  3 Sep 2026 07:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788420633;
 bh=9tOVkpmBxqiyYmSmHnTluUU8rDL5TVeSmuxBDbqXOA4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kPhNFQD0sSJSxW9q88w98LrWBdTbRr2Va/+pzKU7pr/3+tf30DwYLV/9GAUT8SLCp
 MwnJc2FJID1CCuIgfV2wgtmfR2wY2jPQVd4XrrAMWedqOiisng+GkMYNPoDKx35vV8
 oEis07xjbVllV6c2tHcA3rnF6Fv7R6ACbpY8gcoFPBwdz1YCbWk9/R5i7eSlHQMyl9
 /CEUitElv8C+gECBrtOdmDze4wRC3z75utIJcsNfV6a0jRqvr/0OggA+X1hr9myfFn
 RPk8m6BeiiXhvnu+h1Jk42ua+H9X+7gWDNBOoUd7pvOrG75cRbIfWL+aRUK7Og1rtS
 Qt8BBx2NyrgJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/radeon: Create the primary plane in the driver
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903071409.427010-1-oushixiong1025@163.com>
References: <20260903071409.427010-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:30:32 +0000
Message-Id: <20260903073033.1DE551F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Missing `.destroy` callback in `radeon_primary_plane_funcs` ca=
uses a NULL pointer dereference in `drm_mode_config_cleanup()` during drive=
r unload or probe failure.
- [High] Freeing `radeon_crtc` on `drm_crtc_init_with_planes()` failure int=
roduces a Use-After-Free due to a dangling list pointer in DRM core.

Pre-existing issues:
- [High] Unhandled `-ENOMEM` from `drm_mode_crtc_set_gamma_size` leads to g=
uaranteed NULL pointer dereference in LUT loading functions.
- [High] Silent initialization failures in `radeon_crtc_init` leave unpopul=
ated CRTC slots, leading to NULL pointer dereferences later.
--

commit e5375b01119a0846e47327447f621f702f5ebac8
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/radeon: Create the primary plane in the driver

This patch creates a driver-owned primary plane advertising XRGB8888 and
ARGB8888, allocated via drmm_universal_plane_alloc(). It sets a blend mode
property to prevent validation warnings that occur when falling back to
the legacy fixed format list in the DRM core.

> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/ra=
deon/radeon_display.c
> index aac6733ddd82c..6427feb5a5c57 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
[ ... ]
> @@ -664,6 +667,20 @@ radeon_crtc_set_config(struct drm_mode_set *set,
>  	return ret;
>  }
> =20
> +/*
> + * The display engine programs an ARGB8888 surface format for both
> + * XRGB8888 and ARGB8888 framebuffers.
> + */
> +static const uint32_t radeon_primary_formats[] =3D {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +};
> +
> +static const struct drm_plane_funcs radeon_primary_plane_funcs =3D {
> +	.update_plane =3D drm_plane_helper_update_primary,
> +	.disable_plane =3D drm_plane_helper_disable_primary,
> +};
> +

[Severity: Critical]
Does omitting the .destroy callback here lead to a NULL pointer dereference
on module unload or initialization failure?

While drmm_universal_plane_alloc() requires the destroy callback to be
omitted for managed cleanup, the legacy radeon driver explicitly calls
drm_mode_config_cleanup() in radeon_modeset_fini().

Because drm_mode_config_cleanup() iterates over dev->mode_config.plane_list
and unconditionally executes plane->funcs->destroy(plane), won't it attempt
to dereference a NULL function pointer when it encounters this newly added
primary plane?

>  static const struct drm_crtc_funcs radeon_crtc_funcs =3D {
>  	.cursor_set2 =3D radeon_crtc_cursor_set2,
>  	.cursor_move =3D radeon_crtc_cursor_move,
[ ... ]
> @@ -693,7 +711,20 @@ static void radeon_crtc_init(struct drm_device *dev,=
 int index)
>  		return;
>  	}
> =20
> -	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
> +	primary =3D drmm_universal_plane_alloc(dev, struct drm_plane, dev, 0,
> +					     &radeon_primary_plane_funcs,
> +					     radeon_primary_formats,
> +					     ARRAY_SIZE(radeon_primary_formats),
> +					     NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (IS_ERR(primary))
> +		goto err_free_crtc;
> +

[Severity: High]
This is a pre-existing issue, but this patch introduces new failure paths
like this one that expose it.

If we jump to err_free_crtc and return early from radeon_crtc_init(), the
array slot rdev->mode_info.crtcs[index] is left unpopulated (NULL). The
caller, radeon_modeset_init(), does not check for failures and proceeds.

Will this lead to a NULL pointer dereference later when other paths (like
watermark or bandwidth updates) unconditionally access
rdev->mode_info.crtcs[i]->base.enabled?

> +	if (drm_crtc_init_with_planes(dev, &radeon_crtc->base, primary, NULL,
> +				      &radeon_crtc_funcs, NULL))
> +		goto err_free_crtc;
> +
> +	drm_plane_create_blend_mode_property(primary,
> +					     BIT(DRM_MODE_BLEND_PREMULTI));
> =20
>  	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);

[Severity: High]
This isn't a bug introduced by this patch, but the return value of
drm_mode_crtc_set_gamma_size() is ignored here.

If drm_mode_crtc_set_gamma_size() returns -ENOMEM, it leaves
crtc->gamma_store as NULL. Later, in hardware programming paths like
dce4_crtc_load_lut(), the driver assigns:

    r =3D crtc->gamma_store;

and unconditionally iterates up to 256, dereferencing the NULL pointer.
Should the error return from drm_mode_crtc_set_gamma_size() be handled
to prevent this?

>  	radeon_crtc->crtc_id =3D index;
[ ... ]
> @@ -713,6 +744,11 @@ static void radeon_crtc_init(struct drm_device *dev,=
 int index)
>  		radeon_atombios_init_crtc(dev, radeon_crtc);
>  	else
>  		radeon_legacy_init_crtc(dev, radeon_crtc);
> +	return;
> +
> +err_free_crtc:
> +	destroy_workqueue(radeon_crtc->flip_queue);
> +	kfree(radeon_crtc);
>  }

[Severity: High]
Can freeing radeon_crtc here cause a use-after-free regression by leaving a
dangling pointer in the DRM core?

Inside __drm_crtc_init_with_planes(), the CRTC is added to the DRM core's
dev->mode_config.crtc_list early via list_add_tail().

If a late initialization step within that function fails (such as
drm_crtc_crc_init()), the DRM core returns an error but fails to unlink
the CRTC from the list. If we immediately kfree(radeon_crtc) here, any
subsequent iteration over crtc_list (like during drm_mode_config_cleanup())
will access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903071409.4270=
10-1-oushixiong1025@163.com?part=3D1
