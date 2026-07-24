Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6CC531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 01:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1392C88697;
	Fri, 24 Jul 2026 01:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SQFrAqiF";
	dkim-atps=neutral
Received: from mail-m2443.xmail.ntesmail.com (mail-m2443.xmail.ntesmail.com
 [45.195.24.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7BE10F275
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 01:14:15 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 47615be98;
 Fri, 24 Jul 2026 09:14:12 +0800 (GMT+08:00)
Message-ID: <4da7a328-5293-498c-ac9b-b1a5a80c543b@rock-chips.com>
Date: Fri, 24 Jul 2026 09:14:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/bridge: analogix_dp: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-2-panchuang@vivo.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260723131649.134127-2-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9f91afe99303a8kunm3116b8eb41f44
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTk1JVhgfQk4aGU1OGh0ZQ1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=SQFrAqiFjWbUn8Yv2MqV8jHKGso8eKSvKPHbmXVQIObg/QuIcAjqDmaHZU7bUEmBoL/C0b+bT2CLLs8qNzyVTsxJ+29NnxHhWGBJuQ/RNh26V09Z0Fgj26cl/i+xA1JPTfAgsLdANLC7w7VYMFKcNNqOozTagwhJJzsFK5Axsf4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Q/a0rPbMmtzdFvdHKbeP9Sovpw899SkE2AtTwIfPmro=;
 h=date:mime-version:subject:message-id:from;
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

Hi Pan,

On 7/23/2026 9:16 PM, Pan Chuang wrote:
> Since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
> devm_request_threaded_irq() automatically logs detailed error messages on
> failure. Remove the now-redundant driver-specific dev_err() call.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 30c0c0b41d5a..566f1e5eb8cd 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1414,10 +1414,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>   					analogix_dp_hardirq,
>   					analogix_dp_irq_thread,
>   					irq_flags, "analogix-dp", dp);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to request irq\n");
> +	if (ret)
>   		return ERR_PTR(ret);
> -	}
>   
>   	dp->aux.name = "DP-AUX";
>   	dp->aux.transfer = analogix_dpaux_transfer;

Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
