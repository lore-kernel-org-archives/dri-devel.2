Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE236606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Yl1WbbCF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCAA10E0D5;
	Mon, 26 Oct 2026 14:10:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6943B10E07E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 14:10:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A9C8293B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:10:40 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 6E6243F7B4
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793023843; bh=2sAXnIXAPho4z+s8CQR8tTsNIWs6s/t/uWe+/rNGIpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yl1WbbCF0ZwyTZQHCY4LlDsopyYQSaoD7xaT1V1z3WIZ2Sg33k4BRY5w1CGoxwN0z
 Ze78PsRNIll09PNk2zw6J9yZS4sXM11raSEVnEHDcPSrG/ETyWqgcsWlj1ojuTNiDh
 DISLWJgYm0FrWFtJ3gQY1OpInnG4+mrZEKR4RK6k=
Date: Mon, 26 Oct 2026 14:10:33 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: ryan.zhang@oss.nxp.com
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: dummy read to discard the stale first
 GPU_TIMESTAMP read
Message-ID: <at9fWYkbqFNyLNU0@e142607>
References: <20260921102957.1024029-1-ryan.zhang@oss.nxp.com>
 <20260923102448.2279852-1-ryan.zhang@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923102448.2279852-1-ryan.zhang@oss.nxp.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Sep 23, 2026 at 06:24:48PM +0800, ryan.zhang@oss.nxp.com wrote:
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
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Pushed to drm-misc-next.

Best regards,
Liviu

> ---
> v2:
>  - Added the r-b in commit msg.
>  - Rebased on drm-misc-next to resolve conflict.
>  - Moved the dummy read into panthor_gpu_get_timestamp() to align with
>    the refactored timestamp query code on drm-misc-next.
> Note: The original v1 patch was based on v6.18 and applied cleanly there.
> Could we also port v1 into 6.18?
> 
>  drivers/gpu/drm/panthor/panthor_gpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index a383b04f101e..b8df5663f04e 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -2,6 +2,7 @@
>  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
>  /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
>  /* Copyright 2019 Collabora ltd. */
> +/* Copyright 2026 NXP */
>  
>  #include <linux/bitfield.h>
>  #include <linux/bitmap.h>
> @@ -470,6 +471,9 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
>  
>  u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
>  {
> +	/* Dummy read to avoid stale values. */
> +	gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
> +
>  	return gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
>  }
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
