Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7157C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E82E10E1E3;
	Mon, 20 Jul 2026 21:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eN3NeMjj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D545C10E1DC
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 21:08:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB457437AC;
 Mon, 20 Jul 2026 21:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7467A1F000E9;
 Mon, 20 Jul 2026 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784581693;
 bh=Jt3q5T3l2h6jdM81vA2uiwevEbavmOqfYgYsRHcPMEc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eN3NeMjjBLsFxxvAFmhqgIxCX+mD5ryCNb7Xx2/txcmU+dg4cmbgEVqI2W+oe4eOh
 f6BRZ5eg4WM6U/85lRyGuM4DtaIjFrOjYqzaJHCVLU4/s9ELIxtpq3eHMmiQpJiBAS
 emr/bo9aqw+pU8FLmUaSMt2Hj22QH0TPyCIAHunYqH21U3rlXr7xb6B7FqeSwNjhuU
 qnyy9nn84D9e0d6mdZ7BJOUl3H4wAE2PdeekoigERYw6E7+H84FURX4V3nA7+IC/ei
 fB1ZTPR0m2WMQkDE5ZpTEtBfwV8162ZFK8r3eYeL2f6T51p9CaIYprDt+hV11x+cEJ
 +aIAmQY9VBBHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/nouveau/kms/nv50-: Introduce
 nv50_wndw_default_state()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720205541.257781-3-lyude@redhat.com>
References: <20260720205541.257781-1-lyude@redhat.com>
 <20260720205541.257781-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 21:08:12 +0000
Message-Id: <20260720210813.7467A1F000E9@smtp.kernel.org>
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
- [High] Incorrect comparison between the enum value `pixel_blend_mode` and=
 the bitmask `blend_modes` causes a valid default mode to be silently overw=
ritten.
--

--- Patch [2]: [PATCH v2 2/3] drm/nouveau/kms/nv50-: Introduce nv50_wndw_de=
fault_state() ---
commit 43504d2c3aaff4f127ccc271e9439f3f380cd55b
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()

This commit introduces nv50_wndw_default_state() to enforce a valid
pixel_blend_mode for planes supporting alpha channels during driver startup.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.c
> index 2635458d52acc..0f331f47bded8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c

[ ... ]

> @@ -848,6 +848,28 @@ static const u64 nv50_cursor_format_modifiers[] =3D {
>  	DRM_FORMAT_MOD_INVALID,
>  };
> =20
> +/*
> + * Setup defaults for the atomic wndw state
> + */
> +void
> +nv50_wndw_default_state(struct nv50_wndw *wndw)
> +{
> +	struct nv50_wndw_atom *armw =3D nv50_wndw_atom(wndw->plane.state);
> +	const unsigned int blend_modes =3D wndw->func->blend_modes;
> +
> +	drm_modeset_lock_assert_held(&wndw->plane.mutex);
> +
> +	/* Ensure the plane's atomic state didn't default to a pixel_blend_mode=
 we don't support */
> +	if (blend_modes && (!(armw->state.pixel_blend_mode & blend_modes))) {

[Severity: High]
Does this incorrectly perform a bitwise AND between an enum value and a bit=
mask?

Since DRM_MODE_BLEND_PREMULTI is defined as 0, when pixel_blend_mode defaul=
ts
to PREMULTI, armw->state.pixel_blend_mode & blend_modes will evaluate to 0.

This causes the negation !(0) to evaluate to true, unintentionally entering
this block and overwriting the valid default mode with DRM_MODE_BLEND_COVER=
AGE.

Should this comparison be using BIT(armw->state.pixel_blend_mode) & blend_m=
odes
to properly check if the enum value is supported by the bitmask?

> +		if (blend_modes & BIT(DRM_MODE_BLEND_COVERAGE))
> +			armw->state.pixel_blend_mode =3D DRM_MODE_BLEND_COVERAGE;
> +		else if (blend_modes & BIT(DRM_MODE_BLEND_PREMULTI))
> +			armw->state.pixel_blend_mode =3D DRM_MODE_BLEND_PREMULTI;
> +		else if (blend_modes & BIT(DRM_MODE_BLEND_PIXEL_NONE))
> +			armw->state.pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720205541.2577=
81-1-lyude@redhat.com?part=3D2
