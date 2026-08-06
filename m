Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EF8C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A25A10E92C;
	Thu,  6 Aug 2026 13:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="ID1obsL5";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6E710E92C
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 13:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786022747; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JYmNaCoXyzro3Q53i5bL4MpoZ+h3AA8mjjC3oZ2+6YL3cQM16m3/bUZzYmJhXE9Wcx5CAQYC6l3VRLJKA5NB0X0l5puosKf8M34sDgrfeLPrEQ2ya6hdT39IQITRw9CpsnQV5V22GEUbIfHj8Grw2zzt/ZyNcoTnh0YC0vi1qr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786022747;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FpQ3IfkpOavGohpjpuluPWW946E9NWU+bIItyoosQDU=; 
 b=HRExQ/KyUCoGddSQic13nb/WkONNRBX69hYS6oSYQebwV4/7zdquCqqdAna7OxR5z8uykl0uB4nhF14wQ7ryk6n8GJUGMKdWiIekMP40zmh7tIU8RdxNXeAF1JJz92M7vwqeA2XbrsqAU3Gp1CAgkNAOdgsMdpR5qXP4gC4qVzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
 dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786022747; 
 s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=FpQ3IfkpOavGohpjpuluPWW946E9NWU+bIItyoosQDU=;
 b=ID1obsL5YqvP4wcq2/Os4gndSsC4evfLQyabLX6BPwbF4bqiJVGZpp8XUc9eft3d
 zgkpPQLqNK5yiO7nK2x6bidLCrDvf4Fdwup3Z6JXUoLv27RPlk3TFETlzLYah2Ojr3o
 Yob3AmD9JTavnsj/t+Chmd6HIgRDO0PKno9z/JZA=
Received: by mx.zohomail.com with SMTPS id 1786022744954597.4720649105778;
 Thu, 6 Aug 2026 06:25:44 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
Date: Thu, 06 Aug 2026 09:25:42 -0400
Message-ID: <wL-zvSHuQZi1YutYxaPQLA@collabora.com>
In-Reply-To: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
References: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External
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

Hi all,

On Tuesday, 19 May 2026 14:00:11 EDT Detlev Casanova wrote:
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

Gentle nudge on this one.

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c index
> d649a1cf07f5..270c8c47d853 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -469,8 +469,10 @@ static int dw_hdmi_qp_audio_enable(struct drm_bridge
> *bridge, {
>  	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
> 
> -	if (hdmi->tmds_char_rate)
> -		dw_hdmi_qp_mod(hdmi, 0, 
AVP_DATAPATH_PACKET_AUDIO_SWDISABLE,
> GLOBAL_SWDISABLE); +	if (!hdmi->tmds_char_rate)
> +		return -EOPNOTSUPP;
> +
> +	dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE,
> GLOBAL_SWDISABLE);
> 
>  	return 0;
>  }
> @@ -484,7 +486,7 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge
> *bridge, bool ref2stream = false;
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




