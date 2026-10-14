Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1408CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F0B10FCD4;
	Wed, 14 Oct 2026 10:38:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3AACF10E6D9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 10:37:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4431570
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 03:37:53 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 955953F673
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791974276; bh=/MnWgXNTxPKay1llKhn8TqQ5Q2KXZDxnnN/liLDqiSs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ii8lCZwU4jGYWsiIpVciCc4+tl/eUZngel+rbVFYcD2nSd+w0S6yPp2yZCrDa3ZIN
 PqyjsHVAgN/QzVcNd8lZSczM2jA55faB/J53gRor0cYwrVVHxIMQQK1XYY6I899j9j
 jkITds2fs1HwTQDU5nFmcdAXxgWKL7XJrfeHetok=
Date: Wed, 14 Oct 2026 11:37:53 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Akash Goel <akash.goel@arm.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH v2 2/2] drm/panthor: Remove redundant
 drm_gem_create_mmap_offset() call from BO_MMAP_OFFSET ioctl
Message-ID: <as9bgUPg8FJh2AR5@e142607>
References: <20261013125433.26432-1-akash.goel@arm.com>
 <20261013125433.26432-2-akash.goel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013125433.26432-2-akash.goel@arm.com>
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

On Tue, Oct 13, 2026 at 01:54:33PM +0100, Akash Goel wrote:
> This commit removes the call to drm_gem_create_mmap_offset() from
> the BO_MMAP_OFFSET ioctl handler. The call was redundant and didn't
> have any effect as file offset range is allocated unconditionally
> at the BO creation time.
> 
> v2:
> - New patch
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 1ca8aedd83f4..dc8d0191aef4 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1081,7 +1081,7 @@ static int panthor_ioctl_bo_mmap_offset(struct drm_device *ddev, void *data,
>  	struct drm_panthor_bo_mmap_offset *args = data;
>  	struct panthor_gem_object *bo;
>  	struct drm_gem_object *obj;
> -	int ret;
> +	int ret = 0;
>  
>  	if (args->pad)
>  		return -EINVAL;
> @@ -1096,10 +1096,6 @@ static int panthor_ioctl_bo_mmap_offset(struct drm_device *ddev, void *data,
>  		goto out;
>  	}
>  
> -	ret = drm_gem_create_mmap_offset(obj);
> -	if (ret)
> -		goto out;
> -
>  	args->offset = drm_vma_node_offset_addr(&obj->vma_node);
>  
>  out:
> -- 
> 2.25.1
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
