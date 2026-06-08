Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E962CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3BD10ED6B;
	Mon,  8 Jun 2026 06:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="Fm0sFmrR";
	dkim-atps=neutral
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2654610ED6B
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:25:54 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jebHBksVMm4fNWHhbV0t3ziryOzyCEXnBChRodOBHBg=;
 b=Fm0sFmrRBPYYdneneLZNXvP3UsRyHszq1rXeh46WyDIGYExpyxWnmPTbWMhLLt9EQ6jntd6C+
 l6AeCDTHSRiBvjoyBwG4dw8WX4vMQrw6ACn+LT8nFXMV/2q7E30bjtOA52aIM+9Q+ZDxYhGeBX1
 thzBp+I8VK3mhExNE2DXMcs=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gYhfs6mNSzmVWd;
 Mon,  8 Jun 2026 14:17:57 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 200CD40574;
 Mon,  8 Jun 2026 14:25:52 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 14:25:51 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 14:25:50 +0800
Message-ID: <e1ada2a4-ab28-4637-bb72-b8ca510292ee@huawei.com>
Date: Mon, 8 Jun 2026 14:25:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/hibmc: Do not use cpp from struct
 drm_format_info
To: Thomas Zimmermann <tzimmermann@suse.de>, <xinliang.liu@linaro.org>,
 <tiantao6@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
 <sumit.semwal@linaro.org>, <yongqin.liu@linaro.org>, <jstultz@google.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <shiyongbang@huawei.com>, Chenjianmin
 <chenjianmin@huawei.com>, "Liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, "fengsheng (A)" <fengsheng5@huawei.com>
References: <20260601114756.51953-1-tzimmermann@suse.de>
 <20260601114756.51953-4-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260601114756.51953-4-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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

Hi, Thomas.

> Replace uses of struct drm_format_info's cpp with appropriate interfaces.
> The cpp field contains the characters per pixel. It is deprecated and
> should be avoided.
> 
> Calculate the line width in bytes with drm_format_info_min_pitch(). This
> is the preferred way of getting pixel and line sizes.
> 
> Program HIB_CRT_DISP_CTL_FORMAT from the format's 4CC code instead of
> calculating the field's value from the cpp.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 2e6e189bec1a..79c33c778d2c 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -100,8 +100,8 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
>  static void hibmc_plane_atomic_update(struct drm_plane *plane,
>  				      struct drm_atomic_commit *state)
>  {
> -	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
> -									   plane);
> +	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_framebuffer *fb = new_state->fb;
>  	u32 reg;
>  	s64 gpu_addr = 0;
>  	u32 line_l;
> @@ -119,7 +119,7 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>  
>  	writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
>  
> -	reg = new_state->fb->width * (new_state->fb->format->cpp[0]);
> +	reg = drm_format_info_min_pitch(fb->format, 0, fb->width);
>  
>  	line_l = new_state->fb->pitches[0];

Since the variable `fb` was defined earlier, it can be used directly here without needing `new_state->fb`.

This function uses `new_state->fb` in two other places:
https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c?ref_type=heads#L129
https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c?ref_type=heads#L132

Thanks,
Yongbang.

>  	writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
> @@ -129,8 +129,14 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>  	/* SET PIXEL FORMAT */
>  	reg = readl(priv->mmio + HIBMC_CRT_DISP_CTL);
>  	reg &= ~HIBMC_CRT_DISP_CTL_FORMAT_MASK;
> -	reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT,
> -			   new_state->fb->format->cpp[0] * 8 / 16);
> +	switch (fb->format->format) {
> +	case DRM_FORMAT_XRGB8888:
> +		reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT, 2);
> +		break;
> +	case DRM_FORMAT_RGB565:
> +		reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT, 1);
> +		break;
> +	}
>  	writel(reg, priv->mmio + HIBMC_CRT_DISP_CTL);
>  }
>  

