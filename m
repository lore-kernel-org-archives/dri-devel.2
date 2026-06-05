Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F7DCD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3547711A7CB;
	Fri,  5 Jun 2026 12:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JPb0ASxT";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 632AD11A7CB
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 12:07:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCDB14CF9
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 05:07:32 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 81C393F7D8
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780661257; bh=+cJrAH5FBqkCzhvaJ5hJ2+lQ/V1QKK73k3A8dyWF67U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JPb0ASxTOKwDtuQJVkFQdCFn64Gmp+EM7rb5UfiCcQ56K9Tr+6N/UMYO3fTwm3fbl
 5L20vw3Uzj1WZZOtZF4qUK1aE1Gk6O40zFsjhEjj6mPt3y+rYtqpBJx0r1NY4mS5Yv
 nN7k3AixhOoP8bQL+mz2SiNq2OSdPbtjGyCuL1so=
Date: Fri, 5 Jun 2026 13:07:35 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Gustavo Kenji =?utf-8?B?TWVuZG9uw6dh?= Kaneko <kaneko.dev@pm.me>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/arm/malidp: fix ignored clk_prepare_enable() in
 runtime PM resume
Message-ID: <aiK8B2NpvHY33lm5@e142607>
References: <20260531052945.65117-1-kaneko.dev@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260531052945.65117-1-kaneko.dev@pm.me>
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

On Sun, May 31, 2026 at 05:29:57AM +0000, Gustavo Kenji Mendonça Kaneko wrote:
> malidp_runtime_pm_resume() calls clk_prepare_enable() three times
> without checking the return value. If any clock fails to enable, the
> driver silently proceeds with unclocked hardware, leading to undefined
> behavior.
> 
> Use clk_bulk_prepare_enable() which atomically enables all clocks and
> automatically rolls back successfully enabled clocks on failure. This
> is consistent with how the suspend path already uses
> clk_bulk_disable_unprepare() in malidp_runtime_pm_suspend().
> 
> This issue was found by code review without access to Mali DP hardware.
> 
> Signed-off-by: Gustavo Kenji Mendonça Kaneko <kaneko.dev@pm.me>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index b765f6c9eea4..1e4336c3a2fa 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -689,10 +689,17 @@ static int malidp_runtime_pm_resume(struct device *dev)
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
