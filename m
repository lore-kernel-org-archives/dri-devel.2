Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0B0CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8764610E770;
	Mon,  1 Jun 2026 10:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MIFkC8AH";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Mon, 01 Jun 2026 10:50:02 UTC
Received: from mail-m82129.xmail.ntesmail.com (mail-m82129.xmail.ntesmail.com
 [156.224.82.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753AF10E770
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:50:02 +0000 (UTC)
Received: from [172.16.12.77] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40978354e;
 Mon, 1 Jun 2026 18:44:55 +0800 (GMT+08:00)
Message-ID: <2111c699-bf61-4451-b33b-a848b166eb9e@rock-chips.com>
Date: Mon, 1 Jun 2026 18:44:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/rockchip: vop2: Fix wrong wait target in layer
 cfg done check
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
 <20260504-vop2-layer-cfg-tmout-v1-1-730226a7331e@collabora.com>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20260504-vop2-layer-cfg-tmout-v1-1-730226a7331e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e82c95da409d8kunm01c27a9638cd97
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUJIVh9LSkpNQh4aT0JIGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=MIFkC8AHwHL2FWUnQEEtZJFPzaWQekHV6xdH/eKwuXwzxG04rty0Z9H/P4M4t7pUMQgPv9cLtRLyZ6RMo5iTCWLUB33uiKRDddJ5guMQnJsxRBgqHO/Z9YqbmTuKFNICGYMvmH9s01O+hD9Zt93girlwQj/BAoExeRLjDfYJYRI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=k6cFF0rW3WqjUdNa0VXwx7EfaVYwhaHvZBGWXQyCUWY=;
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

On 5/5/26 02:23, Cristian Ciocaltea wrote:
> rk3568_vop2_setup_layer_mixer() waits for the previous Video Port (VP)
> layer configuration to take effect before writing a new one to the
> shared RK3568_OVL_LAYER_SEL shadow register.  However, it passes
> vop2->old_layer_sel to rk3568_vop2_wait_for_layer_cfg_done() as the
> expected value, which at that point already contains the new VP layer.
> 
> This causes the wait to poll for a value that has not been written to
> the shadow register yet, resulting in spurious timeouts when two
> non-blocking atomic commits race:
> 
>    rockchip-drm display-subsystem: [drm] *ERROR* wait layer cfg done timeout [...]
> 
> Pass the local old_layer_sel instead, which still holds the value
> captured from vop2->old_layer_sel before it was overwritten, i.e. the
> previous VP target that the hardware is expected to latch.
> 
> Fixes: 3e89a8c68354 ("drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>


    Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index 02a788a4dfdd..edca0fb16e08 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -2307,7 +2307,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
>   		 * Changes of other VPs' overlays have not taken effect
>   		 */
>   		if (cfg_done)
> -			rk3568_vop2_wait_for_layer_cfg_done(vop2, vop2->old_layer_sel);
> +			rk3568_vop2_wait_for_layer_cfg_done(vop2, old_layer_sel);
>   	}
>   
>   	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
> 

