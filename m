Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0790FCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C9510EEBB;
	Thu, 18 Jun 2026 17:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UTYn35B9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B4610EEBB
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 17:43:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E286660008;
 Thu, 18 Jun 2026 17:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DB11F000E9;
 Thu, 18 Jun 2026 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781804590;
 bh=YdUJEBG7c2c8rp3ikejOx9kXb60VK0it1u92PsE0N9w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UTYn35B9cMi3tFGSVgd4HhpfzYP+vftZKR8P9pR5IBpM/tbFZMfIIjWNKvkzoFIf8
 6WyTCT2aVXDBjQLV0jXV76DxA23tTVuh1IZZf7dJY65oHBOh4i5l6wKa2Wt2FUnyWY
 bEjMhdxwt10IOt6aCdZwbMfpZ9UAT+oiANbMkIYzz8snwig1whFM82baHxnldkZsFX
 Jd9XTL73OCGMNh3pHvnbKsiewRXUDWIP7106I2DQz1Y/sq6j+tRiRSN+pnsAfL134G
 qroDLStFtk8PtWTv4AX+7KMbi9G7OHpuRSuNweQXVwokSRiQEmbTnYevTn47g24gJY
 9W41NwqRBnC6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/fb_helper: Determine proper crtc_index within
 drm_fb_helper_fb_dirty
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com>
References: <5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 17:43:09 +0000
Message-Id: <20260618174310.70DB11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Lockless access to `crtc->state` and `crtc->primary->state` can le=
ad to a Use-After-Free due to concurrent atomic commits.
- [High] The patch breaks vblank synchronization for legacy (non-atomic) DR=
M drivers.
- [Medium] The logic selects the first matching CRTC instead of the last ac=
tive one, contradicting the commit message.
--

commit 0337b26b606b4d905d72ea2be31bcb984fe62c6e
Author: H. Nikolaus Schaller <hns@goldelico.com>

drm/fb_helper: Determine proper crtc_index within drm_fb_helper_fb_dirty

This commit updates the dirty framebuffer worker to search for a matching
active CRTC instead of hardcoding the wait for vblank to CRTC index 0. It
aims to avoid vblank timeouts when CRTC 0 is inactive.

> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
[ ... ]
> @@ -232,9 +232,23 @@ static void drm_fb_helper_fb_dirty(struct drm_fb_hel=
per *helper)
>  	struct drm_clip_rect clip_copy;
>  	unsigned long flags;
>  	int ret;
> +	unsigned int crtc_index =3D 0;
> +	struct drm_crtc *crtc;
> =20
>  	mutex_lock(&helper->lock);
> -	drm_client_modeset_wait_for_vblank(&helper->client, 0);
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		if (crtc->primary && crtc->primary->state &&
> +		    crtc->primary->state->fb =3D=3D helper->fb &&
> +		    crtc->state && crtc->state->active) {

[Severity: High]
Can this lockless access to crtc->state and crtc->primary->state result in a
use-after-free?

The drm_fb_helper_fb_dirty() function holds helper->lock, but does not hold
the DRM modeset locks required to protect these state pointers. During a
concurrent atomic modeset commit, the DRM core allocates new state objects,
swaps them into place, and frees the old objects via kfree().

If this code reads an old state pointer and gets preempted, could it then
dereference the pointer after it has been freed by the concurrent commit?

[Severity: High]
Does this break vblank synchronization for legacy non-atomic DRM drivers?

Legacy drivers do not use the atomic modesetting infrastructure, so their
crtc->state and crtc->primary->state pointers remain NULL. Since the condit=
ion
above requires these pointers to be non-NULL, the loop will skip the vblank
wait entirely for legacy drivers. This skips the intended rate-limiting
behavior and could lead to unbounded damage worker execution.

> +			crtc_index =3D drm_crtc_index(crtc) + 1;
> +			break;

[Severity: Medium]
The commit message states "If multiple CRTCs match, the last active one is
selected." Does the break statement here cause the first active CRTC to be
selected instead, bypassing the remaining matches in the list?

> +		}
> +	}
> +
> +	if (crtc_index > 0)
> +		drm_client_modeset_wait_for_vblank(&helper->client, crtc_index - 1);
> +
>  	mutex_unlock(&helper->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5118b37e579cec220f2=
d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com?part=3D1
