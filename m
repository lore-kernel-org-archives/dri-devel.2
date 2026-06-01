Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE23ACD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270111130F8;
	Mon,  1 Jun 2026 10:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Xr8G+B54";
	dkim-atps=neutral
Received: from mail-m60122.netease.com (mail-m60122.netease.com
 [210.79.60.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E091130F8
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:46:44 +0000 (UTC)
Received: from [172.16.12.77] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 409783698;
 Mon, 1 Jun 2026 18:46:41 +0800 (GMT+08:00)
Message-ID: <71b11cb4-9c9c-4875-a48f-98cb0e3e0517@rock-chips.com>
Date: Mon, 1 Jun 2026 18:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/rockchip: vop2: Drop redundant zero-init in
 setup_layer_mixer()
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260504-vop2-layer-cfg-tmout-v1-0-730226a7331e@collabora.com>
 <20260504-vop2-layer-cfg-tmout-v1-4-730226a7331e@collabora.com>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20260504-vop2-layer-cfg-tmout-v1-4-730226a7331e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e82cafc6109d8kunm2db9e1ee38d185
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSU5DVk9MQ0kYGE4YSBgfSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Xr8G+B54eBQ9FXoDUYlHPIa6DdsjWDxLSkMD/pKLRF6rV+zF6Ax+Y/aClKKK0WwRf3l/eR49as8L4LLYG//fERlL4WJI3KHvReiVuY2neI4EptM4kzvxMzQyEu09lxoTvznKWSnkciEAyFZyhV4c1Rp38e7sbOSAtKvXA5iP0Wo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=4erhXhxolnnqphWTttWW2Y4zr5sdcM4XBJBGs4a57V8=;
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
> The layer_sel and atv_layer_sel local variables in
> rk3568_vop2_setup_layer_mixer() are unconditionally assigned from
> vop2->old_layer_sel and the RK3568_OVL_LAYER_SEL register read,
> respectively, before any use.
> 
> Remove the superfluous zero-initializers.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
   
    Reviewed-by: Andy Yan <andy.yan@rock-chips.com>


> ---
>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index 1f5e8c2acecd..0849bd922ffb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -2134,9 +2134,9 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
>   {
>   	struct vop2 *vop2 = vp->vop2;
>   	struct drm_plane *plane;
> -	u32 layer_sel = 0;
> +	u32 layer_sel;
>   	u32 port_sel;
> -	u32 atv_layer_sel = 0;
> +	u32 atv_layer_sel;
>   	u8 layer_id;
>   	u8 old_layer_id;
>   	u8 layer_sel_id;
> 

