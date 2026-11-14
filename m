Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70686606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aO44Et0y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CFB10EFD1;
	Sat, 14 Nov 2026 05:47:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3516310EFD1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:47:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCD2B4561B;
 Sat, 14 Nov 2026 05:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6241F000C4;
 Sat, 14 Nov 2026 05:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794635258;
 bh=K+K1Mtp+6uB+jRJ+toNFB2qgyTFWl5MdNrLepxwgRaE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aO44Et0yGQi/uQpMWpAKjauRV/MDuu5vZlA7D/nRvWTx+cX7ohIstJwkO4+Kz9KZe
 0Yx1dVoGJ7LKjfDdkmU8t20lq8OdFm6toLIv7pzc9L5086WEejyR5Qrb1GGuyWocZ2
 D2Rh0wx8X+pPsqD7WyU0+xrlx7aFw9IYE6hRUh15EmSjQeINBXZraHZT3e6NyR1PX3
 PUGIYBgEpkJw43b/eHhN67uvh0/WSO6j7Asq2Q3IE9x13l+vCkOI/BSs2CgJWCcce2
 ECc80qsRg5eFDk7+5VioN/cuE6TbgRcrl6Uhc5LN1I3JMKonwtUsWjCcOuS9GjrAou
 N5EwcG9bsUHKA==
Message-ID: <sashiko-outbox-214188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 22/23] drm/bridge: synopsys: dw-dp: Add audio support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-22-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
 <20261114-synopsys-dw-dp-improvements-v12-22-d42d3dc5bdd4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:47:38 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] drm/bridge: dw-dp: unselected audio clock disabled before mux
  switch
- [Medium] drm/bridge: dw-dp: unadvertised sample_width limit breaks
  32-bit I2S formats
- [Medium] drm/bridge: dw-dp: checking params->cea.channels breaks
  non-PCM audio
- [Medium] drm/bridge: dw-dp: missing
  drm_connector_hdmi_audio_plugged_notify() calls
- [Low] drm/bridge: dw-dp: invalid hdmi_audio_dai_port in dw_dp_probe()
--

commit 20fac3cf1ff3b933dbf4d3b4b4b914b2c8a55eb1
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add audio support

This commit adds DisplayPort audio support to the Synopsys DesignWare
DisplayPort bridge driver using the DRM bridge audio callbacks.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 3c10cdb9ca28b..bf3a53463394f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1696,6 +1727,261 @@ static int dw_dp_link_enable(struct dw_dp *dp)
>  	return ret;
>  }

[ ... ]

> +static int __dw_dp_audio_enable(struct dw_dp *dp)
> +{
> +	u8 audio_data_in_en;
> +
> +	switch (dp->audio_channels) {
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
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(dp->regmap, DW_DP_AUD_CONFIG1,
> +			   AUDIO_DATA_IN_EN | NUM_CHANNELS | AUDIO_DATA_WIDTH |
> +			   AUDIO_INF_SELECT | HBR_MODE_ENABLE | AUDIO_MUTE,
> +			   FIELD_PREP(AUDIO_DATA_IN_EN, audio_data_in_en) |
> +			   FIELD_PREP(NUM_CHANNELS, dp->audio_channels - 1) |
> +			   FIELD_PREP(AUDIO_DATA_WIDTH, dp->audio_sample_width) |
> +			   FIELD_PREP(AUDIO_INF_SELECT, dp->audio_interface) |
> +			   FIELD_PREP(HBR_MODE_ENABLE, 0) |
> +			   FIELD_PREP(AUDIO_MUTE, dp->audio_muted));
> +
> +	/* Wait for inf switch */
> +	usleep_range(20, 40);

[ ... ]

> +static int dw_dp_audio_prepare(struct drm_bridge *bridge,
> +			       struct drm_connector *connector,
> +			       struct hdmi_codec_daifmt *daifmt,
> +			       struct hdmi_codec_params *params)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +	u8 supported_audio_interfaces;
> +	enum dw_dp_audio_interface audio_interface;
> +	u32 cfg1;
> +	int ret;
> +
> +	guard(mutex)(&dp->audio_lock);
> +
> +	/*
> +	 * prepare might be called multiple times, so release the clocks
> +	 * from previous calls to keep the calls in balance.
> +	 */
> +	if (dp->audio_interface !=3D DW_DP_AUDIO_UNUSED)
> +		__dw_dp_audio_disable(dp);
> +
> +	/* The hardware is limited to 1,2 or 8 channels */
> +	switch (params->cea.channels) {
> +	case 1:
> +	case 2:
> +	case 8:
> +		break;
> +	default:
> +		dev_err(dp->dev, "invalid audio channels %d\n", params->cea.channels);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Should dw_dp_audio_prepare() check and store params->channels instead of
params->cea.channels?

In hdmi_codec_fill_codec_params(), params->cea.channels is set to 0 when
IEC958_AES0_NONAUDIO is set in the IEC958 status bits (meaning "refer to
stream header" in the CTA-861 Audio InfoFrame), while params->channels holds
the actual stream channel count.  Using params->cea.channels causes
dw_dp_audio_prepare() to reject non-PCM streams with -EINVAL, and would also
program NUM_CHANNELS and AUDIO_DATA_IN_EN in DW_DP_AUD_CONFIG1 with the
InfoFrame field rather than the stream channel count.

> +
> +	if (params->sample_width < 16 || params->sample_width > 24) {
> +		dev_err(dp->dev, "invalid data sample width %d\n", params->sample_widt=
h);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Does rejecting sample_width > 24 here break 32-bit formats advertised on the
I2S DAI?

In dw_dp_probe(), bridge->hdmi_audio_i2s_formats is left unset, so
hdmi_codec_probe() falls back to its default I2S_FORMATS mask, which
includes SNDRV_PCM_FMTBIT_S32_LE and SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE
(used by ALSA's iec958 plugin to insert PCUV bits in I2S mode).
hdmi_codec_prepare() sets params->sample_width to
snd_pcm_format_width(runtime->format), which is 32 for both formats, causing
dw_dp_audio_prepare() to fail with -EINVAL after hw_params succeeds.
Should bridge->hdmi_audio_i2s_formats be restricted to 16-bit through 24-bit
formats?

> +
> +	switch (daifmt->fmt) {
> +	case HDMI_SPDIF:
> +		audio_interface =3D DW_DP_AUDIO_SPDIF;
> +		break;
> +	case HDMI_I2S:
> +		/*
> +		 * It is recommended to use SPDIF instead of I2S, since I2S mode requi=
res
> +		 * manually inserting PCUV control bits from userspace and this is done
> +		 * automatically in hardware for SPDIF mode.
> +		 */
> +		audio_interface =3D DW_DP_AUDIO_I2S;
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
> +	    supported_audio_interfaces !=3D audio_interface) {
> +		dev_err(dp->dev, "unsupported DAI %d\n", daifmt->fmt);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D clk_prepare_enable(dp->spdif_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(dp->i2s_clk);
> +	if (ret) {
> +		clk_disable_unprepare(dp->spdif_clk);
> +		return ret;
> +	}
> +
> +	if (audio_interface =3D=3D DW_DP_AUDIO_I2S)
> +		clk_disable_unprepare(dp->spdif_clk);
> +	else if (audio_interface =3D=3D DW_DP_AUDIO_SPDIF)
> +		clk_disable_unprepare(dp->i2s_clk);
> +
> +	dp->audio_channels =3D params->cea.channels;
> +	dp->audio_channel_allocation =3D params->cea.channel_allocation;
> +	dp->audio_sample_width =3D params->sample_width;
> +	dp->audio_interface =3D audio_interface;
> +
> +	ret =3D __dw_dp_audio_enable(dp);

[Severity: Medium]
Does disabling the unselected audio clock before calling
__dw_dp_audio_enable() defeat keeping both clocks running across the
AUDIO_INF_SELECT mux switch?

Both dp->spdif_clk and dp->i2s_clk are enabled here and the unselected clock
is immediately disabled before any register access occurs.  The actual
AUDIO_INF_SELECT update in DW_DP_AUD_CONFIG1 and the 20-40 us interface
switch delay happen inside __dw_dp_audio_enable(), which is also called from
dw_dp_bridge_atomic_enable() after dw_dp_reset() resets AUDIO_INF_SELECT to
0 (I2S).  If the hardware mux requires both clocks to be active while
switching AUDIO_INF_SELECT, both clocks should be enabled around the
DW_DP_AUD_CONFIG1 update and usleep_range(20, 40) inside
__dw_dp_audio_enable().

[ ... ]

> @@ -1734,12 +2020,22 @@ static void dw_dp_bridge_atomic_enable(struct drm=
_bridge *bridge,
>  		dev_err(dp->dev, "failed to enable video: %d\n", ret);
>  		return;
>  	}
> +
> +	scoped_guard(mutex, &dp->audio_lock) {
> +		if (dp->audio_interface !=3D DW_DP_AUDIO_UNUSED) {
> +			ret =3D __dw_dp_audio_enable(dp);
> +			if (ret < 0)
> +				dev_err(dp->dev, "failed to restore audio: %d\n", ret);
> +		}
> +	}
>  }

[Severity: Medium]
Should the driver call drm_connector_hdmi_audio_plugged_notify() when the
DisplayPort link is enabled, disabled, or hotplugged?

The patch includes drm/display/drm_hdmi_audio_helper.h and sets
DRM_BRIDGE_OP_DP_AUDIO, but never calls
drm_connector_hdmi_audio_plugged_notify().  Because drm_bridge_connector
only calls drm_atomic_helper_connector_hdmi_hotplug() automatically when
DRM_BRIDGE_OP_HDMI is set, hdmi-codec's plugged_cb() is never invoked for
this bridge.  As a result, ASoC jack detection (SND_JACK_AVOUT) is never
signaled and the ALSA ELD control is not updated on hotplug before a PCM
stream is opened.

[ ... ]

> @@ -2368,12 +2673,21 @@ int dw_dp_probe(struct dw_dp *dp)
>  		return ret;
> =20
>  	dp->vsc_sdp_nr =3D -1;
> +	dp->audio_interface =3D DW_DP_AUDIO_UNUSED;
> +	dp->audio_sdp_nr =3D -1;
> =20
>  	bridge =3D &dp->bridge;
>  	bridge->of_node =3D dev->of_node;
> -	bridge->ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_=
OP_HPD;
> +	bridge->ops =3D DRM_BRIDGE_OP_DP_AUDIO |
> +		      DRM_BRIDGE_OP_DETECT |
> +		      DRM_BRIDGE_OP_EDID |
> +		      DRM_BRIDGE_OP_HPD;
>  	bridge->type =3D DRM_MODE_CONNECTOR_DisplayPort;
>  	bridge->ycbcr_420_allowed =3D true;
> +	bridge->hdmi_audio_dev =3D dev;
> +	bridge->hdmi_audio_max_i2s_playback_channels =3D 8;
> +	bridge->hdmi_audio_dai_port =3D 1;
> +	bridge->hdmi_audio_spdif_playback =3D true;

[Severity: Low]
Should bridge->hdmi_audio_dai_port be set to -1 instead of 1?

In rockchip,dw-dp.yaml (and in dw_dp_probe() via
of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0)), OF-graph port 1 is the
DisplayPort video output port, while audio DAIs are referenced via
#sound-dai-cells =3D <1> rather than an OF-graph audio port.  Per struct
drm_bridge documentation, hdmi_audio_dai_port should be -1 when an OF-graph
audio port is not used, otherwise drm_connector_hdmi_audio_get_dai_id() will
match the video output port.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-synopsys-d=
w-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com?part=3D22
