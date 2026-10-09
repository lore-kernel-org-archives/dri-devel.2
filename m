Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3005CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311E310FE45;
	Fri,  9 Oct 2026 03:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XCvQASzV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD17610FE45
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:34:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5130B60DB0;
 Fri,  9 Oct 2026 03:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06621F000FF;
 Fri,  9 Oct 2026 03:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791516871;
 bh=uLEBDTGSrOERnuwBKCOruRVL+fRG9kRlOZ7F9Hcdxlo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XCvQASzV9uLMnjIXf45ghnsvi147o/1NAhhkkcnl8kJzJeem1lzbDtTkQ2TmzXKW4
 Ip6yKKf5IUjr1ikrR7GfbwiPdDlZA9rq08KTECtYlcBrJA5jcM4Y02wo943kz2miTH
 y5XwNi7ckr3s8jk/9QrP4S9HUGesPaDMtCpJxf7kT0z1z9fahPbs9YrvpVfW8PEWx8
 Uhp3RXpJBs3sCFwiq7MSu+bZ3Nbo4VX/Vu5Y1HNkwQl9MPyS6dzePdeCkc+WY7AhmP
 0I3sb+zG7wcgPI5mScP6knEpfCOnqduhvQ3QyX2jCIoWESs8+eoWXHnKlAfkrPGqLE
 kR2I5QzXiLsJQ==
Message-ID: <sashiko-outbox-164774@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/20] drm/msm/dp: Track VSC packets in bridge atomic
 state
To: "Xilin Wu" <sophon@radxa.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-17-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-17-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:34:30 +0000
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
- [Medium] drm/msm/dp: persistent peripheral flush after disabling VSC SDP =
(state stickiness)
--

commit b5e9083e5d055244149a4e0660254522762ffc0e
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Track VSC packets in bridge atomic state

This commit moves YUV420 VSC construction to the atomic check phase and
retains the packed packet in the private bridge state. It also programs
the packet unchanged for normal streams while deriving the peripheral
flush from both the old and new states.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -679,7 +681,8 @@ static int msm_dp_init_sub_modules(struct msm_dp_disp=
lay_private *dp)
>  static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
>  				   const struct drm_display_mode *adjusted_mode,
>  				   struct msm_dp_panel *msm_dp_panel,
> -				   const struct msm_dp_bridge_state *state)
> +				   const struct msm_dp_bridge_state *state,
> +				   const struct msm_dp_bridge_state *old_state)
>  {
>  	struct msm_dp_display_private *dp;
>  	u32 bpp;
> @@ -691,8 +694,7 @@ static int msm_dp_display_set_mode(struct msm_dp *msm=
_dp_display,
>  	else
>  		bpp =3D state->bpp;
> =20
> -	msm_dp_panel->sdp_needs_flush =3D msm_dp_panel->msm_dp_mode.out_fmt_is_=
yuv_420 ||
> -		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_=
mode);
> +	dp->sdp_needs_flush =3D old_state->vsc_enabled || state->vsc_enabled;

[Severity: Medium]
When transitioning from a mode with VSC SDP enabled (e.g., YUV420) to a mode
without it (RGB), the display controller requires a peripheral flush to app=
ly
the disabled SDP configuration. Here, the expression correctly evaluates to
true for that transition frame.

However, since msm_dp_display_set_mode() is only executed during
atomic_pre_enable (on modesets), does this code leave the flush flag
persistently enabled?

Because there is no mechanism here to clear dp->sdp_needs_flush after the
transition frame completes, it appears the flag will stay true for all
subsequent non-modeset page flips.

[ ... ]

> @@ -1563,7 +1578,7 @@ bool msm_dp_needs_periph_flush(const struct msm_dp =
*msm_dp_display,
>  	struct msm_dp_display_private *dp =3D container_of(msm_dp_display,
>  					struct msm_dp_display_private, msm_dp_display);
> =20
> -	return dp->panel->sdp_needs_flush;
> +	return dp->sdp_needs_flush;

[Severity: Medium]
The DPU encoder queries msm_dp_needs_periph_flush() on every frame kickoff.

If the value remains stuck at true after a transition away from a VSC SDP
mode, does this cause the hardware to perform unnecessary peripheral flushes
on every VSYNC during the entire duration of the new mode?

Could we provide a way to clear the flush flag once the transition frame has
been successfully kicked off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D17
