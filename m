Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D03C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4249B10EB10;
	Tue, 21 Jul 2026 18:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OZ54J1Hc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A2510E39C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:25:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10E5943BE8;
 Tue, 21 Jul 2026 18:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ABC1F00A3A;
 Tue, 21 Jul 2026 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784658322;
 bh=wkGzB3ShbAvWISg4sxHNeQcUOniW1HkCmjm4pleFNSw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OZ54J1HcZ4GJT3dOk8VrzpjyAnVku2UgdPnSOKiHmblLfw1377PbG6eVtpYLtRShW
 4yWWbtT1EI/uRPjYWj1QgiKLpvr50UwZfZIC2905UY7OdzEqES9324x5z+3FoQVYCR
 +MjPlh8/A0FGBX4tTR26hUc1iXQrZVReLorvUqlYeD9+8KgEBUDu7pWCrHqDffn7+z
 pB2hJPyGwnlnDBDZbquTCUekOAu+h1I6i2DM169TdMN7b9Bkb52gj7XuUf2oUQu1Ui
 4krKOoc/sOKmPHUXs6Wf8Vio2xrRvUbSkGmCr+svj/GJ/lDGQBON1zyk0TjbgeXmTW
 /jrLQUwfpB/KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] drm/bridge: synopsys: dw-dp: Add audio support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-10-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
 <20260721-synopsys-dw-dp-improvements-v4-10-f0f4a4ede712@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:25:22 +0000
Message-Id: <20260721182522.A3ABC1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Audio infoframe preparation permanently leaks an SDP register bank=
 slot on every call, leading to exhaustion of slots and duplicated Audio In=
foFrames.
- [Medium] The return value of `clk_prepare_enable(dp->i2s_clk)` is not ass=
igned to `ret`, rendering the subsequent error check dead code and ignoring=
 failures.
- [Medium] TOCTOU race condition in `dw_dp_send_sdp` for SDP register bank =
allocation when called concurrently from audio and display contexts.
- [Medium] A 32-bit audio sample width will be silently truncated to 0 when=
 configured in the hardware register via FIELD_PREP.
- [Medium] Incomplete channel count support blocks valid ALSA streams from =
playing.
--

--- Patch [10]: [PATCH v4 10/10] drm/bridge: synopsys: dw-dp: Add audio sup=
port ---
commit 9935aa2c50aed1038e27452a987227adb8e93b00
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add audio support

Implement audio support for the Synopsys DesignWare DisplayPort
controller.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 636b9e1052978..8d6a52135e54d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1846,6 +1871,195 @@ static void dw_dp_bridge_oob_notify(struct drm_br=
idge *bridge,
>  		dev_err_once(dp->dev, "Missing platform handler for OOB HPD handling\n=
");
>  }
> =20
> +static int dw_dp_audio_infoframe_send(struct dw_dp *dp)
> +{
> +	struct hdmi_audio_infoframe frame;
> +	struct dw_dp_sdp sdp;
> +	int ret;
> +
> +	ret =3D hdmi_audio_infoframe_init(&frame);
> +	if (ret < 0)
> +		return ret;
> +
> +	frame.coding_type =3D HDMI_AUDIO_CODING_TYPE_STREAM;
> +	frame.sample_frequency =3D HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
> +	frame.sample_size =3D HDMI_AUDIO_SAMPLE_SIZE_STREAM;
> +	frame.channels =3D dp->audio_channels;
> +
> +	ret =3D hdmi_audio_infoframe_pack_for_dp(&frame, &sdp.base, DW_DP_SDP_V=
ERSION);
> +	if (ret < 0)
> +		return ret;
> +
> +	sdp.flags =3D DW_DP_SDP_VERTICAL_INTERVAL;
> +
> +	return dw_dp_send_sdp(dp, &sdp);

[Severity: Medium]
Is there a race condition when allocating SDP register bank slots?=20

When dw_dp_audio_infoframe_send() is called, it routes to dw_dp_send_sdp()=
=20
which performs a non-atomic bitmap allocation on the shared dp->sdp_reg_ban=
k=20
state:

    nr =3D find_first_zero_bit(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
    if (nr < SDP_REG_BANK_SIZE)
        set_bit(nr, dp->sdp_reg_bank);

If a DRM atomic commit and an ALSA stream start execute concurrently on=20
different CPUs, could they allocate the same SDP slot and corrupt the=20
hardware configuration?

> +}
> +
> +static int dw_dp_audio_startup(struct drm_bridge *bridge,
> +			       struct drm_connector *connector)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	dev_dbg(dp->dev, "audio startup\n");
> +
> +	return pm_runtime_resume_and_get(dp->dev);
> +}
> +
> +static void dw_dp_audio_unprepare(struct drm_bridge *bridge,
> +				  struct drm_connector *connector)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	/* Disable all audio streams */
> +	regmap_update_bits(dp->regmap, DW_DP_AUD_CONFIG1, AUDIO_DATA_IN_EN,
> +			   FIELD_PREP(AUDIO_DATA_IN_EN, 0));

[Severity: High]
Does dw_dp_audio_unprepare() miss freeing the SDP register bank slot=20
allocated during audio prepare?=20

When dw_dp_audio_infoframe_send() calls dw_dp_send_sdp(), a slot in=20
dp->sdp_reg_bank is allocated and the corresponding EN_VERTICAL_SDP=20
hardware bits are set.=20

Since the cleanup path here doesn't clear that bit or disable the hardware=
=20
bits, won't repeatedly starting and stopping an ALSA stream exhaust all 16=
=20
hardware slots and permanently break audio infoframe updates with -EBUSY?

> +
> +	if (dp->audio_interface =3D=3D DW_DP_AUDIO_SPDIF)
> +		clk_disable_unprepare(dp->spdif_clk);

[ ... ]

> +static int dw_dp_audio_prepare(struct drm_bridge *bridge,
> +			       struct drm_connector *connector,
> +			       struct hdmi_codec_daifmt *daifmt,
> +			       struct hdmi_codec_params *params)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +	u8 audio_data_in_en, supported_audio_interfaces;
> +	enum dw_dp_audio_interface audio_interface;
> +	u32 cfg1;
> +	int ret;
> +
> +	/*
> +	 * prepare might be called multiple times, so release the clocks
> +	 * from previous calls to keep the calls in balance.
> +	 */
> +	if (dp->audio_interface !=3D DW_DP_AUDIO_UNUSED)
> +		dw_dp_audio_unprepare(bridge, connector);
> +
> +	dp->audio_channels =3D params->cea.channels;
> +	switch (params->cea.channels) {
> +	case 1:
> +	case 2:
> +		audio_data_in_en =3D AUDIO_DATA_IN_EN_CHANNEL12;
> +		break;
> +	case 8:
> +		audio_data_in_en =3D AUDIO_DATA_IN_EN_CHANNEL12 |
> +				   AUDIO_DATA_IN_EN_CHANNEL34 |
> +				   AUDIO_DATA_IN_EN_CHANNEL56 |
> +				   AUDIO_DATA_IN_EN_CHANNEL78;
> +		break;
> +	default:
> +		dev_err(dp->dev, "invalid audio channels %d\n", dp->audio_channels);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Does this switch statement need to handle 4 and 6 channel audio streams?=20

Since the bridge advertises support for up to 8 channels via=20
hdmi_audio_max_i2s_playback_channels =3D 8, the ALSA framework might=20
negotiate 4.0 or 5.1 surround sound configurations.=20

It seems these valid channel counts would be rejected here with -EINVAL,=20
blocking their playback.

> +
> +	switch (daifmt->fmt) {

[ ... ]

> +	ret =3D clk_prepare_enable(dp->spdif_clk);
> +	if (ret)
> +		return ret;
> +
> +	clk_prepare_enable(dp->i2s_clk);
> +	if (ret) {

[Severity: Medium]
Does this ignore the return value of clk_prepare_enable() for the I2S clock=
?=20

Since the result isn't assigned to ret, the subsequent error check appears=
=20
to be evaluating the return value from the previous spdif_clk enable call=20
(which is already known to be 0).=20

If the I2S clock fails to enable, it looks like this will silently proceed=
=20
with an unclocked interface and cause an unbalanced clock state when=20
dw_dp_audio_unprepare() is called.

> +		clk_disable_unprepare(dp->spdif_clk);
> +		return ret;
> +	}
> +
> +	regmap_update_bits(dp->regmap, DW_DP_AUD_CONFIG1,
> +			   AUDIO_DATA_IN_EN | NUM_CHANNELS | AUDIO_DATA_WIDTH |
> +			   AUDIO_INF_SELECT | HBR_MODE_ENABLE,
> +			   FIELD_PREP(AUDIO_DATA_IN_EN, audio_data_in_en) |
> +			   FIELD_PREP(NUM_CHANNELS, dp->audio_channels - 1) |
> +			   FIELD_PREP(AUDIO_DATA_WIDTH, params->sample_width) |

[Severity: Medium]
Can a 32-bit audio sample width get silently truncated here?=20

The AUDIO_DATA_WIDTH mask is defined as GENMASK(9, 5) which is 5 bits wide.=
=20
If userspace negotiates a 32-bit audio stream (which is allowed by default)=
,=20
the value 32 (binary 100000, 6 bits) will be truncated to 0 by FIELD_PREP,=
=20
potentially misconfiguring the hardware.

> +			   FIELD_PREP(AUDIO_INF_SELECT, audio_interface) |
> +			   FIELD_PREP(HBR_MODE_ENABLE, 0));
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-synopsys-d=
w-dp-improvements-v4-0-f0f4a4ede712@collabora.com?part=3D10
