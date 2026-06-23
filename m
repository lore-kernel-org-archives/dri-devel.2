Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5426FCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF53810E576;
	Tue, 23 Jun 2026 21:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VEPJ5GlY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAB210E576
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:00:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6861F43236;
 Tue, 23 Jun 2026 21:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC5D1F000E9;
 Tue, 23 Jun 2026 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248417;
 bh=/Mi0X8us1g4B4LoWrANEf/NdTBfvaTPXFvm8OPbQytk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VEPJ5GlYSmEksuJ8NUSPpJyE1qqAXe9/teD8KIKjzC1C1X8MBOFyheICC8KAUGaMx
 OpiQzerqaNHtvTq9XGYYn2DQkBXMJWwoP8d1JoV5r5SwjAGgmPaWpFpWRiM0NtBF8e
 Xcm4E7AmLqh99zOWOojmTpw3ex8k+WPANjRj2u/RKc0/1oCCI7eEjtp3t/wvP3bc15
 tRpibFyKx5xLztkTdmf9jdgyzuw4OoYdNh1V1BSC8zbXgifNEe0aipsQLdKwsGBddk
 zmE0IHPZXMnvMAhZc3GVyksWyzLwMhbsjqAES8OMPUEaIWCTmlNjsf/2LWnle0TTD5
 3UXip88i1a9Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] drm/bridge: synopsys: dw-dp: Add audio support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-10-dc61e6352508@collabora.com>
References: <20260612-synopsys-dw-dp-improvements-v3-10-dc61e6352508@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:00:16 +0000
Message-Id: <20260623210017.1CC5D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The return value of `pm_runtime_get_sync()` is ignored in `dw_dp_a=
udio_startup()`, violating PM runtime API contracts and risking hardware ac=
cess while suspended.
- [High] Missing error checks on `clk_prepare_enable()` in `dw_dp_audio_pre=
pare()` lead to hardware access failures and clock reference count underflo=
ws.
- [High] SDP register bank slots are permanently leaked because `dw_dp_audi=
o_unprepare()` does not free them.
- [Medium] Prematurely updating `dp->audio_interface` before hardware valid=
ation causes an unbalanced clock disable in the teardown path on error.
- [Medium] `dw_dp_audio_prepare()` explicitly rejects valid intermediate ch=
annel counts, breaking multi-channel playback.

Pre-existing issues:
- [High] Concurrent accesses to the `dp->sdp_reg_bank` bitmap between DRM a=
nd ALSA threads lack locking, leading to SDP register corruption.
--

commit 91c310c87d4ddad349da89d89896e7fa9319465d
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add audio support

Implement audio support for the Synopsys DesignWare DisplayPort
controller.

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/brid=
ge/synopsys/dw-dp.c
index 7f4f36c614844..f1946f2c945da 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> +static int dw_dp_audio_startup(struct drm_bridge *bridge,
> +			       struct drm_connector *connector)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	dev_dbg(dp->dev, "audio startup\n");
> +	pm_runtime_get_sync(dp->dev);

[Severity: High]
Does this code need to check the return value of pm_runtime_get_sync()?

If the power domain or clock fails to resume, it returns a negative error
code. Ignoring this might lead to accessing suspended hardware registers wh=
en
ALSA triggers startup.

> +
> +	return 0;
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
> +
> +	if (dp->audio_interface =3D=3D DW_DP_AUDIO_SPDIF)
> +		clk_disable_unprepare(dp->spdif_clk);
> +	else if (dp->audio_interface =3D=3D DW_DP_AUDIO_I2S)
> +		clk_disable_unprepare(dp->i2s_clk);
> +
> +	dp->audio_interface =3D DW_DP_AUDIO_UNUSED;
> +}

[Severity: High]
Does dw_dp_audio_unprepare() leak SDP register bank slots?

dw_dp_audio_prepare() allocates a new SDP slot by calling dw_dp_send_sdp(),
which sets a bit in dp->sdp_reg_bank. However, dw_dp_audio_unprepare() never
clears the allocated bit.

Could this exhaust the register bank slots if userspace starts and stops au=
dio
multiple times?

[ ... ]

> +static int dw_dp_audio_prepare(struct drm_bridge *bridge,
> +			       struct drm_connector *connector,
> +			       struct hdmi_codec_daifmt *daifmt,
> +			       struct hdmi_codec_params *params)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +	u8 audio_data_in_en, supported_audio_interfaces;
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
Will this explicit rejection break valid multi-channel playback?

The driver sets bridge->hdmi_audio_max_i2s_playback_channels =3D 8 indicati=
ng
hardware support, but this switch statement returns -EINVAL for intermediate
channel counts like 4 or 6. Is it intended to reject valid multi-channel
audio setups?

> +
> +	switch (daifmt->fmt) {
> +	case HDMI_SPDIF:
> +		dp->audio_interface =3D DW_DP_AUDIO_SPDIF;
> +		break;
> +	case HDMI_I2S:
> +		/*
> +		 * It is recommended to use SPDIF instead of I2S, since I2S mode requi=
res
> +		 * manually inserting PCUV control bits from userspace and this is done
> +		 * automatically in hardware for SPDIF mode.
> +		 */
> +		dp->audio_interface =3D DW_DP_AUDIO_I2S;
> +		break;
> +	default:
> +		dev_err(dp->dev, "invalid DAI format %d\n", daifmt->fmt);
> +		return -EINVAL;
> +	}
> +
> +	regmap_read(dp->regmap, DW_DP_CONFIG_REG1, &cfg1);
> +	supported_audio_interfaces =3D FIELD_GET(AUDIO_SELECT, cfg1);
> +
> +	if (supported_audio_interfaces !=3D DW_DP_AUDIO_I2S_AND_SPDIF &&
> +	    supported_audio_interfaces !=3D dp->audio_interface) {
> +		dev_err(dp->dev, "unsupported DAI %d\n", daifmt->fmt);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Could this leave dp->audio_interface in a corrupted state on failure?

If an unsupported DAI format is provided, dp->audio_interface is updated pr=
ior
to the validation check. If this function then returns -EINVAL, the ALSA co=
re
later calls dw_dp_audio_shutdown() -> dw_dp_audio_unprepare(), which acts on
the corrupted state and attempts to disable a clock that was never enabled.

> +
> +	clk_prepare_enable(dp->spdif_clk);
> +	clk_prepare_enable(dp->i2s_clk);

[Severity: High]
Does this code need to check the return values of clk_prepare_enable()?

If clk_prepare_enable() fails, the driver continues to program hardware
registers, which could lead to hardware lockups. Furthermore, the teardown
path unconditionally disables the failed clock, causing reference count
underflows.

[ ... ]

> +	ret =3D dw_dp_audio_infoframe_send(dp);
> +	if (ret < 0)
> +		dev_err(dp->dev, "failed to send audio infoframe\n");

[Severity: High]
This isn't a bug introduced by this patch, but adding audio support introdu=
ces
a concurrent access path that makes a pre-existing race possible.

dw_dp_audio_infoframe_send() calls dw_dp_send_sdp(), which allocates a slot
using non-atomic test and set:

	nr =3D find_first_zero_bit(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
	if (nr < SDP_REG_BANK_SIZE)
		set_bit(nr, dp->sdp_reg_bank);

Can ALSA audio preparation running concurrently with DRM display updates le=
ad
to slot allocation collisions and SDP hardware register corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-synopsys-d=
w-dp-improvements-v3-0-dc61e6352508@collabora.com?part=3D10
