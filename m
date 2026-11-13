Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F9D606A335
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=cux/RLhd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C0310E15E;
	Fri, 13 Nov 2026 02:03:13 +0000 (UTC)
Received: from mail-m128123.netease.com (mail-m128123.netease.com
 [103.209.128.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2460C10E15E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 02:03:06 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5484f6ba6;
 Fri, 13 Nov 2026 10:03:03 +0800 (GMT+08:00)
Message-ID: <a5b52d95-7fa2-4148-aa02-cfee6f195e1a@rock-chips.com>
Date: Fri, 13 Nov 2026 10:03:01 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] drm/rockchip: vop2: Fix the HDMI sync polarity on
 RK3588
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
 <20261112-vop2-fixes-v2-3-8218c1cf8ac8@gmail.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261112-vop2-fixes-v2-3-8218c1cf8ac8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1d2a4e0a503a8kunm80fbc02f473c1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEgZVktPSUtOHktJHUkeHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=cux/RLhdEL9vzjCYZTxGA7XZvFMhySw1imRGjuTXATiePVhVQlIg6iqCsMd2ya3Ce40+JGvTvb6GcwHJprfLAmmcqepp/gpQu3glqJRd9eOvuUXOFZKrNE0NuHSnPUYPB//LAmjkdaURy8uevm+sR9XEbyAYolryMwDneUGHmjY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=2yRMouvHM4a05izOhD8UAJhMpR/Nv3hy0kmuRjqTsS0=;
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
> rk3588_set_intf_mux() passes the POLFLAG bits of the mode to
> rk3588_get_hdmi_pol(), which decodes them as DRM mode flags: the
> VSYNC_POSITIVE bit is taken for DRM_MODE_FLAG_NHSYNC and POLFLAG_DCLK_INV
> for DRM_MODE_FLAG_NVSYNC. As a result GRF_VO1_CON0 marks the HSYNC of
> every +HSync/+VSync mode (e.g. all 1080p, 2160p CTA modes) as negative
> and both syncs of -HSync/-VSync modes (e.g. 720x480, 640x480) as
> positive.

The commit msg confuses me. POLFLAG_DCLK_INV has no relation to 
DRM_MODE_FLAG_NVSYNC.

For the RK3588, the polarity relationship is:

DRM_MODE_FLAG_NHSYNC -> Set HDMI hsync polarity bit
DRM_MODE_FLAG_NVSYNC -> Set HDMI vsync polarity bit
DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE -> No valid HDMI dclk polarity bit

> 
> The bits in GRF_VO1_CON0 are set for a negative sync; that is how the
> vendor kernel programs them (vop2_get_hdmi_pol(), called with the mode
> flags, sets them for DRM_MODE_FLAG_NHSYNC/NVSYNC on RK3588). Decode the
> POLFLAG bits accordingly.
> 
> Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index 659fd0a3ab63..7c48b440cb29 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -1687,12 +1687,16 @@ static u32 rk3588_get_mipi_port_mux(int vp_id)
>   		return 0;
>   }
>   
> -static u32 rk3588_get_hdmi_pol(u32 flags)
> +/*
> + * The HDMI sync polarity bits in GRF_VO1_CON0 are set for an active low
> + * (negative) sync.
> + */
> +static u32 rk3588_get_hdmi_pol(u32 polflags)
>   {
>   	u32 val;
>   
> -	val = (flags & DRM_MODE_FLAG_NHSYNC) ? BIT(HSYNC_POSITIVE) : 0;
> -	val |= (flags & DRM_MODE_FLAG_NVSYNC) ? BIT(VSYNC_POSITIVE) : 0;
> +	val = (polflags & BIT(HSYNC_POSITIVE)) ? 0 : BIT(HSYNC_POSITIVE);
> +	val |= (polflags & BIT(VSYNC_POSITIVE)) ? 0 : BIT(VSYNC_POSITIVE);
>   
>   	return val;
>   }
> 

With the commit msg modification:

Reviewed-by: Damon Ding <damon.ding@rock-chips.com>

Best regards,
Damon

