Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60638C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BAF10F246;
	Thu, 23 Jul 2026 22:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gXManLm8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6445B10F246
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:38:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B720C600AD;
 Thu, 23 Jul 2026 22:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EA11F000E9;
 Thu, 23 Jul 2026 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784846327;
 bh=YzXgNCJrXug++jdnBenwtCBO6+ShH4iOpkGAyuOFDQE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gXManLm8CvEQBAFPKN+gK7nGb61Gz35UFD055ep8R5kzpusSAA3wl8qNxxji9w69y
 UOZc/BEAJLSOPUDaNmlCTlrmdE+DLSVK8hFxEZKXLsvWUitqABc0l3Ws+kCjWGyyFw
 hiSUSZI2F99WwEBdMGJwPrvBrdRFMEbo4CRPBanjgE6ejab0+Vnl5vyKOmC22xVmmH
 nPIU0nUlzRQ0m33EKhFnITogIgXhC7IfLwGbAHymUhRZ5RbgAkBkDyXwk3PXTyjMX8
 GXlL7BmlKLYppmrsZxfVD7BDvf1efbyW4dlHhMzjYAcmbh4dge8jX9NYw0xxp9Ub5N
 GVptGN2nD94ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/15] drm/bridge: synopsys: dw-dp: Add audio support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-15-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v5-15-9445c2e87441@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:38:46 +0000
Message-Id: <20260723223847.34EA11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Unhandled error from `dw_dp_audio_infoframe_send()` results in=
 a negative SDP index, leading to out-of-bounds memory write and undefined =
bitwise shifts.
- [High] Typo in sample width validation allows 32-bit audio to bypass chec=
ks and silently overflow the hardware register mask.
- [High] `dw_dp_audio_unprepare()` unconditionally clears `audio_sdp_nr` (w=
hich defaults to 0), potentially corrupting the active video stream's VSC S=
DP configuration.
- [Medium] `dw_dp_audio_unprepare()` fails to clear the audio stream and ti=
mestamp SDP enablement bits, leaving the hardware in an inconsistent state.
--

--- Patch [15]: [PATCH v5 15/15] drm/bridge: synopsys: dw-dp: Add audio sup=
port ---
commit 8d3e8e3c7ab668f3eaf614e21b09c813acc45d46
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
drm/bridge: synopsys: dw-dp: Add audio support

This commit adds audio support to the Synopsys DesignWare DisplayPort
controller. It implements the necessary DRM bridge audio callbacks and
configures the hardware to transmit I2S or SPDIF audio streams.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 2bd37e5c36da8..a9e04cee002e8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -1890,6 +1928,205 @@ static void dw_dp_bridge_oob_notify(struct drm_br=
idge *bridge,
[ ... ]
> +static void dw_dp_audio_unprepare(struct drm_bridge *bridge,
> +				  struct drm_connector *connector)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	/* Disable all audio streams */
> +	regmap_update_bits(dp->regmap, DW_DP_AUD_CONFIG1, AUDIO_DATA_IN_EN,
> +			   FIELD_PREP(AUDIO_DATA_IN_EN, 0));
> +
[Severity: Medium]
Does this leave the hardware attempting to send stale audio SDPs?

The setup logic in dw_dp_audio_prepare() enables EN_AUDIO_STREAM_SDP and
EN_AUDIO_TIMESTAMP_SDP in the DW_DP_SDP_VERTICAL_CTRL and
DW_DP_SDP_HORIZONTAL_CTRL registers.

However, this cleanup path disables AUDIO_DATA_IN_EN and clears the
infoframe SDP slot, but does not appear to clear the stream and timestamp
SDP bits.

> +	if (dp->audio_interface =3D=3D DW_DP_AUDIO_SPDIF)
> +		clk_disable_unprepare(dp->spdif_clk);
> +	else if (dp->audio_interface =3D=3D DW_DP_AUDIO_I2S)
> +		clk_disable_unprepare(dp->i2s_clk);
> +
> +	dp->audio_interface =3D DW_DP_AUDIO_UNUSED;
> +
> +	dw_dp_clear_sdp(dp, dp->audio_sdp_nr);
[Severity: High]
Can this unintentionally clear the video stream configuration?

When the dw_dp structure is allocated, dp->audio_sdp_nr is initialized to 0.
If a userspace application opens the audio device but closes it before
hardware parameters are configured, dw_dp_audio_shutdown() will still be
called, leading to an unconditional call to dw_dp_clear_sdp(dp, 0).

Since slot 0 is typically already in use by the video stream (allocated by
dw_dp_send_vsc_sdp), this could cause the display hardware to lose its VSC
SDP configuration and break the display.

> +}
> +
> +static int dw_dp_audio_prepare(struct drm_bridge *bridge,
> +			       struct drm_connector *connector,
> +			       struct hdmi_codec_daifmt *daifmt,
> +			       struct hdmi_codec_params *params)
> +{
[ ... ]
> +	if (params->sample_width < 16 || params->sample_width >> 24) {
> +		dev_err(dp->dev, "invalid data sample width %d\n", params->sample_widt=
h);
> +		return -EINVAL;
> +	}
[Severity: High]
Is this a typo where >> 24 was intended to be > 24?

If an ALSA client configures a stream with a 32-bit sample width,
params->sample_width >> 24 evaluates to 0, which bypasses this check.

Later in this function, the 32 value is passed to
FIELD_PREP(AUDIO_DATA_WIDTH, 32). Since AUDIO_DATA_WIDTH is GENMASK(9, 5),
this will silently overflow the 5-bit mask and truncate to 0,
misconfiguring the hardware.

[ ... ]
> +	ret =3D dw_dp_audio_infoframe_send(dp);
> +	if (ret < 0)
> +		dev_err(dp->dev, "failed to send audio infoframe\n");
> +
> +	dp->audio_sdp_nr =3D ret;
[Severity: Critical]
Could this lead to an out-of-bounds memory write if sending the infoframe
fails?

If dw_dp_audio_infoframe_send() returns a negative error code (for example,
if dw_dp_send_sdp() returns -EBUSY because the SDP bank is full), that
negative value is assigned to dp->audio_sdp_nr while the function proceeds
without returning the error.

During teardown, dw_dp_audio_unprepare() will then call:

    dw_dp_clear_sdp(dp, dp->audio_sdp_nr);

In dw_dp_clear_sdp(), this results in negative bit shifts and an
out-of-bounds write:

    EN_VERTICAL_SDP << nr
    clear_bit(nr, dp->sdp_reg_bank);

Would it be safer to return the error code here instead of continuing?

> +
> +	dev_dbg(dp->dev, "audio prepare with %d channels using DAI=3D%d\n",
> +		dp->audio_channels, dp->audio_interface);
> +
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v5-0-9445c2e87441@collabora.com?part=3D15
