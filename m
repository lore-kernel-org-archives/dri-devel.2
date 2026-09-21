Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA14C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533D010E19F;
	Mon, 21 Sep 2026 16:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rTPV3Y4d";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E9E1910E19F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:36:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7F8D19F0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:36:12 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 1285B3F86C
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790008576; bh=4iyfBXQPN/kMHD3Pi/xPJUMFHR4GcFjDxAHBGHDGGf8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rTPV3Y4dysopelYefzLNmXK/aF+5FnU465320cWbycnPPv1N2ddb2P9jjPY3Baq/T
 ta0p5wGXlgVUCiaCslol8nULlTr+kELPR44rjsgSPHYJl9uE2UHtf6uYFo08wlLAnA
 3SqGjIO3juy+zbEJEq+hmG0Lh7WQzYNDhzFVCr94=
Date: Mon, 21 Sep 2026 17:36:06 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: ryan.zhang@oss.nxp.com
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: dummy read to discard the stale first
 GPU_TIMESTAMP read
Message-ID: <arFc9vNnxld2PtTp@e142607>
References: <20260921102957.1024029-1-ryan.zhang@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921102957.1024029-1-ryan.zhang@oss.nxp.com>
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

On Mon, Sep 21, 2026 at 06:29:57PM +0800, ryan.zhang@oss.nxp.com wrote:
> From: Ryan Zhang <ryan.zhang@oss.nxp.com>
> 
> The first read of GPU_TIMESTAMP after the GPU has been idle can return a
> value that lags the real counter, while a read issued immediately after is
> accurate.
> 
> Userspace correlates this timestamp with the host clock, so a stale value
> shows up as skew between the device and host time domains and makes
> dEQP-VK.pipeline.monolithic.timestamp.calibrated.calibration_test fail
> whenever a query happens to hit a large first-read error.
> 
> Signed-off-by: Ryan Zhang <ryan.zhang@oss.nxp.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 720bf889096d..956a147dc282 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -2,6 +2,7 @@
>  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
>  /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
>  /* Copyright 2019 Collabora ltd. */
> +/* Copyright 2026 NXP */
>  
>  #ifdef CONFIG_ARM_ARCH_TIMER
>  #include <asm/arch_timer.h>
> @@ -772,6 +773,10 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
>  #else
>  	arg->timestamp_frequency = 0;
>  #endif
> +
> +	/* Dummy read to avoid stale values. */
> +	gpu_read64_counter(ptdev, GPU_TIMESTAMP);
> +
>  	arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
>  	arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
>  
> -- 
> 2.43.0
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
