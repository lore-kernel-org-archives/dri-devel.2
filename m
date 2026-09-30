Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2045BCA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B15A10E139;
	Wed, 30 Sep 2026 07:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gc7P09mm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B669210E139
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:38:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 581CB42E95;
 Wed, 30 Sep 2026 07:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19041F000FF;
 Wed, 30 Sep 2026 07:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790753889;
 bh=tEIlDpf8qZDfu9vXtL2PzehNLauFNtdfCT24Nh2LIw0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gc7P09mm9ugKzX/dfcEqF4hf8Wb4QNpaxvHUrDuNkiOnrOyKadLTMGvyqZcX6OKph
 CWnK1pRjBdjYc/uv9v4sU4YIh3KwDoKMYMcCWtSyM/w0qbhUayrYXYprVGiSXxuH7X
 XVGYxxprJtBQdFLthH6KUGampePHIEoSXGJGCzUrAdwXHOfb6PNX4zmzPMABOvb+FD
 DyeTbyv5GE3ncnb/C7AtXMY1xe0KAYur4h4qZQX9ceqBHvui0+EdDv9p0crZnadhvQ
 rB8/QuJDyATnjPurZKhLQVBTXv//jPFDnw1UC92oTn7BQ87nxv8DCGM93fkK2OWU91
 xC/qXndpsWqfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/6] drm/tegra: rgb: Parameterize configuration based
 on bus flags
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260930070535.47130-3-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:38:08 +0000
Message-Id: <20260930073808.E19041F000FF@smtp.kernel.org>
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
- [High] drm/tegra: rgb: NULL pointer deref in tegra_rgb_encoder_enable()
- [High] drm/tegra: rgb: pixel clock polarity regression for legacy panels
--

commit 54b0f3191ac9412b6aca8d1f4028b3159a42b6a2
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: rgb: Parameterize configuration based on bus flags

This commit parameterizes the RGB display configuration based on bus flags
passed from the bridge or panel. It updates pixel clock polarity, display
enable polarity, and data alignment according to the input bus configuratio=
n.

> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c
> @@ -104,14 +105,19 @@ static void tegra_rgb_encoder_enable(struct drm_enc=
oder *encoder)
>  	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_rgb *rgb =3D to_rgb(output);
> -	u32 value;
> +	struct drm_bridge_state *bridge_state;
> +	u32 bus_flags, value;
> =20
> +	/* Get but flags from the bridge state. */
> +	bridge_state =3D drm_bridge_get_current_state(output->bridge);
> +	bus_flags =3D bridge_state->input_bus_cfg.flags;

[Severity: High]
Does this introduce a NULL pointer dereference for non-atomic bridges?

Looking at drm_bridge_get_current_state(), it can return NULL if the
attached bridge does not support atomic state:

static inline struct drm_bridge_state *
drm_bridge_get_current_state(struct drm_bridge *bridge)
{
	...
	if (!bridge->base.state)
		return NULL;

	return drm_priv_to_bridge_state(bridge->base.state);
}

Since bridge_state is unconditionally dereferenced to read
input_bus_cfg.flags, will this crash the display pipeline during
tegra_rgb_encoder_enable() for any devices using non-atomic bridges?

[ ... ]
> -	/* configure H- and V-sync signal polarities */
> +	/* configure H- and V-sync and pixel clock signal polarities */
>  	value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
> =20
>  	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> @@ -124,11 +130,31 @@ static void tegra_rgb_encoder_enable(struct drm_enc=
oder *encoder)
>  	else
>  		value &=3D ~LVS_OUTPUT_POLARITY_LOW;
> =20
> +	if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE)
> +		value |=3D LSC0_OUTPUT_POLARITY_LOW;
> +	else
> +		value &=3D ~LSC0_OUTPUT_POLARITY_LOW;

[Severity: High]
Can this cause a regression for legacy panels by inverting the pixel clock?

The previous code preserved the initial state of the
LSC0_OUTPUT_POLARITY_LOW bit (which is initialized just prior to this block
via tegra_dc_write_regs(..., rgb_enable, ...)).

By forcefully clearing LSC0_OUTPUT_POLARITY_LOW when the
DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE flag is absent, doesn't this break
existing hardware relying on older device trees that do not explicitly
specify this bus flag?

> +
>  	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930070535.4713=
0-1-clamor95@gmail.com?part=3D2
