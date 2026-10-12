Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD31CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC6510E1A0;
	Mon, 12 Oct 2026 11:29:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B24EB10E1A0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:29:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9986E1655;
 Mon, 12 Oct 2026 04:29:17 -0700 (PDT)
Received: from [10.57.78.107] (unknown [10.57.78.107])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA3E53F882;
 Mon, 12 Oct 2026 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791804560; bh=8gHMNFXU5ZfAf5WRCsgcrgApTYYHBogVGayJxjoixHw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gCqP3YCVW+pjWZ3XD5u3ZEeujHuaxP98nmSy8SVxX7jCXFc6jUSx4szgvegxmSfxC
 tyzHLxQt8pm2bIxIOF9Qi8xQerR11Hw1SS4rmwGerGlTwwoobhtzuzS0dXOTyMB001
 8jIzPArlZR0sB1VYvBgmeCRU+IokxRiWHPYzwQ4w=
Message-ID: <100ff535-2361-4717-b302-b4a662f19fa3@arm.com>
Date: Mon, 12 Oct 2026 12:29:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/15] drm/panfrost: Warn of RPM get failure at device
 remove time
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-9-cb743b3b973b@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261009-claude-fixes-v14-9-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 09/10/2026 13:33, Adrián Larumbe wrote:
> Rather than just failing silently, let's warn the user of device removal
> not being able to take a PM reference, because it should be seen as fatal.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index a6deabb39fd2..687230225743 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -9,6 +9,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_print.h>
>  
>  #include "panfrost_device.h"
>  #include "panfrost_devfreq.h"
> @@ -385,7 +386,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> -	pm_runtime_get_sync(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
>  
>  	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> 

