Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD3CCA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E291610E487;
	Fri,  2 Oct 2026 14:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="L9YtsQt1";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6970F10E487
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:20:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E061476;
 Fri,  2 Oct 2026 07:20:49 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DEC73F86F;
 Fri,  2 Oct 2026 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790950852; bh=a911ETWir/XtqF1LPazIH4XtUFulvCkCjSpVEYEZ/BQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=L9YtsQt1IujRdTHTjxeVLGwh5BHgRVWn//i3RBwseGiAyLyAGnIpa+9cnEueosAab
 n36kBKjl2OyGPAQef8JyfC/Ug37GQm9o7l38AyKCLbv9FMakuAjihyK9Nd0ZB9vzha
 ZVS2OSx7Ofz2Lo25PVJVfV/FwcDhA7iL5Jo/MRjQ=
Message-ID: <b533d7d1-fb81-4eff-bcdd-a2bfe9bd2180@arm.com>
Date: Fri, 2 Oct 2026 15:20:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/15] drm/panfrost: Consolidate device clock
 management and reset
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
 <20260929-claude-fixes-v12-5-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-5-62beb08de207@collabora.com>
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
> Gather all clock enables and disables into a single function to avoid
> repetitions between driver init/fini and device resume/suspend, since
> these clocks are always handled in bulk.
> 
> Also do clk (un)prepares and dis/enables at the same time, since the
> clk_prepare_* family of functions can simply increase the refcnt of
> an already prepared clock.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 118 +++++++++++++----------------
>  1 file changed, 52 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index b3a53504bd01..9f2b1967a398 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -34,10 +34,46 @@ static void panfrost_reset_fini(struct panfrost_device *pfdev)
>  	reset_control_assert(pfdev->rstc);
>  }
>  
> -static int panfrost_clk_init(struct panfrost_device *pfdev)
> +static int panfrost_clks_enable(struct panfrost_device *pfdev, bool on_resume)
>  {
>  	int err;
> +
> +	err = clk_prepare_enable(pfdev->clock);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(pfdev->bus_clock);
> +	if (err)
> +		goto disable_clock;
> +
> +	if (on_resume) {
> +		err = clk_prepare_enable(pfdev->bus_ace_clock);
> +		if (err)
> +			goto disable_bus_clock;
> +	}
> +
> +	return 0;
> +
> +disable_bus_clock:
> +	clk_disable_unprepare(pfdev->bus_clock);
> +disable_clock:
> +	clk_disable_unprepare(pfdev->clock);
> +
> +	return err;
> +}
> +
> +static void panfrost_clks_disable(struct panfrost_device *pfdev, bool on_suspend)
> +{
> +	if (on_suspend)
> +		clk_disable_unprepare(pfdev->bus_ace_clock);
> +	clk_disable_unprepare(pfdev->bus_clock);
> +	clk_disable_unprepare(pfdev->clock);
> +}
> +
> +static int panfrost_clk_init(struct panfrost_device *pfdev)
> +{
>  	unsigned long rate;
> +	int err;
>  
>  	pfdev->clock = devm_clk_get(pfdev->base.dev, NULL);
>  	if (IS_ERR(pfdev->clock)) {
> @@ -48,53 +84,31 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
>  	rate = clk_get_rate(pfdev->clock);
>  	dev_info(pfdev->base.dev, "clock rate = %lu\n", rate);
>  
> -	err = clk_prepare_enable(pfdev->clock);
> -	if (err)
> -		return err;
> -
>  	pfdev->bus_clock = devm_clk_get_optional(pfdev->base.dev, "bus");
>  	if (IS_ERR(pfdev->bus_clock)) {
> -		dev_err(pfdev->base.dev, "get bus_clock failed %ld\n",
> -			PTR_ERR(pfdev->bus_clock));
>  		err = PTR_ERR(pfdev->bus_clock);
> -		goto disable_clock;
> +		dev_err(pfdev->base.dev, "get bus_clock failed %d\n", err);
> +		return err;
>  	}
>  
>  	if (pfdev->bus_clock) {
>  		rate = clk_get_rate(pfdev->bus_clock);
>  		dev_info(pfdev->base.dev, "bus_clock rate = %lu\n", rate);
> -
> -		err = clk_prepare_enable(pfdev->bus_clock);
> -		if (err)
> -			goto disable_clock;
>  	}
>  
>  	pfdev->bus_ace_clock = devm_clk_get_optional(pfdev->base.dev, "bus_ace");
>  	if (IS_ERR(pfdev->bus_ace_clock)) {
>  		err = PTR_ERR(pfdev->bus_ace_clock);
>  		dev_err(pfdev->base.dev, "get bus_ace_clock failed %d\n", err);
> -		goto disable_bus_clock;
> +		return err;
>  	}
>  
> -	err = clk_prepare_enable(pfdev->bus_ace_clock);
> -	if (err)
> -		goto disable_bus_clock;
> -
> -	return 0;
> -
> -disable_bus_clock:
> -	clk_disable_unprepare(pfdev->bus_clock);
> -disable_clock:
> -	clk_disable_unprepare(pfdev->clock);
> -
> -	return err;
> +	return panfrost_clks_enable(pfdev, true);
>  }
>  
>  static void panfrost_clk_fini(struct panfrost_device *pfdev)
>  {
> -	clk_disable_unprepare(pfdev->bus_ace_clock);
> -	clk_disable_unprepare(pfdev->bus_clock);
> -	clk_disable_unprepare(pfdev->clock);
> +	panfrost_clks_disable(pfdev, true);
>  }
>  
>  static int panfrost_regulator_init(struct panfrost_device *pfdev)
> @@ -436,34 +450,17 @@ static int panfrost_device_runtime_resume(struct device *dev)
>  		if (ret)
>  			return ret;
>  
> -		ret = clk_enable(pfdev->clock);
> -		if (ret)
> -			goto err_clk;
> -
> -		ret = clk_enable(pfdev->bus_clock);
> -		if (ret)
> -			goto err_bus_clk;
> -
> -		ret = clk_enable(pfdev->bus_ace_clock);
> -		if (ret)
> -			goto err_bus_ace_clk;
> +		ret = panfrost_clks_enable(pfdev, true);
> +		if (ret) {
> +			reset_control_assert(pfdev->rstc);
> +			return ret;
> +		}
>  	}
>  
>  	panfrost_device_reset(pfdev, true);
>  	panfrost_devfreq_resume(pfdev);
>  
>  	return 0;
> -
> -err_bus_ace_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> -		clk_disable(pfdev->bus_clock);
> -err_bus_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> -		clk_disable(pfdev->clock);
> -err_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> -		reset_control_assert(pfdev->rstc);
> -	return ret;
>  }
>  
>  static int panfrost_device_runtime_suspend(struct device *dev)
> @@ -480,9 +477,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
>  	panfrost_gpu_power_off(pfdev);
>  
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> -		clk_disable(pfdev->bus_ace_clock);
> -		clk_disable(pfdev->bus_clock);
> -		clk_disable(pfdev->clock);
> +		panfrost_clks_disable(pfdev, true);
>  		reset_control_assert(pfdev->rstc);
>  	}
>  
> @@ -506,13 +501,9 @@ static int panfrost_device_resume(struct device *dev)
>  	}
>  
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		ret = clk_enable(pfdev->clock);
> +		ret = panfrost_clks_enable(pfdev, false);
>  		if (ret)
>  			goto err_clk;
> -
> -		ret = clk_enable(pfdev->bus_clock);
> -		if (ret)
> -			goto err_bus_clk;
>  	}
>  
>  	ret = pm_runtime_force_resume(dev);
> @@ -523,10 +514,7 @@ static int panfrost_device_resume(struct device *dev)
>  
>  err_resume:
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> -		clk_disable(pfdev->bus_clock);
> -err_bus_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> -		clk_disable(pfdev->clock);
> +		panfrost_clks_disable(pfdev, false);
>  err_clk:
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
>  		dev_pm_opp_set_opp(dev, NULL);
> @@ -542,10 +530,8 @@ static int panfrost_device_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		clk_disable(pfdev->bus_clock);
> -		clk_disable(pfdev->clock);
> -	}
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> +		panfrost_clks_disable(pfdev, false);
>  
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
>  		dev_pm_opp_set_opp(dev, NULL);
> 

