Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA2DC79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9402610E587;
	Thu, 10 Sep 2026 01:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="iWP/fydg";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1BC10E587
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789003089; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XpdOgEsHpqu+6bGsivuueqBn69BgmpM9kdBWWUFQ+GGjZoQwXOCmjRDed2cTIwSphGNcihskB5IfarT+KyNmvzQGOu4kNdVNP1o9YEVDOdEj3hri4nRaTQWDQpNZPNp3j8GsBh6NZ3XEFc5Ku6qrltUanmMNwfnibde1q92OcLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789003089;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=swfvw6E9LPj82OdV2+5HH1jNWXs8rY8qpluiG1Z8Mfg=; 
 b=PJCaCMXpteGcpSWNWrGCFlJw2riMIjnqVZYjBxoL0gsW4DrPU9rbKfqvUHCa6T0GztH2gKFUqOd6QIbp1jiAoHMvKHS/ORhJ3qxKiTYHsuhhF+j/2RFjtfqy9BLxMK3+Gj6P4slsFjngwkbYTEULw08Bg1pp/YXmU30KvdS1TvU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789003089; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=swfvw6E9LPj82OdV2+5HH1jNWXs8rY8qpluiG1Z8Mfg=;
 b=iWP/fydgfutZeLcR2wg/qcZe78EXl4krWWv/fISM5Cm7ZCzhGrY2V5t4ZV1k9akh
 4eB7cznE4WyT0b371DJ4U8J9359hfoJkdku2i1VXFhFIpIgtz+ebMkNIjs8o1FKmBsg
 v6N3kfEiaCvtGdNQWqkXU8IqV8KkMWWxkKiQ+1eE=
Received: by mx.zohomail.com with SMTPS id 1789003088803668.7289213837038;
 Wed, 9 Sep 2026 18:18:08 -0700 (PDT)
Date: Thu, 10 Sep 2026 02:18:04 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/18] drm/panthor: Move the debugfs initialization to
 panthor_device.c
Message-ID: <aqIFMFY-jBIZZr9X@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-7-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-7-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.982.46
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

On 26.08.2026 16:56, Boris Brezillon wrote:
> Those are per-device debugfs-files, so it makes sense to have the
> initialization logic in panthor_device.c.
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  9 +++++++++
>  drivers/gpu/drm/panthor/panthor_device.h |  4 ++++
>  drivers/gpu/drm/panthor/panthor_drv.c    | 10 +---------
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 08bb4d410941..19d3669f5ec7 100644
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
> @@ -661,3 +662,11 @@ int panthor_device_suspend(struct device *dev)
>  
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
> index a7ea475fb407..e12049961912 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -421,6 +421,10 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
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
> index 67db6701699b..3993e1a81495 100644
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

Adrian Larumbe
