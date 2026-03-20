Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EE91099B30
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA95D10EB18;
	Fri, 20 Mar 2026 21:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="D79vvaV+";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2858410EB18
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 21:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774041330; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EC9fsxrWkR2PpP1oKfcLYKaosEk1iTCs114ddsXwcpnz6PawTV43xXWJJMZxyfO0j4JJoqq0x+yAQauWiW2K2UXrzjXnlkqvEoWfZWKuicQnPNaZJYLlQo4aqzKqoqCSW4PADy62tWDrLMdb6VBr0mSry1egYudM2evAe1wdg7M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774041330;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JRNyXHVtn2PpTLiAjNMNPkrrImzdHX7B3U+BewJhPEU=; 
 b=lLfiiQWwTDPyeDa+SztT15TKEkTBoEQIpE06IRnwo1H13aFkZMapnydXwiT/2paidK3w5DblsYiA+nzKbKoPzejwcxvV2jhoqjHNXpTCQJz+/cpFTsMn1+lHQr1uIhswEFUyblcWPEiKsdepLgxZN1N+/t/Oo5aKkRBMhk5vHUw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774041330; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=JRNyXHVtn2PpTLiAjNMNPkrrImzdHX7B3U+BewJhPEU=;
 b=D79vvaV+p7ggWCF2Oox0o6TMMBOAL9cMbRDkbJZjLOTXyzrqWQpPvGpGhPsJCyTe
 Hi2chd4nUAlQO6JXYeUNGu9wjEqT9ezF1/XWlmL8nIw78OXQsnbXtneUKK2fCQHdvY1
 EFHmgOnbD744hTom40viZBea8cguVnrPVYIg43hg=
Received: by mx.zohomail.com with SMTPS id 1774041328246474.7136681465947;
 Fri, 20 Mar 2026 14:15:28 -0700 (PDT)
Date: Fri, 20 Mar 2026 21:15:23 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Biju <biju.das.au@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Biju Das <biju.das.jz@bp.renesas.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/panfrost: Add bus_ace optional clock support
 for RZ/G2L
Message-ID: <ab242zFMHJmtgbvX@sobremesa>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
 <20260320164158.487406-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320164158.487406-4-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 20.03.2026 16:41, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> On RZ/G2L SoCs, the GPU MMU requires a bus_ace clock to operate correctly.
> Without it, unbind/bind cycles leave the GPU non-operational, manifesting
> as an AS_ACTIVE bit stuck and a soft reset timeout falling back to hard
> reset. Add bus_ace_clock as an optional clock, wiring it into init/fini,
> and the runtime suspend/resume paths alongside the existing optional
> bus_clock.
>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped duplicate err assignment
>  * Changed the format string of dev_err to "%d" and simplify the dev_err()
>    line by using err rather than the same PTR_ERR().
>  * Collected tag
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 01e702a0b2f0..7fed22d555a5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -70,8 +70,21 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
>  			goto disable_clock;
>  	}
>
> +	pfdev->bus_ace_clock = devm_clk_get_optional(pfdev->base.dev, "bus_ace");
> +	if (IS_ERR(pfdev->bus_ace_clock)) {
> +		err = PTR_ERR(pfdev->bus_ace_clock);
> +		dev_err(pfdev->base.dev, "get bus_ace_clock failed %d\n", err);
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
> @@ -80,6 +93,7 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
>
>  static void panfrost_clk_fini(struct panfrost_device *pfdev)
>  {
> +	clk_disable_unprepare(pfdev->bus_ace_clock);
>  	clk_disable_unprepare(pfdev->bus_clock);
>  	clk_disable_unprepare(pfdev->clock);
>  }
> @@ -432,6 +446,10 @@ static int panfrost_device_runtime_resume(struct device *dev)
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
> @@ -439,6 +457,9 @@ static int panfrost_device_runtime_resume(struct device *dev)
>
>  	return 0;
>
> +err_bus_ace_clk:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> +		clk_disable(pfdev->bus_clock);
>  err_bus_clk:
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
>  		clk_disable(pfdev->clock);
> @@ -462,6 +483,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
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
> --
> 2.43.0


Adrian Larumbe
