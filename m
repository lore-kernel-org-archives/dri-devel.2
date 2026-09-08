Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEC6C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF2E10E101;
	Tue,  8 Sep 2026 13:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="iC4e28iV";
	dkim-atps=neutral
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE6910E101
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:23:24 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=hZbR2xlJDiY7gkV7x2WwVHhdejJ2GuNou35l9pXKZVw=;
 b=iC4e28iVW6i8dvoGUkpyykY5tUSF9v+8C0Jp75NbBpuks7inV5aobg+JcVozvosg8mWKRuhL+
 /FnLJWSb64BB28WzPX8GEvYLY5Bk2YX5QdDGL4iUTQlKm67lN5RHgxmIsiX+UliVWc03f0EipmV
 WMsfgc8q6pOzHCQ4SnRR52I=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hfPTz36Cmz1T4Fq;
 Tue,  8 Sep 2026 21:11:51 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id BF6DC4058E;
 Tue,  8 Sep 2026 21:23:21 +0800 (CST)
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 8 Sep 2026 21:23:21 +0800
Message-ID: <2a5a6bc2-d94b-4102-9c65-cf15dbb20eae@huawei.com>
Date: Tue, 8 Sep 2026 21:23:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/hibmc: Set up vblank event to be send on the next
 vblank
To: Thomas Zimmermann <tzimmermann@suse.de>, "kongxinwei (A)"
 <kong.kongxinwei@hisilicon.com>, "tiantao (H)" <tiantao6@hisilicon.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Chenjianmin <chenjianmin@huawei.com>, <shuliubin@huawei.com>,
 <shiyongbang@huawei.com>
References: <20260827082915.61176-1-tzimmermann@suse.de>
 <20260827082915.61176-3-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260827082915.61176-3-tzimmermann@suse.de>
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

> Do not send the vblank event when the page flip completes, but when
> the vblank interrupt fires. Sending the vblank event at the wrong time
> can break synchronization of the display update with the vblank period.
> 
> Use the vblank helper drm_crtc_vblank_atomic_flush(), which sets up
> the vblank event accordingly. In case of an error, it still sends out
> the vblank event immediately; thus not starving consumers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index b4ab53db1c08..72ce696e6d11 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -20,6 +20,7 @@
>   #include <drm/drm_gem_atomic_helper.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_vblank.h>
> +#include <drm/drm_vblank_helper.h>
>   
>   #include "hibmc_drm_drv.h"
>   #include "hibmc_drm_regs.h"
> @@ -420,19 +421,6 @@ static void hibmc_crtc_atomic_begin(struct drm_crtc *crtc,
>   	/* We can add more initialization as needed. */
>   }
>   
> -static void hibmc_crtc_atomic_flush(struct drm_crtc *crtc,
> -				    struct drm_atomic_commit *state)
> -
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&crtc->dev->event_lock, flags);
> -	if (crtc->state->event)
> -		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> -	crtc->state->event = NULL;
> -	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> -}
> -
>   static int hibmc_crtc_enable_vblank(struct drm_crtc *crtc)
>   {
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
> @@ -502,7 +490,7 @@ static const struct drm_crtc_funcs hibmc_crtc_funcs = {
>   static const struct drm_crtc_helper_funcs hibmc_crtc_helper_funcs = {
>   	.mode_set_nofb	= hibmc_crtc_mode_set_nofb,
>   	.atomic_begin	= hibmc_crtc_atomic_begin,
> -	.atomic_flush	= hibmc_crtc_atomic_flush,
> +	.atomic_flush	= drm_crtc_vblank_atomic_flush,
>   	.atomic_enable	= hibmc_crtc_atomic_enable,
>   	.atomic_disable	= hibmc_crtc_atomic_disable,
>   	.mode_valid = hibmc_crtc_mode_valid,

Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>
