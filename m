Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286DAC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822B789E2A;
	Tue, 28 Jul 2026 10:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DbYPPZCx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5076110E869
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:38:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB18F4073E;
 Tue, 28 Jul 2026 10:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A448E1F000E9;
 Tue, 28 Jul 2026 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785235132;
 bh=ws6RYRnllcK/oHYF1BlnkFmw+f3/ADGFatzbTCmVWYA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DbYPPZCxNDM1kf24M5nXwb+ONktqrToULi+TMQPN9sdwHFqeTLDa1Jueea+X1FEHs
 l4EjSLPlUE8ek2Axa9M+n37RDI4v9sJhNddpsLTsYY3cE8Qi914YmS199jrHEyJ07a
 DwsBUAQy0vXbdLrSJKAR6Ix0+/VJh2PcfAx1/ZQVaBC3bkCPVzo1ssP7Jx1EFjB1z3
 klQ8McWZ2srN1Ilv31HaZzrGXWsB6trpmAC2hfHa/tTsW3tQnTEZC2p27WE7DdpSG6
 5B63USwmOhBjEByImQn8v0SptwDC6KOZOkTDk+vTq13/N6pZ2zSJSAPSDZ5zPpq56N
 4+47VomU0Tyzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/14] drm/msm/dp: make bridge helpers use dp_display
 to allow re-use
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-dp_mstclean-v9-13-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
 <20260728-dp_mstclean-v9-13-f7779fce10f4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 10:38:52 +0000
Message-Id: <20260728103852.A448E1F000E9@smtp.kernel.org>
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
- [Medium] Hardcoded encoder lookup in `msm_dp_display_atomic_pre_enable` b=
reaks the intended MST reuse by dropping the virtual bridge context.
--

--- Patch [13]: [PATCH v9 13/14] drm/msm/dp: make bridge helpers use dp_dis=
play to allow re-use ---
commit 9cd0096573edf67dd79ce85b7bf559799b84cbe4
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: make bridge helpers use dp_display to allow re-use

This patch modifies DP bridge helpers to directly take a msm_dp display
object rather than extracting it from drm_bridge. The stated goal is to
allow the MST bridge to reuse these same helpers.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 9b9e96b683c71..88ca263010c60 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -1408,18 +1405,16 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_dis=
play, struct drm_device *dev,
>  	return 0;
>  }
> =20
> -void msm_dp_bridge_atomic_pre_enable(struct drm_bridge *drm_bridge,
> -				     struct drm_atomic_commit *state)
> +void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
> +				      struct drm_atomic_commit *state)
>  {
> -	struct msm_dp_bridge *msm_dp_bridge =3D to_dp_bridge(drm_bridge);
> -	struct msm_dp *dp =3D msm_dp_bridge->msm_dp_display;
> -	struct msm_dp_display_private *msm_dp_display;
> +	struct msm_dp_display_private *dp;
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *crtc_state;
> =20
> -	msm_dp_display =3D container_of(dp, struct msm_dp_display_private, msm_=
dp_display);
> +	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> -	crtc =3D drm_atomic_get_new_crtc_for_encoder(state, drm_bridge->encoder=
);
> +	crtc =3D drm_atomic_get_new_crtc_for_encoder(state, msm_dp_display->bri=
dge->encoder);

[Severity: Medium]
Will this hardcoded encoder lookup prevent MST bridges from reusing this
helper?

During an MST commit, the atomic state contains the virtual MST encoder. By
changing this from the caller's drm_bridge->encoder to the root DP encoder
(msm_dp_display->bridge->encoder), drm_atomic_get_new_crtc_for_encoder()
will return NULL for MST streams. This causes the function to return early
without programming the mode.

Should the helper still take the encoder or the calling bridge as an
argument to support MST reuse?

>  	if (!crtc)
>  		return;
>  	crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-dp_mstclea=
n-v9-0-f7779fce10f4@oss.qualcomm.com?part=3D13
