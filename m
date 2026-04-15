Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA57F43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF91A10E6FD;
	Wed, 15 Apr 2026 15:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Gz5vD7Oy";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B725D10E6FD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:19:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58FF446FC;
 Wed, 15 Apr 2026 08:19:35 -0700 (PDT)
Received: from [10.57.61.136] (unknown [10.57.61.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40B2B3F7B4;
 Wed, 15 Apr 2026 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776266380; bh=7B3x1d4RReA0svAtmZoCpTUMjRFPipXfe51+HKmAGGQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Gz5vD7OyqU+sDgAI11A59mF7zyJGIJyR9YLypCfMPwgf3mZiIy5xgchJJ9I7IVEJY
 SOrKXBb5Bqed/D1kA+2OpCAhpX7AV/TSfAgx7hZWKYQs0gRfBxo4Cwu6oeXxFuiOOk
 Klhcfm97FpZiyQIUX1bgBTKoFng4HTwK+xQ3abyQ=
Message-ID: <edb5705c-f5f1-4676-8269-76e58cdeb50b@arm.com>
Date: Wed, 15 Apr 2026 16:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] drm/panthor: Expose GPU page sizes to UM
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-2-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260415112900.681834-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 15/04/2026 12:28, Adrián Larumbe wrote:
> In future commits that will implement repeated mappings, only repeat
> values multiple of GPU page sizes will be tolerated. That means these
> values must be made known to UM. Do it through a queriable GPU info
> value.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.h |  3 +++
>  drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  9 ++++++++-
>  include/uapi/drm/panthor_drm.h           | 13 +++++++++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 5cba272f9b4d..d856a4fe1d61 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -158,6 +158,9 @@ struct panthor_device {
>  	/** @csif_info: Command stream interface information. */
>  	struct drm_panthor_csif_info csif_info;
>  
> +	/** @mmu_info: MMU info */
> +	struct drm_panthor_mmu_info mmu_info;
> +
>  	/** @hw: GPU-specific data. */
>  	struct panthor_hw *hw;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 73fc983dc9b4..a8090bc4e33c 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -175,6 +175,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  	_Generic(_obj_name, \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_mmu_info, page_size_bitmap), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
> @@ -946,6 +947,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  			args->size = sizeof(ptdev->csif_info);
>  			return 0;
>  
> +		case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
> +			args->size = sizeof(ptdev->mmu_info);
> +			return 0;
> +
>  		case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
>  			args->size = sizeof(timestamp_info);
>  			return 0;
> @@ -966,6 +971,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  	case DRM_PANTHOR_DEV_QUERY_CSIF_INFO:
>  		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
>  
> +	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
> +		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
> +
>  	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
>  		ret = copy_struct_from_user(&timestamp_info,
>  					    sizeof(timestamp_info),
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index bd41c892beb7..01577be88933 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2769,7 +2769,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
>  	refcount_set(&vm->as.active_cnt, 0);
>  
>  	pgtbl_cfg = (struct io_pgtable_cfg) {
> -		.pgsize_bitmap	= SZ_4K | SZ_2M,
> +		.pgsize_bitmap	= ptdev->mmu_info.page_size_bitmap,
>  		.ias		= va_bits,
>  		.oas		= pa_bits,
>  		.coherent_walk	= ptdev->coherent,
> @@ -3214,6 +3214,11 @@ static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
>  	destroy_workqueue(res);
>  }
>  
> +static void panthor_mmu_info_init(struct panthor_device *ptdev)
> +{
> +	ptdev->mmu_info.page_size_bitmap = SZ_4K | SZ_2M;
> +}
> +
>  /**
>   * panthor_mmu_init() - Initialize the MMU logic.
>   * @ptdev: Device.
> @@ -3226,6 +3231,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	struct panthor_mmu *mmu;
>  	int ret, irq;
>  
> +	panthor_mmu_info_init(ptdev);
> +
>  	mmu = drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
>  	if (!mmu)
>  		return -ENOMEM;
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 0e455d91e77d..dc2704fc2829 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -246,6 +246,9 @@ enum drm_panthor_dev_query_type {
>  	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface information. */
>  	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
>  
> +	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
> +	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
> +
>  	/** @DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO: Query timestamp information. */
>  	DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO,
>  
> @@ -487,6 +490,16 @@ struct drm_panthor_timestamp_info {
>  	__u64 cpu_timestamp_nsec;
>  };
>  
> +/**
> + * struct drm_panthor_mmu_info - MMU information
> + *
> + * Structure grouping all queryable information relating to the MMU.
> + */
> +struct drm_panthor_mmu_info {
> +	/** @page_size_bitmap: Allowed page sizes */
> +	__u64 page_size_bitmap;
> +};
> +
>  /**
>   * struct drm_panthor_group_priorities_info - Group priorities information
>   *

