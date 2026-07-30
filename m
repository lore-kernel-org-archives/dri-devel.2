Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE8AC54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABDE10ED35;
	Thu, 30 Jul 2026 01:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Pnsa1UGv";
	dkim-atps=neutral
Received: from mail-m6097.netease.com (mail-m6097.netease.com [210.79.60.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E13710ED35
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:57:00 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 481805a17;
 Thu, 30 Jul 2026 09:56:57 +0800 (GMT+08:00)
Message-ID: <24547ed2-0950-48be-92cb-bbb0e1653258@rock-chips.com>
Date: Thu, 30 Jul 2026 09:56:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: vop2: give rk3576 VP2 a primary plane
To: Tomonori Nakagawa <jack@supremeoverlordjabs.co>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729232450.13797-1-jack@supremeoverlordjabs.co>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260729232450.13797-1-jack@supremeoverlordjabs.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9fb0bd339503a7kunmf80d911848e5e4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTBlDVkodQ0sfHx0aSk4ZS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Pnsa1UGvoPlSQyjRMpaNfuBLH6zpKreiZ/LmhTDTrbu9ywYQ919LFMrV4aUfVPyVvlebheN3UW2XnJoVrIw5mGQDWfIMSIAYRJ07D4EFQQo7WOtA2FNXjFKslD3GJn6digpbRqqMc1xj1P97jXVVG3FoglfwSceX9vkL3pgrkWU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=xYPdjsXkASKMyTAg3XvVIpdC44k10zS9iryWX8Aia78=;
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

Hello Tomonori,

On 7/30/2026 7:24 AM, Tomonori Nakagawa wrote:
> The rk3576 VOP2 has three video ports. VP0 and VP1 each have a Cluster
> window that acts as their primary plane, but VP2 - the port wired to the
> DesignWare DP controller - only has Esmart windows, all typed
> DRM_PLANE_TYPE_OVERLAY.

The description here is not accurate. VP2 can wire to different
display interfaces which depending on your board configuration.

> 
> The driver requires every active video port to own a
> DRM_PLANE_TYPE_PRIMARY plane. When VP2 is driven (a board that uses the
> DP output) it finds none, CRTC creation returns -ENOENT, and the whole
> VOP2 bind fails, taking down the entire display subsystem.
> 
> Promote Esmart0 to DRM_PLANE_TYPE_PRIMARY so VP2 has a primary plane.
> Esmart0's possible_vp_mask already includes VP2 (BIT(2)) and its
> layer_sel_id[2] = 0 is a valid VP2 layer slot, while VP0 keeps Cluster0
> as its primary, so the existing VP0/VP1 assignments are unchanged:
> 
>   VP0: primary=Cluster0, overlay=Esmart2
>   VP1: primary=Cluster1, overlays=Esmart1, Esmart3
>   VP2: primary=Esmart0,  overlays=Esmart1, Esmart2, Esmart3
> 
> Tested on Anbernic RG Vita Pro (rk3576) with the DP alt-mode output.
> 
> Signed-off-by: Tomonori Nakagawa <jack@supremeoverlordjabs.co>
> ---
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index 17eda592b..e7d013dc3 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -894,7 +894,7 @@ static const struct vop2_win_data rk3576_vop_win_data[] = {
>  		.format_modifiers = format_modifiers,
>  		.layer_sel_id = { 2, 0xf, 0, 0xf },
>  		.supported_rotations = DRM_MODE_REFLECT_Y,
> -		.type = DRM_PLANE_TYPE_OVERLAY,
> +		.type = DRM_PLANE_TYPE_PRIMARY,
>  		.axi_bus_id = 0,
>  		.axi_yrgb_r_id = 0x10,
>  		.axi_uv_r_id = 0x11,

-- 
Best, 
Chaoyi
