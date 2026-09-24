Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5283BC9830D
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 03:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB4910E90F;
	Thu, 24 Sep 2026 03:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z2iZmh4T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BAB10E90F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 03:06:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97D60600AA;
 Thu, 24 Sep 2026 03:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ECD1F000FF;
 Thu, 24 Sep 2026 03:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790219204;
 bh=DTGu7E169AgcHr8xnN1bDS1EvCEt7fSi2o7Q8ntHT+s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z2iZmh4TpixhW6kttbBv1jqY6zTIVT4NqNtTj6KItz8URLuVO26NmaWPyyRgr86B+
 jUF2siK+12JHCwZq0LwVvI4mRM8Z0hie/h9/kgYFcZAevGH7q5vLmtT0oDH3o1+2Gy
 Q7msT950diwyr0oSeEBsk/ypLilrKmaQEpFiC29NqGbrIcsrxklaqW7istVov1uVGv
 FW6RAfLlEwkevg1lXsOhiaFkZqdWXpKFNLRI2wG4vCkzrbVzv+5O6W651lOmHxgjJa
 1Phxd+ryDDOlnCEdb103pBamCPi1yg59HIAUXK2yNyft49BNt2ZB6hVQrorMkAcii0
 MQiZQdwb/4UXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: size packed dumb heads from the plane source
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260924025222.6077-1-dillona@gmail.com>
References: <20260924025222.6077-1-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:06:43 +0000
Message-Id: <20260924030644.06ECD1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/qxl: out-of-bounds write in primary surface due to uncompensat=
ed src_y
- [High] drm/qxl: out-of-bounds read in SPICE client due to double-applied =
X offset
- [Medium] drm/qxl: active CRTCs are blanked when shadow surface is realloc=
ated on plane updates
--

commit 6cdb15db884bed833722eee3adac75f129fa0806
Author: Dillon Amburgey <dillona@gmail.com>

    drm/qxl: size packed dumb heads from the plane source
   =20
    QXL packs per-CRTC dumb buffers into a single primary surface.
    qxl_update_dumb_head() recorded each dumb BO allocation (bo->surf)
    instead of the plane source rectangle. Scanning 1280x800 from a
    2048x1024 dumb framebuffer beside a 1024x768 head therefore created
    a 3072x1024 primary and placed head 1 at +2048, rather than 2304x800
    with head 1 at +1280.

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> index 0719fc6a52d53..e57aeeb97f84e 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -670,13 +670,17 @@ static void qxl_primary_atomic_update(struct drm_pl=
ane *plane,
>  	struct qxl_device *qdev =3D to_qxl(plane->dev);
>  	struct qxl_bo *bo =3D gem_to_qxl_bo(new_state->fb->obj[0]);
>  	struct qxl_bo *primary;
> -	struct drm_clip_rect norect =3D {
> -	    .x1 =3D 0,
> -	    .y1 =3D 0,
> -	    .x2 =3D new_state->fb->width,
> -	    .y2 =3D new_state->fb->height
> -	};
> +	struct drm_clip_rect norect;
>  	uint32_t dumb_shadow_offset =3D 0;
> +	u32 src_x =3D new_state->src_x >> 16;
> +	u32 src_y =3D new_state->src_y >> 16;
> +	u32 src_w =3D new_state->src_w >> 16;
> +	u32 src_h =3D new_state->src_h >> 16;
> +
> +	norect.x1 =3D src_x;
> +	norect.y1 =3D src_y;
> +	norect.x2 =3D src_x + src_w;
> +	norect.y2 =3D src_y + src_h;

[Severity: High]
Can this result in an out-of-bounds write in the primary surface?

The destination Y coordinates are set directly to the source Y offset (src_=
y)
without being compensated or normalized. In qxl_calc_dumb_shadow(), the
primary surface height is allocated as just the maximum src_h across all
heads.

If a plane is configured with a non-zero src_y, src_y + src_h will exceed t=
he
allocated surface height, causing qxl_draw_dirty_fb() to instruct the host =
to
draw outside the bounds of the primary surface.

> =20
>  	primary =3D bo->shadow ? bo->shadow : bo;
> =20
> @@ -689,7 +693,7 @@ static void qxl_primary_atomic_update(struct drm_plan=
e *plane,
> =20
>  	if (bo->is_dumb)
>  		dumb_shadow_offset =3D
> -			qdev->dumb_heads[new_state->crtc->index].x;
> +			qdev->dumb_heads[new_state->crtc->index].x - src_x;

[Severity: High]
Does this cause an out-of-bounds read in the SPICE client?

By subtracting src_x here, the image is packed at exactly dumb_heads[i].x
in the shadow surface. However, qxl_crtc_update_monitors_config() was not
updated and still adds crtc->x to the head position:

	if (crtc->state->active) {
		...
		head.x =3D crtc->x;
		if (qdev->primary_bo =3D=3D qdev->dumb_shadow_bo)
			head.x +=3D qdev->dumb_heads[i].x;

Since the viewport was placed exactly at dumb_heads[i].x in the primary
surface, instructing SPICE to read from dumb_heads[i].x + crtc->x means it
will read past the valid image data for the secondary CRTC.

[ ... ]

> @@ -869,7 +868,9 @@ static int qxl_plane_prepare_fb(struct drm_plane *pla=
ne,
> =20
>  	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY &&
>  	    user_bo->is_dumb) {
> -		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
> +		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index,
> +				   new_state->src_w >> 16,
> +				   new_state->src_h >> 16);
>  	}

[Severity: Medium]
Will this blank active CRTCs when the shadow surface is reallocated?

By tying the shared shadow surface layout to per-plane mutable crop state
(src_w and src_h), qxl_prepare_shadow() will dynamically reallocate the
shared primary surface if a plane's dimensions change:

static void qxl_prepare_shadow(...)
{
	...
	if (!qdev->dumb_shadow_bo ||
	    qdev->dumb_shadow_bo->surf.width  !=3D surf.width ||
	    qdev->dumb_shadow_bo->surf.height !=3D surf.height) {
		...
		qxl_bo_create(qdev, surf.height * surf.stride, ...);

When this reallocation happens during a single-plane atomic update, other
active CRTCs are not participating in the commit and won't redraw their
contents into the new shared surface, potentially leaving them blank.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924025222.6077=
-1-dillona@gmail.com?part=3D1
