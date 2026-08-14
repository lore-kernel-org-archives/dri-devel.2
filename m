Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA97C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96C710F688;
	Fri, 14 Aug 2026 15:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fHIMZRtS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D09E10F676
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:30:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91A58600C3
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BA91F000E9;
 Fri, 14 Aug 2026 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721451;
 bh=zNfZ8iouWrouq8YZVtUNjX1iFK176tAx01Zmq0FaFEg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fHIMZRtSfLrJ6ZekgndRXekfF6ar6U8UYK0BY9nwEV3HxEar+OZzyeOiw+m0KwWB9
 hAXnms2z2EYOUrSrG4wkRPeFhUCZSC30Mb6gJLSQXssJXJ/RYafKHRAlcEpAWJecE4
 wFowNybevXHhhRpmnBWgLCmwwzT97J4paRn2J0m0RgRdEi1lDxhFUGlcyeYlw/bMZc
 GEjMoSClqE8Boclkdz5zIFxHFtlhzwDksJwNXnAX7Br5KglpYChvjT1neC5jT2+5BF
 r4xu6cQuCDAo3ro5DMLhRZYKTmR9nDKsbbh5QhEI3xc1ZtsrcJsDach+PkrP/QFMQ1
 XtIaIei0RqGMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 58/61] drm/vmwgfx: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-58-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-58-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:30:50 +0000
Message-Id: <20260814153051.27BA91F000E9@smtp.kernel.org>
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
- [High] Missing NULL check on `plane->state` leads to a NULL pointer deref=
erence in `kmemdup()`.
--

--- Patch [58]: [PATCH v2 58/61] drm/vmwgfx: Convert to atomic_create_state=
 ---
commit 4ecc3dc3826a2081d66677b1fc848a7ce4eeb905
Author: Maxime Ripard <mripard@kernel.org>

drm/vmwgfx: Convert to atomic_create_state

The plane reset implementation creates a custom state subclass, but only
initializes a pristine state without resetting any hardware. This is
equivalent to what atomic_create_state expects. Convert to it.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 1b407b61f6838..dd9960060b08b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -287,27 +287,24 @@ vmw_du_plane_duplicate_state(struct drm_plane *plan=
e)

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference in vmw_du_plane_duplicate_state() which is located just above
this diff hunk.

If vmw_du_plane_create_state() fails to allocate memory, it returns
ERR_PTR(-ENOMEM). The DRM core handles this but can leave plane->state as
NULL. Later, when an atomic commit accesses the plane, it invokes
vmw_du_plane_duplicate_state(), which does:

	vps =3D kmemdup(plane->state, sizeof(*vps), GFP_KERNEL);

Since plane->state is passed directly to kmemdup() without a NULL check,
could this lead to a kernel panic during userspace atomic commits? The CRTC
and connector equivalents appear to have a WARN_ON(!crtc->state) guard.
Should a similar check be added for planes?

> =20
> =20
>  /**
> - * vmw_du_plane_reset - creates a blank vmw plane state
> + * vmw_du_plane_create_state - creates a blank vmw plane state

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D58
