Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A0606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Qdg4MUZ5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9257610E101;
	Fri, 13 Nov 2026 02:59:30 +0000 (UTC)
Received: from mail-m81108.xmail.ntesmail.com (mail-m81108.xmail.ntesmail.com
 [156.224.81.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D837A10E101
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 02:59:23 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 548728669;
 Fri, 13 Nov 2026 10:59:19 +0800 (GMT+08:00)
Message-ID: <72fb3540-e08e-40be-8f3d-63727063be6a@rock-chips.com>
Date: Fri, 13 Nov 2026 10:59:18 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] drm/rockchip: vop2: Don't use uninitialised
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
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
 <20261112-vop2-fixes-v2-2-8218c1cf8ac8@gmail.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261112-vop2-fixes-v2-2-8218c1cf8ac8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1d2d8660c03a8kunm99272d8254646
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZS04dVkMfH0hJGk5CGUtOQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Qdg4MUZ5Y5J5AttCyLUfn9lIM32IW8XAcaVforshf1MHKrWmIjs5KPzF7sr5ykNqk4XWdPqxd/kZqOSYOCZRct3O6ZciBOTaddFdowkjYuaDeHkiVOJ+Pputz/rl2wt+RHFdr6fNS8xAE5b+cJEXtrfgF7Tdnc0btK8nXnye/dY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=7f0VgzKYfj5CawodwOdHpH247rLlZpKsDV1GNlXMq38=;
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

Hi Arun,

On 11/12/2026 4:33 PM, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> rk3588_calc_cru_cfg() converts all four dividers to their register
> encoding with ilog2(), but only sets the ones the interface uses:
> dclk_out_div is left uninitialised for HDMI, eDP and DPI, and
> if_pixclk_div/if_dclk_div for DP and DPI. The garbage is then written to
> RK3588_VP_CLK_CTRL; on an Orange Pi 5 the dclk_out divider of the HDMI
> video port reads back as 3 (/8) in every mode.
> 

The comments are not entirely accurate. The divider relationship is:

dclk_out_div: HDMI(dsc mode), DP and MIPI
if_pixclk_div: All interfaces
if_dclk_div: HDMI and eDP

> Start all dividers at 1. dclk_out only feeds DP and MIPI (and HDMI with
> DSC, which is not supported), so for the other interfaces keep it at the
> dclk_core rate, as the vendor kernel does for HDMI with DSC, instead of
> letting it run at the full DCLK rate.
> 
> Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index c44648e1bc0d..659fd0a3ab63 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -1579,6 +1579,15 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
>   	unsigned long if_pixclk_rate;
>   	int K = 1;
>   
> +	/*
> +	 * Not every interface uses every divider: dclk_out only feeds DP and
> +	 * MIPI, the interface dividers are unused for DP. Start from 1 so that
> +	 * no divider is left uninitialised when its value is converted below.
> +	 */
> +	*dclk_out_div = 1;
> +	*if_pixclk_div = 1;
> +	*if_dclk_div = 1;
> +
>   	if (vop2_output_if_is_hdmi(id)) {
>   		/*
>   		 * K = 2: dclk_core = if_pixclk_rate > if_dclk_rate
> @@ -1648,6 +1657,9 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
>   	}
>   
>   	*dclk_core_div = dclk_rate / dclk_core_rate;
> +	/* An unused dclk_out must not run faster than dclk_core */
> +	if (!vop2_output_if_is_dp(id) && !vop2_output_if_is_mipi(id))
> +		*dclk_out_div = *dclk_core_div;
>   	*if_pixclk_div = ilog2(*if_pixclk_div);
>   	*if_dclk_div = ilog2(*if_dclk_div);
>   	*dclk_core_div = ilog2(*dclk_core_div);
> 

I think we can drop the previous divider initialization, and configure 
the correct dividers for specific interfaces.

- dclk_core_div and if_pixclk_div just remain unchanged.
- if_dclk_div is set for HDMI and eDP interfaces; all others are set to 0.
- dclk_out_div is set for DP and MIPI interfaces; the rest are set to 0.

Best regards,
Damon

