Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D1C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0AB10E1EC;
	Mon, 20 Jul 2026 22:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iFy05tfM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99FF10E1EC
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 22:06:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5384942B94;
 Mon, 20 Jul 2026 22:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6851F000E9;
 Mon, 20 Jul 2026 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784585193;
 bh=jh6fRXb9c3bEbQaeMgUV456Yi1ZMa0tZYHl0Y2cJpvE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iFy05tfMlIwBt9XxC3NQB14sCvpmRRzRgE6sqQe0qVLX6TO7FEU2B6pl6a+miVOrd
 lHrlM4/vTEUm/XaTjYzKwcR9fPG2OOLYQmzZ9OdIMQpr2BHx7r3DoW/YviV23kX4TM
 5dfou3lGtFZXzw7vUxTqLS51/49X9SWEhqCoWaLp865iG1WuhiVcjEMXtV0XYv9h6s
 Iw1oAemFuKNevsXufmZ/5LCPlp5QBFmG5h/7z7i/c+KCypLFGYl7jlro5T8/3a7F10
 5am6hftQahW0JU0YPnyyvPwoWmGSRIHX+hrqihjcnP0HZc2YRE8E4glgyAx1PbMylr
 9s+JSCoNakNsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/nouveau/kms/nv50-: Introduce
 nv50_wndw_default_state()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720215058.398210-3-lyude@redhat.com>
References: <20260720215058.398210-1-lyude@redhat.com>
 <20260720215058.398210-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 22:06:32 +0000
Message-Id: <20260720220633.0A6851F000E9@smtp.kernel.org>
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
- [High] Unconditional dereference of `wndw->plane.state` which may be NULL=
 if the initial state allocation fails.
--

--- Patch [2]: [PATCH v3 2/3] drm/nouveau/kms/nv50-: Introduce nv50_wndw_de=
fault_state() ---
commit 2d2dcbda94d37e6b985a1775b04d636840fd94c1
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()

This commit introduces nv50_wndw_default_state() to ensure the initial
atomic state for a window always starts with a supported value in
pixel_blend_mode. It hooks this function into nv50_display_read_hw_state()
to enforce a valid blend mode value during driver startup.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.c
> index 2635458d52acc..dfa1ba45acd99 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c

[ ... ]

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
> +	if (blend_modes && (!(BIT(armw->state.pixel_blend_mode) & blend_modes))=
) {

[Severity: High]
Could this dereference a NULL pointer if memory allocation fails during
drm_mode_config_reset()?

If plane state allocation fails in the plane's reset hook, wndw->plane.state
is left as NULL. When nv50_display_read_hw_state() subsequently calls this
function, armw will evaluate to NULL, leading to a fault when accessing
armw->state.pixel_blend_mode.

> +		if (blend_modes & BIT(DRM_MODE_BLEND_COVERAGE))
> +			armw->state.pixel_blend_mode =3D DRM_MODE_BLEND_COVERAGE;
> +		else if (blend_modes & BIT(DRM_MODE_BLEND_PREMULTI))
> +			armw->state.pixel_blend_mode =3D DRM_MODE_BLEND_PREMULTI;
> +		else if (blend_modes & BIT(DRM_MODE_BLEND_PIXEL_NONE))
> +			armw->state.pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720215058.3982=
10-1-lyude@redhat.com?part=3D2
