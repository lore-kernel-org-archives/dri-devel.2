Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856D6CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9BA10E29C;
	Fri,  2 Oct 2026 13:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qmqyd6fu";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 81C3010E29C
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:58:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 650E5497;
 Fri,  2 Oct 2026 06:58:48 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A8663F85F;
 Fri,  2 Oct 2026 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790949531; bh=mqt8t+ec1Xk7/9q96O+Wx3CGmiUS78Zd8OqN57CIcVY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qmqyd6fu4tpbhG6x0IvOzlm5dpV6EJMsEr/qtxPtfXBYXvSHsJ+z0c6exjgfLwv/Y
 CH6zTu8rkQe1wv7pT35mQvK3yQafqL4DZflZw3We9szl5JTHTEO5QXABFcobtNave7
 aL9ZBN41fZKusu29peXQPcs10W+jLJFjj9izgQHU=
Message-ID: <95d3da59-4f44-4d4e-a8b7-9a9a9f88d046@arm.com>
Date: Fri, 2 Oct 2026 14:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/15] drm/panfrost: Move shrinker initialization and
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
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-1-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-1-62beb08de207@collabora.com>
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
> Since the moment we call drm_dev_register() the device should be in a
> position to accept jobs, so it's best if the shrinker is already
> initialized by then.
> 
> On top of that, make shrinker functions take an panfrost_device pointer
> like other functions in the same sequence and rename them accordingly.
> 
> Essentially mimic the init/fini behaviour in Panthor.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
>  drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
>  drivers/gpu/drm/panfrost/panfrost_gem.c          | 26 ++++++++++++++----------
>  drivers/gpu/drm/panfrost/panfrost_gem.h          |  7 ++++---
>  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
>  5 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 485349faf251..05c40d5a20b5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -280,9 +280,14 @@ int panfrost_device_init(struct panfrost_device *pfdev)
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
> @@ -304,6 +309,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> +	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
>  	panfrost_mmu_fini(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 96a66d673ba6..9882a3ede75f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1003,14 +1003,9 @@ static int panfrost_probe(struct platform_device *pdev)
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
> @@ -1024,7 +1019,6 @@ static void panfrost_remove(struct platform_device *pdev)
>  	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
>  
>  	drm_dev_unregister(&pfdev->base);
> -	panfrost_gem_shrinker_cleanup(&pfdev->base);
>  
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 3a7fce428898..f39c0f50ed4f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -15,20 +15,24 @@
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
>  
> -void panfrost_gem_init(struct panfrost_device *pfdev)
> +int panfrost_gem_init(struct panfrost_device *pfdev)
>  {
> -	int err;
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && panfrost_transparent_hugepage) {
> +		int err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> +
> +		if (drm_gem_get_huge_mnt(&pfdev->base))
> +			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> +		else if (err)
> +			drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> +				 err);
> +	}
>  
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -	    !panfrost_transparent_hugepage)
> -		return;
> +	return panfrost_gem_shrinker_init(pfdev);
> +}
>  
> -	err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> -	if (drm_gem_get_huge_mnt(&pfdev->base))
> -		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> -	else if (err)
> -		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> -			 err);
> +void panfrost_gem_fini(struct panfrost_device *pfdev)
> +{
> +	panfrost_gem_shrinker_fini(pfdev);
>  }
>  
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
> index 79d4377019e9..5c823cdbd980 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> @@ -129,7 +129,8 @@ drm_mm_node_to_panfrost_mapping(struct drm_mm_node *node)
>  	return container_of(node, struct panfrost_gem_mapping, mmnode);
>  }
>  
> -void panfrost_gem_init(struct panfrost_device *pfdev);
> +int panfrost_gem_init(struct panfrost_device *pfdev);
> +void panfrost_gem_fini(struct panfrost_device *pfdev);
>  
>  struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t size);
>  
> @@ -154,8 +155,8 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *bo,
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

