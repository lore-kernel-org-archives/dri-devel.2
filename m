Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0098C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4484F10EE16;
	Thu, 30 Jul 2026 10:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="m0mnkRXZ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 16CE410EE16
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:40:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 776EE1688;
 Thu, 30 Jul 2026 03:40:06 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8E93F86F;
 Thu, 30 Jul 2026 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785408010; bh=C5aLqKZ8R7tzlwxM3IDM/wMVjWo8Dccx7XBruNOOv1w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m0mnkRXZUMV1wwdut6p1/oV0UFRFZXn+nMxVZzisLUqMQJvKG8ueleqqUIWWle/XV
 EyCVS7ZMr/mDCYaxI6+Z2nM06yB5sOmF5Gdf/UQW/6Bv0zXKLcvoxJvUzbVnGyGJBN
 6bx/oQWaMPnuBaiYHubn6hihooUqaWzV147E6hpI=
Message-ID: <faac1559-e1d1-4756-9bbd-01f760628fb9@arm.com>
Date: Thu, 30 Jul 2026 11:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] drm/panfrost: Move shrinker initialization and
 unplug one level down
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-4-01968f2ec77a@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729-claude-fixes-v4-4-01968f2ec77a@collabora.com>
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

On 29/07/2026 03:54, Adrián Larumbe wrote:
> Since the moment we call drm_dev_register() the device should be in a
> position to accept jobs, so it's best if the shrinker is already
> initialized by then.
> 
> On top of that, make shrinker functions take an panfrost_device pointer
> like other functions in the same sequence and rename them accordingly.
> 
> Essentially mimic the init/fini behaviour in Panthor.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
>  drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
>  drivers/gpu/drm/panfrost/panfrost_gem.c          | 19 ++++++++++---------
>  drivers/gpu/drm/panfrost/panfrost_gem.h          |  6 +++---
>  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
>  5 files changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index d8421fd6a662..03905495aee2 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -281,9 +281,14 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  	if (err)
>  		goto out_job;
>  
> -	panfrost_gem_init(pfdev);
> +	err = panfrost_gem_init(pfdev);
> +	if (err)
> +		goto out_perfcnt;
>  
>  	return 0;
> +
> +out_perfcnt:
> +	panfrost_perfcnt_fini(pfdev);
>  out_job:
>  	panfrost_jm_fini(pfdev);
>  out_mmu:
> @@ -305,6 +310,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> +	panfrost_gem_shrinker_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
>  	panfrost_mmu_fini(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 2e931fa90da0..331a3bd5b98c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1002,14 +1002,9 @@ static int panfrost_probe(struct platform_device *pdev)
>  	if (err < 0)
>  		goto err_out1;
>  
> -	err = panfrost_gem_shrinker_init(&pfdev->base);
> -	if (err)
> -		goto err_out2;
>  
>  	return 0;
>  
> -err_out2:
> -	drm_dev_unregister(&pfdev->base);
>  err_out1:
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> @@ -1023,7 +1018,6 @@ static void panfrost_remove(struct platform_device *pdev)
>  	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
>  
>  	drm_dev_unregister(&pfdev->base);
> -	panfrost_gem_shrinker_cleanup(&pfdev->base);
>  
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 3a7fce428898..aa3a604b3439 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -15,20 +15,21 @@
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
>  
> -void panfrost_gem_init(struct panfrost_device *pfdev)
> +int panfrost_gem_init(struct panfrost_device *pfdev)
>  {
>  	int err;
>  
>  	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -	    !panfrost_transparent_hugepage)
> -		return;
> +	    panfrost_transparent_hugepage) {

Note you haven't quite inverted the condition here, but I don't think
the new condition is wrong - we skip the otherwise no-op helpers. The
old condition seems a bit backward. Indeed I'm not really sure why we
bother with the IS_ENABLED() check at all. But the new code looks fine.

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> +		err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> +		if (drm_gem_get_huge_mnt(&pfdev->base))
> +			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> +		else if (err)
> +			drm_warn(&pfdev->base,
> +				 "Can't use Transparent Hugepage (%d)\n", err);
> +	}
>  
> -	err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> -	if (drm_gem_get_huge_mnt(&pfdev->base))
> -		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> -	else if (err)
> -		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> -			 err);
> +	return panfrost_gem_shrinker_init(pfdev);
>  }
>  
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
> index 79d4377019e9..d6e55c2e4d86 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> @@ -129,7 +129,7 @@ drm_mm_node_to_panfrost_mapping(struct drm_mm_node *node)
>  	return container_of(node, struct panfrost_gem_mapping, mmnode);
>  }
>  
> -void panfrost_gem_init(struct panfrost_device *pfdev);
> +int panfrost_gem_init(struct panfrost_device *pfdev);
>  
>  struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t size);
>  
> @@ -154,8 +154,8 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *bo,
>  void panfrost_gem_mapping_put(struct panfrost_gem_mapping *mapping);
>  void panfrost_gem_teardown_mappings_locked(struct panfrost_gem_object *bo);
>  
> -int panfrost_gem_shrinker_init(struct drm_device *dev);
> -void panfrost_gem_shrinker_cleanup(struct drm_device *dev);
> +int panfrost_gem_shrinker_init(struct panfrost_device *pfdev);
> +void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev);
>  
>  void panfrost_gem_set_label(struct drm_gem_object *obj, const char *label);
>  int panfrost_gem_sync(struct drm_gem_object *obj, u32 type,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> index 2fe967a90bcb..fefae87535d6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> @@ -95,10 +95,8 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>   *
>   * This function registers and sets up the panfrost shrinker.
>   */
> -int panfrost_gem_shrinker_init(struct drm_device *dev)
> +int panfrost_gem_shrinker_init(struct panfrost_device *pfdev)
>  {
> -	struct panfrost_device *pfdev = to_panfrost_device(dev);
> -
>  	pfdev->shrinker = shrinker_alloc(0, "drm-panfrost");
>  	if (!pfdev->shrinker)
>  		return -ENOMEM;
> @@ -118,10 +116,8 @@ int panfrost_gem_shrinker_init(struct drm_device *dev)
>   *
>   * This function unregisters the panfrost shrinker.
>   */
> -void panfrost_gem_shrinker_cleanup(struct drm_device *dev)
> +void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev)
>  {
> -	struct panfrost_device *pfdev = to_panfrost_device(dev);
> -
>  	if (pfdev->shrinker)
>  		shrinker_free(pfdev->shrinker);
>  }
> 

