Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AB7CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A037F10F44C;
	Fri, 26 Jun 2026 07:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X9+jv7yg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3440810F44C
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 07:39:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 146D3402C5;
 Fri, 26 Jun 2026 07:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC301F000E9;
 Fri, 26 Jun 2026 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782459544;
 bh=eXY8FDSRb5eT3g6s5JakCT8NftyFAeZjgCx6Cc53uSI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X9+jv7yguiCsGHPkyowTWTxq5J1BNwW2wIb4fD3gAyvEnkTq7WKHd+RTBhcF6x0UP
 EH9xDgn43eOF9erz8xEO13Y3vlTjbDsjisk7qghJENZwFhFSimcyMd9zRHhEcCTN5d
 dsIzVq9wKdKk1Gq5qDpssLXIHmOaT5xqmbWO/ok1Alf4AnZI4Tqu8oCUxX7gc+f32X
 6kTMRjISpwLlTmSCh4dOdpJML3jkB8scIUtcv+dFpf18553dyIWBFULCe3oLiTac64
 eBRTEAuxMTX+++Cc8B/Oe+6+Kd358lugYLaIV0X1vDFz5lUh9LHzIIPRRNRyZDq78U
 eSRXUGNRzxCSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/fb-helper: Only consider active CRTCs for vblank
 sync
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626073048.453206-1-tzimmermann@suse.de>
References: <20260626073048.453206-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:39:03 +0000
Message-Id: <20260626073903.BCC301F000E9@smtp.kernel.org>
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
- [High] Acquiring multiple modeset locks sequentially without an acquire c=
ontext causes AB-BA deadlocks with concurrent atomic commits and triggers l=
ockdep splats.
--

commit 5bf4951cc945bdc22bbaea8b5337320cd5b7047d
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/fb-helper: Only consider active CRTCs for vblank sync

This commit synchronizes fbdev output only to the vblank of an active
CRTC to prevent vblank wait timeouts. It implements separate atomic and
non-atomic code paths to select the correct active CRTC at runtime.

> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index 7b11a582f8ec4..67b187f5c6bfc 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c

[ ... ]

> +static int find_crtc_index_atomic(struct drm_fb_helper *helper)
> +{
> +	struct drm_device *dev =3D helper->dev;
> +	struct drm_plane *plane;
> +	int crtc_index =3D -EINVAL;
> +
> +	drm_for_each_plane(plane, dev) {
> +		const struct drm_plane_state *plane_state;
> +
> +		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
> +			continue;
> +
> +		drm_modeset_lock(&plane->mutex, NULL);
> +		plane_state =3D plane->state;
> +
> +		if (plane_state->fb =3D=3D helper->fb && plane_state->crtc) {
> +			struct drm_crtc *crtc =3D plane_state->crtc;
> +
> +			drm_modeset_lock(&crtc->mutex, NULL);

[Severity: High]
Can this sequence cause an AB-BA deadlock with concurrent atomic commits?

Because drm_modeset_lock() is called here on both plane->mutex and
crtc->mutex with a NULL acquire context, it falls back to standard blocking
mutex acquisition without the wait/wound deadlock avoidance mechanism.

If a concurrent atomic commit thread from a userspace compositor acquires
crtc->mutex and then attempts to acquire plane->mutex, could this permanent=
ly
hang both threads since the fbdev worker cannot be wound or back off?

> +			if (crtc->state->active)
> +				crtc_index =3D crtc->index;
> +			drm_modeset_unlock(&crtc->mutex);
> +		}
> +		drm_modeset_unlock(&plane->mutex);
> +
> +		if (crtc_index >=3D 0)
> +			break;
> +	}
> +
> +	return crtc_index;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626073048.4532=
06-1-tzimmermann@suse.de?part=3D1
