Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17228C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB3310E0CC;
	Mon, 31 Aug 2026 21:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qb2vxoAO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBE610E0CC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:56:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 17E2A601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941111F000E9;
 Mon, 31 Aug 2026 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788213405;
 bh=eQGwF3SNgNcDvDsU9vMR14pU7TZdrVUyF7CPvmfWfsQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qb2vxoAOvmKB6vDLImYHdXPp4HpLP11Ta+FOSVrfA8Dv++lCIwR+Ma9L+LluIZRWY
 B/+jjCwlRD4wIwnC3in51kzZdz0sSzomgEfGFdOkGsnrpcdv04m9XyaY0ETR6fIaqP
 y1kaKDOXDvUMux92a+jOvyGfoYcaW8an1DgyxW6JkS5HAZ9wfKOnwQFp99gGNOyxWb
 KCeZxKzHzUCHwo9l8NRm5ugqHgj0ZuhmNvr8M9GQHcOwZ4wcHbXEiQfOIMtrXrytUF
 pvTLWwwJMKkUNaM/U8FX5sA3UhVUZGixYKn0UYND2XpaY0UQ3zsmPMtTlV9jdsCiGW
 VezMnRScPZF4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 28/40] drm/atmel-hlcdc: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-28-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-28-1877c7aa57b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:56:45 +0000
Message-Id: <20260831215645.941111F000E9@smtp.kernel.org>
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
- [High] A NULL pointer dereference occurs in atmel_hlcdc_plane_atomic_dupl=
icate_state if plane->state is NULL.
--

commit 004bf4e4c17577d951c839204e87ff451eddcce3
Author: Maxime Ripard <mripard@kernel.org>

drm/atmel-hlcdc: Convert to atomic_create_state

This commit converts the plane reset implementation to use the standard
atomic_create_state hook. The change was generated using a Coccinelle
semantic patch to automate the transformation.

> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gp=
u/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 70a1cef24388f..e09ce6342085d 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -1183,31 +1183,31 @@ static void atmel_hlcdc_plane_atomic_destroy_stat=
e(struct drm_plane *p,
[ ... ]
> -static void atmel_hlcdc_plane_reset(struct drm_plane *p)
> +static struct drm_plane_state *atmel_hlcdc_plane_create_state(struct drm=
_plane *p)
>  {
>  	struct atmel_hlcdc_plane_state *state;
> -
> -	if (p->state) {
> -		atmel_hlcdc_plane_atomic_destroy_state(p, p->state);
> -		p->state =3D NULL;
> -	}
> +	int ret;
> =20
>  	state =3D kzalloc_obj(*state);
> -	if (state) {
> -		if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
> -			kfree(state);
> -			drm_err(p->dev,
> -				"Failed to allocate initial plane state\n");
> -			return;
> -		}
> -		__drm_atomic_helper_plane_reset(p, &state->base);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);

[Severity: High]
This is a pre-existing issue, but could a failure here cause a NULL pointer
dereference later?

If this initial allocation fails during device probe or reset, the DRM core
leaves p->state as NULL.

When a subsequent atomic modeset is initiated, the core calls the driver's
atomic_duplicate_state hook. In atmel_hlcdc_plane_atomic_duplicate_state(),
this NULL state is retrieved:

    struct atmel_hlcdc_plane_state *state =3D
            drm_plane_state_to_atmel_hlcdc_plane_state(p->state);

And then directly passed to kmemdup():

    copy =3D kmemdup(state, sizeof(*state), GFP_KERNEL);

Since kmemdup() does not check for a NULL source pointer, this leads to a
kernel panic inside its internal memcpy() call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-plane-reset-v3-0-1877c7aa57b3@kernel.org?part=3D28
