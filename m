Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170EAC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CDD10EA25;
	Tue,  4 Aug 2026 12:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="k2fftbKM";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2F0E210EA20
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:50:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A546C165C
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:50:30 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 72D8A3F66F
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785847834; bh=snTQtcGEqteAJu+Rvoz3D4mB2JBxEopiOgm2EBh9KKc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k2fftbKMw/iu9Ti07oFOE8epnvkuKjnVlz+9kRadqpaOzFm3OO80JRtd3G/QHku9X
 5aqpr9vW2SVAGvNpqLpXbpU2GMLI7OPam5vK24Hp8zDTm/AnNmBJDIR7Rg71MYA50k
 55VAwhXS4waLnLYa380WtkSAwIX9POWI3O4KppzY=
Date: Tue, 4 Aug 2026 13:50:25 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] drm/panthor: Move the debugfs initialization to
 panthor_device.c
Message-ID: <anHgEQIVMZkPXxLr@e142607>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-3-abbbd2d41b13@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804-panthor-unplug-fixes-v1-3-abbbd2d41b13@collabora.com>
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

On Tue, Aug 04, 2026 at 12:09:42PM +0200, Boris Brezillon wrote:
> Those are per-device debugfs-files, so it makes sense to have the
> initialization logic in panthor_device.c.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  9 +++++++++
>  drivers/gpu/drm/panthor/panthor_device.h |  4 ++++
>  drivers/gpu/drm/panthor/panthor_drv.c    | 10 +---------
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 1aa86d00646f..7d336f160d1f 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -13,6 +13,7 @@
>  #include <linux/reset.h>
>  
>  #include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_print.h>
>  
> @@ -616,3 +617,11 @@ int panthor_device_suspend(struct device *dev)
>  	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_SUSPENDED);
>  	return 0;
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
> +void panthor_device_debugfs_init(struct drm_minor *minor)
> +{
> +	panthor_mmu_debugfs_init(minor);
> +	panthor_gem_debugfs_init(minor);
> +}
> +#endif
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 0fda64fbe5f2..a6b1a2a5fca4 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -403,6 +403,10 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
>  int panthor_device_resume(struct device *dev);
>  int panthor_device_suspend(struct device *dev);
>  
> +#ifdef CONFIG_DEBUG_FS
> +void panthor_device_debugfs_init(struct drm_minor *minor);
> +#endif
> +
>  static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
>  {
>  	int ret = pm_runtime_resume_and_get(ptdev->base.dev);
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 46a3080b0b20..924a7ecd3733 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1764,14 +1764,6 @@ static const struct file_operations panthor_drm_driver_fops = {
>  	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
> -#ifdef CONFIG_DEBUG_FS
> -static void panthor_debugfs_init(struct drm_minor *minor)
> -{
> -	panthor_mmu_debugfs_init(minor);
> -	panthor_gem_debugfs_init(minor);
> -}
> -#endif
> -
>  /*
>   * PanCSF driver version:
>   * - 1.0 - initial interface
> @@ -1807,7 +1799,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
>  	.gem_prime_import = panthor_gem_prime_import,
>  #ifdef CONFIG_DEBUG_FS
> -	.debugfs_init = panthor_debugfs_init,
> +	.debugfs_init = panthor_device_debugfs_init,
>  #endif
>  };
>  
> 
> -- 
> 2.55.0
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
