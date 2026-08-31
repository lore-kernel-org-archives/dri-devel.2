Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0341DC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631D910E65B;
	Mon, 31 Aug 2026 19:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VszlBjF+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E62810E33F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:22:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DACA601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC421F000E9;
 Mon, 31 Aug 2026 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788204176;
 bh=wDtrQc9jtyOXmiXfomtpYeqZ0Ev1ItBgWiBzJbXg4KE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VszlBjF+Aud4hxdtZrYWAWfaJdn/hzSPLKrJ8RrFaQwAuYJwM3jO6fo/SO38fZEvG
 wYMKK8EjdjhHu5fE4lytMukFiEgRYRLPJoa/xVf+i+MyiOZtHHXcUcSVOWaP4/21Cv
 7/LtsJwwvQbRk2c7b3CyduaUSPNNqpZzYxXwRipQ79hlpjKsHXz/D3U3Vkz7Z7KvqF
 b+UF84009nT/HMO0bDqwAFI6/fdBXWddmG9W5PgBT4HVH8CYQgz9iNepCsfCHWakZk
 sPfy+7+rJr2eVfp+jlMq9/abRhgrySuWCUWyObL1E0oAzEzxLFMFtFM26qTLyCKmDq
 GC+Ndj0OzL0Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/40] drm/fsl-dcu: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-5-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-5-1877c7aa57b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:22:55 +0000
Message-Id: <20260831192256.6DC421F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference in fsl_dcu_drm_primary_create_plane() err=
or path.
--

commit 9167a24528f8ea634b64f0e356c2b60880610b79
Author: Maxime Ripard <mripard@kernel.org>

drm/fsl-dcu: Convert to atomic_create_state

This commit uses a Coccinelle semantic patch to rename the .reset hook in
drm_plane_funcs to .atomic_create_state, aligning with standard DRM state
creation expectations.

> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/dr=
m/fsl-dcu/fsl_dcu_drm_plane.c
> index b34f880c1e098..92794b337512c 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> @@ -177,7 +177,7 @@ static const struct drm_plane_funcs fsl_dcu_drm_plane=
_funcs =3D {
>  	.atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  	.destroy =3D drm_plane_helper_destroy,
>  	.disable_plane =3D drm_atomic_helper_disable_plane,
> -	.reset =3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
>  	.update_plane =3D drm_atomic_helper_update_plane,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes=
=20
to fsl_dcu_drm_plane_funcs, I noticed a pre-existing issue in the same file.

Can this lead to a NULL pointer dereference in the error path of
fsl_dcu_drm_primary_create_plane()?

If drm_universal_plane_init() fails, primary is freed and set to NULL,
but the execution then proceeds to call drm_plane_helper_add() with the
NULL primary pointer:

drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c:fsl_dcu_drm_primary_create_plan=
e() {
	...
	ret =3D drm_universal_plane_init(dev, primary, 0,
				       &fsl_dcu_drm_plane_funcs,
				       ...
				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
	if (ret) {
		kfree(primary);
		primary =3D NULL;
	}
	drm_plane_helper_add(primary, &fsl_dcu_drm_plane_helper_funcs);
	...
}

Would it be better to return NULL immediately after freeing primary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-plane-reset-v3-0-1877c7aa57b3@kernel.org?part=3D5
