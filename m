Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE5FF9D0CE
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 03:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EAB910E669;
	Wed, 15 Apr 2026 03:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="TdR0M9zB";
	dkim-atps=neutral
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC36810E669
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 03:19:30 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=l+fJwhZnDaRqjAPGBBygKMIeCQd+QtirtJFtlB4DpJI=;
 b=TdR0M9zBA2Q6D9ExGSEop+PpOhnkfBNnZhBCJ7nwZw4UstMfBnN9XKlt9MVuO1YcMekrunED7
 oecFOZ8yotzdf3V0b41haOpjYYY7CE3BzFAwB1Qe0IBz3Du1O+usYNT2UVilH6DX1xL6mOBgIkB
 odyiH88IEhf3nnTUQxEq8cY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fwR6g4D1lzpStx;
 Wed, 15 Apr 2026 11:13:15 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id A07D820104;
 Wed, 15 Apr 2026 11:19:27 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 11:19:27 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 11:19:26 +0800
Message-ID: <0668b6ec-b844-4fef-804c-91e488b39516@huawei.com>
Date: Wed, 15 Apr 2026 11:19:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/hibmc: Fix list of formats on the primary plane
To: Thomas Zimmermann <tzimmermann@suse.de>, <xinliang.liu@linaro.org>,
 <tiantao6@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
 <sumit.semwal@linaro.org>, <yongqin.liu@linaro.org>, <jstultz@google.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Rongrong Zou <zourongrong@gmail.com>,
 Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Baihan Li <libaihan@huawei.com>, <stable@vger.kernel.org>,
 <shiyongbang@huawei.com>
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-3-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260413085037.17491-3-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

> Remove all formats from the primary plane that are unsupported for
> various reasons.
> 
> * Formats with alpha channel: planes should not announce alpha channels
> unless they support transparency. There's no transparency support in
> the primary plane's implementation.
> 
> * Formats with BGR order. The common format is in RGB channel order.
> There's no BGR support in the primary plane's implementation.
> 
> * RGB888: atomic_update programs the format from cpp[0] * 8 / 16. For
> RGB888's cpp value of 3 this returns 1.5; rounded to 1. Programming
> the value of 1 to HIBMC_CRT_DISP_CTL_FORMAT sets up RGB565. Hence, the
> output is distorted. This can be tested by booting with video=1024x768-24.
> 

I tested this method and was able to reproduce the issue. Thank you for
pointing it out.


> Removing all unsupported formats leaves XRGB8888 and RGB565. Both of
> which are supported and work correctly.
> 

You're right, I checked the DataSheet and confirmed that it only
supports RGB565 and XRGB8888.

Also, I looked at the commit history, and this format was already
present in the first version of the hibmc driver. This is a historic
issue, and it's a bit difficult to determine why it was implemented this
way.


> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Yongbang Shi <shiyongbang@huawei.com>
> Cc: Baihan Li <libaihan@huawei.com>
> Cc: <stable@vger.kernel.org> # v4.10+
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 8fa2a95bcdd1..c4f9ebd9250d 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -118,10 +118,8 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>  }
>  
>  static const u32 channel_formats1[] = {
> -	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
> -	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_ABGR8888
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_RGB565,
>  };
>  
>  static const struct drm_plane_funcs hibmc_plane_funcs = {

Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>

