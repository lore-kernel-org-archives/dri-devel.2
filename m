Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D0CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A2610E5EE;
	Fri,  2 Oct 2026 14:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ZolcFSF1";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1ED3110E5EE
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:37:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448B2497;
 Fri,  2 Oct 2026 07:37:11 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C4983F86F;
 Fri,  2 Oct 2026 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790951834; bh=3dn54dCsXnCXYpAf3hPzLT2h82Gv0QxovmmmqR8Z4VY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZolcFSF1k/4mgxhd7ju3tNWLJZj/nQ2OI9v9kQjBmnIShSIOihLVCuTpuNbDgys9C
 oh4h2c769yFE6v+NiQpj9HYlZYaI9I+29pgCkZDBcCgBmfohB3LLy+49KpNtreEwhE
 wBgg5x14GqF2ZaIc4wyUFbAlqONHPvIumAwTHDWk=
Message-ID: <6c2953cd-ec0e-4579-ad7a-be189fa1838a@arm.com>
Date: Fri, 2 Oct 2026 15:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/15] drm/panfrost: Move all DRM device
 initialisation into device_init()
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
 <20260929-claude-fixes-v12-8-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-8-62beb08de207@collabora.com>
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
> Ideally the probe() function will do as little as possible, and all device
> initialisation and registration should happen inside the panfrost device
> subsystem, just like it's done in Panthor. This also simplifies resource
> unwinding in the error path.
> 
> Do the same thing for DRM driver remove, as in, sweep most of the action
> into panfrost_device_fini(), just like we did for device probe.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 49 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 52 +-----------------------------
>  2 files changed, 50 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 9f2b1967a398..c6bf3d0663df 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -8,6 +8,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <drm/drm_drv.h>
>  
>  #include "panfrost_device.h"
>  #include "panfrost_devfreq.h"
> @@ -228,8 +229,15 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
>  
>  int panfrost_device_init(struct panfrost_device *pfdev)
>  {
> +	bool device_initialised = false;
>  	int err;
>  
> +	pfdev->comp = of_device_get_match_data(pfdev->base.dev);
> +	if (!pfdev->comp)
> +		return -ENODEV;
> +
> +	pfdev->coherent = device_get_dma_attr(pfdev->base.dev) == DEV_DMA_COHERENT;
> +
>  #ifdef CONFIG_DEBUG_FS
>  	mutex_init(&pfdev->debugfs.gems_lock);
>  	INIT_LIST_HEAD(&pfdev->debugfs.gems_list);
> @@ -291,8 +299,35 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  	if (err)
>  		goto out_perfcnt;
>  
> +	device_initialised = true;
> +
> +	/* The reason we must manually set the PM status and usage counter is
> +	 * we have just powered the device up but did not go through the PM
> +	 * runtime resume callback, so we need to update these ourselves.
> +	 */
> +	pm_runtime_get_noresume(pfdev->base.dev);
> +	pm_runtime_set_active(pfdev->base.dev);
> +	pm_runtime_mark_last_busy(pfdev->base.dev);
> +	pm_runtime_enable(pfdev->base.dev);
> +	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> +	pm_runtime_use_autosuspend(pfdev->base.dev);
> +
> +	/*
> +	 * Register the DRM device with the core and the connectors with
> +	 * sysfs
> +	 */
> +	err = drm_dev_register(&pfdev->base, 0);
> +	if (err < 0)
> +		goto err_disable_rpm;
> +
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> +
>  	return 0;
>  
> +err_disable_rpm:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_disable(pfdev->base.dev);
> +	panfrost_gem_fini(pfdev);
>  out_perfcnt:
>  	panfrost_perfcnt_fini(pfdev);
>  out_job:
> @@ -311,11 +346,22 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  	panfrost_reset_fini(pfdev);
>  out_pm_domain:
>  	panfrost_pm_domain_fini(pfdev);
> +
> +	if (device_initialised) {
> +		pm_runtime_set_suspended(pfdev->base.dev);
> +		pm_runtime_put_noidle(pfdev->base.dev);
> +	}
> +
>  	return err;
>  }
>  
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> +	pm_runtime_get_sync(pfdev->base.dev);
> +
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_disable(pfdev->base.dev);
> +
>  	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
> @@ -326,6 +372,9 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
>  	panfrost_clk_fini(pfdev);
>  	panfrost_reset_fini(pfdev);
>  	panfrost_pm_domain_fini(pfdev);
> +
> +	pm_runtime_set_suspended(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  }
>  
>  #define PANFROST_EXCEPTION(id) \
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 907d4a14a0b5..f77780c72a1a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -830,7 +830,6 @@ static const struct drm_driver panfrost_drm_driver = {
>  static int panfrost_probe(struct platform_device *pdev)
>  {
>  	struct panfrost_device *pfdev;
> -	int err;
>  
>  	pfdev = devm_drm_dev_alloc(&pdev->dev, &panfrost_drm_driver,
>  				   struct panfrost_device, base);
> @@ -839,50 +838,7 @@ static int panfrost_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pfdev);
>  
> -	pfdev->comp = of_device_get_match_data(&pdev->dev);
> -	if (!pfdev->comp)
> -		return -ENODEV;
> -
> -	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
> -
> -	err = panfrost_device_init(pfdev);
> -	if (err) {
> -		if (err != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Fatal error during GPU init\n");
> -		goto err_out0;
> -	}
> -
> -	/* The reason we must manually set the PM status and usage counter is
> -	 * we have just powered the device up but did not go through the PM
> -	 * runtime resume callback, so we need to update these ourselves.
> -	 */
> -	pm_runtime_get_noresume(pfdev->base.dev);
> -	pm_runtime_set_active(pfdev->base.dev);
> -	pm_runtime_mark_last_busy(pfdev->base.dev);
> -	pm_runtime_enable(pfdev->base.dev);
> -	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> -	pm_runtime_use_autosuspend(pfdev->base.dev);
> -
> -	/*
> -	 * Register the DRM device with the core and the connectors with
> -	 * sysfs
> -	 */
> -	err = drm_dev_register(&pfdev->base, 0);
> -	if (err < 0)
> -		goto err_out1;
> -
> -	pm_runtime_put_autosuspend(pfdev->base.dev);
> -
> -	return 0;
> -
> -err_out1:
> -	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
> -	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
> -	pm_runtime_put_noidle(pfdev->base.dev);
> -err_out0:
> -	return err;
> +	return panfrost_device_init(pfdev);
>  }
>  
>  static void panfrost_remove(struct platform_device *pdev)
> @@ -891,13 +847,7 @@ static void panfrost_remove(struct platform_device *pdev)
>  
>  	drm_dev_unregister(&pfdev->base);
>  
> -	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
> -	pm_runtime_put_noidle(pfdev->base.dev);
> -
>  }
>  
>  static ssize_t profiling_show(struct device *dev,
> 

