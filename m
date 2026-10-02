Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F592CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A6310F878;
	Fri,  2 Oct 2026 14:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="B/9V81lN";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2274F10F874
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:06:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3946C497;
 Fri,  2 Oct 2026 07:06:36 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12D123F86F;
 Fri,  2 Oct 2026 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790949999; bh=LXcBf5DqUjfpozfw5KUQg7cr3ol8Ac44JaBwa3ukRWc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B/9V81lN3FHKo2ZO2YbSD2+LNlPmrdC5Ri9HLYfzg1m9O9B7TCBy9G2saK+FFE8zQ
 iz1Gy0HhbM79a4fiaeB/ujUOGd/WIucdr1YbqdVCjKLofI5kdV31YioegGC2ySfVT6
 JhNbtCigB4Jw0YPKttaBx0dOYnD1pTAJchW3YG4A=
Message-ID: <be07db72-8cba-4d37-baf4-13ea2d94dd35@arm.com>
Date: Fri, 2 Oct 2026 15:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/15] drm/panfrost: Move lock and modparam
 initialisations into their subsystems
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
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-2-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-2-62beb08de207@collabora.com>
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

On 29/09/2026 04:44, Adrián Larumbe wrote:
> The device init function feels a bit cluttered with things that should be
> done in the specific subsystems where those locks and lists are being
> used. Same goes for module parameters, it's best to limit them to the
> subsystems where they're relevant.
> 
> Then we can also discard panfrost_drv.h since the transparent_huge_page
> doesn't need to be accessed elsewhere. We can also simplify the
> creation of a mount point, because drm_gem_get_huge_mnt() would never
> return NULL if drm_gem_huge_mnt_create() returns 0 when kernel is built
> with support for transparent huge pages.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c       |  7 -------
>  drivers/gpu/drm/panfrost/panfrost_drv.c          | 10 ----------
>  drivers/gpu/drm/panfrost/panfrost_drv.h          |  9 ---------
>  drivers/gpu/drm/panfrost/panfrost_gem.c          | 19 +++++++++++++------
>  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  3 +++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c          |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_job.c          |  1 +
>  drivers/gpu/drm/panfrost/panfrost_mmu.c          |  3 +++
>  8 files changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 05c40d5a20b5..c1a2e93a2b9b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -216,13 +216,6 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  {
>  	int err;
>  
> -	mutex_init(&pfdev->sched_lock);
> -	INIT_LIST_HEAD(&pfdev->as_lru_list);
> -
> -	spin_lock_init(&pfdev->as_lock);
> -
> -	spin_lock_init(&pfdev->cycle_counter.lock);
> -
>  #ifdef CONFIG_DEBUG_FS
>  	mutex_init(&pfdev->debugfs.gems_lock);
>  	INIT_LIST_HEAD(&pfdev->debugfs.gems_list);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 9882a3ede75f..59af79a534fa 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -21,7 +21,6 @@
>  #include <drm/drm_utils.h>
>  
>  #include "panfrost_device.h"
> -#include "panfrost_drv.h"
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
>  #include "panfrost_job.h"
> @@ -955,12 +954,6 @@ static const struct drm_driver panfrost_drm_driver = {
>  #endif
>  };
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -bool panfrost_transparent_hugepage = true;
> -module_param_named(transparent_hugepage, panfrost_transparent_hugepage, bool, 0400);
> -MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with Transparent Hugepage enabled (true = default)");
> -#endif
> -
>  static int panfrost_probe(struct platform_device *pdev)
>  {
>  	struct panfrost_device *pfdev;
> @@ -979,9 +972,6 @@ static int panfrost_probe(struct platform_device *pdev)
>  
>  	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
>  
> -	mutex_init(&pfdev->shrinker_lock);
> -	INIT_LIST_HEAD(&pfdev->shrinker_list);
> -
>  	err = panfrost_device_init(pfdev);
>  	if (err) {
>  		if (err != -EPROBE_DEFER)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.h b/drivers/gpu/drm/panfrost/panfrost_drv.h
> deleted file mode 100644
> index a2277ec61aab..000000000000
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 or MIT */
> -/* Copyright 2025 Amazon.com, Inc. or its affiliates */
> -
> -#ifndef __PANFROST_DRV_H__
> -#define __PANFROST_DRV_H__
> -
> -extern bool panfrost_transparent_hugepage;
> -
> -#endif
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index f39c0f50ed4f..383ac8cd5645 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -11,20 +11,27 @@
>  #include <drm/panfrost_drm.h>
>  #include <drm/drm_print.h>
>  #include "panfrost_device.h"
> -#include "panfrost_drv.h"
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static bool panfrost_transparent_hugepage = true;
> +module_param_named(transparent_hugepage, panfrost_transparent_hugepage, bool, 0400);
> +MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with Transparent Hugepage enabled (true = default)");
> +#else
> +#define panfrost_transparent_hugepage false
> +#endif
> +
>  int panfrost_gem_init(struct panfrost_device *pfdev)
>  {
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && panfrost_transparent_hugepage) {
> +	if (panfrost_transparent_hugepage) {
>  		int err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
>  
> -		if (drm_gem_get_huge_mnt(&pfdev->base))
> +		if (err)
> +			drm_warn(&pfdev->base,
> +				 "Can't use Transparent Hugepage (%d)\n", err);
> +		else
>  			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> -		else if (err)
> -			drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> -				 err);
>  	}
>  
>  	return panfrost_gem_shrinker_init(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> index fefae87535d6..72cd7a165e6d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> @@ -97,6 +97,9 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>   */
>  int panfrost_gem_shrinker_init(struct panfrost_device *pfdev)
>  {
> +	mutex_init(&pfdev->shrinker_lock);
> +	INIT_LIST_HEAD(&pfdev->shrinker_list);
> +
>  	pfdev->shrinker = shrinker_alloc(0, "drm-panfrost");
>  	if (!pfdev->shrinker)
>  		return -ENOMEM;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 7d555e63e21a..8a15ccce08e9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -516,6 +516,8 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
>  {
>  	int err;
>  
> +	spin_lock_init(&pfdev->cycle_counter.lock);
> +
>  	err = panfrost_gpu_soft_reset(pfdev);
>  	if (err)
>  		return err;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index d59b4863b8ad..476c936b54e6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -874,6 +874,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
>  
>  	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
>  	spin_lock_init(&js->job_lock);
> +	mutex_init(&pfdev->sched_lock);
>  
>  	js->irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "job");
>  	if (js->irq < 0)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 4a3162c3b659..5c393ed6e310 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -955,6 +955,9 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  {
>  	int err;
>  
> +	INIT_LIST_HEAD(&pfdev->as_lru_list);
> +	spin_lock_init(&pfdev->as_lock);
> +
>  	pfdev->mmu_irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "mmu");
>  	if (pfdev->mmu_irq < 0)
>  		return pfdev->mmu_irq;
> 

