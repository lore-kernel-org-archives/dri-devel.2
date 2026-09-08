Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE17C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0BEE10EBFC;
	Tue,  8 Sep 2026 13:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="4618Aq6b";
	dkim-atps=neutral
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDBE10E105
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:22:31 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Eb1cQcj6MvtpZLYHM3GD7NJ2bTpaFqK2CpZ1e6jF/C4=;
 b=4618Aq6bgUiMe1bEWUAeC1NsWsopp1xDH+PMtkVKSBYq317bMx3nv+TJM2/bW8BXhUHRcC9TE
 PwlILVMixLBcBXuiDq/w7SmLBjA5CULhNiy582BnCzLtphmcPQL3kq/AAZWFFDIFgeevpp/ASiT
 DsmvoBOMtXXU5r48md4CLLo=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hfPTd3TLXzmV8f;
 Tue,  8 Sep 2026 21:11:33 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 76CD340586;
 Tue,  8 Sep 2026 21:22:27 +0800 (CST)
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 8 Sep 2026 21:22:26 +0800
Message-ID: <d6f278ab-c56d-4a88-b89a-b751013edd55@huawei.com>
Date: Tue, 8 Sep 2026 21:22:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/hibmc: Return IRQ_NONE for unhandled interrupts
To: Thomas Zimmermann <tzimmermann@suse.de>, "kongxinwei (A)"
 <kong.kongxinwei@hisilicon.com>, "tiantao (H)" <tiantao6@hisilicon.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Chenjianmin <chenjianmin@huawei.com>, <shuliubin@huawei.com>
References: <20260827082915.61176-1-tzimmermann@suse.de>
 <20260827082915.61176-2-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260827082915.61176-2-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200005.china.huawei.com (7.202.194.71)
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

> Let the kernel know if hibmc did not handle an interrupt. Allows
> the kernel to detect spurious interrupts and maintain diagnostics.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 4d85c89f3f88..602930964e93 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -49,9 +49,10 @@ static irqreturn_t hibmc_interrupt(int irq, void *arg)
>   		writel(HIBMC_RAW_INTERRUPT_VBLANK(1),
>   		       priv->mmio + HIBMC_RAW_INTERRUPT);
>   		drm_handle_vblank(dev, 0);
> +		return IRQ_HANDLED;
>   	}
>   
> -	return IRQ_HANDLED;
> +	return IRQ_NONE;
>   }
>   
>   static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
> @@ -67,7 +68,7 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
>   		return IRQ_WAKE_THREAD;
>   	}
>   
> -	return IRQ_HANDLED;
> +	return IRQ_NONE;
>   }
>   
>   static int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,

Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>
