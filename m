Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B15DCA9ED8
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B5910E471;
	Mon, 12 Oct 2026 04:51:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC2E10E414;
 Mon, 12 Oct 2026 04:51:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FBAD43A4F;
 Mon, 12 Oct 2026 04:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B6E1F0089B;
 Mon, 12 Oct 2026 04:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780706;
 bh=sJ26jaIQOR80dIcsCnlyIFv/xhjad9Wsv0rieOq7Leg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZSJu4ICLnWM5ex+zyQadwNIkka30VO8FJtmVHTlzAYFH5+HwjqK+LRO7tziEdu7aL
 KFlg6r3JljHvK8Bbm3am6WrnNZVJbOGMPBgTSczjaq7bnaFiaZ+EU9MjjmU0cIvhBp
 s53BtV2Pn3Fgx6A5Eww+Wl64Pl/g3k4JOga1Hl7AzKGXhWK9ULXaXVGe1VIEmbJJl1
 300F3OQFF/AcztA1om3hp/X+qiZbJvwLsOV3hMkpHdfKHV8Ku7z6KJLH3tV8zzFZwV
 6PWFitVmk8o+7hUxfPCFcR2Cx0OHxzHRzsJ8wyHAbOa0Y/KHAtZk5gHZWHRVVLmC8m
 E3FstKnHGujiQ==
Message-ID: <sashiko-outbox-167638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 38/56] drm/i915/hdmi: Add FRL clock computation based
 on DFM
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-39-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-39-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:51:45 +0000
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
- [Medium] drm/i915/hdmi: pipe_bpp corruption in intel_hdmi_compute_frl_clo=
ck restricts fallback
--

commit e2a7d5ac5410d9fb50137634f445228551f6d758
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: drm/i915/hdmi: Add FRL clock computation based on DFM

This commit computes the FRL port clock for a mode using the DFM helper.
It starts with the lowest FRL rate meeting the DFM requirements and checks
if FRL can support the mode.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index 8e742165a50ad..0391597c9847f 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c

[ ... ]

> +static int
> +intel_hdmi_compute_frl_clock(struct intel_encoder *encoder,
> +			     struct intel_crtc_state *crtc_state)
> +{
> +	struct intel_hdmi *hdmi =3D enc_to_intel_hdmi(encoder);
> +	int max_bpc =3D max(crtc_state->pipe_bpp / 3, 8);
> +	int port_clock;
> +	int bpc;
> +
> +	for (bpc =3D max_bpc; bpc >=3D 8; bpc -=3D 2) {
> +		int ret;
> +
> +		if (!hdmi_bpc_possible(crtc_state, bpc))
> +			continue;
> +
> +		crtc_state->pipe_bpp =3D bpc * 3;
> +
> +		ret =3D intel_hdmi_compute_frl_config(encoder, crtc_state);
> +		if (ret)
> +			continue;
> +
> +		/* Port clock for FRL rates is bitrate in 10Kbps */
> +		port_clock =3D FRL_GBPS_TO_10KBPS(crtc_state->frl.required_rate);
> +
> +		if (hdmi_port_frl_clock_valid(hdmi, port_clock) =3D=3D MODE_OK) {
> +			crtc_state->port_clock =3D port_clock;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;

[Severity: Medium]
Does returning -EINVAL here leave crtc_state->pipe_bpp corrupted?

Because pipe_bpp is modified in-place within the loop, if all FRL
configurations fail, the function exits with pipe_bpp retaining the last
tested value (typically 24).

When this happens, the caller intel_hdmi_compute_formats() will reuse
the exact same crtc_state object for a YCbCr420 fallback attempt:

intel_hdmi_compute_formats() {
	ret =3D intel_hdmi_compute_output_format(..., INTEL_OUTPUT_FORMAT_RGB, ...=
);
=09
	if (ret && drm_mode_is_420_also(...))
		ret =3D intel_hdmi_compute_output_format(..., INTEL_OUTPUT_FORMAT_YCBCR42=
0, ...);
}

Since max_bpc is derived from crtc_state->pipe_bpp, the fallback is then
artificially restricted to only testing 8 bpc, missing valid 10/12 bpc
capabilities.

Should pipe_bpp be saved before the loop and restored to its original value=
=20
before returning -EINVAL?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D38
