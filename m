Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A42606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=W3bdIiSz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2616310E046;
	Fri, 20 Nov 2026 09:11:16 +0000 (UTC)
Received: from mail-m128109.netease.com (mail-m128109.netease.com
 [103.209.128.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5733C10E046
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:11:08 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55693ebca;
 Fri, 20 Nov 2026 17:11:05 +0800 (GMT+08:00)
Message-ID: <f3cda527-073e-4c77-9ea5-5376f034220f@rock-chips.com>
Date: Fri, 20 Nov 2026 17:11:03 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: analogix_dp: Make
 analogix_dp_init_analog_func() void
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>,
 Brian Norris <briannorris@chromium.org>
References: <CGME20261120083308eucas1p1d1298fab5a4df3a64cf66d5fe9d82438@eucas1p1.samsung.com>
 <20261120083302.3719465-1-m.szyprowski@samsung.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261120083302.3719465-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1f839450f03a8kunmb9ca3b3f4874b1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTkNNVk8dSh9DTRhMSkMdTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=W3bdIiSzw1LREh5N9f/n197EYfBIZFlDT2YqPMW/IZjIrcjUiL8X20Or4x+dA/9Fiwxu03kXdj6kKFAuxV/oh8htorASc5B60t7dYOLaMO+fFDoqP2AKI5hyIty5f2Xk2LjVlF+1Y+W70neoa9/+oRqNnNaaM1OySpTmkxsQCho=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=vxz0t5xlw/l/+uw1TjbyDmkk2nY6oeOtyb8Cl7pZ61M=;
 h=date:mime-version:subject:message-id:from;
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 11/20/2026 4:33 PM, Marek Szyprowski wrote:
> analogix_dp_init_analog_func() always returned 0, so the error check in
> its only caller, analogix_dp_set_bridge(), never took the jump to the
> common error path. Make the function void and drop the check. No
> functional change.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Link: https://lore.kernel.org/all/20261119093347.1159198-1-m.szyprowski@samsung.com/
> Fixes: 3efe2ace7f5b ("drm/bridge: analogix_dp: move basic controller init into runtime PM")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 +---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 2 +-
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 3 +--
>   3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8bb4c48aa3b4..a41c16b7dcbe 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -996,9 +996,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>   
>   	pm_runtime_get_sync(dp->dev);
>   
> -	ret = analogix_dp_init_analog_func(dp);
> -	if (ret)
> -		return ret;
> +	analogix_dp_init_analog_func(dp);
>   
>   	/*
>   	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 4560597604ad..440007e2270d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -192,7 +192,7 @@ void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable);
>   void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>   				       enum analog_power_block block,
>   				       bool enable);
> -int analogix_dp_init_analog_func(struct analogix_dp_device *dp);
> +void analogix_dp_init_analog_func(struct analogix_dp_device *dp);
>   void analogix_dp_init_hpd(struct analogix_dp_device *dp);
>   void analogix_dp_force_hpd(struct analogix_dp_device *dp);
>   enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index c1344a3f013a..3d196cf96fb9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -351,7 +351,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>   	}
>   }
>   
> -int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
> +void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
>   {
>   	u32 reg;
>   
> @@ -372,7 +372,6 @@ int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
>   	reg &= ~(SERDES_FIFO_FUNC_EN_N | LS_CLK_DOMAIN_FUNC_EN_N
>   		| AUX_FUNC_EN_N);
>   	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
> -	return 0;
>   }
>   
>   void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp)

I've picked this patch on top of my HPD support series and it tests well 
on RK3576.

Tested-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>

Best regards,
Damon

