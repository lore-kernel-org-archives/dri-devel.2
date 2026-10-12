Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3755CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3035210E49F;
	Mon, 12 Oct 2026 04:53:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005DC10E910;
 Mon, 12 Oct 2026 04:53:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4739060AA1;
 Mon, 12 Oct 2026 04:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DB21F0089B;
 Mon, 12 Oct 2026 04:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780823;
 bh=arJuLL5GQUhe12ZDQK1wsQjC1NNOA7WpdX3AVkTrYv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fzemsQf8R3yB6eFQ8pHLq4a9fF68ClcSnaJMT7i1zvk4sJ0Mh/pUEpzSktnT+OY0m
 djAsMPfHtQIR0/xBl/00KkVuV/h8OMbmzgIvqjuK+mJndT5035NqQNV0i8nVPzLdms
 bbQCq5obrqleh191R/LrCyeALV+BEmhiz8qMeUWdjnoSXg4vf6CjrQwnS+LFjKcJs9
 1vg3nYvaLwfrWwhU97VtztLZIg/oWZNDRBz0Ik8+kMr7WJTr3N5M1dQdpfHdsy02DU
 wa0sOS0A++vBvP6pnSCduEfAgndDem/qg/Z2HzcpQs0+ro6Car9ZvOm6Ag5HxWSJBT
 OhiX/LQ9B27Xg==
Message-ID: <sashiko-outbox-167641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 55/56] drm/i915/hdmi: Iterate through joiner
 candidates in mode_valid path
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-56-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-56-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:53:42 +0000
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
- [High] drm/i915/hdmi: TMDS modes bypass max dotclock and plane size checks
--

commit fcc107a6617c907f4675cb58944ba1cef59c27ff
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
drm/i915/hdmi: Iterate through joiner candidates in mode_valid path

This commit updates the HDMI mode validation path to iterate through joiner
candidates, relaxing the dotclock ceiling when multiple pipes are joined.
The single-pipe validation checks were relocated from the main mode validat=
ion
function into the format-specific validation function.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index 2ec7d2a5e7d4d..2c7c47a3c61d1 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -2132,20 +2132,55 @@ intel_hdmi_mode_valid_format(struct intel_connect=
or *connector,
[ ... ]
> +	status =3D intel_hdmi_tmds_mode_clock_valid(&connector->base, clock,
> +						  has_hdmi_sink, sink_format);
> +
> +	if (status =3D=3D MODE_OK)
> +		return status;

[Severity: High]
Does this early return cause TMDS modes to bypass the max dotclock and plane
size limits?=20

It looks like if a mode fits within the TMDS link bandwidth, the function
returns immediately, skipping the newly relocated intel_pfit_mode_valid(),
intel_mode_valid_max_plane_size(), and intel_dp_dotclk_valid() checks inside
the for_each_joiner_candidate() loop below.

[ ... ]
> @@ -2160,7 +2195,6 @@ intel_hdmi_mode_valid(struct drm_connector *_connec=
tor,
[ ... ]
>  	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) =3D=3D DRM_MODE_FLAG_3D_FRAME=
_PACKING)
>  		clock *=3D 2;
> =20
> -	if (clock > max_dotclk)
> -		return MODE_CLOCK_HIGH;
> -

[Severity: High]
Since this overarching max_dotclk check was removed from the parent function
intel_hdmi_mode_valid(), and TMDS modes now return early in=20
intel_hdmi_mode_valid_format() before reaching the new validation loop, cou=
ld
this allow user-provided TMDS modes that exceed the display engine's max CD=
CLK
dotclock to pass validation?

[ ... ]
> @@ -2197,10 +2228,8 @@ intel_hdmi_mode_valid(struct drm_connector *_conne=
ctor,
>  			status =3D intel_hdmi_mode_valid_format(connector, mode, clock, has_h=
dmi_sink,
>  							      INTEL_OUTPUT_FORMAT_YCBCR420);
>  	}
> -	if (status !=3D MODE_OK)
> -		return status;
> =20
> -	return intel_mode_valid_max_plane_size(display, mode, 1);
> +	return status;

[Severity: High]
Similarly, since intel_mode_valid_max_plane_size() is also removed here,
it seems TMDS modes might bypass plane width and panel fitter checks too,
potentially leading to atomic commit failures or hardware pipeline errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D55
