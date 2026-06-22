Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E2CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C48810E63F;
	Mon, 22 Jun 2026 11:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="lJZUx1H7";
	dkim-atps=neutral
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9FD10E63F
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:42:06 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=guLH7PWsPN4QRiR2otfLo4i4a2OD+mVsl8hoiTPpR7w=;
 b=lJZUx1H7Or0exrO6C0C4NRLAOtY8A8DY3H2pDw3s4wV41+fyCIqEFCaH7PwfkVnaLG/wNGYPP
 giKERb+yRAULTFQRtyhMc3tdFteiuv2rmQZ806qdo7V28c8c0Es5I2pn9Hb8rNPrVY7KNLKr6DX
 OpQmKZtprmml/LTiYDZuryg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gkR12148KzKm51;
 Mon, 22 Jun 2026 19:33:58 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 48B3D40539;
 Mon, 22 Jun 2026 19:42:02 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 19:42:02 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 19:42:01 +0800
Message-ID: <0cada37c-bd85-49f7-bec3-8850dd57e688@huawei.com>
Date: Mon, 22 Jun 2026 19:42:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/hibmc: Verify the framebuffer pitch to be a
 multiple of 128
To: Thomas Zimmermann <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
 <kong.kongxinwei@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <sashiko-reviews@lists.linux.dev>,
 <shiyongbang@huawei.com>, "liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>, "fengsheng
 (A)" <fengsheng5@huawei.com>
References: <20260618123142.92298-1-tzimmermann@suse.de>
 <20260618123142.92298-6-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260618123142.92298-6-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

> The hibmc hardware requires the framebuffer pitch to be aligned to
> a multiple of 128. Dumb-buffer creation already guarantees this for
> the created GEM buffer object. Also verify this contraint during
> framebuffer creation.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 99b36de1fe13..55d175028c46 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -14,6 +14,7 @@
>  #include <linux/aperture.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/sizes.h>
>  
>  #include <drm/clients/drm_client_setup.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -106,11 +107,26 @@ static const struct dev_pm_ops hibmc_pm_ops = {
>  				hibmc_pm_resume)
>  };
>  
> +static struct drm_framebuffer *hibmc_mode_config_fb_create(struct drm_device *dev,
> +							   struct drm_file *file_priv,
> +							   const struct drm_format_info *info,
> +							   const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	int i;
> +
> +	for (i = 0; i < info->num_planes; ++i) {
> +		if (mode_cmd->pitches[i] % SZ_128)
> +			return ERR_PTR(-EINVAL);
> +	}
> +
> +	return drm_gem_fb_create(dev, file_priv, info, mode_cmd);
> +}
> +
>  static const struct drm_mode_config_funcs hibmc_mode_funcs = {
>  	.mode_valid = drm_vram_helper_mode_valid,
>  	.atomic_check = drm_atomic_helper_check,
>  	.atomic_commit = drm_atomic_helper_commit,
> -	.fb_create = drm_gem_fb_create,
> +	.fb_create = hibmc_mode_config_fb_create,
>  };
>  
>  static int hibmc_kms_init(struct hibmc_drm_private *priv)


Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>

Thanks,
Yongbang.

