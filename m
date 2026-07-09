Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DB6C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF38910F589;
	Thu,  9 Jul 2026 12:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mn7rpreG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A315010F5AC
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:23:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 18CF56001A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A401F000E9;
 Thu,  9 Jul 2026 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599789;
 bh=+w6vUyralNY4mrEvWSWXTJvXIhNrn4l4DrB/d/PJvE0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mn7rpreGzwvMfxU+rPJzkRGRetZCdiO3agAkNEm2hzw3Vk8v1a4f9XMxQ2iJkXq5a
 cbl2uqVoax9ahwIsSz4D9beeGS3E6tIVhaXeHyZUPQeH6KDxxD/uE2J/iDRBkhvuH7
 R08E7AvORNqhpYe9LdKOHiE6Yuzi5coO3H80OvJ5RgUrM0xQ5ecJFrG/tcIotzFNQn
 k7qo0pqE08rt+6goJYBGbkcSMdQNAMd39cr/ij6idQFBSRqi+I+57IGlZpT5w789qC
 RXaxDConpcp6ekGk5WAR1yjU8AwvpaMD4McmWEMovD59nZy9stjZnWb60mcPHMfvTh
 hj6eR3nXIAY2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 42/60] drm/armada: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-42-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-42-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:23:09 +0000
Message-Id: <20260709122309.A3A401F000E9@smtp.kernel.org>
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
- [Low] Missing static modifier and orphaned prototype for armada_plane_cre=
ate_state.
--

--- Patch [42]: [PATCH 42/60] drm/armada: Convert to atomic_create_state ---
commit ef234958ddf9c7a237937375b8f630e71d5f0286
Author: Maxime Ripard <mripard@kernel.org>

drm/armada: Convert to atomic_create_state

This commit converts the armada plane reset implementation to use
atomic_create_state instead of a custom reset state subclass. The
conversion was performed using a Coccinelle semantic patch.

> diff --git a/drivers/gpu/drm/armada/armada_plane.c b/drivers/gpu/drm/arma=
da/armada_plane.c
> index fe46a8e4508a2..1f5172d6816b3 100644
> --- a/drivers/gpu/drm/armada/armada_plane.c
> +++ b/drivers/gpu/drm/armada/armada_plane.c
[ ... ]
> @@ -256,15 +256,16 @@ static const struct drm_plane_helper_funcs armada_p=
rimary_plane_helper_funcs =3D {
>  	.atomic_disable	=3D armada_drm_primary_plane_atomic_disable,
>  };
> =20
> -void armada_plane_reset(struct drm_plane *plane)
> +struct drm_plane_state *armada_plane_create_state(struct drm_plane *plan=
e)

[Severity: Low]
Should armada_plane_create_state() be marked as static here?

Compiling armada_plane.c without the static modifier triggers a
-Wmissing-prototypes warning for this function since there is no matching
header declaration.

Additionally, since this replaces armada_plane_reset(), does the
armada_plane.h header still contain the obsolete prototype for
armada_plane_reset() that should be cleaned up alongside this change?

>  {
>  	struct armada_plane_state *st;
> -	if (plane->state)
> -		__drm_atomic_helper_plane_destroy_state(plane->state);
> -	kfree(plane->state);
>  	st =3D kzalloc_obj(*st);
> -	if (st)
> -		__drm_atomic_helper_plane_reset(plane, &st->base);
> +	if (!st)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_plane_state_init(&st->base, plane);
> +
> +	return &st->base;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D42
