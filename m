Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72012C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5D410EB81;
	Tue, 11 Aug 2026 12:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=picoheart.com header.i=@picoheart.com header.b="qKPKT2wB";
	dkim-atps=neutral
Received: from va-2-27.ptr.blmpb.com (va-2-27.ptr.blmpb.com [209.127.231.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7381E10EB81
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1786451458; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=aRaFxfP5cQJyd0CyQHN0/SWA5n0kScYk6WSqEKPcIR8=;
 b=qKPKT2wBXEZlRbDi7hJtvAUWmhjMs1ti3pXlEXORqUQRX0UnuIihWd7OnyPaXqxSgOOBUY
 F7l9HxRsNJUPmEXuiyxOhr1YqWh7pvYD9VF20ApJLcByEc8mri34UaVWjVSDq4L5HByXiD
 PkiSu5p3v5fdgBkFFkwyF2IyJchTGtmBdHTMxV5bIRC2r9LaoUNabXcno1avk0emGVV7k4
 vfhXjBNVqYZ/PWFnDg2S+z6SH4gpT2+zC9pt6Kmv6x8EpCCFTyL/1XlHabfisExJHZHuAW
 6FCsSAdaWwPKBAOIiu6JdoCfUpHtanNTDopY27aOvx0PlcjN/enHz7bGfA3P6w==
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, 
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, 
 <thomas.hellstrom@linux.intel.com>
Content-Disposition: inline
References: <anSKZabjuhl5Ojl4@hostpc>
From: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Subject: Re: [PATCH v2] drm/pagemap: no need to recheck own pagemap in
 migrate_to_devmem
Received: from hostpc ([124.160.26.250]) by smtp.feishu.cn with ESMTPS;
 Tue, 11 Aug 2026 20:30:55 +0800
X-Lms-Return-Path: <lba+26a7b1600+c0b578+lists.freedesktop.org+liuzhaoyu.zackary@picoheart.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 11 Aug 2026 20:30:53 +0800
Message-Id: <ansV/e7ByOyzHJzM@hostpc>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
In-Reply-To: <anSKZabjuhl5Ojl4@hostpc>
Mime-Version: 1.0
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

Hi,
Could you please help review this patch?

Thanks,
zackary

On Thu, Aug 06, 2026 at 09:21:41PM +0800, Zhaoyu Liu wrote:
> The second loop in drm_pagemap_migrate_to_devmem() checks
> `page_pgmap(src_page) == pagemap && !can_migrate_same_pagemap` to skip
> pages already on the target pagemap. However, this condition is always
> false at this point: if can_migrate_same_pagemap is false and any own
> pages exist, the first loop already returns -EBUSY before reaching here.
> 
> v2:
>   - Skip the no-op migrate_vma_pages() when all pages already reside on
>     the target pagemap.
> 
> Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
> ---
>  drivers/gpu/drm/drm_pagemap.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b..64922b944092 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -698,7 +698,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  		 * nothing. Raced or unknown device pages.
>  		 */
>  		err = -EBUSY;
> -		goto err_aborted_migration;
> +		goto direct_finalize;
>  	}
>  
>  	/* Count device-private pages to migrate */
> @@ -719,19 +719,17 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  	if (own_pages == npages) {
>  		err = 0;
>  		drm_dbg(dpagemap->drm, "Migration wasn't necessary.\n");
> -		goto err_aborted_migration;
> +		goto direct_finalize;
>  	} else if (own_pages && !mdetails->can_migrate_same_pagemap) {
>  		err = -EBUSY;
>  		drm_dbg(dpagemap->drm, "Migration aborted due to fragmentation.\n");
> -		goto err_aborted_migration;
> +		goto direct_finalize;
>  	}
>  
>  	err = ops->populate_devmem_pfn(devmem_allocation, npages, migrate.dst);
>  	if (err)
>  		goto err_aborted_migration;
>  
> -	own_pages = 0;
> -
>  	for (i = 0; i < npages;) {
>  		unsigned long j;
>  		struct page *page = pfn_to_page(migrate.dst[i]);
> @@ -744,12 +742,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  			struct drm_pagemap_zdd *src_zdd =
>  				drm_pagemap_page_zone_device_data(src_page);
>  
> -			if (page_pgmap(src_page) == pagemap &&
> -			    !mdetails->can_migrate_same_pagemap) {
> -				migrate.dst[i] = 0;
> -				own_pages++;
> -				goto next;
> -			}
> +			/* Own or peer device private page */
>  			cur.dpagemap = src_zdd->dpagemap;
>  			cur.ops = src_zdd->devmem_allocation->ops;
>  			cur.device = cur.dpagemap->drm->dev;
> @@ -786,7 +779,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  			goto err_finalize;
>  		}
>  
> -next:
>  		i += NR_PAGES(order);
>  	}
>  
> @@ -797,8 +789,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  	if (err)
>  		goto err_finalize;
>  
> -	drm_WARN_ON(dpagemap->drm, !!own_pages);
> -
>  	dma_fence_put(devmem_allocation->pre_migrate_fence);
>  	devmem_allocation->pre_migrate_fence = NULL;
>  
> @@ -822,11 +812,12 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  		i += nr_pages;
>  	}
>  
> -	if (!err && migrated_pages < npages - own_pages) {
> +	if (!err && migrated_pages < npages) {
>  		drm_dbg(dpagemap->drm, "Raced while finalizing migration.\n");
>  		err = -EBUSY;
>  	}
>  
> +direct_finalize:
>  	migrate_vma_finalize(&migrate);
>  err_free:
>  	drm_pagemap_zdd_put(zdd);
> -- 
> 2.34.1
