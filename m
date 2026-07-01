Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D34C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B914B10EEE2;
	Wed,  1 Jul 2026 10:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uznlvatN";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACAA10EEE5
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1782902729;
 bh=d2IWXZq6Dmau8UfTNk+TACUN3QluuzDtTFgWgtgZaB0=;
 b=uznlvatNUnUpFS9K7WWKgg+Ywn17Qmw7UOGnH1wGVz1+6Id/TUZfEKbR4zxk1J8hCN63AkXwo
 y09Iqe19NWa/coU2Fzhm+OPEsktO+kELWAiYx8Y+zH3nKeKE333VuXunTTYwMFcEw6vvlogBL5u
 HffkOtd92tn4r7xt6a+FYe4X2eVS/fmLtg1enDa5YOI0hBMGEAHhAleY/223AufdmzREqC+fGV9
 ENar/f1At0kZj9FhRx4ueBFfIYw/LgBF5QWNYXddSv8QFiFsZSVZzV/HMmkmDEMMCAuxU1Kw7vZ
 Kcu2S5XZ5xdIZUIeQToQOq0qkSDTwYZaJrH8stZn9Qjg==
X-Forward-Email-ID: 6a44efc46e27ac04145a5a04
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.9.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <35572b83-0e1e-4b2d-932e-47818fc815a4@kwiboo.se>
Date: Wed, 1 Jul 2026 12:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: dw_hdmi: Fix error handling for
 drm_atomic_get_bridge_state()
To: Chen Ni <nichen@iscas.ac.cn>, heiko@sntech.de
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
References: <20260701030835.2662123-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260701030835.2662123-1-nichen@iscas.ac.cn>
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

Hi,

On 7/1/2026 5:08 AM, Chen Ni wrote:
> The drm_atomic_get_bridge_state() function returns an error pointer on
> failure, not NULL. Fix the check to use IS_ERR() to correctly handle
> allocation failures.
> 
> Fixes: dc70272cc184 ("drm/rockchip: dw_hdmi: Propagate bus format to display driver")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thanks, I missed similar change in v15 of 'Add new general DRM property
"color format"' series.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index cffc0af5190f..766cf21a4be7 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -287,7 +287,7 @@ static u32 dw_hdmi_rockchip_get_bus_format(struct drm_encoder *encoder,
>  		return 0;
>  
>  	bridge_state = drm_atomic_get_bridge_state(conn_state->state, bridge);
> -	if (!bridge_state)
> +	if (IS_ERR(bridge_state))
>  		return 0;
>  
>  	if (bridge_state->input_bus_cfg.format != MEDIA_BUS_FMT_FIXED)

