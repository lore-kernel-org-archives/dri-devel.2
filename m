Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4576CD5BD1
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 10:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310C110E546;
	Sun, 31 May 2026 10:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="C94mOfww";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Sun, 31 May 2026 10:34:16 UTC
Received: from mail-m6037.netease.com (mail-m6037.netease.com [210.79.60.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2832A10E546
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 10:34:15 +0000 (UTC)
Received: from [172.16.12.77] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 407772b21;
 Sun, 31 May 2026 18:29:10 +0800 (GMT+08:00)
Message-ID: <a496ada3-fc3f-4b29-a445-20d5615b67e0@rock-chips.com>
Date: Sun, 31 May 2026 18:29:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/rockchip: dw_dp: Release core resources
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com>
 <20260327-drm-rk-fixes-v3-2-fd2e6900c08c@collabora.com>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20260327-drm-rk-fixes-v3-2-fd2e6900c08c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e7d94971009d8kunmdad3b07c2c8c6f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk4fVh1DSkIYH0gdSkMaQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=C94mOfwweKdCeNMsAXQxqYki9N9p084rKTujXn86eTRZGwqHKo+W/4qR0JYA0N/PT9Z7G1kGZ1so/srrKImXHZGsQqpSAO5aqoitDW2UuJF9s34gMbTNeQM1REqMtZTm7GvsaypUD1/K+hBTDRfhcjkgpIDjfCAAoa1mwbarHO8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=aY8TqNHQ0EabLACieZZHcwq7jIIC+qHpK9YEKIQ+3u8=;
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

On 3/27/26 08:55, Cristian Ciocaltea wrote:
> Core resources such as the DisplayPort AUX channel get initialized and
> registered during dw_dp_bind(), but are never unregistered, which may
> lead to memory leaks and/or use-after-free:
> 
> [  224.661371] BUG: KASAN: slab-use-after-free in device_is_dependent+0xe0/0x2b0
> [  224.662015] Read of size 8 at addr ffff00011aee8550 by task modprobe/658
> [  224.662612]
> [  224.662752] CPU: 7 UID: 0 PID: 658 Comm: modprobe Not tainted 7.0.0-rc2-next-20260305 #14 PREEMPT
> [  224.662759] Hardware name: Radxa ROCK 5B (DT)
> [  224.662762] Call trace:
> [  224.662764]  show_stack+0x20/0x38 (C)
> [  224.662772]  dump_stack_lvl+0x6c/0x98
> [  224.662777]  print_report+0x160/0x4b8
> [  224.662783]  kasan_report+0xb4/0xe0
> [  224.662790]  __asan_report_load8_noabort+0x20/0x30
> [  224.662796]  device_is_dependent+0xe0/0x2b0
> [  224.662802]  device_is_dependent+0x108/0x2b0
> [  224.662808]  device_link_add+0x1f8/0x10b0
> [  224.662813]  devm_of_phy_get_by_index+0x120/0x200
> [  224.662819]  dw_dp_bind+0x34c/0xb10 [dw_dp]
> [  224.662830]  dw_dp_rockchip_bind+0x194/0x250 [rockchipdrm]
> [  224.662864]  component_bind_all+0x3a8/0x720
> [  224.662869]  rockchip_drm_bind+0x120/0x390 [rockchipdrm]
> [  224.662899]  try_to_bring_up_aggregate_device+0x76c/0x838
> [  224.662904]  component_master_add_with_match+0x1f4/0x230
> [  224.662909]  rockchip_drm_platform_probe+0x420/0x538 [rockchipdrm]
> [  224.662939]  platform_probe+0xe8/0x168
> [  224.662945]  really_probe+0x340/0x828
> [  224.662950]  __driver_probe_device+0x2e0/0x350
> [  224.662954]  driver_probe_device+0x80/0x140
> [  224.662959]  __driver_attach+0x398/0x460
> [  224.662964]  bus_for_each_dev+0xe0/0x198
> [  224.662968]  driver_attach+0x50/0x68
> [  224.662972]  bus_add_driver+0x2a0/0x4c0
> [  224.662977]  driver_register+0x294/0x360
> [  224.662982]  __platform_driver_register+0x7c/0x98
> [  224.662987]  rockchip_drm_init+0xc4/0xff8 [rockchipdrm]
> 
> Since a previous commit exported dw_dp_unbind() function in DW DP core
> library to take care of the necessary cleanup, use this in the
> component's unbind() callback, as well as in its bind() error path.
> 
> Fixes: d68ba7bac955 ("drm/rockchip: Add RK3588 DPTX output support")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> index 22c0911f1896..8cba90d2dd56 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> @@ -108,14 +108,28 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
>   
>   	connector = drm_bridge_connector_init(drm_dev, encoder);
>   	if (IS_ERR(connector))
> -		return dev_err_probe(dev, PTR_ERR(connector),
> -				     "Failed to init bridge connector");
> +		ret = dev_err_probe(dev, PTR_ERR(connector),
> +				    "Failed to init bridge connector");
> +	else
> +		ret = drm_connector_attach_encoder(connector, encoder);
>   
> -	return drm_connector_attach_encoder(connector, encoder);

This line has already been removed in the latest code.




> +	if (ret)
> +		dw_dp_unbind(dp->base);
> +
> +	return ret;
> +}
> +
> +static void dw_dp_rockchip_unbind(struct device *dev, struct device *master,
> +				  void *data)
> +{
> +	struct rockchip_dw_dp *dp = dev_get_drvdata(dev);
> +
> +	dw_dp_unbind(dp->base);
>   }
>   
>   static const struct component_ops dw_dp_rockchip_component_ops = {
>   	.bind = dw_dp_rockchip_bind,
> +	.unbind = dw_dp_rockchip_unbind,
>   };
>   
>   static int dw_dp_probe(struct platform_device *pdev)
> 

