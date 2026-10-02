Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36050CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7296D10E5D5;
	Fri,  2 Oct 2026 14:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="eP3PIB6o";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id EDBF210E5D5
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:22:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08193497;
 Fri,  2 Oct 2026 07:22:01 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1EED3F86F;
 Fri,  2 Oct 2026 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790950924; bh=jOCOO+Xj5f5OyiqiChnSfE5G0LOwbUWiM9AoQvHa98g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eP3PIB6oJLprBjAWiKq/2eZedOU49fIkZA8r680s90y5Ooep4JI1nQiLu45zFBh50
 NYQVKM3r3sT/LS4vhSHdaJpXSp4u9ebEMcVXDxzPmOV7kufAi+G9R4sRLkkfwklTJP
 SbtcQZBzz1/T8JaHHgPPBZ9qjjRfyIUGeijTr5x8=
Message-ID: <492e3023-bba1-42d4-bd72-287c2a6a8b75@arm.com>
Date: Fri, 2 Oct 2026 15:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/15] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
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
 <20260929-claude-fixes-v12-6-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-6-62beb08de207@collabora.com>
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
> During device probe(), failure to do a PM get() will leave the usage_count
> set to 0, which is the value assigned at device creation time. That means
> when the autosuspend delay expires, runtime suspend callback won't be
> invoked, so the device will remain powered on forever.
> 
> On top of that, failure to call PM put() during device unplug means
> Panfrost device's PM usage_count increases monotonically for every new
> module reload.
> 
> The outcome of both of the above meant that:
> 
> - Devfreq OPP transition notifications would be printed all the time,
>   even when no jobs are being submitted. This quickly fills the kernel
>   ring buffer with junk.
> - Because MMU interrupts are only enabled when the device is reset,
>   the very first job targeting the tiler heap BO after device probe()
>   would always time out, since the driver's PM runtime resume callback
>   would not be invoked.
> 
> To fix the above:
> - Manually adjust the PM refcnt at device probe and removal time.
> - Ensure pm_runtime_dont_use_autosuspend is called in the wind-down path.
> - Call pm_runtime_put_autosuspend() when device is ready to accept jobs
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 55fc22e8d4d4..907d4a14a0b5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -852,6 +852,11 @@ static int panfrost_probe(struct platform_device *pdev)
>  		goto err_out0;
>  	}
>  
> +	/* The reason we must manually set the PM status and usage counter is
> +	 * we have just powered the device up but did not go through the PM
> +	 * runtime resume callback, so we need to update these ourselves.
> +	 */
> +	pm_runtime_get_noresume(pfdev->base.dev);
>  	pm_runtime_set_active(pfdev->base.dev);
>  	pm_runtime_mark_last_busy(pfdev->base.dev);
>  	pm_runtime_enable(pfdev->base.dev);
> @@ -866,13 +871,16 @@ static int panfrost_probe(struct platform_device *pdev)
>  	if (err < 0)
>  		goto err_out1;
>  
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
>  
>  	return 0;
>  
>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  err_out0:
>  	return err;
>  }
> @@ -884,9 +892,12 @@ static void panfrost_remove(struct platform_device *pdev)
>  	drm_dev_unregister(&pfdev->base);
>  
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
> +
>  }
>  
>  static ssize_t profiling_show(struct device *dev,
> 

