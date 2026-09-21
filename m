Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60738C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C7B10EAB7;
	Mon, 21 Sep 2026 16:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XmBCw4ow";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3500810EAB7
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:17:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD39D60120;
 Mon, 21 Sep 2026 16:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442411F000FF;
 Mon, 21 Sep 2026 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007477;
 bh=E7D9KP3EtEzoMUVIKXv+hJkuWMfOtNwDc6jaxq1salQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XmBCw4owg9gjlR5KX7xuvKOaTCeXTThu2fxDvG1UZH4dzHIgzTkueU6GZUeEqzT7K
 RwLG+XWnaUlL3NOkWgyLLIsOhsNMy0Q3L8OKoy/+560qQHAPCfBRsx51e3d0L9OErR
 lxZVhKE1GolYFVEWr3HliFAteeblCTzyALV6zJ2L/crTSl4cbIttBq1a5qbyKdekNS
 5vNAkfhuMtoTyzzKVSZkotoNTyqvSy7XAFzxcQj/mgbGjswhgGYUBr6VNHdNmZ0Jjg
 unyI4JYWHge09Ulsrze3fOZC1F+wATxv8NLDfZyLvmBegvzq22zpXndutUnpPZtPGv
 pLghKpSjVDe4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 14/25] drm: Implement VRR rate limiting
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-14-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-14-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:17:56 +0000
Message-Id: <20260921161757.442411F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm: integer overflow and implicit sign conversion in VRR vsync pa=
cing
- [Medium] drm: missing initialization of VRR accumulator cur_err on rate t=
ransitions
- [Medium] drm: fixed VRR target rates bypass sink's max_vfreq capability c=
heck
- [Low] drm: redundant check_mul_overflow and unused limit_d in VRR limits =
validation
--

commit d061573186c289ab886bdae3285afbec3f7304ae
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

    drm: Implement VRR rate limiting

    Currently, VRR is allowed to use the entire range advertised by the
    sink's EDID. Userspace may find it desirable, however, to limit this
    range, or set a fixed target rate entirely. The latter is mainly useful
    for multimedia playback applications, where judder can be avoided by
    matching the content's frame rate precisely.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 33d0c94916430..7dbd678cf0612 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
[ ... ]
> @@ -1046,6 +1047,39 @@ static int hdmi_calculate_vtotal(const struct drm_=
display_mode *mode,
>  	return 0;
>  }
> =20
> +static int hdmi_validate_vrr_limits(struct drm_crtc_state *crtc_state, u=
16 vrr_min)
> +{
> +	struct drm_crtc_vrr_state *vrr_state =3D &crtc_state->vrr_state;
> +	const struct drm_display_mode *mode =3D &crtc_state->mode;
> +	u32 limit_d;
> +	int ret;
> +
> +	/* No limiter, don't need to validate, but reset the error */
> +	if (!drm_crtc_helper_vrr_is_fixed_rate(vrr_state)) {
> +		vrr_state->per_frame_err =3D 0;
> +		return 0;
> +	}
> +
> +	/* Don't allow rates equal to or below the minimum VRR rate / 1.001 */
> +	if (cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
> +			 vrr_min * 1000, 1001) < 0)
> +		return -EINVAL;
> +
> +	if (check_mul_overflow(mode->crtc_htotal, vrr_state->vrr_min_n, &limit_=
d))
> +		return -ERANGE;

[Severity: Low]
Is the limit_d variable ever used after being assigned in this overflow che=
ck?

Also, doesn't hdmi_calculate_vtotal() duplicate the exact same
mode->crtc_htotal * rate_n check immediately below, making this check
redundant?

> +
> +	ret =3D hdmi_calculate_vtotal(&crtc_state->mode, vrr_state->vrr_min_n,
> +				    vrr_state->vrr_min_d, &vrr_state->base_vtotal,
> +				    &vrr_state->denom, &vrr_state->per_frame_err);

[Severity: Medium]
When userspace changes the fixed VRR target rate or switches from dynamic
to fixed VRR, does this state transition leave the old cur_err
accumulator value intact?

If the new denom is significantly smaller than the old one, could a
disproportionately large carried-over cur_err take thousands of frames
to drain, causing a persistent frame rate artifact (stuck at
base_vtotal + 1) for several seconds?

> +	if (ret)
> +		return ret;
> +
> +	if (vrr_state->base_vtotal < mode->crtc_vtotal)
> +		return -EINVAL;
> +
> +	return 0;
> +}
[ ... ]
> @@ -1112,25 +1151,64 @@ static int hdmi_validate_vrr(struct drm_connector=
 *connector,
> =20
>  	vrr_state->vic =3D drm_match_cea_mode(mode);
> =20
> -	if (cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > =
0) {
> -		drm_dbg_kms(dev, "Target max (%u/%u) > target min (%u/%u)\n",
> -			    max_vfreq_n, max_vfreq_d, min_vfreq_n, min_vfreq_d);
> -		return -EINVAL;
> -	}
> -
> -	ret =3D hdmi_calculate_vtotal(mode, max_vfreq_n, max_vfreq_d,
> -				    &vrr_state->base_vtotal, NULL, NULL);
> +	ret =3D hdmi_validate_vrr_limits(new_crtc_state, min_vfreq_n);
>  	if (ret) {
> -		drm_dbg_kms(dev, "Couldn't calculate base_vtotal: %pe\n", ERR_PTR(ret)=
);
> +		drm_dbg_kms(dev, "Invalid VRR fixed target rate: %pe\n", ERR_PTR(ret));
>  		return ret;
>  	}
> =20
> -	/*
> -	 * Even at its fastest, it can't go faster than the mode, so
> -	 * clamp to avoid imprecisely rounded mode_refresh values we
> -	 * can't do anything about from ruining our day.
> -	 */
> -	vrr_state->base_vtotal =3D max(vrr_state->base_vtotal, mode->crtc_vtota=
l);
> +	if (!is_fixed) {

[Severity: Medium]
If a userspace DRM client requests a fixed VRR target rate, does wrapping
the capability checks in if (!is_fixed) cause the driver to silently
bypass validating against the monitor's max_vfreq?

If the monitor's EDID advertises a max_vfreq strictly lower than the
mode's refresh rate, couldn't userspace improperly exceed the sink's
hardware capabilities?

> +		vrr_state->dynamic =3D true;
> +
> +		if (vrr_state->vrr_min_n) {
> +			if (!vrr_state->vrr_min_d)
> +				return -EINVAL;
[ ... ]
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc=
_helper.c
> index 4ffb3b0b78780..c46de778df309 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
[ ... ]
> @@ -889,10 +908,21 @@ bool drm_crtc_helper_vrr_vsync(struct drm_crtc_stat=
e *crtc_state)
>  	struct drm_crtc_vrr_state *vrr =3D &crtc_state->vrr_state;
>  	u16 old_vtotal =3D vrr->cur_vtotal;
> =20
> -	if (!crtc_state->vrr_enabled)
> +	if (!crtc_state->vrr_enabled) {
>  		vrr->cur_vtotal =3D 0;
> -	else
> +		vrr->cur_err =3D 0;
> +	} else if (drm_crtc_helper_vrr_is_fixed_rate(vrr)) {
> +		if (vrr->cur_err * 2 >=3D vrr->denom) {

[Severity: High]
Since vrr->cur_err is an int and vrr->denom is a u32, can this
cause an implicit sign conversion bug?

When userspace sets a fixed VRR rate where per_frame_err < denom / 2,
cur_err becomes negative after vrr->cur_err -=3D vrr->denom executes.

Because vrr->denom is a u32, won't C integer promotion rules implicitly
cast the negative int to a massive u32, causing this check to be
unconditionally true every frame thereafter?

> +			vrr->cur_err -=3D vrr->denom;
> +			vrr->cur_vtotal =3D vrr->base_vtotal + 1;
> +		} else {
> +			vrr->cur_vtotal =3D vrr->base_vtotal;
> +		}
> +
> +		vrr->cur_err +=3D vrr->per_frame_err;
> +	} else {
>  		vrr->cur_vtotal =3D vrr->max_vtotal;
> +	}
[ ... ]
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index df37f4ebb58ed..00e9df02f3d5e 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -71,6 +71,9 @@ struct drm_crtc_vrr_state {
>  	u32 vrr_min_d;
>  	u32 vrr_max_n;
>  	u32 vrr_max_d;
> +	u32 denom;
> +	u32 per_frame_err;
> +	int cur_err;

[Severity: High]
Does declaring cur_err as an int while denom is a u32 cause the
signed/unsigned comparison flaw in drm_crtc_helper_vrr_vsync()?

>  	u16 base_vtotal;
>  	bool dynamic;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D14
