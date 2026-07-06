Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2F0C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4731E10E80F;
	Mon,  6 Jul 2026 08:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="biArTUc1";
	dkim-atps=neutral
X-Greylist: delayed 495 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 08:33:03 UTC
Received: from mail3.ecloud.global (mail3.ecloud.global [135.181.139.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFD910E80F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:33:03 +0000 (UTC)
Received: from authenticated-user (mail3.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail3.ecloud.global (Postfix) with ESMTPSA id 647828835D9;
 Mon,  6 Jul 2026 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail3;
 t=1783326286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g719dEOrRGyCB71IRs28fycBEbGMkolkOcvo0NwjESI=;
 b=biArTUc1uEJkW7rlIgSFAFGChpkemd/g4cNx4iFazVTPvGJ4nuGQq2xDjWX1vpDQTVjTLC
 bFK/BFmdUh0oh/hd+jNIYBoQmlydcGx/AQ3jzZQGfvG0r2+XgSq9L9rMJkaVT171tfe+KR
 RLS126Ofe3RhYK5wiR3f/256sO+U22g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail3; t=1783326286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g719dEOrRGyCB71IRs28fycBEbGMkolkOcvo0NwjESI=;
 b=R+d/ACK09g2RXoD/xFyNB2u4va2HsTeRF5QY9Yn8sa1V/AFYx/muNr7uqyDp/mWECRF837
 5AedRiGF8HeyDC5i7BfAGgfJF7QKGB2FCRN2epiVn0w852wj/YwZiD2dISrpJTp3QjQXS+
 jZjGe12qD0dmau1Wd1QhL68Kogs1qAQ=
ARC-Authentication-Results: i=1; mail3.ecloud.global;
 auth=pass smtp.mailfrom=maud_spierings@murena.io
ARC-Seal: i=1; s=mail3; d=murena.io; t=1783326286; a=rsa-sha256; cv=none;
 b=47XxuVdlsI+MA+bKR+xMubr3fv2zNCD8zJ3OQIoOkuPvgXvqdGPmpEphLXrcQXIWv/eqrT
 D5L2BersdCV/yy5ErvpjwtFZhk4qfOpTO0gv8+FOtC/S9xRKIN0M4K0v96eL1UrlAtdGj/
 Y8VKlSSXnfUB7ge2Ev4Xm1Z5D7AzOgE=
Message-ID: <706d33da-1927-4bdd-9102-7500ca271887@murena.io>
Date: Mon, 6 Jul 2026 10:24:44 +0200
MIME-Version: 1.0
To: detlev.casanova@collabora.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, kernel@collabora.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
References: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

> -EOPNOTSUPP is not logged as an error by the ASoC subsystem, but -ENODEV
> is.
> It also better represents the situation: The operation is currently not
> supported (because clocks are not enabled and tmds_char_rate is
> unavailable), but the hardware is present.
> 
> Using -EOPNOTSUPP in the audio_prepare callback removes possible repeated
> warning log lines when HDMI is not connected.
> 
> Returning -EOPNOTSUPP in the audio_enable callback is also needed as it
> avoids logging 0-valued ELD errors.
> 
> When tmds_char_rate is available, the clocks are enabled and the
> functions will keep returning 0 as before.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Error messages are gone, tested on Orangepi 5+

Kind regards,
Maud

Tested-by: Maud Spierings <maud_spierings@hotmail.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5..270c8c47d853 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -469,8 +469,10 @@ static int dw_hdmi_qp_audio_enable(struct drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
>  
> -	if (hdmi->tmds_char_rate)
> -		dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWDISABLE);
> +	if (!hdmi->tmds_char_rate)
> +		return -EOPNOTSUPP;
> +
> +	dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWDISABLE);
>  
>  	return 0;
>  }
> @@ -484,7 +486,7 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge *bridge,
>  	bool ref2stream = false;
>  
>  	if (!hdmi->tmds_char_rate)
> -		return -ENODEV;
> +		return -EOPNOTSUPP;
>  
>  	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
>  		dev_err(hdmi->dev, "unsupported clock settings\n");
> 
> ---
> base-commit: 1a2ab0feaa23147e347b4d4cb79cb3fc392118eb
> change-id: 20260519-fix-hdmi-audio-warnings-139062ec00b9
> 
> Best regards,
> --  
> Detlev Casanova <detlev.casanova@collabora.com>

