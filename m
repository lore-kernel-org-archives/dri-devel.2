Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F81C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323FD10F5B4;
	Thu,  9 Jul 2026 12:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oTPWIjK+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2579E10F5A0
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:33:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40F8460EEF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA81F000E9;
 Thu,  9 Jul 2026 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783600427;
 bh=J1j+sIyhKQngAmkw1qForz3WZUGW/ajgN+kBvp8Gl0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oTPWIjK+LlrZSNxNMdD4av3RFVkE9Hv91ZhDSPeG+/tA47yNCMhhjvINochePIoN5
 6aGPHwCwt6Rz7364WWR8wmYJINd8IjXJD+Pf3Fx1FfUPLamksYXgTZoEu/R3H8dZvb
 G96obrU4z5y8ecQQq1pU6eheKrQydqEJLdOvQJQQy6XsJOR2zUCGFL4CS6y8t15rxD
 SFtQUmw5N/nJdhLCBlFyNkHF5KfuFLodk6EgI39QS02cC2+1+9Ps2Dsp6KD7WlRsNR
 hd/3mQpq2jp/Q+DOrBdThZUQGXSXUz/zYmPTbT/MT3+HMexz6qJ05aF0/Q1oscMBgR
 C2rzBODQU4xGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 54/60] drm/sun4i: layer: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-54-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-54-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:33:46 +0000
Message-Id: <20260709123346.B8DA81F000E9@smtp.kernel.org>
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
- [Medium] Leftover state destruction code in `atomic_create_state` callbac=
k violates API contract
--

--- Patch [54]: [PATCH 54/60] drm/sun4i: layer: Convert to atomic_create_st=
ate ---
commit 85f4174b6e45254800a7a99399fee4bf10972b0f
Author: Maxime Ripard <mripard@kernel.org>

drm/sun4i: layer: Convert to atomic_create_state
   =20
This commit converts the plane reset implementation in sun4i to use
atomic_create_state instead. The conversion relies on a Coccinelle semantic
patch to rename the functions and update the DRM plane function assignments.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/=
sun4i_layer.c
> index d65587d96d9ee..b165960ca8e5d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -16,7 +16,7 @@
>  #include "sun4i_layer.h"
>  #include "sunxi_engine.h"
> =20
> -static void sun4i_backend_layer_reset(struct drm_plane *plane)
> +static struct drm_plane_state *sun4i_backend_layer_create_state(struct d=
rm_plane *plane)
>  {
>  	struct sun4i_layer_state *state;
> =20
> @@ -30,8 +30,12 @@ static void sun4i_backend_layer_reset(struct drm_plane=
 *plane)
>  	}

[Severity: Medium]
Does the Coccinelle script miss the plane state destruction block here?

Looking at sun4i_backend_layer_create_state() in sun4i_layer.c, the untouch=
ed
code right above this hunk still contains legacy state destruction logic:

	if (plane->state) {
		state =3D state_to_sun4i_layer_state(plane->state);
		__drm_atomic_helper_plane_destroy_state(&state->state);
		kfree(state);
		plane->state =3D NULL;
	}

Since atomic_create_state is expected to be a pure constructor without side
effects, shouldn't this block be removed?

While plane->state is currently guaranteed to be NULL when this is called by
the DRM core, retaining this block could lead to a use-after-free if any dr=
iver
logic later calls this hook directly on an active plane.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D54
