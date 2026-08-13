Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB455C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC65E10F387;
	Thu, 13 Aug 2026 14:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KTUUHX4q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A623310F387
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:44:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43DDF4038E;
 Thu, 13 Aug 2026 14:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8031F000E9;
 Thu, 13 Aug 2026 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786632246;
 bh=q+wIh2Ca4em6dj3+EfO5peee2on1nhOfljvAwBTCrAg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KTUUHX4q+eQC8JTDd7swiy4imkQLPqIjCEaaIf7m/tArhwK+CdXh6MOUPWDMKpxhI
 vc50g12qQlpYiqz4O3taXE7OyqeBtMmJRviZud74Z0CoCLza/ka79BugWXgAQ3XH/G
 vD7k5mFbJ8f951YaIA51ZMTwLEFNz0mY2CtS/Sf3V89me8zovad/hiFMR7GYnWI0JP
 rqhgwlIeJ+6+4Xmyd5fIDRrSb+IdCbnfHS+JbQIbjzDO5VBeGYw5zyuqyIJPYKfqn8
 RmLALW0Tp5XZzA/b7zHDGvPwpgxoOIBx6Sb1In6LK13fsUa/KWP+eZIHVUKzimvG9t
 96+oCK/QXly8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813143605.106104-4-mwen@igalia.com>
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-4-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:44:05 +0000
Message-Id: <20260813144405.EF8031F000E9@smtp.kernel.org>
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
- [High] Calling drm_plane_create_blend_mode_property() without PREMULTI su=
pport triggers a kernel warning (WARN_ON) and fails to create the property.
--

--- Patch [3]: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blen=
d mode for DCE generations ---
commit 44681caffc8bcfc7085bcfe1ec288a0eafc8c992
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: advertise PIXEL_NONE as blend mode for DCE generations

This commit changes the blend mode property creation for primary planes on
DCE generations. It modifies the driver to create the blend mode property
with PIXEL_NONE only, instead of the DRM default PREMULTI mode.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 423e3cd7b9c98..e02cbafc8c5d0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
[ ... ]
> @@ -2208,14 +2208,18 @@ int amdgpu_dm_plane_init(struct amdgpu_display_ma=
nager *dm,
[ ... ]
> -	if ((plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY ||
> -	     plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) &&
> -	    plane_cap && plane_cap->per_pixel_alpha &&
> -	    plane_cap->type =3D=3D DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +	if (plane_cap && plane_cap->type !=3D DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PIXEL_N=
ONE));

[Severity: High]
Does this trigger a kernel warning and fail to create the property?

Looking at drm_plane_create_blend_mode_property() in drm_blend.c, the DRM
core explicitly enforces that DRM_MODE_BLEND_PREMULTI must be supported:

int drm_plane_create_blend_mode_property(struct drm_plane *plane,
					 unsigned int supported_modes)
{
	...
	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) =3D=3D 0)))
		return -EINVAL;
	...
}

Since amdgpu_dm_plane_init() now passes only BIT(DRM_MODE_BLEND_PIXEL_NONE),
this will trigger the WARN_ON and return -EINVAL during device probe,
meaning the property is not created at all.

> +	} else if ((plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY ||
> +		    plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) &&
> +		   plane_cap && plane_cap->per_pixel_alpha) {
>  		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>  					  BIT(DRM_MODE_BLEND_PREMULTI) |
>  					  BIT(DRM_MODE_BLEND_COVERAGE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813143605.1061=
04-1-mwen@igalia.com?part=3D3
