Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12FAC56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAEC10E359;
	Thu,  6 Aug 2026 17:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U4u2o6l7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D884C10E359
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:44:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA8BB408BF;
 Thu,  6 Aug 2026 17:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BEC1F000E9;
 Thu,  6 Aug 2026 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786038281;
 bh=9rN6BYKnjbscIaHnxKzNteyr1HEwInIW6JwkxxMa8Z4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U4u2o6l7T0BcMHIzhPbROxysGYZtSWilr0ezRjCkA1kkN0Lw9A7+Y9xB15jj5BbI9
 D/nSueC8Eo+PKGe/C/uoVNKjYF9C0WI2dOh1fixh+ZPIky8CfovuaGX9fpd04BFybs
 b62iffyBfURjRwr0e/RZAAeo5MaK35RA54ChmAEJ6REDOYau3weq5N5hZphrKQ68vo
 DlQ+lz3oe7GZbwih5vl6gBZON899gFZyXmxzSql4ztFtNq/cgnz+T04xjt6Yu0azJB
 J3xS9eboWUHGh/H9E3cPnNy8HRlGhypmmsKHR4e1bRSwFH4J/uxeEoBTkwGqHhbA7N
 rRdjrLGqIKn8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 21/21] drm/bridge: synopsys: dw-dp: Add audio support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-21-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-21-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:44:40 +0000
Message-Id: <20260806174441.48BEC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sleeping functions executed in atomic context.
- [High] Concurrent execution of ALSA audio callbacks and hardware reset ca=
uses unprotected register accesses.
- [Medium] Unchecked `regmap_read()` return value leads to use of uninitial=
ized stack variable.
--

--- Patch [21]: [PATCH v11 21/21] drm/bridge: synopsys: dw-dp: Add audio su=
pport ---
commit eb4fb1ad87ba9ac01c09edc96621a5ee17d9b830
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drm/bridge: synopsys: dw-dp: Add audio support

This commit implements audio support for the Synopsys DesignWare DisplayPort
controller.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index b610abf76ef77..df149c52fce0f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -1697,6 +1728,261 @@ static int dw_dp_link_enable(struct dw_dp *dp)
[ ... ]
> +static int dw_dp_audio_prepare(struct drm_bridge *bridge,
> +			       struct drm_connector *connector,
> +			       struct hdmi_codec_daifmt *daifmt,
> +			       struct hdmi_codec_params *params)
> +{
[ ... ]
> +	regmap_read(dp->regmap, DW_DP_CONFIG_REG1, &cfg1);
> +	supported_audio_interfaces =3D FIELD_GET(AUDIO_SELECT, cfg1);

[Severity: Medium]
Since regmap_read() can fail and return an error code, can this leave cfg1
uninitialized?

If the read fails (e.g. due to a temporary bus issue), FIELD_GET() might
extract bits from uninitialized stack memory, which could lead to rejecting
valid audio formats or accepting invalid ones.

[ ... ]
> +static int dw_dp_audio_mute_stream(struct drm_bridge *bridge,
> +				   struct drm_connector *connector,
> +				   bool enable, int direction)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	dev_dbg(dp->dev, "audio %smute\n", enable ? "" : "un");
> +
> +	guard(mutex)(&dp->audio_lock);
> +
> +	dp->audio_muted =3D enable;
> +
> +	regmap_update_bits(dp->regmap, DW_DP_AUD_CONFIG1, AUDIO_MUTE,
> +			   FIELD_PREP(AUDIO_MUTE, enable));
> +
> +	return 0;
> +}

[Severity: High]
Can this ALSA audio callback conflict with a concurrent hardware reset?

While dw_dp_audio_mute_stream() takes dp->audio_lock before updating
DW_DP_AUD_CONFIG1, the DRM subsystem can concurrently call dw_dp_reset()
to reset the controller:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_reset() {
	...
	regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL, CONTROLLER_RESET,
			   FIELD_PREP(CONTROLLER_RESET, 1));
	...
}

Since dw_dp_reset() does not acquire dp->audio_lock before asserting the
CONTROLLER_RESET, could dw_dp_audio_mute_stream() write to the IP while it
is held in reset, resulting in a bus hang or dropped register updates?

[ ... ]
> @@ -1735,6 +2021,14 @@ static void dw_dp_bridge_atomic_enable(struct drm_=
bridge *bridge,
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

[Severity: High]
Is it safe to acquire a sleeping mutex (dp->audio_lock) here?=20

According to the DRM subsystem guidelines, bridge atomic enable callbacks
execute in an atomic context during non-blocking commits, where sleeping
functions are not allowed.

Additionally, __dw_dp_audio_enable() called from this block contains a slee=
p:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:__dw_dp_audio_enable() {
	...
	/* Wait for inf switch */
	usleep_range(20, 40);
	...
}

Could this usleep_range() cause deadlocks or kernel warnings when invoked
from this atomic commit path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D21
