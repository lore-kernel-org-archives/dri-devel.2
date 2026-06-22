Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EC2CD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 01:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4173210E41E;
	Mon, 22 Jun 2026 01:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="zkEI6co+";
	dkim-atps=neutral
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA5710E41E
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 01:56:09 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=5hfMtSDzgGXtKulm+dm7oYe+aQzpL/O7amMQwhP+lp4=;
 b=zkEI6co+aWUxfVadZdvZY/vBU9jhv9yYax6YU5jKbnY99CKCByu8zptvH1JtDJTKwkg/2kDaT
 R23sIjMe3TLrYkfybhgelaZ8XZ63LkbBhUq//O94Kgi3nwofYzQcoHlJup65Aoc8NK+pUw/IQP0
 uxvzF1SXMhmcjmijsTZ4acM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gk9zg6TQkzmVXR;
 Mon, 22 Jun 2026 09:46:55 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 06C4040562;
 Mon, 22 Jun 2026 09:56:00 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 09:55:59 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 09:55:59 +0800
Message-ID: <515104e6-979d-456e-8635-3bd5eabf29bc@huawei.com>
Date: Mon, 22 Jun 2026 09:55:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/hibmc: Store fb in variable in atomic_update
To: Thomas Zimmermann <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
 <kong.kongxinwei@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <sashiko-reviews@lists.linux.dev>,
 <shiyongbang@huawei.com>
References: <20260618123142.92298-1-tzimmermann@suse.de>
 <20260618123142.92298-4-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260618123142.92298-4-tzimmermann@suse.de>
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

> The atomic-update helper frequently refers to the framebuffer in
> new_state->fb. Store it in a local variable to make the code more
> readable. No functional changes.
> 
> Suggested-by: Yongbang Shi <shiyongbang@huawei.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 2e6e189bec1a..19cb16a7daf9 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -100,18 +100,18 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
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
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(plane->dev);
>  	struct drm_gem_vram_object *gbo;
>  
> -	if (!new_state->fb)
> +	if (!fb)
>  		return;
>  
> -	gbo = drm_gem_vram_of_gem(new_state->fb->obj[0]);
> +	gbo = drm_gem_vram_of_gem(fb->obj[0]);
>  
>  	gpu_addr = drm_gem_vram_offset(gbo);
>  	if (WARN_ON_ONCE(gpu_addr < 0))
> @@ -119,9 +119,9 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>  
>  	writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
>  
> -	reg = new_state->fb->width * (new_state->fb->format->cpp[0]);
> +	reg = fb->width * fb->format->cpp[0];
>  
> -	line_l = new_state->fb->pitches[0];
> +	line_l = fb->pitches[0];
>  	writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
>  	       HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_OFFS, line_l),
>  	       priv->mmio + HIBMC_CRT_FB_WIDTH);
> @@ -129,8 +129,7 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>  	/* SET PIXEL FORMAT */
>  	reg = readl(priv->mmio + HIBMC_CRT_DISP_CTL);
>  	reg &= ~HIBMC_CRT_DISP_CTL_FORMAT_MASK;
> -	reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT,
> -			   new_state->fb->format->cpp[0] * 8 / 16);
> +	reg |= HIBMC_FIELD(HIBMC_CRT_DISP_CTL_FORMAT, fb->format->cpp[0] * 8 / 16);
>  	writel(reg, priv->mmio + HIBMC_CRT_DISP_CTL);
>  }
>  

Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>

Thanks,
Yongbang.


