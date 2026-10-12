Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA68BCA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1F710E497;
	Mon, 12 Oct 2026 04:53:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A7810E40E;
 Mon, 12 Oct 2026 04:53:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E6CF4043F;
 Mon, 12 Oct 2026 04:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037C61F0089B;
 Mon, 12 Oct 2026 04:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780797;
 bh=rvCvOJK/26gje9EzgHEVJMlqrPWYJUqWHR4USq0cA7w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VXmg2hg2ZgNUKnnt1yM2qqxtkls6WRqR6B7olio1zW42yCOEz9vwyAiTe+F9nzZlv
 B4LgiKt1B6yT8X4MJ9rrHQ+8MUa4BLEdc2gUHy3N1fu67IlmxgQl7B9LkcSKTb83ob
 PZ9Ova9ka5F7d3D03Iy146fnGvBPpi38+UiAuXQjgxN7PRJeEgHSwnMcGpflFrnJxw
 PDNGKpgZmJ3MKmyTQzWnegjgrzoBsMhT4tVNUCEJe6aVAH3jU0Ngg1j7xByhYWKmdv
 qvy8nwO/yvDROrPGEdEDcbJMlW3h1xNUacDk86Ni6mikJ9mnYV++BHAfMq0WQt4bt0
 z/lQNsz0qcKNw==
Message-ID: <sashiko-outbox-167640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 47/56] drm/i915/hdmi: Compute output format for HDMI
 FRL mode
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-48-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-48-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:53:16 +0000
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
- [High] drm/i915/hdmi: out-of-spec TMDS fallback takes precedence over val=
id FRL modes
- [High] drm/i915/hdmi: FRL bypassed for modes exceeding sink TMDS limits
- [Medium] drm/i915/hdmi: FRL clock computation corrupts crtc_state->pipe_b=
pp on failure
- [Low] drm/i915: unconditional FRL enablement logging on error path
--

commit 53b28248132a15ea6972675cb5d3f48a3d13e3b3
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi: Compute output format for HDMI FRL mode

If the source and sink support FRL, then compute output format
that can support HDMI FRL mode.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c

[ ... ]

> @@ -2648,13 +2672,23 @@ int intel_hdmi_compute_config(struct intel_encode=
r *encoder,
>  	if (!intel_link_bw_compute_pipe_bpp(pipe_config))
>  		return -EINVAL;
> =20
> -	/*
> -	 * Try to respect downstream TMDS clock limits first, if
> -	 * that fails assume the user might know something we don't.
> -	 */
> -	ret =3D intel_hdmi_compute_formats(encoder, pipe_config, conn_state, tr=
ue);
> -	if (ret)
> -		ret =3D intel_hdmi_compute_formats(encoder, pipe_config, conn_state, f=
alse);
> +	if (HAS_HDMI_FRL(display) &&
> +	    intel_bios_hdmi_max_frl_rate(encoder->devdata) &&
> +	    intel_hdmi->has_sink_hdmi_21)
> +		enable_frl =3D true;
> +
> +	ret =3D intel_hdmi_compute_formats(encoder, pipe_config, conn_state, fa=
lse);
> +
> +	if (ret && enable_frl) {

[Severity: High]
Does this sequence bypass FRL completely for displays with low TMDS limits?

When connecting an HDMI 2.1 sink that supports FRL but has a lower max
TMDS clock than the mode requires, the call to intel_hdmi_compute_formats
with enable_frl=3Dfalse will first fail the strict limit check, but then
internally fall back to ignoring downstream limits:

intel_hdmi_compute_formats() {
    ...
    ret =3D _intel_hdmi_compute_formats(..., true, enable_frl);
    if (ret)
        ret =3D _intel_hdmi_compute_formats(..., false, enable_frl);
    ...
}

If the mode's clock is within the source's max TMDS capability, this
fallback succeeds and returns 0, masking the downstream limit failure.
Because ret evaluates to 0, this FRL configuration block is skipped,
and the driver outputs an out-of-spec TMDS signal instead of attempting
FRL.

Additionally, in intel_hdmi_compute_frl_config, there is a strict
check against max_rate:

intel_hdmi_compute_frl_config() {
    ...
    for (i =3D 0; i < ARRAY_SIZE(rate); i++) {
        if (rate[i] > max_rate)
            continue;
    ...
}

This means the fallback mechanism to ignore downstream limits doesn't
actually allow users to override FRL bandwidth limits either. Could we
attempt FRL before falling back to out-of-spec TMDS formats?

> +		ret =3D intel_hdmi_compute_formats(encoder, pipe_config, conn_state, t=
rue);

[Severity: Medium]
Can intel_hdmi_compute_formats corrupt crtc_state->pipe_bpp if the FRL
computation fails?

When FRL computation is attempted, it calls down to
intel_hdmi_compute_frl_clock which iterates over bpc:

intel_hdmi_compute_frl_clock() {
    ...
    for (bpc =3D max_bpc; bpc >=3D 8; bpc -=3D 2) {
        ...
        crtc_state->pipe_bpp =3D bpc * 3;

        ret =3D intel_hdmi_compute_frl_config(encoder, crtc_state);
        if (ret)
            continue;
    ...
}

If the FRL computation fails across all iterations, crtc_state->pipe_bpp
remains permanently lowered (e.g., to 24). When
_intel_hdmi_compute_formats subsequently falls back to trying the YCBCR420
format, it reads this corrupted pipe_bpp to determine its starting max_bpc.
This artificially restricts the fallback to 8 BPC, skipping 10 and 12 BPC
which require less bandwidth under YCBCR420 and might have otherwise
succeeded.

> +		drm_dbg_kms(display->drm,
> +			    "Enabling FRL mode with lanes =3D %d rate =3D %d\n",
> +			    pipe_config->frl.required_lanes,
> +			    pipe_config->frl.required_rate);
> +		pipe_config->frl.enable =3D true;
> +		lane_count =3D pipe_config->frl.required_lanes;
> +	}

[Severity: Low]
Is it intentional that this block executes unconditionally, even if
intel_hdmi_compute_formats fails?

If the intel_hdmi_compute_formats call above returns a non-zero error
code, the code still executes this drm_dbg_kms claiming FRL is being
enabled with uninitialized or stale lane/rate values, and mutates
pipe_config->frl.enable. While the atomic check will subsequently reject
the mode and discard the state, the debug trace will misleadingly indicate
FRL mode was successfully computed before the mode rejection.

> +
>  	if (ret) {
>  		drm_dbg_kms(display->drm,
>  			    "unsupported HDMI clock (%d kHz), rejecting mode\n",
> @@ -2677,7 +2711,7 @@ int intel_hdmi_compute_config(struct intel_encoder =
*encoder,
>  		adjusted_mode->picture_aspect_ratio =3D
>  			conn_state->picture_aspect_ratio;
> =20
> -	pipe_config->lane_count =3D 4;
> +	pipe_config->lane_count =3D lane_count;
> =20
>  	if (scdc->scrambling.supported && source_supports_scrambling(encoder) &&
>  	    !pipe_config->frl.enable) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D47
