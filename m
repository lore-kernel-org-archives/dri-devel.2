Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375E606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=NRK1Ogzd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D475D1122FD;
	Fri, 13 Nov 2026 01:41:31 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 13 Nov 2026 01:41:25 UTC
Received: from mail-m1288.netease.com (mail-m1288.netease.com [103.209.128.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0ED1122FD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:41:24 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5483f8bd3;
 Fri, 13 Nov 2026 09:36:19 +0800 (GMT+08:00)
Message-ID: <781db207-ca0e-4e41-8706-c0769b58385f@rock-chips.com>
Date: Fri, 13 Nov 2026 09:36:16 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] drm/rockchip: vop2: Fix the HDMI sync polarity on
 RK3588
To: aiyengar1990@gmail.com
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Piotr Zalewski <pZ010001011111@proton.me>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
 <20261112-vop2-fixes-v2-3-8218c1cf8ac8@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261112-vop2-fixes-v2-3-8218c1cf8ac8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1d28c68f003a7kunm3ed8a3c2a36d2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUJIVhlOH0ofTR1CH00aGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=NRK1OgzdCmB0whylUbps83DuQoBR+n4HlZoHbh9r3cb/rRAS1LmfPW6CJBFracLEP2OjBWzSwHIRlCOx5ZgWV4+srjQntk06TeTXvD8Xvua0J5PX+oSN0N2tCeZvWAtxonYwNljqL5muGYLMjOh2y6mgMc0Cg8AlBD5CZYQ3ncY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=yUomd9KXnjseidZCb+3NrIiSfYZB9y809aXsxz/VNIE=;
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

Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Oh wow, nobody even noticed this.

On 11/12/2026 4:33 PM, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> rk3588_set_intf_mux() passes the POLFLAG bits of the mode to
> rk3588_get_hdmi_pol(), which decodes them as DRM mode flags: the
> VSYNC_POSITIVE bit is taken for DRM_MODE_FLAG_NHSYNC and POLFLAG_DCLK_INV
> for DRM_MODE_FLAG_NVSYNC. As a result GRF_VO1_CON0 marks the HSYNC of
> every +HSync/+VSync mode (e.g. all 1080p, 2160p CTA modes) as negative
> and both syncs of -HSync/-VSync modes (e.g. 720x480, 640x480) as
> positive.
> 
> The bits in GRF_VO1_CON0 are set for a negative sync; that is how the
> vendor kernel programs them (vop2_get_hdmi_pol(), called with the mode
> flags, sets them for DRM_MODE_FLAG_NHSYNC/NVSYNC on RK3588). Decode the
> POLFLAG bits accordingly.
> 
> Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

> ---
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index 659fd0a3ab63..7c48b440cb29 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -1687,12 +1687,16 @@ static u32 rk3588_get_mipi_port_mux(int vp_id)
>  		return 0;
>  }
>  
> -static u32 rk3588_get_hdmi_pol(u32 flags)
> +/*
> + * The HDMI sync polarity bits in GRF_VO1_CON0 are set for an active low
> + * (negative) sync.
> + */
> +static u32 rk3588_get_hdmi_pol(u32 polflags)
>  {
>  	u32 val;
>  
> -	val = (flags & DRM_MODE_FLAG_NHSYNC) ? BIT(HSYNC_POSITIVE) : 0;
> -	val |= (flags & DRM_MODE_FLAG_NVSYNC) ? BIT(VSYNC_POSITIVE) : 0;
> +	val = (polflags & BIT(HSYNC_POSITIVE)) ? 0 : BIT(HSYNC_POSITIVE);
> +	val |= (polflags & BIT(VSYNC_POSITIVE)) ? 0 : BIT(VSYNC_POSITIVE);
>  
>  	return val;
>  }
> 

-- 
Best, 
Chaoyi

