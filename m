Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF680CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CD610E272;
	Thu, 15 Oct 2026 12:47:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5EF1D10E272
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:46:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC6B31516;
 Thu, 15 Oct 2026 05:46:46 -0700 (PDT)
Received: from [10.0.129.161] (e122027.cambridge.arm.com [10.0.129.161])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC0DD3F871;
 Thu, 15 Oct 2026 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792068410; bh=zDN7SNuYuh1g08zUdIuQFmX0WMNo+t2hPuwvDFZNQfs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PDu7uvLaWetg/UZzUKAIERfgfuFOap7SByK1JkadoWjk9NqTPmqn/s34e34U97MoK
 jGzvVyBXHC/pzoEHOxhKklEXiMAdO+BgHVADWNJf3Q8LmmLEn8wJ4K54laU3LzUir6
 MHwsw/CEPYnl+H+Er/7vdChxdnIflDjnUE0Qrc9U=
Message-ID: <a9cdbeb0-08f7-40d3-9f3b-8846bc641378@arm.com>
Date: Thu, 15 Oct 2026 13:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/panthor: Remove redundant
 drm_gem_create_mmap_offset() call from BO_MMAP_OFFSET ioctl
To: Akash Goel <akash.goel@arm.com>, boris.brezillon@collabora.com,
 liviu.dudau@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20261013125433.26432-1-akash.goel@arm.com>
 <20261013125433.26432-2-akash.goel@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261013125433.26432-2-akash.goel@arm.com>
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

On 13/10/2026 13:54, Akash Goel wrote:
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

Reviewed-by: Steven Price <steven.price@arm.com>

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

