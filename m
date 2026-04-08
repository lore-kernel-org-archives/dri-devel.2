Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A282C10F994F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 15:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163AF10E51A;
	Wed,  8 Apr 2026 15:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WY9slsKs";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD4D10E51A
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 15:33:27 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 019C81A31F7;
 Wed,  8 Apr 2026 15:33:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C495B603CB;
 Wed,  8 Apr 2026 15:33:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E28D410450144; 
 Wed,  8 Apr 2026 17:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775662404; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XgrwB8oAIVjlAggKnPwuRCiDlzO+uSlP6BW+9wxQCpc=;
 b=WY9slsKseQQdifjXci9ktSbh7pjFpsw9qvaCaeKt9l2Qw1dQGh/M8O/T45Lcy7VMHrGHjP
 WKNzHgNiImEYcsIyQmAPs7Ld0TGiU4e58N4yEVjLt6midnPPcc8nkY/oqh+WtKkhF4iMmy
 VI2ODUpsBrks5tqNuSsiXm0lSS1y8p6tKzQuAcsYw1i1vwmGGjkx4Oy1Fy+sYGJIvr7G5Y
 xGQa4ODa4z0WsAMnsiIaJBseS3OkQo/RqLbA6ymFF312Q+ma1RPM2cJ+uUdJBAleZFSAWb
 H4iaywFrc9JmeixBgAfKEItw+4pnxXrYZsRESdljzVG41kL43dpOxnDZLIM59g==
Message-ID: <fdfc2321-bc31-4ff8-831e-adefcf6689a8@bootlin.com>
Date: Wed, 8 Apr 2026 17:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for
 dual LVDS output
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 Linus Walleij <linusw@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
 <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 2/26/26 17:16, Luca Ceresoli wrote:
> Dual LVDS output (available on the SN65DSI84) requires HSYNC_PULSE_WIDTH
> and HORIZONTAL_BACK_PORCH to be divided by two with respect to the values
> used for single LVDS output.
> 
> While not clearly stated in the datasheet, this is needed according to the
> DSI Tuner [0] output. It also makes sense intuitively because in dual LVDS
> output two pixels at a time are output and so the output clock is half of
> the pixel clock.
> 
> Some dual-LVDS panels refuse to show any picture without this fix.
> 
> Divide by two HORIZONTAL_FRONT_PORCH too, even though this register is used
> only for test pattern generation which is not currently implemented by this
> driver.
> 
> [0] https://www.ti.com/tool/DSI-TUNER
> 
> Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index d2a81175d279..17a885244e1e 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -517,6 +517,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>   					struct drm_atomic_state *state)
>   {
>   	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
> +	const unsigned int dual_factor = ctx->lvds_dual_link ? 2 : 1;
>   	const struct drm_bridge_state *bridge_state;
>   	const struct drm_crtc_state *crtc_state;
>   	const struct drm_display_mode *mode;
> @@ -653,18 +654,18 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>   	/* 32 + 1 pixel clock to ensure proper operation */
>   	le16val = cpu_to_le16(32 + 1);
>   	regmap_bulk_write(ctx->regmap, REG_VID_CHA_SYNC_DELAY_LOW, &le16val, 2);
> -	le16val = cpu_to_le16(mode->hsync_end - mode->hsync_start);
> +	le16val = cpu_to_le16((mode->hsync_end - mode->hsync_start) / dual_factor);
>   	regmap_bulk_write(ctx->regmap, REG_VID_CHA_HSYNC_PULSE_WIDTH_LOW,
>   			  &le16val, 2);
>   	le16val = cpu_to_le16(mode->vsync_end - mode->vsync_start);
>   	regmap_bulk_write(ctx->regmap, REG_VID_CHA_VSYNC_PULSE_WIDTH_LOW,
>   			  &le16val, 2);
>   	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_BACK_PORCH,
> -		     mode->htotal - mode->hsync_end);
> +		     (mode->htotal - mode->hsync_end) / dual_factor);
>   	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_BACK_PORCH,
>   		     mode->vtotal - mode->vsync_end);
>   	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_FRONT_PORCH,
> -		     mode->hsync_start - mode->hdisplay);
> +		     (mode->hsync_start - mode->hdisplay) / dual_factor);
>   	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
>   		     mode->vsync_start - mode->vdisplay);
>   	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
> 

