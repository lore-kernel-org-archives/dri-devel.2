Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB02CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBB910EA99;
	Sun,  4 Oct 2026 16:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O5zG1Kcu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3CE710EA90
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:41:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D39AD6021E;
 Sun,  4 Oct 2026 16:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA6D1F000FF;
 Sun,  4 Oct 2026 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791132102;
 bh=BFG8awLRvZRX9dzF7o5bh9AVWLs+atq1ASHeycNjXEg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O5zG1KcupYA0pZrZbRVuam/x1V8EUYrd+MbzyK7PUWcU7JB9Cq1XiO2FDJ4osliGf
 RdpWewR5UZwJwh+foEXO1Uy3oswG5z4B+nQS1XKRSV17cSqmW59YYmp2CcmKekYhaZ
 GItR7k+MfjtF3Srsyaa4rq0taaszZ0HXUkuHIRcsFLMOKTBtmgFHciCjbQ9b2zKZvu
 ywiJ16gBG3QETOC1mjqqudHmGIVHqzSFGRx8rsy1hIVansq4GOiyOPHQSuQ8yGx7tA
 ITAbiB9x/Ca3FTHjW6Oz1EysAytj05tNc8XuJJjCdr3Gbk3dsR8Vnlp3yEq8CFbdjX
 LhoMvX7MD6m+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] drm/tegra: rgb: Parameterize configuration based
 on bus flags
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261004163114.181800-3-clamor95@gmail.com>
References: <20261004163114.181800-1-clamor95@gmail.com>
 <20261004163114.181800-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 16:41:41 +0000
Message-Id: <20261004164142.3CA6D1F000FF@smtp.kernel.org>
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
- [High] drm/tegra: lockdep splat in tegra_rgb_encoder_enable() due to drop=
ped locks
- [High] drm/tegra: fallback bus flags invert default pixel clock polarity
--

commit 9e423aa598f153ae0ba6a206e3338f678a83bd15
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: rgb: Parameterize configuration based on bus flags

This commit parameterizes the display configuration based on bus flags pass=
ed
from the bridge or panel. The list of supported flags now includes pixel
clock polarity, display enable polarity, and data alignment.

> diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> index b6d09a8d8e5ea..86bff5f7f7964 100644
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c

[ ... ]

> @@ -104,14 +105,24 @@ static void tegra_rgb_encoder_enable(struct drm_enc=
oder *encoder)
>  	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_rgb *rgb =3D to_rgb(output);
> -	u32 value;
> +	struct drm_bridge_state *bridge_state;
> +	u32 bus_flags, value;
> +
> +	/* Get but flags from the bridge state. */
> +	bridge_state =3D drm_bridge_get_current_state(output->bridge);

[Severity: High]
Does calling drm_bridge_get_current_state() here trigger a lockdep warning?

The helper function explicitly requires the modeset lock to be held and
asserts it via drm_modeset_lock_assert_held(). If a userspace application
issues a non-blocking atomic commit, the commit_tail worker executes this
tegra_rgb_encoder_enable() hook asynchronously after the modeset locks have
been dropped, which will trigger a WARN.

> +	if (bridge_state)
> +		bus_flags =3D bridge_state->input_bus_cfg.flags;
> +	else
> +		bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +			    DRM_BUS_FLAG_DE_HIGH |
> +			    DRM_BUS_FLAG_DATA_MSB_TO_LSB;

[ ... ]

> @@ -124,11 +135,31 @@ static void tegra_rgb_encoder_enable(struct drm_enc=
oder *encoder)
>  	else
>  		value &=3D ~LVS_OUTPUT_POLARITY_LOW;
> =20
> +	if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
> +		value &=3D ~LSC0_OUTPUT_POLARITY_LOW;
> +	else
> +		value |=3D LSC0_OUTPUT_POLARITY_LOW;

[Severity: High]
Does this fallback configuration silently invert the default pixel clock
polarity for older panels?

The legacy hardware initialization array rgb_enable historically set
LSC0_OUTPUT_POLARITY_LOW to 1 by default. By hardcoding
DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE in the fallback bus_flags for
missing bridge states, the code now clears LSC0_OUTPUT_POLARITY_LOW.
Will this corrupt the display output or cause blank screens on legacy
configurations without explicitly configured bus flags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004163114.1818=
00-1-clamor95@gmail.com?part=3D2
