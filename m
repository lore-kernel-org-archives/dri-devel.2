Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2CFC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280E510EC9A;
	Tue, 30 Jun 2026 15:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="erQf5PDj";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E3F0010EC9A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 15:34:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17FA32ED2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:34:44 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 438803F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782833688; bh=lq5f476JObY8Pg8hX2Bh3cHTLWt33Mu4o87uEoga/D8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=erQf5PDjfeW3pHwtlUa+AQA/+SyoQj6qk/W0QkinUs+CV8DBAugm2W89dqzXCbrRX
 uIr4FIjOcutzB5ayP2SeBk+eYzLumFz4i5P3VQmqPl+ivmdD/BIkCZ4+3ov7jxwWyU
 5w8QaZs3dmImNdSMWeGL7X0yZdYy5h4CeifzosU8=
Date: Tue, 30 Jun 2026 16:34:46 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Gustavo Kenji =?utf-8?B?TWVuZG9uw6dh?= Kaneko <kaneko.dev@pm.me>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/arm/malidp: use clk_bulk API in runtime PM resume
 and suspend
Message-ID: <akPiFvu_FEjn8n84@e142607>
References: <20260609130812.1065699-1-kaneko.dev@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609130812.1065699-1-kaneko.dev@pm.me>
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

On Tue, Jun 09, 2026 at 01:08:19PM +0000, Gustavo Kenji Mendonça Kaneko wrote:
> malidp_runtime_pm_resume() calls clk_prepare_enable() three times
> without checking the return value. If any clock fails to enable, the
> driver silently proceeds with unclocked hardware, leading to undefined
> behavior.
> 
> Convert both the resume and suspend paths to use the clk_bulk API:
> clk_bulk_prepare_enable() in resume checks the return value and rolls
> back any successfully enabled clocks on failure;
> clk_bulk_disable_unprepare() in suspend keeps the two paths symmetric.
> 
> This issue was found by code review without access to Mali DP hardware.
> 
> Signed-off-by: Gustavo Kenji Mendonça Kaneko <kaneko.dev@pm.me>

Sorry for the delay, I've pushed both your patches into drm-misc-fixes today.

Best regards,
Liviu

> ---
> Changes in v2:
>   - Also convert malidp_runtime_pm_suspend() to clk_bulk_disable_unprepare()
>     to make both paths truly symmetric (Liviu Dudau)
>   - Drop the incorrect claim about existing clk_bulk usage in the suspend
>     path from the commit message (Liviu Dudau)
> 
>  drivers/gpu/drm/arm/malidp_drv.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index b765f6c9eea4..90e7f14aacec 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -670,6 +670,11 @@ static int malidp_runtime_pm_suspend(struct device *dev)
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct malidp_drm *malidp = drm_to_malidp(drm);
>  	struct malidp_hw_device *hwdev = malidp->dev;
> +	struct clk_bulk_data clks[] = {
> +		{ .clk = hwdev->pclk },
> +		{ .clk = hwdev->aclk },
> +		{ .clk = hwdev->mclk },
> +	};
>  
>  	/* we can only suspend if the hardware is in config mode */
>  	WARN_ON(!hwdev->hw->in_config_mode(hwdev));
> @@ -677,9 +682,7 @@ static int malidp_runtime_pm_suspend(struct device *dev)
>  	malidp_se_irq_fini(hwdev);
>  	malidp_de_irq_fini(hwdev);
>  	hwdev->pm_suspended = true;
> -	clk_disable_unprepare(hwdev->mclk);
> -	clk_disable_unprepare(hwdev->aclk);
> -	clk_disable_unprepare(hwdev->pclk);
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(clks), clks);
>  
>  	return 0;
>  }
> @@ -689,10 +692,17 @@ static int malidp_runtime_pm_resume(struct device *dev)
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct malidp_drm *malidp = drm_to_malidp(drm);
>  	struct malidp_hw_device *hwdev = malidp->dev;
> +	struct clk_bulk_data clks[] = {
> +		{ .clk = hwdev->pclk },
> +		{ .clk = hwdev->aclk },
> +		{ .clk = hwdev->mclk },
> +	};
> +	int err;
> +
> +	err = clk_bulk_prepare_enable(ARRAY_SIZE(clks), clks);
> +	if (err)
> +		return err;
>  
> -	clk_prepare_enable(hwdev->pclk);
> -	clk_prepare_enable(hwdev->aclk);
> -	clk_prepare_enable(hwdev->mclk);
>  	hwdev->pm_suspended = false;
>  	malidp_de_irq_hw_init(hwdev);
>  	malidp_se_irq_hw_init(hwdev);
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
