Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34032CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8324C10EDCF;
	Mon,  5 Oct 2026 15:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="drU99tv6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D67B10EDCF
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:29:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB9AB60514;
 Mon,  5 Oct 2026 15:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AC51F0089A;
 Mon,  5 Oct 2026 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791214188;
 bh=GPzu1Bb++aEV7e5wMvxRDyiW8kLoUne6dg0j31le+yE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=drU99tv62Ru9wz3RB4avRFn4+vIT2OP7GmedJzlNQy4VH6erSa73heh2NZ2vUK/pY
 Puh+cCiQuqI5V0rrZqMGYbkVH3aejLum5hYa/XtjG1VzOX0IbaHFF7+kJpz7J0Kold
 GoLJxotJtBS3tvEeAqMS1B+W+IEk1pk5G0JVk0WVQCBZPcvgNqsn+o+pJjjxopR9A5
 azlYHhLCP6P2reaW/hjvQHG6O2TDCU9d/hyj+9euuK4G6ktFfAHpTq06rPmdVzcX5J
 kALVreLUsOBF6tym9QQ/9j4xpufkOExhlyBmc2oZkcyIEHgKg1PvGV1RET8k3v5DIJ
 EIZ1iTf0wElWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/msm/dp: validate modes against the trained
 link, not the sink's claim
To: "Jean-Francois Bobier" <jean-francois.bobier@laposte.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261005131432.22840-4-jean-francois.bobier@laposte.net>
References: <20261005131432.22840-1-jean-francois.bobier@laposte.net>
 <20261005131432.22840-4-jean-francois.bobier@laposte.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 15:29:47 +0000
Message-Id: <20261005152948.54AC51F0089A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm/dp: stale link training parameters artificially restrict m=
odes after hotplug
- [Medium] drm/msm/dp: data race and TOCTOU in mode validation reading link=
_params
--

commit 69ad059161eff4e2e43af0ffa4e037a24d8b918c
Author: Jean-Francois Bobier <jean-francois.bobier@laposte.net>

drm/msm/dp: validate modes against the trained link, not the sink's claim

This commit updates msm_dp_display_mode_valid() to validate modes against
the trained link parameters rather than the sink's advertised capabilities.
This prevents advertising modes that the link cannot carry after a training
fallback.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 6abe30bdff120..d1e111c6a5fb8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -793,10 +795,42 @@ enum drm_mode_status msm_dp_display_mode_valid(stru=
ct msm_dp *dp,
>  			mode_bpp, link_pclk_khz);
> =20
>  	mode_rate_khz =3D link_pclk_khz * mode_bpp;
> -	supported_rate_khz =3D link_info->num_lanes * link_info->rate * 8;
> =20
> -	if (mode_rate_khz > supported_rate_khz)
> +	/*
> +	 * link_info is what the sink advertises in DPCD, which is not
> +	 * necessarily what we managed to train. msm_dp_ctrl_on_link() walks
> +	 * the rate down HBR3 -> HBR2 -> HBR -> RBR and then halves the lane
> +	 * count until training succeeds, so a cable with two unusable lanes
> +	 * ends up carrying half the bandwidth the sink claims.
> +	 *
> +	 * Sizing modes against the sink's maximum then advertises modes the
> +	 * link cannot carry: training "succeeds" at the reduced parameters,
> +	 * the mode does not fit in them, and the sink shows a black screen
> +	 * with nothing in the log to say why.
> +	 *
> +	 * link->link_params holds the trained values, and is reset to the
> +	 * sink's maximum at the top of every msm_dp_ctrl_on_link(), so taking
> +	 * the lower of the two is accurate after a fallback and a no-op
> +	 * before the first training.
> +	 */
> +	num_lanes =3D link_info->num_lanes;
> +	rate =3D link_info->rate;
> +
> +	trained =3D &msm_dp_display->link->link_params;
> +	if (trained->num_lanes && trained->num_lanes < num_lanes)
> +		num_lanes =3D trained->num_lanes;
> +	if (trained->rate && trained->rate < rate)
> +		rate =3D trained->rate;

[Severity: High]
Will this improperly restrict modes for new monitors after a hotplug?

When a monitor is unplugged, msm_dp_hpd_unplug_handle() and
msm_dp_link_reset_data() do not clear or invalidate link_params.

If the previous monitor fell back to a lower lane count or rate, does this
mean the new monitor's modes will be evaluated against the old monitor's
degraded parameters?

[Severity: Medium]
Is it safe to read trained->num_lanes and trained->rate locklessly here?

During an asynchronous non-blocking modeset, msm_dp_ctrl_on_link() can
modify these values concurrently:

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_on_link() {
    ...
		ctrl->link->link_params.rate =3D rate;
		ctrl->link->link_params.num_lanes =3D panel->link_info.num_lanes;
    ...
}

Since userspace can concurrently read the EDID and trigger mode validation,
could the lack of locking or READ_ONCE() here lead to a data race or a TOCT=
OU
issue where the condition check and subsequent assignment see different
values?

> +
> +	supported_rate_khz =3D num_lanes * rate * 8;
> +
> +	if (mode_rate_khz > supported_rate_khz) {
> +		drm_dbg_dp(dp->drm_dev,
> +			   "mode %s rejected: needs %u kHz, link carries %u kHz (%u lanes @ %=
u)\n",
> +			   mode->name, mode_rate_khz, supported_rate_khz,
> +			   num_lanes, rate);
>  		return MODE_BAD;
> +	}
> =20
>  	return MODE_OK;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005131432.2284=
0-1-jean-francois.bobier@laposte.net?part=3D3
