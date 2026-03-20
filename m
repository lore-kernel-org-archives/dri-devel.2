Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D74108B914
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C90610EAAC;
	Fri, 20 Mar 2026 12:16:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 44A5810EAA8
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:16:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3F6A1682;
 Fri, 20 Mar 2026 05:16:00 -0700 (PDT)
Received: from [10.1.29.20] (e122027.cambridge.arm.com [10.1.29.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1344D3F7BD;
 Fri, 20 Mar 2026 05:16:03 -0700 (PDT)
Message-ID: <5bb58801-2851-4c7b-a8f0-d4b3cc2db474@arm.com>
Date: Fri, 20 Mar 2026 12:15:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/panfrost: Add bus_ace optional clock support for
 RZ/G2L
To: Biju <biju.das.au@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20260304134845.267030-1-biju.das.jz@bp.renesas.com>
 <20260304134845.267030-4-biju.das.jz@bp.renesas.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260304134845.267030-4-biju.das.jz@bp.renesas.com>
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

On 04/03/2026 13:48, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> On RZ/G2L SoCs, the GPU MMU requires a bus_ace clock to operate correctly.
> Without it, unbind/bind cycles leave the GPU non-operational, manifesting
> as an AS_ACTIVE bit stuck and a soft reset timeout falling back to hard
> reset. Add bus_ace_clock as an optional clock, wiring it into init/fini,
> and the runtime suspend/resume paths alongside the existing optional
> bus_clock.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 24 ++++++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 01e702a0b2f0..87dae0ed748a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -70,8 +70,23 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
>  			goto disable_clock;
>  	}
>  
> +	pfdev->bus_ace_clock = devm_clk_get_optional(pfdev->base.dev, "bus_ace");
> +	if (IS_ERR(pfdev->bus_ace_clock)) {
> +		err = PTR_ERR(pfdev->bus_ace_clock);
> +		dev_err(pfdev->base.dev, "get bus_ace_clock failed %ld\n",
> +			PTR_ERR(pfdev->bus_ace_clock));
> +		err = PTR_ERR(pfdev->bus_ace_clock);

You've assigned err twice (with the same value), and you can simplify
the dev_err() line by using err rather than the same PTR_ERR()
expression again.

With that fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> +		goto disable_bus_clock;
> +	}
> +
> +	err = clk_prepare_enable(pfdev->bus_ace_clock);
> +	if (err)
> +		goto disable_bus_clock;
> +
>  	return 0;
>  
> +disable_bus_clock:
> +	clk_disable_unprepare(pfdev->bus_clock);
>  disable_clock:
>  	clk_disable_unprepare(pfdev->clock);
>  
> @@ -80,6 +95,7 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
>  
>  static void panfrost_clk_fini(struct panfrost_device *pfdev)
>  {
> +	clk_disable_unprepare(pfdev->bus_ace_clock);
>  	clk_disable_unprepare(pfdev->bus_clock);
>  	clk_disable_unprepare(pfdev->clock);
>  }
> @@ -432,6 +448,10 @@ static int panfrost_device_runtime_resume(struct device *dev)
>  		ret = clk_enable(pfdev->bus_clock);
>  		if (ret)
>  			goto err_bus_clk;
> +
> +		ret = clk_enable(pfdev->bus_ace_clock);
> +		if (ret)
> +			goto err_bus_ace_clk;
>  	}
>  
>  	panfrost_device_reset(pfdev, true);
> @@ -439,6 +459,9 @@ static int panfrost_device_runtime_resume(struct device *dev)
>  
>  	return 0;
>  
> +err_bus_ace_clk:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> +		clk_disable(pfdev->bus_clock);
>  err_bus_clk:
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
>  		clk_disable(pfdev->clock);
> @@ -462,6 +485,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
>  	panfrost_gpu_power_off(pfdev);
>  
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> +		clk_disable(pfdev->bus_ace_clock);
>  		clk_disable(pfdev->bus_clock);
>  		clk_disable(pfdev->clock);
>  		reset_control_assert(pfdev->rstc);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 0f3992412205..ec55c136b1b6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -136,6 +136,7 @@ struct panfrost_device {
>  	void __iomem *iomem;
>  	struct clk *clock;
>  	struct clk *bus_clock;
> +	struct clk *bus_ace_clock;
>  	struct regulator_bulk_data *regulators;
>  	struct reset_control *rstc;
>  	/* pm_domains for devices with more than one. */

