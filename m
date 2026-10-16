Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8C0CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E43F112629;
	Fri, 16 Oct 2026 07:49:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF2911266F
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:49:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65941413C1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5821F000C4;
 Fri, 16 Oct 2026 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792136951;
 bh=TQrfcshK/JAykqAxSfFo1u3+AxhNgB3tzZWzT2wVFuI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mOsJkGYl9/nINKLh7wTkdiwiDYesYmJKmydInb2QwoA18PtaFzlZiQMIFhW5sAbsq
 MAYT8zIP3WR0gTCLEDMxScfmxgthv0iyfE/flZbHtBnEzEaEuoGMzbdblILTlvCoUc
 MifMSB3TmrzU9B8Ir8WolHxcajnXwp3ZC/Uu2PQQj3T/04mU9XjpBU/XwVbgxIWLmj
 0+n+Agyc7/bvYCmWM1XJwZlPcZr+kfSG0CFT/JYTCwUvzTcgr4Zn3At7XLNyeQmTjo
 +hmvkELxbh6tqKrmd4Ynd+3KFiGXgWt8xMivlg6S0BXfYC6YtZa8zeWMH1On0thL+u
 N+mrqThCmATPw==
Message-ID: <sashiko-outbox-173967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/14] drm/vkms: Add driver-specific plane property
 for testing
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-drm-reset-state-flag-v5-14-dad2d64b693b@kernel.org>
References: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
 <20261016-drm-reset-state-flag-v5-14-dad2d64b693b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:49:10 +0000
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
- [High] vkms: NULL pointer dereference in vkms_plane_create_state on prope=
rty alloc failure
--

commit d0a4c2c6cd5d0119f8db12db7c2a842adce4aa8a
Author: Maxime Ripard <mripard@kernel.org>

drm/vkms: Add driver-specific plane property for testing

This commit adds a driver-specific range property to vkms planes for testing
the DRM_MODE_ATOMIC_RESET flag. It initializes the property during plane
creation and duplicates its value in the plane state.

> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index fd3d34dcf0fe5..0ebc131c2788f 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
[ ... ]
> @@ -85,7 +92,9 @@ static void vkms_plane_destroy_state(struct drm_plane *=
plane,
> =20
>  static struct drm_plane_state *vkms_plane_create_state(struct drm_plane =
*plane)
>  {
> +	struct vkms_plane *vkms_plane =3D to_vkms_plane(plane);
>  	struct vkms_plane_state *vkms_state;
> +	u64 val;
> =20
>  	vkms_state =3D kzalloc_obj(*vkms_state);
>  	if (!vkms_state) {
> @@ -95,14 +104,53 @@ static struct drm_plane_state *vkms_plane_create_sta=
te(struct drm_plane *plane)
> =20
>  	__drm_gem_shadow_plane_state_init(plane, &vkms_state->base);
> =20
> +	if (!drm_object_property_get_default_value(&plane->base,
> +						   vkms_plane->vkms_test_do_not_use_property,
> +						   &val))

[Severity: High]
Can vkms_plane->vkms_test_do_not_use_property be NULL here?

In vkms_plane_init(), if drm_property_create_range() fails, the property
pointer is left as NULL, but initialization succeeds:

	plane->vkms_test_do_not_use_property =3D
		drm_property_create_range(dev, 0,
					  "vkms-test-do-not-use-in-prod",
					  0, U32_MAX);
	if (plane->vkms_test_do_not_use_property)
		drm_object_attach_property(&plane->base.base,
					   plane->vkms_test_do_not_use_property,
					   0);

If the property pointer is NULL, calling
drm_object_property_get_default_value() will trigger a NULL pointer
dereference because the DRM core unconditionally dereferences it:

drivers/gpu/drm/drm_mode_object.c:drm_object_property_get_default_value() {
	WARN_ON(!drm_drv_uses_atomic_modeset(property->dev));
    ...
}

Should there be a NULL check for vkms_test_do_not_use_property before passi=
ng
it to drm_object_property_get_default_value(), or should vkms_plane_init()
return an error if the property allocation fails?

> +		vkms_state->vkms_test_do_not_use_value =3D val;
> +
>  	return &(&vkms_state->base)->base;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-drm-reset-=
state-flag-v5-0-dad2d64b693b@kernel.org?part=3D14
