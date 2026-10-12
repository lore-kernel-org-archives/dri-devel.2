Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D80BCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2B910EC5E;
	Mon, 12 Oct 2026 04:34:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F8110EB45;
 Mon, 12 Oct 2026 04:34:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA4F943836;
 Mon, 12 Oct 2026 04:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4561F0089B;
 Mon, 12 Oct 2026 04:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779676;
 bh=XzGWGbUNJa0VOliIJ9F6aun4wC2RakHffbd8KCEUl54=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F6xgb6DGu6TuVv+b0D53IFBtd89Z0ZA7raftjZGr8LIGAuuGzfCAxrTnIZIkncVc3
 UlB7UeWI19LBz6KrcSDBN0DDET39rZtCrER8iwq7yROJOU4/gV/QqTNXrY2kOdWvX4
 +oJhIfVLQlvm8+G0bTKsTjfOnHEkE7uUiFiqzW9PIQhk8lhlWs/DukL8NAyXLfEKaa
 gj2G0Vl11Sg4IurXqH6DxpnDUz6UPekABcwXqOTp0k/nOSgIGoNskCrSgcmMHOCN63
 /DKJeZ2xC2rUloMU33xvmlNUw5DhdCpQHz3auYGnKC5zW9MLJbr/6Mxl0mXPn2WjkR
 3YAWe/PHK3ZSw==
Message-ID: <sashiko-outbox-167611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/56] drm/i915/hdmi: Parse FRL max link rate from VBT
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-2-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-2-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:34:36 +0000
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
- [High] drm: hardcoded platform check disables FRL on newer hardware
- [High] drm/hdmi: FRL incorrectly disabled when VBT specifies platform def=
ault rate
--

commit df17bdb1a2102d3ca65a52512220409d6c6fe624
Author: Vandita Kulkarni <vandita.kulkarni@intel.com>

drm/i915/hdmi: Parse FRL max link rate from VBT

Parse the maximum FRL link rate from VBT and store it for use
during FRL mode selection and link training.

> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/=
i915/display/intel_bios.c
> index 7b6a6f8c3cf19..7181237508b3a 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
[ ... ]
> @@ -2788,12 +2788,45 @@ static bool is_port_valid(struct intel_display *d=
isplay, enum port port)
>  	return true;
>  }
> =20
> +int intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data *d=
evdata)
> +{
> +	struct intel_display *display =3D devdata->display;
> +
> +	if (display->vbt.version < 237)
> +		return 0;
> +
> +	/*
> +	 * When hdmi_max_frl_rate_valid is 0 the VBT does not specify a maximum
> +	 * FRL rate, so don't use it to limit the FRL rate on FRL-capable
> +	 * platforms.
> +	 */
> +	if (!devdata->child.hdmi_max_frl_rate_valid)
> +		return display->platform.meteorlake ? 12000000 : 0;

[Severity: High]
Does this hardcoded check disable FRL on newer hardware?

By restricting the fallback rate exclusively to Meteorlake, 0 is returned
for all newer FRL-capable platforms (e.g., Lunar Lake, Panther Lake) when
the VBT lacks a valid max FRL rate.

Downstream callers like intel_hdmi_compute_config() in intel_hdmi.c use
the return value as a boolean condition:

    if (HAS_HDMI_FRL(display) && intel_bios_hdmi_max_frl_rate(encoder->devd=
ata) && ...)
        enable_frl =3D true;

Returning 0 causes enable_frl to evaluate to false, which means FRL will
never be enabled on newer hardware architectures under these conditions.

> +
> +	switch (devdata->child.hdmi_max_frl_rate) {
> +	default:
> +	case HDMI_MAX_FRL_RATE_PLATFORM:
> +		return 0;

[Severity: High]
Does returning 0 here inadvertently disable FRL when the VBT specifies
the platform default rate?

Although the comment above mentions that a missing VBT specification
should not limit the FRL rate, returning 0 signals callers to completely
disable FRL rather than applying a platform fallback.

Later in the series, the caller logic in intel_hdmi_compute_config()
treats 0 as a strict boolean requirement and cap:

    if (HAS_HDMI_FRL(display) &&
        intel_bios_hdmi_max_frl_rate(encoder->devdata) &&
        intel_hdmi->has_sink_hdmi_21)
        enable_frl =3D true;

Because intel_bios_hdmi_max_frl_rate() returns 0, enable_frl stays false
and the rate cap becomes 0. This completely disables HDMI 2.1 Fixed
Rate Link capabilities on any platform where the VBT is configured to use
the platform's native default or if the VBT is older than version 237.

> +	case HDMI_MAX_FRL_RATE_3G:
> +		return 3000000;
> +	case HDMI_MAX_FRL_RATE_6G:
> +		return 6000000;
> +	case HDMI_MAX_FRL_RATE_8G:
> +		return 8000000;
> +	case HDMI_MAX_FRL_RATE_10G:
> +		return 10000000;
> +	case HDMI_MAX_FRL_RATE_12G:
> +		return 12000000;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D1
