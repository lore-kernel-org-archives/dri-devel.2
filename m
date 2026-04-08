Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A06210F994F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 15:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7104010E09B;
	Wed,  8 Apr 2026 15:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="eU3sWnKC";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8E110E09B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 15:39:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 588D7C5AA98;
 Wed,  8 Apr 2026 15:40:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E9950603CB;
 Wed,  8 Apr 2026 15:39:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F2C57104500FE; 
 Wed,  8 Apr 2026 17:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775662792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=cggLDteGIAY6o5iUmEqsbCcoytc+rXJUlqQQpdlnP8M=;
 b=eU3sWnKCS7WHZMQ0hg2gS1RVEX5ECwt56L+XDVQPDYNltFSlyy0O7oLsD/BgdIuAtonx5d
 //5ZjfzkBrzlikl3ZPK5APdC7/xa/Pt9O5qx7s9+3/HZ17SJQs6XicaYE/Eoy7wVIFOMHi
 yoeWdTR3T9fBmZfRvUI7wN68E0BdefLfXEkNZmnOZiQQpdDMup5+3fLDq0fettWAGVDY/p
 cXKjpFFDfeZG+YlEeRHVqNYbTQ7VnRN7Zr2NzciyKun/EpVR6SCPgDfRXojnimOHktqsNG
 feESdoYupz/79ANxiqf5kSwciRS7/X5Hh1/cXVggD2FCcYlzu4ahfbhQyFyOYw==
Message-ID: <bde82b04-ba23-4324-8ee4-179e8a2cdae3@bootlin.com>
Date: Wed, 8 Apr 2026 17:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/bridge: ti-sn65dsi83: add test pattern generation
 support
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
 <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-3-2e15f5a9a6a0@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-3-2e15f5a9a6a0@bootlin.com>
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
> Generation of a test pattern output is a useful tool for panel bringup and
> debugging, and very simple to support with this chip.
> 
> The value of REG_VID_CHA_ACTIVE_LINE_LENGTH_LOW needs to be divided by two
> for the test pattern to work in dual LVDS mode. While not clearly stated in
> the datasheet, this is needed according to the DSI Tuner [0] output. And
> some dual-LVDS panels refuse to show any picture without this division by
> two.
> 
> [0] https://www.ti.com/tool/DSI-TUNER
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 17a885244e1e..ddc8b5e1dd15 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -114,6 +114,7 @@
>   #define REG_VID_CHA_HORIZONTAL_FRONT_PORCH	0x38
>   #define REG_VID_CHA_VERTICAL_FRONT_PORCH	0x3a
>   #define REG_VID_CHA_TEST_PATTERN		0x3c
> +#define  REG_VID_CHA_TEST_PATTERN_EN		BIT(4)
>   /* IRQ registers */
>   #define REG_IRQ_GLOBAL				0xe0
>   #define  REG_IRQ_GLOBAL_IRQ_EN			BIT(0)
> @@ -134,6 +135,9 @@
>   #define  REG_IRQ_STAT_CHA_SOT_BIT_ERR		BIT(2)
>   #define  REG_IRQ_STAT_CHA_PLL_UNLOCK		BIT(0)
>   
> +static bool sn65dsi83_test_pattern;
> +module_param_named(test_pattern, sn65dsi83_test_pattern, bool, 0644);
> +
>   enum sn65dsi83_channel {
>   	CHANNEL_A,
>   	CHANNEL_B
> @@ -645,7 +649,11 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>   			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
>   	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
>   
> -	le16val = cpu_to_le16(mode->hdisplay);
> +	/*
> +	 * Active line length needs to be halved for test pattern
> +	 * generation in dual LVDS output.
> +	 */
> +	le16val = cpu_to_le16(mode->hdisplay / (sn65dsi83_test_pattern ? 2 : 1));

This will always half the line length, even for "mono" LVDS output no? 
 From the comment I expect something like

if (dual && test_pattern)
	val = hdisplay/2
else
	val = hdisplay

>   	regmap_bulk_write(ctx->regmap, REG_VID_CHA_ACTIVE_LINE_LENGTH_LOW,
>   			  &le16val, 2);
>   	le16val = cpu_to_le16(mode->vdisplay);
> @@ -668,7 +676,8 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>   		     (mode->hsync_start - mode->hdisplay) / dual_factor);
>   	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
>   		     mode->vsync_start - mode->vdisplay);
> -	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
> +	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN,
> +		     sn65dsi83_test_pattern ? REG_VID_CHA_TEST_PATTERN_EN : 0);
>   

(sn65dsi83_test_pattern is not "atomic", but you already saw it)

>   	/* Enable PLL */
>   	regmap_write(ctx->regmap, REG_RC_PLL_EN, REG_RC_PLL_EN_PLL_EN);
> 

