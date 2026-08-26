Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9D6C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105F510E00D;
	Wed, 26 Aug 2026 11:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fpjs52Wh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752A210E00D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:07:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D3876011F
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326A41F000E9;
 Wed, 26 Aug 2026 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787742470;
 bh=F8EF5wdT8G+oMlrA8mWh4mrzzF7LJ+spXrruhcu/zbE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fpjs52WhbknXXjwYPMw3uU2zwP93ShoIkBDMR7Fgd4oqIAWPwaLWhJCV3UvHtvNMX
 AUk25c2zfIH2BNpXCokFLAJXNK/CFcRNRbjPaB+CEjRyu496VWZo5jGmdHHZ3UI7e1
 LyCzFZ9KOz61Qr37TMcrb1yaEkoOO171KmfZmv2I6coBnF66IxXZv0Uxgx1UJREs0u
 qKpCaOwcUfczppxhZbqywlff0lKMx5O5VeVkf5o3auLh4RuzIbl0M2X/w/QWCgvOSi
 AdhkEJE4Y5EgN+KfhIOtyMZNd7pYzD+yE1F74jN8c8IfprNl/Rx/mNjmZwIgekNvEK
 xcbzCfy6gcqaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: Add blend mode properties
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826105421.1825331-1-thierry.reding@kernel.org>
References: <20260826105421.1825331-1-thierry.reding@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 11:07:49 +0000
Message-Id: <20260826110750.326A41F000E9@smtp.kernel.org>
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
- [High] The newly added pixel_blend_mode property is not initialized in th=
e plane's reset hook, leading to an invalid initial atomic state.
--

commit dea256106aa6a4944ed84de30a43b82c973ff72f
Author: Thierry Reding <treding@nvidia.com>

drm/tegra: Add blend mode properties

The default programming in the driver matches the "coverage" blend mode,
so add the corresponding pixel blend mode property to let userspace know
about it.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 0b3fcc7011b35..fefc3761a4bc7 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -939,6 +940,7 @@ static struct drm_plane *tegra_primary_plane_create(s=
truct drm_device *drm,
>  	}
> =20
>  	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
> +	drm_plane_create_blend_mode_property(&plane->base, blend_caps);

[Severity: High]
Since tegra_plane_reset() in drivers/gpu/drm/tegra/plane.c uses kzalloc_obj=
()
to zero-allocate the atomic plane state:

	state =3D kzalloc_obj(*state);
	if (state) {
		plane->state =3D &state->base;
		plane->state->plane =3D plane;

Will this cause atomic commits to fail with -EINVAL if userspace performs a
commit without changing the blend mode?

The pixel_blend_mode field is implicitly left at 0 (DRM_MODE_BLEND_PREMULTI=
).
Because only DRM_MODE_BLEND_COVERAGE (enum value 1) is exposed in blend_cap=
s,
the core DRM enum validator (drm_property_change_valid_get()) will reject
the 0 value when userspace queries and subsequently commits the state.

Should tegra_plane_reset() be updated to explicitly initialize
pixel_blend_mode to DRM_MODE_BLEND_COVERAGE?

>  	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826105421.1825=
331-1-thierry.reding@kernel.org?part=3D1
