Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27455CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7012010EFF9;
	Thu, 11 Jun 2026 15:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="tkqgXSVO";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8AA9210EFF7
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:58:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378EE1516
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 08:58:02 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 B95B73FB90
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781193487; bh=JjgcsqnCxL3j20VMBBvzPgr+g2M5UACBDHsxu7RFV3Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tkqgXSVOhiM6WdiJ0RwLoncitvStwoo1QJpKh5MiQyk3VVXS+OEvPLku+EYUn+PUw
 pHJouBqcdbQd3V/u0wTIvANEXBTpp5Cfvi0ClvbwvjYcfkvf6hcPr3hxKU2/yz9+nD
 KtoOmnmoPG8kpDAs2uB86xzr1mQfh+DnJcO5d44o=
Date: Thu, 11 Jun 2026 16:58:04 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Gustavo Kenji =?utf-8?B?TWVuZG9uw6dh?= Kaneko <kaneko.dev@pm.me>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/arm/komeda: fix error handling for
 clk_prepare_enable() and callers
Message-ID: <airbDPZeIDVDHa3W@e142607>
References: <20260609130828.1066038-1-kaneko.dev@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609130828.1066038-1-kaneko.dev@pm.me>
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

On Tue, Jun 09, 2026 at 01:08:33PM +0000, Gustavo Kenji Mendonça Kaneko wrote:
> komeda_dev_resume() calls clk_prepare_enable() without checking the
> return value. If the clock fails to enable, the function returns 0
> (success) while IRQs are enabled and IOMMU is connected on potentially
> unclocked hardware, causing undefined behavior on resume.
> 
> Propagate the error from clk_prepare_enable() and fix all call sites
> in komeda_drv.c that previously ignored the return value of
> komeda_dev_resume():
> 
> - komeda_platform_probe(): if resume fails, jump to err_destroy_mdev
>   (skipping the suspend call, since the clock was never enabled)
> - komeda_pm_resume(): propagate the error and skip
>   drm_mode_config_helper_resume() on failure
> 
> This issue was found by code review without access to Komeda hardware.
> 
> Signed-off-by: Gustavo Kenji Mendonça Kaneko <kaneko.dev@pm.me>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> Changes in v2:
>   - Fix all call sites in komeda_drv.c that ignored the return value of
>     komeda_dev_resume() (Liviu Dudau)
>   - In komeda_platform_probe(), use a new err_destroy_mdev label to skip
>     the komeda_dev_suspend() call when resume itself failed
>   - In komeda_pm_resume(), propagate the error from komeda_dev_resume()
>     and skip drm_mode_config_helper_resume() on failure
> 
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c |  6 +++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 14 +++++++++-----
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 5ba62e637a61..9aad1d1d28ec 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -313,7 +313,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  
>  int komeda_dev_resume(struct komeda_dev *mdev)
>  {
> -	clk_prepare_enable(mdev->aclk);
> +	int err;
> +
> +	err = clk_prepare_enable(mdev->aclk);
> +	if (err)
> +		return err;
>  
>  	mdev->funcs->enable_irq(mdev);
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index 4bb5f250e95e..67fffab018ae 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -74,8 +74,11 @@ static int komeda_platform_probe(struct platform_device *pdev)
>  	}
>  
>  	pm_runtime_enable(dev);
> -	if (!pm_runtime_enabled(dev))
> -		komeda_dev_resume(mdrv->mdev);
> +	if (!pm_runtime_enabled(dev)) {
> +		err = komeda_dev_resume(mdrv->mdev);
> +		if (err)
> +			goto err_destroy_mdev;
> +	}
>  
>  	mdrv->kms = komeda_kms_attach(mdrv->mdev);
>  	if (IS_ERR(mdrv->kms)) {
> @@ -93,7 +96,7 @@ static int komeda_platform_probe(struct platform_device *pdev)
>  		pm_runtime_disable(dev);
>  	else
>  		komeda_dev_suspend(mdrv->mdev);
> -
> +err_destroy_mdev:
>  	komeda_dev_destroy(mdrv->mdev);
>  
>  free_mdrv:
> @@ -140,11 +143,12 @@ static int __maybe_unused komeda_pm_suspend(struct device *dev)
>  static int __maybe_unused komeda_pm_resume(struct device *dev)
>  {
>  	struct komeda_drv *mdrv = dev_get_drvdata(dev);
> +	int err = 0;
>  
>  	if (!pm_runtime_status_suspended(dev))
> -		komeda_dev_resume(mdrv->mdev);
> +		err = komeda_dev_resume(mdrv->mdev);
>  
> -	return drm_mode_config_helper_resume(&mdrv->kms->base);
> +	return err ? err : drm_mode_config_helper_resume(&mdrv->kms->base);
>  }
>  
>  static const struct dev_pm_ops komeda_pm_ops = {
> -- 
> 2.54.0
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
