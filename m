Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1697C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12E810EA56;
	Tue,  4 Aug 2026 13:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ORaEDiaK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3E610EA56
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:29:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14C4C4010B;
 Tue,  4 Aug 2026 13:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83F51F000E9;
 Tue,  4 Aug 2026 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785850162;
 bh=Yy155rcMlXz9Z02y31d2JlQv7z87FAHKQifV4M9TJ60=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ORaEDiaKvVr2u64AI/sGl9QvXx3JIILQKHzgDAkyvBZlUolFUuwsKm9SuixHIC6qb
 8J2wtsFN+8NErhDa88oiiBNk0NMWsvUM6TSrBUwvX+jzar+5vW8vaLrj28If3Gv3M+
 ujTn77Ut9oi7mSVsYJojJFQw8ZN5t4CAW18D1yaelU2I1MaDfaWs8+nP79JWz5IG3f
 mJR7n80ZaenPDFb+257/OXJUVmehkhJSkaY8eSqf4XVBjA3Iw0Vp29mZPBDqZxYk2c
 V7T5dLG+mWKfUGgL4TXiYDtYuqieY1AEMn/SCrwgbx3oulsmZbXFElbcRSaRQiOVW7
 zaDlciM2aw5nw==
From: sashiko-bot@kernel.org
Subject: Re: [v6 9/9] drm/i915/color: Add color pipeline support for SDR planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804123107.2256124-10-chaitanya.kumar.borah@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-10-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 13:29:20 +0000
Message-Id: <20260804132921.D83F51F000E9@smtp.kernel.org>
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
- [Critical] Use-After-Free vulnerability due to missing `drm_mode_object_u=
nregister()` in `drm_colorop_cleanup()`.
- [High] Kernel crash via NULL pointer dereference if `kasprintf()` fails t=
o allocate the pipeline name.
- [High] NULL pointer dereference of `colorop->dev` during error cleanup in=
 `drm_colorop_cleanup()`.
- [High] Kernel crash via NULL pointer dereference when calling `list_del()=
` on an uninitialized `list_head`.
--

--- Patch [9]: [v6 9/9] drm/i915/color: Add color pipeline support for SDR =
planes ---
commit 80efc788f141365ff51bb15bb83bcb8d636605f2
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add color pipeline support for SDR planes

This commit exposes the SDR plane color pipeline to user-space by
removing the restriction that previously limited it only to HDR planes.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index 53e55ce0a5a35..38cfd6ed585d0 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> @@ -177,17 +177,11 @@ int _intel_color_pipeline_plane_init(struct drm_pla=
ne *plane, struct drm_prop_en
> =20
>  int intel_color_pipeline_plane_init(struct drm_plane *plane, enum pipe p=
ipe)
>  {
[ ... ]
> -	/* Currently expose pipeline only for HDR planes */
> -	if (!icl_is_hdr_plane(display, to_intel_plane(plane)->id))
> -		return 0;
> -
>  	/* Add pipeline consisting of transfer functions */
>  	ret =3D _intel_color_pipeline_plane_init(plane, &pipelines[len], pipe);

[Severity: High]
This is a pre-existing issue, but does this function properly handle
memory allocation failures?

In drivers/gpu/drm/i915/display/intel_color_pipeline.c:
_intel_color_pipeline_plane_init(), the pipeline name is allocated:

	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d",
			       colorop[0]->base.base.id);

	return 0;

If kasprintf() fails, list->name is NULL, but the function still returns 0.
This NULL pointer is then passed up the stack and eventually to
drm_property_add_enum(), which calls strlen(name):

	if (WARN_ON(strlen(name) >=3D DRM_PROP_NAME_LEN))
		return -EINVAL;

Could this cause a NULL pointer dereference when memory is tight?


[Severity: High]
This is a pre-existing issue, but could error cleanup paths triggered during
initialization cause a NULL pointer dereference?

If intel_color_pipeline_plane_add_colorop() fails early (for example, if
drm_mode_object_add() fails), the cleanup path calls intel_colorop_destroy(=
),
which invokes drm_colorop_cleanup().

At this point, colorop->dev might still be NULL. In drm_colorop_cleanup():

	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;

	list_del(&colorop->head);
	config->num_colorop--;

Will this unconditionally dereference the NULL dev pointer?


[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free risk when freei=
ng
a colorop?

When a colorop is successfully added to the DRM IDR via drm_mode_object_add=
(),
it needs to be unregistered when destroyed. However, drm_colorop_cleanup()
does not appear to call drm_mode_object_unregister().

If a colorop is freed, but its mode object ID remains valid in the IDR, cou=
ld
userspace trigger a use-after-free by interacting with the stale ID?


[Severity: High]
This is a pre-existing issue, but could the error handling crash when remov=
ing
an uninitialized list node?

In drm_plane_colorop_init(), if drm_mode_object_add() fails, the function
returns early before the colorop is added to the list:

	ret =3D drm_mode_object_add(dev, &colorop->base,
				  DRM_MODE_OBJECT_COLOROP);
	if (ret)
		return ret;

When the error path later calls drm_colorop_cleanup(), it unconditionally
executes list_del(&colorop->head). Since the head was zero-initialized via
kzalloc_obj(), __list_del() attempts to write to next->prev.

Will this result in an immediate NULL pointer dereference?

>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804123107.2256=
124-1-chaitanya.kumar.borah@intel.com?part=3D9
