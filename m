Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4710DCD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9440711A745;
	Fri,  5 Jun 2026 10:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WMvTMM+R";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1704411A743
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:48:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 953D64AC6;
 Fri,  5 Jun 2026 03:48:37 -0700 (PDT)
Received: from [10.1.31.21] (e122027.cambridge.arm.com [10.1.31.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55D33F7D8;
 Fri,  5 Jun 2026 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780656522; bh=NKkvKPtBO2Iiyx4BaKJx0azdCEH/SeTZbwaWFffbLsg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WMvTMM+RXc4Rwgmso6tlmvhAZMPmBRjT1E1NvtYnh8tsxZS5yaINZy/6oVzPi+wW7
 8O2M9I/s4ydC1zJEIYCqijNoNBQSk2gTVs3rte3A7QTXnObJnbxWXyQLd+MzvznU2I
 qW+w+pnFuUx/+O8dLMdcP33XHbIrpgVsfWWXxMms=
Message-ID: <57571cae-dac7-4550-a634-c2889a961c7b@arm.com>
Date: Fri, 5 Jun 2026 11:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/panfrost: Fix PM usage_count mishandling
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
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com>
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

On 04/06/2026 18:35, Adrián Larumbe wrote:
> During device probe(), failure to do a PM get() will leave the usage_count
> set to 0, which is the value assigned at device creation time. That means
> when the autosuspend delay expires, runtime suspend callback won't be
> invoked, so the device will remain powered on forever.
> 
> On top of that, failure to call PM put() during device unplug means
> Panfrost device's PM usage_count increases monotonically for every new
> module reload.
> 
> The combined outcome of both of the above was that devfreq OPP transition
> notifications would be printed all the time, even when no jobs are being
> submitted. This quickly fills the kernel ring buffer with junk.
> 
> Even direr than that was the fact MMU interrupts are only enabled when
> the device is reset, so after device probe() the very first job targeting
> the tiler heap BO would always time out, because the driver's PM runtime
> resume callback would not be invoked.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 2d4b6aa95c66..545fbf2c8d0c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -989,6 +989,7 @@ static int panfrost_probe(struct platform_device *pdev)
>  	pm_runtime_set_active(pfdev->base.dev);
>  	pm_runtime_mark_last_busy(pfdev->base.dev);
>  	pm_runtime_enable(pfdev->base.dev);
> +	pm_runtime_get_noresume(pfdev->base.dev);
>  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
>  	pm_runtime_use_autosuspend(pfdev->base.dev);
>  
> @@ -1000,10 +1001,12 @@ static int panfrost_probe(struct platform_device *pdev)
>  	if (err < 0)
>  		goto err_out1;
>  
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
>  
>  	return 0;
>  
>  err_out1:
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);

Sashiko is concerned that dropping the usage count before
pm_runtime_disable() could cause things to turn off too early, and I
have to agree it sounds like it could be a problem:

Sashiko wrote:
> Does dropping the usage count before pm_runtime_disable() create a race
> condition where the suspend callback can run and disable clocks before
> hardware shutdown?
> Because the usage count is dropped early, a concurrent PM event could trigger
> the suspend callback, disabling clocks. Then, panfrost_device_fini() calls
> panfrost_gpu_fini() which writes to MMIO registers. Could writing to
> unclocked registers on ARM SoCs cause fatal bus errors or panics?

Sashiko also suggests we might have some other (partially pre-existing)
issues here.

https://sashiko.dev/#/patchset/20260604-claude-fixes-v2-0-57c6bd4c1655%40collabora.com

Thanks,
Steve

>  	pm_runtime_set_suspended(pfdev->base.dev);
> @@ -1018,8 +1021,9 @@ static void panfrost_remove(struct platform_device *pdev)
>  	drm_dev_unregister(&pfdev->base);
>  
>  	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
> +	pm_runtime_disable(pfdev->base.dev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
>  }
>  
> 

