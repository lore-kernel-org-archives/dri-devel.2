Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3495CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC71113F5C;
	Thu,  4 Jun 2026 11:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IxM8Rb/I";
	dkim-atps=neutral
Received: from mail-m8267.xmail.ntesmail.com (mail-m8267.xmail.ntesmail.com
 [156.224.82.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA53113F5A
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 11:32:35 +0000 (UTC)
Received: from [172.16.12.77] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4114f0229;
 Thu, 4 Jun 2026 19:32:31 +0800 (GMT+08:00)
Message-ID: <c3b829f2-8f8f-4b76-bbd6-977ee49e32d1@rock-chips.com>
Date: Thu, 4 Jun 2026 19:32:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] drm/bridge: synopsys: dw-dp: Simplify driver
 data setting
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
 <20260501-synopsys-dw-dp-improvements-v2-3-d7e7f6bac77f@collabora.com>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20260501-synopsys-dw-dp-improvements-v2-3-d7e7f6bac77f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e9268059309d8kunmba51a6264c1bb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSxkYVkIeQh4ZGUNNQxhDGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=IxM8Rb/I2HY1HFLeGgoTCxr9yMRWq2uCjku9+lyH/eib/AzBDiclBkhnEdoRyaaPTlFEUfrz/eWpdvhOjsfiFG59EBa8a0xBqZ2z8mm1cMQNjrlANczPs4s9KDMWCWIUhYEsabXYKnzCDej+y/axSmo7vmX89rHtVB+LDW95RbM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=WPG/AsGIP40sCtd85f/8cpoPt3ZPqI9/+Lllb2HF/3o=;
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

Hello,

On 5/1/26 06:20, Sebastian Reichel wrote:
> There is no need to get the platform device just for setting up
> the driver data. Simplify the logic.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

    Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> index 150c2da8fee5..52e956bffb12 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> @@ -74,7 +74,6 @@ static const struct drm_encoder_helper_funcs dw_dp_encoder_helper_funcs = {
>   
>   static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *data)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
>   	const struct dw_dp_plat_data *plat_data;
>   	struct drm_device *drm_dev = data;
>   	struct rockchip_dw_dp *dp;
> @@ -87,7 +86,7 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
>   		return -ENOMEM;
>   
>   	dp->dev = dev;
> -	platform_set_drvdata(pdev, dp);
> +	dev_set_drvdata(dev, dp);
>   
>   	plat_data = of_device_get_match_data(dev);
>   	if (!plat_data)
> 

