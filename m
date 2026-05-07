Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F93FCD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 08:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD95D10F00F;
	Thu,  7 May 2026 08:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QGxjPHJX";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7E1E610EFBB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 08:05:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59BC32A9A;
 Thu,  7 May 2026 01:05:53 -0700 (PDT)
Received: from [10.57.67.110] (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B59583F7B4;
 Thu,  7 May 2026 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778141158; bh=RBP31O4YJ9Rv34PC6sxGbZVnmQ2UltlZv4Jp6qQyrOI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QGxjPHJXEzWjlCt8db04ZywdJQVyGYOKeyjCCEl1ius59mFoP/LeERg9VhX/Lvp2x
 vTH4Y74bBx+jlJyeOpyGxJYLzIylER1V1tkjrUvheVF0V2sgoQJJJY/LrHvmRMuCfB
 41CztrcBPJhVoMgvO/z44P/I1LSGM0aLmZ7LiIjE=
Message-ID: <25be33e3-4c45-444e-b753-40196aa54923@arm.com>
Date: Thu, 7 May 2026 09:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix missing declaration for
 panthor_transparent_hugepage
To: gyeyoung <gye976@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260503144234.2150138-1-gye976@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260503144234.2150138-1-gye976@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 03/05/2026 15:42, gyeyoung wrote:
> sparse reports:
> 	drivers/gpu/drm/panthor/panthor_drv.c:1805:6: warning: symbol 'panthor_transparent_hugepage' was not declared. Should it be static?
> 
> Make it clean.
> 
> Signed-off-by: gyeyoung <gye976@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks, I'll push this to drm-misc-next.

Steve

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 1 +
>  drivers/gpu/drm/panthor/panthor_drv.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 66996c9147c2..e8dc4096c1d2 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -31,6 +31,7 @@
>  
>  #include "panthor_devfreq.h"
>  #include "panthor_device.h"
> +#include "panthor_drv.h"
>  #include "panthor_fw.h"
>  #include "panthor_gem.h"
>  #include "panthor_gpu.h"
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.h b/drivers/gpu/drm/panthor/panthor_drv.h
> index 1bc7ddbad23e..b81f21ed5398 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.h
> +++ b/drivers/gpu/drm/panthor/panthor_drv.h
> @@ -4,6 +4,8 @@
>  #ifndef __PANTHOR_DRV_H__
>  #define __PANTHOR_DRV_H__
>  
> +#include <linux/types.h>
> +
>  extern bool panthor_transparent_hugepage;
>  
>  #endif

