Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E73C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C712E10EAE5;
	Mon, 21 Sep 2026 16:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GYJEoQvc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EEFE10E3D8
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:05:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4316743B3F;
 Mon, 21 Sep 2026 16:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEE11F00893;
 Mon, 21 Sep 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790006707;
 bh=zrF9ssxa2GyGpqiwq+vIOln9Y3m4ZbB7kStuuxKoHbk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GYJEoQvcz3jmREvkqJ9xOUkOfdNFYthRmb39a/zx0YwqVRbpBLZXpA5M1qt1mrWKK
 Ykvs7Cq+SbWcWba/YRP0mV2sTZgxHiAKxdJRxKaC2tptZ9P31QgHg9ik1wrNxJaFzg
 ipRLFd5G1nlLUAmKx9HcVLNGXiQasY16CbqWOGd08zGEgkaFXHUJ3H7QnhJLnFkRs/
 tExdogHKqwCutfe+/j3BEqVHPZgc3K+AQZTdZywpgAaMqSEAsU7nekwsdnMfbZbnd2
 TaasWMCjHqMR3IGrGFxxClyv0xv/XRen2azsVQT3Za4Fbmc7TA+dH2M0P3iFav0zeT
 UKvWSXHNxNrcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/25] drm/crtc-helper: Add VRR helper functions
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-7-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-7-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:05:06 +0000
Message-Id: <20260921160506.EEEE11F00893@smtp.kernel.org>
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
- [High] drm: data race and atomic state violation in VRR helpers
--

commit cd3351e2a707f9bec1527caf2353e335222e5295
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/crtc-helper: Add VRR helper functions

This commit introduces two VRR helper functions, drm_crtc_helper_vrr_flush
and drm_crtc_helper_vrr_vsync. They modify the vertical front porch timing
to change the duration of a frame and update the internal VRR state.

> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc=
_helper.c
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
[ ... ]
> +bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_crtc_vrr_state *vrr =3D &crtc_state->vrr_state;
> +
> +	if (!crtc_state->vrr_enabled) {
> +		if (vrr->cur_vtotal) {
> +			vrr->cur_vtotal =3D 0;
> +			return true;
> +		}
> +		return false;
> +	}
> +
> +	if (vrr->cur_vtotal =3D=3D vrr->base_vtotal)
> +		return false;
> +
> +	vrr->cur_vtotal =3D vrr->base_vtotal;

[Severity: High]
Does this code modify the atomic CRTC state from process context?

In DRM, the active crtc->state is strictly immutable after commit.
Modifying it directly contributes to the improper use of atomic state
objects as dynamic hardware trackers, breaking state duplication invariants.

> +
> +	return true;
> +}
> +EXPORT_SYMBOL(drm_crtc_helper_vrr_flush);
[ ... ]
> +bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_crtc_vrr_state *vrr =3D &crtc_state->vrr_state;
> +	u16 old_vtotal =3D vrr->cur_vtotal;
> +
> +	if (!crtc_state->vrr_enabled)
> +		vrr->cur_vtotal =3D 0;
> +	else
> +		vrr->cur_vtotal =3D vrr->max_vtotal;

[Severity: High]
Does this modify the immutable atomic CRTC state directly from an interrupt
handler?

Modifying it from an IRQ asynchronously without the CRTC mutex creates a da=
ta
race when drm_atomic_helper_crtc_duplicate_state() copies the state for a n=
ew
concurrent commit. The hardware tracking state (cur_vtotal) can be copied
mid-mutation, replacing the software request state with torn hardware state,
potentially causing torn reads and visual stuttering.

> +
> +	if (abs_diff(vrr->cur_vtotal, old_vtotal) > 1)
> +		vrr->dynamic =3D true;
> +
> +	return old_vtotal !=3D vrr->cur_vtotal;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D7
