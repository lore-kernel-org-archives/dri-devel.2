Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F99CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D0310EA07;
	Thu, 15 Oct 2026 17:20:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3A910EA07
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 17:20:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37FA760200
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 17:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70C91F000C4;
 Thu, 15 Oct 2026 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792084808;
 bh=A4tp3g0IYcLACaoBlrejdZvIu3PH/ncGbUbhma4Ikto=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d1kGwjTz/kFYfdjyFnF5qPOf/fHnAx54Z2Fq9qI6EfJ/iBBkCp8T9AsuBPzUo1gsq
 cpFp6tNC/V8Z+nGI5HmAmGWrtXIRHgmmNMX6U+d21w/RYzLU3NdI1BLjXwYl2PZc7l
 gxUu2Z5V9pz1qDiZsaRIziqIbQS++L1b+4ZNWWtNMGMp+NZJF15sUVZUnAxhTpP/uu
 nI606lEml9tcgEaRv5pWLhmDkBjBRDUAlHhtSb7hOojaxaxUrPuLHSUDLSo4WDDYCv
 A1w99ZGMZF1D0KYYePLx7PWvVoGdlu0apCuYufYSKCj/gVZTqtqywWqUWv50CGIkgw
 V6q5QUg5+iEYg==
Message-ID: <sashiko-outbox-173247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 28/28] drm/bridge: sii902x: Implement hw state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-28-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-28-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:20:08 +0000
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
- [High] drm/bridge: sii902x: unconditional deref of optional atomic_sro_ge=
t_current_crtc hook
- [Medium] drm/bridge: silent masking of I2C errors via regmap_test_bits
--

commit 688ff92bfdba29f9af2e8eb0898f519167caccaa
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: sii902x: Implement hw state readout

This commit implements hardware state readout for the sii902x bridge.
It introduces connector and state readout callbacks utilizing the atomic
SRO (State ReadOut) infrastructure.

> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index 9aac44ed5b677..332945f3c9f7f 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
[ ... ]
> @@ -537,6 +539,80 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
>  	return MODE_OK;
>  }
> =20
> +static int
> +sii902x_bridge_connector_readout(struct drm_bridge *bridge,
> +				 struct drm_atomic_sro_state *state,
> +				 struct drm_connector_state *conn_state)
> +{
> +	struct sii902x *sii902x =3D bridge_to_sii902x(bridge);
> +	struct drm_connector *connector =3D conn_state->connector;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_encoder *encoder;
> +	struct drm_crtc *crtc;
> +
> +	if (regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SY=
S_CTRL_PWR_DWN))
> +		return 0;

[Severity: Medium]
Will a negative error code from a failed I2C read evaluate as true here?

If regmap_test_bits() encounters an underlying hardware error (such as
-EIO or -ETIMEDOUT), it returns a negative value. In C, this evaluates to
true, which seems like it would cause the function to incorrectly assume
the device is powered down, skip the readout, and mask the hardware error
by returning 0.

> +
> +	encoder =3D bridge->encoder;
> +	crtc =3D encoder->funcs->atomic_sro_get_current_crtc(encoder);

[Severity: High]
Could this dereference a NULL pointer?

As an external I2C HDMI bridge, sii902x can be attached to arbitrary display
controllers. The DRM core permits encoder->funcs to be NULL for simple
managed encoders, and atomic_sro_get_current_crtc is an optional hook.

If the attached encoder lacks the funcs pointer or does not implement
the atomic_sro_get_current_crtc hook, this unconditional dereference
would result in a kernel panic.

> +	if (!crtc)
> +		return -ENODEV;
[ ... ]
> +static int sii902x_bridge_readout_state(struct drm_bridge *bridge,
> +					struct drm_atomic_sro_state *state,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state)
> +{
> +	struct sii902x *sii902x =3D bridge_to_sii902x(bridge);
> +	u32 input_format;
> +
> +	if (regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SY=
S_CTRL_PWR_DWN))
> +		return 0;

[Severity: Medium]
Is this subject to the same error masking as in
sii902x_bridge_connector_readout()?

A negative return value from an I2C failure here will also evaluate as true,
skipping the bridge state readout and leaving the state object uninitialized
without propagating the failure.

> +
> +	switch (sii902x->bus_width) {
> +	case 16:
> +		input_format =3D MEDIA_BUS_FMT_RGB565_1X16;
> +		break;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D28
