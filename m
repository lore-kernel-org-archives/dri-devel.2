Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D4606A336
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=RyQFNc4i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A770610E75F;
	Wed, 18 Nov 2026 07:55:55 +0000 (UTC)
Received: from mail-m1287.netease.com (mail-m1287.netease.com [103.209.128.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D4A10E733
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:55:49 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 551bffbb0;
 Wed, 18 Nov 2026 15:55:45 +0800 (GMT+08:00)
Message-ID: <8e614b4d-b2be-4da8-8003-de88f22ab7ef@rock-chips.com>
Date: Wed, 18 Nov 2026 15:55:44 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] drm/rockchip: vop2: Don't use uninitialised
 dividers on RK3588
To: aiyengar1990@gmail.com, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andyshrk@163.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
 <20261113-vop2-fixes-v3-2-08ae37e83b5c@gmail.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261113-vop2-fixes-v3-2-08ae37e83b5c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1eda7965b03a8kunm1a1ddd1833dd04
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR5DVkgeHktKSUlMSx4aTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=RyQFNc4ij2drw6Fx0nqJbDh+SFPMGM1Pqfbh0IhdR4KcOBgFgAMAIFpF/e2okYwYuUcCAohtps8YxDc0spFY7KMXP83tQQMfG/ESJAeh/zlQa5QQZh4F0HozwlE4sFb7RobNAO+ZD02FwVmFtA6gw0qFMA3yf1x3NBMlsCXp4qI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=yoojdmS52xksREd25PZVdu2MX9Ot+zg4Wegw5yQYlu4=;
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/2026 12:39 AM, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> rk3588_calc_cru_cfg() converts all four dividers with ilog2(), but every
> interface only sets the ones it uses: dclk_out_div is left uninitialised
> for HDMI, eDP and DPI, if_dclk_div for DP, MIPI and DPI, and
> if_pixclk_div for DP and DPI. For HDMI and eDP the uninitialised
> dclk_out_div is then written to RK3588_VP_CLK_CTRL.
> 
> Set the dividers an interface doesn't use to 1.
> 
> Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> Suggested-by: Damon Ding <damon.ding@rock-chips.com>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index c44648e1bc0d..f340aba5bfd1 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -1597,6 +1597,7 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
>   		 */
>   		*if_pixclk_div = 2;
>   		*if_dclk_div = 4;
> +		*dclk_out_div = 1;
>   	} else if (vop2_output_if_is_edp(id)) {
>   		/*
>   		 * edp_pixclk = edp_dclk > dclk_core
> @@ -1609,6 +1610,7 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
>   		 */
>   		*if_pixclk_div = K;
>   		*if_dclk_div = K;
> +		*dclk_out_div = 1;
>   	} else if (vop2_output_if_is_dp(id)) {
>   		if (output_mode == ROCKCHIP_OUT_MODE_YUV420)
>   			dclk_out_rate = v_pixclk >> 3;
> @@ -1622,6 +1624,8 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
>   			return 0;
>   		}
>   		*dclk_out_div = dclk_rate / dclk_out_rate;
> +		*if_pixclk_div = 1;
> +		*if_dclk_div = 1;
>   	} else if (vop2_output_if_is_mipi(id)) {
>   		if_pixclk_rate = dclk_core_rate / K;
>   		/*
> @@ -1643,8 +1647,12 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
>   		 * mipi pixclk == dclk_out
>   		 */
>   		*if_pixclk_div = 1;
> +		*if_dclk_div = 1;
>   	} else if (vop2_output_if_is_dpi(id)) {
>   		dclk_rate = v_pixclk;
> +		*dclk_out_div = 1;
> +		*if_pixclk_div = 1;
> +		*if_dclk_div = 1;
>   	}
>   
>   	*dclk_core_div = dclk_rate / dclk_core_rate;
> 

Reviewed-by: Damon Ding <damon.ding@rock-chips.com>

Best regards,
Damon

