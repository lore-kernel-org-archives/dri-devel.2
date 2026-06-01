Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C150CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD1710E771;
	Mon,  1 Jun 2026 10:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BfXqXNyo";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Mon, 01 Jun 2026 10:50:34 UTC
Received: from mail-m10163.netease.com (mail-m10163.netease.com
 [154.81.10.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA0610E771
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:50:34 +0000 (UTC)
Received: from [172.16.12.77] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4097835ba;
 Mon, 1 Jun 2026 18:45:28 +0800 (GMT+08:00)
Message-ID: <a92af1c4-cd0e-4d31-9fd1-7e9cae6bb1d1@rock-chips.com>
Date: Mon, 1 Jun 2026 18:45:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/rockchip: vop2: Wait for layer cfg done before
 switching LAYERSEL_REGDONE_SEL
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
 <20260504-vop2-layer-cfg-tmout-v1-2-730226a7331e@collabora.com>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20260504-vop2-layer-cfg-tmout-v1-2-730226a7331e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e82c9e0e709d8kunmad12aac138cee1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUxKVk1JHhlCQ01KTkxLSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=BfXqXNyopum9m3NwZ3/eLvgDX/aWRtwx81UaXfNhBs/h5/HxoDhhncez6cfRAWAHnc/Vwd9lvbGj6wLRIWR3Ylgs82gcHezYHfcWMPBEzr5O5UuzfgX21toLVYA6gNXbgvCqBBq6keqTxKZGXDLBosAcXbIMOL+FUBNHcP/azD0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=szKM+xo2CtG53S4RQ+h02A+npZXUcLB6AowO29QwZPs=;
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

On 5/5/26 02:24, Cristian Ciocaltea wrote:
> LAYERSEL_REGDONE_SEL mask of RK3568_OVL_CTRL register controls which
> Video Port (VP) vsync latches the shared RK3568_OVL_{LAYER|PORT}_SEL
> shadow registers into the active configuration.
> 
> rk3568_vop2_setup_layer_mixer() overwrites LAYERSEL_REGDONE_SEL to the
> current VP ID before waiting for the previous VP layer configuration to
> take effect.  As a consequence, the previous VP vsync can no longer
> trigger the latch, so the wait polls a value that might never appear.
> 
> Move the layer cfg done wait before the RK3568_OVL_CTRL write so the
> previous VP vsync can still commit the pending configuration.
> 
> Fixes: 3e89a8c68354 ("drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

   
    Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index edca0fb16e08..5206f01ec787 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -2289,15 +2289,6 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
>   	 *    lead to the configuration of the previous VP being take effect along with the VSYNC
>   	 *    of the new VP.
>   	 */
> -	if (layer_sel != old_layer_sel || port_sel != old_port_sel)
> -		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
> -	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
> -
> -	if (port_sel != old_port_sel) {
> -		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
> -		vop2_cfg_done(vp);
> -		rk3568_vop2_wait_for_port_mux_done(vop2);
> -	}
>   
>   	if (layer_sel != old_layer_sel && atv_layer_sel != old_layer_sel) {
>   		cfg_done = vop2_readl(vop2, RK3568_REG_CFG_DONE);
> @@ -2310,6 +2301,16 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
>   			rk3568_vop2_wait_for_layer_cfg_done(vop2, old_layer_sel);
>   	}
>   
> +	if (layer_sel != old_layer_sel || port_sel != old_port_sel)
> +		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
> +	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
> +
> +	if (port_sel != old_port_sel) {
> +		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
> +		vop2_cfg_done(vp);
> +		rk3568_vop2_wait_for_port_mux_done(vop2);
> +	}
> +
>   	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
>   	mutex_unlock(&vop2->ovl_lock);
>   }
> 

