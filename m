Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC91CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 21:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CEA10E6C8;
	Tue,  2 Jun 2026 21:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hAtICkWn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0BF10E6C8
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780435502;
 bh=Lee243RAZYN2iotwnQCtXiZ1Zjke9zD4F6uMm5s/2GM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hAtICkWnT8hfet4ArCllU66Ap/BRAih0RWPLTycBx/EBWgSWzMjvsI/R447p/EqIP
 e8lcmmQ11l8nHctryxXeoSN/6XNRDIfeMtJXprF7uWd655dFruRpibo9O2TpG4d4W9
 jozQkgX9ssowC1VZTnGrAew4j3nj7Ie4hJ55yCWtEehlVHMVtW7wXOkiIbw3fPcb36
 nrgVHP/H+l+1E7keSJSr59WPn+hbs52zs3ow//Dgxtsnu2jGYHCJa8846c05ChWnxR
 9DUlJK6/4V8xM/cEMhnOzAf8tY4HAHfqJbogrdIHglgV9eiwbp3gd3h3TUiOrsD4gY
 K7dTz1dbQziHA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E0B2717E093F;
 Tue,  2 Jun 2026 23:25:01 +0200 (CEST)
Message-ID: <92ac1962-e43a-45a0-958e-e32385af098c@collabora.com>
Date: Wed, 3 Jun 2026 00:25:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: dw-hdmi-qp: use drm_hdmi_acr_get_n_cts()
 helper for audio N/CTS
To: Simon Wright <simon@symple.nz>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
Content-Type: text/plain; charset=UTF-8
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

Hi Simon,

On 5/21/26 10:36 AM, Simon Wright wrote:
> dw_hdmi_qp_set_sample_rate() open-coded its own N and CTS lookup
> tables and search/compute helpers, but it lacked the out-of-table
> CTS fallback needed by strict HDMI sinks at TMDS rates not in the
> table.  The original LG G3 OLED audio mute (linux-rockchip 070633)
> was caused by dw_hdmi_qp_find_cts() returning 0 at 185.625 MHz,
> leaving AUDPKT_ACR_CTS_OVR_EN clear and falling back to the
> controller's internal CTS auto-measurement, which produces incorrect
> timing on the wire at out-of-table rates.
> 
> The shared drm_hdmi_acr_get_n_cts() helper in
> drivers/gpu/drm/display/drm_hdmi_helper.c already implements the
> correct behaviour: it has the HDMI 1.4b spec N/CTS tables, and for
> TMDS rates not in the table it computes CTS = (TMDS * N) / (128 * Fs)
> inline (the canonical HDMI spec formula).  It is already used by
> drivers/gpu/drm/msm/hdmi/hdmi_audio.c.
> 
> Convert dw_hdmi_qp_set_sample_rate() to call the helper.  This
> removes ~200 lines of open-coded tables and search functions
> (dw_hdmi_qp_find_n, _compute_n, _find_cts, _audio_math_diff,
> _match_tmds_n_table, common_tmds_n_table[], common_tmds_cts_table[])
> and fixes the strict-sink audio mute as a side effect of using the
> helper's complete N+CTS path.
> 
> Tested on R76S (RK3576) running Linux 7.0.1, against the LG G3 OLED
> (the sink that originally reported the mute in linux-rockchip
> 070633) at four TMDS rates spanning HDMI 1.4 and HDMI 2.0:
> 
>   TMDS         Mode              Audio with v3
>   148.5 MHz    1080p60   8-bit   plays
>   185.625 MHz  1080p60  10-bit   plays
>   297 MHz      1080p100  8-bit   plays
>   594 MHz      3840p60   8-bit   plays
> 
> Without this change, the LG G3 mutes audio at 185.625, 297, and
> 594 MHz (every rate outside dw-hdmi-qp's open-coded CTS table,
> which contained only 148.5 MHz and below).  With this change,
> drm_hdmi_acr_get_n_cts() supplies the correct CTS at every rate --
> table-canonical at 148.5 / 297 / 594 MHz, and computed via the
> HDMI 1.4b formula at 185.625 MHz.  The 148.5 MHz row is a
> regression check confirming the in-table path is unchanged.
> 
> The Kogan KALED43XU9210STA (a permissive HDMI 2.0 sink that plays
> audio at all rates with or without this change) was used as a
> no-regression control: audio plays at 594 MHz with v3 loaded.
> 
> The open-coded N table in dw-hdmi-qp included optimised N values
> for some TMDS rates that are not in the helper's table (e.g.
> various non-CEA rates between 28-162 MHz).  For those rates the
> helper's fallback returns N = 128 * Fs / 1000, which is the same
> value dw_hdmi_qp_compute_n() returned when no table optimisation
> was needed; no audio regression has been observed at the rates
> tested above.
> 
> Reported-by: Simon Wright <simon@symple.nz>
> Closes: https://lore.kernel.org/linux-rockchip/ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM/
> Suggested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Simon Wright <simon@symple.nz>

I think T-b can be dropped, as the commit description implies you've actually
tested this before submitting.

> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Simon Wright <simon@symple.nz>

The patch looks good to me. 

I'm unable to reproduce the reported issues, but I can confirm audio continues
to work as expected on my end.  

Feel free to include:

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Regards,
Cristian
