Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62DCCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425D710EC92;
	Mon, 12 Oct 2026 04:49:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0B010EC95;
 Mon, 12 Oct 2026 04:49:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12920601FA;
 Mon, 12 Oct 2026 04:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C091F0089B;
 Mon, 12 Oct 2026 04:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780577;
 bh=r45ZW0wjWIWJud8Ws7IZwEW9omR6MhyZOB8u8MQVLv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lBoU893SO3U9pMasgOvpWjWeVEwGGckncKjJQevZF9U3rXpKe0gjuGbNQvZp9r1oW
 wAdwELlWgLLjCJw7v/MzraV3mhpIdsXUFywsnn1rOpMbfYkcd7SlCvh8FRKZGhWAmO
 ODThvy9kNmL89zXEf6XpGBAcbHnwI0w2tI8BYT64sXart40cJelZbX+T48HRunBTac
 02dVwpuRQJ+vv0aW5TqLRTjYnk66ZFwwMChKSe0AcUglcQDCHQgaTZ3O3FwLYAnr2z
 kzWAzLDzaaR3RbeWEGJS+rCm7FHDv98VblSSCcB8n22XzopnqS6oPrIQqFHiY6xCjM
 TX8qqDBy/E8Uw==
Message-ID: <sashiko-outbox-167631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 36/56] drm/i915/hdmi: Validate FRL modes in
 mode_valid using the FRL DFM
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-37-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-37-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:49:37 +0000
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
- [High] drm/i915: FRL mode valid misses 3D frame packing clock doubling
--

commit 357e437906e7e9f540a08210f7b85cf2f3e109aa
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
drm/i915/hdmi: Validate FRL modes in mode_valid using the FRL DFM

This commit adds a fallback FRL capability check to
intel_hdmi_mode_valid_format() using the non-DSC FRL DFM parameters to
validate modes that exceed TMDS limits. It also introduces
intel_hdmi_can_support_frl() as a placeholder returning false until FRL
support is completed.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index 67228b538e81a..b82c636b46f93 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> @@ -2021,6 +2022,51 @@ intel_hdmi_tmds_mode_clock_valid(struct drm_connec=
tor *_connector, int clock,
>  	return status;
>  }
> =20
[ ... ]
> +static enum drm_mode_status
> +intel_hdmi_frl_mode_clock_valid(struct intel_connector *connector,
> +				const struct drm_display_mode *mode,
> +				enum intel_output_format output_format)
> +{
> +	struct intel_hdmi *hdmi =3D intel_attached_hdmi(connector);
> +	struct intel_hdmi_frl_dfm frl_dfm =3D {};
> +	int max_rate =3D hdmi->max_frl_rate;
> +	int lanes =3D max_rate < 24 ? 3 : 4;
> +
> +	frl_dfm.config.pixel_clock_nominal_khz =3D mode->clock;

[Severity: High]
Does this code miss the 3D frame packing clock doubling?

In intel_hdmi_mode_valid(), the clock variable is doubled for 3D Frame
Packing modes:

	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) =3D=3D DRM_MODE_FLAG_3D_FRAME_PA=
CKING)
		clock *=3D 2;

This adjusted clock is passed to intel_hdmi_mode_valid_format() and used by
the TMDS validation path.

However, intel_hdmi_frl_mode_clock_valid() directly reads mode->clock, which
means it uses the unadjusted clock.

Could this cause the FRL Data Flow Management (DFM) capacity check to
underestimate the required bandwidth by a factor of 2 for 3D Frame Packing
modes, erroneously accepting modes that exceed the physical capacity of the
FRL link?

> +	frl_dfm.config.hactive =3D mode->hdisplay;
> +	frl_dfm.config.hblank =3D mode->htotal - mode->hdisplay;
> +
[ ... ]
> @@ -2052,6 +2105,7 @@ intel_hdmi_mode_valid_format(struct intel_connector=
 *connector,
>  			     enum intel_output_format sink_format)
>  {
>  	struct intel_display *display =3D to_intel_display(connector);
> +	struct intel_hdmi *hdmi =3D intel_attached_hdmi(connector);
>  	enum drm_mode_status status;
> =20
>  	status =3D intel_hdmi_sink_format_valid(connector, mode,
> @@ -2063,7 +2117,12 @@ intel_hdmi_mode_valid_format(struct intel_connecto=
r *connector,
>  	if (status !=3D MODE_OK)
>  		return status;
> =20
> -	return intel_hdmi_tmds_mode_clock_valid(&connector->base, clock, has_hd=
mi_sink, sink_format);
> +	status =3D intel_hdmi_tmds_mode_clock_valid(&connector->base, clock, ha=
s_hdmi_sink, sink_format);
> +
> +	if (status !=3D MODE_OK && intel_hdmi_can_support_frl(hdmi))
> +		status =3D intel_hdmi_frl_mode_clock_valid(connector, mode, sink_forma=
t);

[Severity: High]
Since intel_hdmi_frl_mode_clock_valid() is called without the adjusted clock
parameter, it will use the unadjusted mode->clock.

Should we pass the adjusted clock variable to
intel_hdmi_frl_mode_clock_valid() similar to how it is passed to
intel_hdmi_tmds_mode_clock_valid()?

> +
> +	return status;
>  }
> =20
>  static enum drm_mode_status

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D36
