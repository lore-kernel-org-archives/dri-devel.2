Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B40C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 11:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D80010E197;
	Sat,  8 Aug 2026 11:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="RtPwgry/";
	dkim-atps=neutral
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C7110E197
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 11:28:18 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1786188496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTiQEkGVBrasvVz8h8QknY2d4efiqb6H0T4s+eD983M=;
 b=RtPwgry/cGWIE73k1OOPhyXIijIJRNCMYBRaHVyD1Z+u1QIXAj6XGI6cnrEw3pfnu7vVQH
 w9IupxB3EOMxN8AELNZNIDUppeEOpS93Ph6S/wwbns1SXO72Q7cfRpNSZZ6P/2mYYzeAN/
 vUl5AlUCPtzg9hptJ0G1lNu2keigXxcdFaZ9UtMSqwAi5RWWa8EQj+5WiCDfKOA2C3Tm4x
 HtVhLZAH+pOcVdUUI+xLHIp3SR8oX1tk0XANscUQMl8+oA/J5dF16+eHms//VqcemYMdNi
 4G2srQgigDo9cS2ya9gThKXgFRXLQuCcFhFjraZs+qdylNC3l8JMYmUhP26r+Q==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Aug 2026 13:28:11 +0200
Message-Id: <DKJIZ53ZYJ91.3KMAO0TX8X9XS@cknow-tech.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Detlev Casanova" <detlev.casanova@collabora.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <kernel@collabora.com>, <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI
 audio functions
References: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
In-Reply-To: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
X-Migadu-Flow: FLOW_OUT
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Detlev,

On Tue May 19, 2026 at 8:00 PM CEST, Detlev Casanova wrote:
> -EOPNOTSUPP is not logged as an error by the ASoC subsystem, but -ENODEV
> is.
> It also better represents the situation: The operation is currently not
> supported (because clocks are not enabled and tmds_char_rate is
> unavailable), but the hardware is present.
>
> Using -EOPNOTSUPP in the audio_prepare callback removes possible repeated
> warning log lines when HDMI is not connected.

IME/IMO that's a bit of an understatement as I got 10/100/1000s of these:

  hdmi-audio-codec hdmi-audio-codec.6.auto: ASoC error (-19): at snd_soc_da=
i_prepare() on i2s-hifi

In my test without this patch, I booted up my SBCs, logged in quickly and
still got 60/120/270 of these errors in dmesg ... and I wasn't actually=20
using HDMI at that time. Previously, more then once did it completely
fill the dmesg buffer, removing/hiding the things I actually wanted to see.

> Returning -EOPNOTSUPP in the audio_enable callback is also needed as it
> avoids logging 0-valued ELD errors.

I've seen those too, multiple times, although it didn't annoy me as much
as the above one ... due to the (much) lower frequency. So

1) Thanks a LOT for this patch :-D
2) Feel free to include my

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock 5B, NanoPC-T6=
 LTS & Plus

Cheers,
  Diederik

> When tmds_char_rate is available, the clocks are enabled and the
> functions will keep returning 0 as before.
>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5..270c8c47d853 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -469,8 +469,10 @@ static int dw_hdmi_qp_audio_enable(struct drm_bridge=
 *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi =3D dw_hdmi_qp_from_bridge(bridge);
> =20
> -	if (hdmi->tmds_char_rate)
> -		dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SW=
DISABLE);
> +	if (!hdmi->tmds_char_rate)
> +		return -EOPNOTSUPP;
> +
> +	dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWD=
ISABLE);
> =20
>  	return 0;
>  }
> @@ -484,7 +486,7 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge=
 *bridge,
>  	bool ref2stream =3D false;
> =20
>  	if (!hdmi->tmds_char_rate)
> -		return -ENODEV;
> +		return -EOPNOTSUPP;
> =20
>  	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
>  		dev_err(hdmi->dev, "unsupported clock settings\n");
>
> ---
> base-commit: 1a2ab0feaa23147e347b4d4cb79cb3fc392118eb
> change-id: 20260519-fix-hdmi-audio-warnings-139062ec00b9
>
> Best regards,
> -- =20
> Detlev Casanova <detlev.casanova@collabora.com>


