Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1FCCA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F66E10F896;
	Fri,  2 Oct 2026 14:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SSv/2CMn";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 35B7A10F881
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:14:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EFCC497;
 Fri,  2 Oct 2026 07:14:35 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9C353F86F;
 Fri,  2 Oct 2026 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790950478; bh=j52YBQvyhm0qnm4xjwmBVEnjBVrMPDC8lohQo+T5vLg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SSv/2CMn9K++VWgh78IGljwuILd5KO4eYt8+l6kpBl/pQuGDMTq6cwTkFXdVP9X6z
 7wMcsqH2Vcn8AQsT8y1xvZJZ0QojYnmN0NMZUkr56tAZqLAim37u9OTjMusaz7sKSl
 IxlG4GOiJCY9JEeFu+9zL/pQIqDtzxI/GnSKhUeQ=
Message-ID: <73c68c98-5ef3-44e1-81b8-16de37cf10ee@arm.com>
Date: Fri, 2 Oct 2026 15:14:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/15] drm/panfrost: Skip NULL checks for clock
 enable/disabling
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
 <20260929-claude-fixes-v12-4-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-4-62beb08de207@collabora.com>
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
> The clk_* API can deal with NULL clock objects, so we can do away with NULL
> checks in client code.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 5bf528f41278..b3a53504bd01 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -510,11 +510,9 @@ static int panfrost_device_resume(struct device *dev)
>  		if (ret)
>  			goto err_clk;
>  
> -		if (pfdev->bus_clock) {
> -			ret = clk_enable(pfdev->bus_clock);
> -			if (ret)
> -				goto err_bus_clk;
> -		}
> +		ret = clk_enable(pfdev->bus_clock);
> +		if (ret)
> +			goto err_bus_clk;
>  	}
>  
>  	ret = pm_runtime_force_resume(dev);
> @@ -524,7 +522,7 @@ static int panfrost_device_resume(struct device *dev)
>  	return 0;
>  
>  err_resume:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
>  		clk_disable(pfdev->bus_clock);
>  err_bus_clk:
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> @@ -545,9 +543,7 @@ static int panfrost_device_suspend(struct device *dev)
>  		return ret;
>  
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		if (pfdev->bus_clock)
> -			clk_disable(pfdev->bus_clock);
> -
> +		clk_disable(pfdev->bus_clock);
>  		clk_disable(pfdev->clock);
>  	}
>  
> 

