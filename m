Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C84FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DAFB10E76A;
	Mon, 27 Apr 2026 14:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="c6kJyxQE";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE0710E76A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777300199; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lsFsNHKLDgrducjjPO464sAo0WfGUux6ZMY8/Oir0ZDnfeLaaTcG9BZAdHEKlX12RQQbbjB6W5jNRVBKBhNq7faO7NDro+Exiia6JMvg8r8EZR07yxZNk3AQMSVIZ6uKZKU0GbMfbKweylqMLLGD1a1XBuZhONod9bhRNuQnKbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777300199;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uwZnq5EJnn++su2XsJpns3YMuRt2+EKtTUYS5NgkxfE=; 
 b=nuUpy7ysNw3WB5wNLHuZ30z1lCbyao9+qFNhkU9fqRwWaE7o89vq6vot8NUwLMFQv0tWHrKQH+1N4fF2jcfl/xzLIdUDpJK96Cj6HpFjOYDiAzFaZ67XJmGJ19dceqYOPzs90IZeif9YTUSEC/y1FqqHamzYJY2czshZrYEyBEs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777300199; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=uwZnq5EJnn++su2XsJpns3YMuRt2+EKtTUYS5NgkxfE=;
 b=c6kJyxQEawrM0MUui/tBv1/NtfxgbXnvYP69eRerPyIVSZFtKOxiR1FfUmXO+zr6
 7YqSZNEypfUI8SM82UNWRDvKyNKObUj78Dr6H9PXjbJtlD4OVpydxy2WitnCxPNwelA
 ruNTz236x6ie8O6Qm+/j5C2GXVxj50v3As4IHs08=
Received: by mx.zohomail.com with SMTPS id 1777300197909285.0489425341178;
 Mon, 27 Apr 2026 07:29:57 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:29:53 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v9 1/6] drm/panthor: Expose GPU page sizes to UM
Message-ID: <ae9yp93D1wY7jBDZ@sobremesa>
References: <20260422122538.3117380-1-adrian.larumbe@collabora.com>
 <20260422122538.3117380-2-adrian.larumbe@collabora.com>
 <dc262035-1147-4fbc-8140-10176e43b8bc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc262035-1147-4fbc-8140-10176e43b8bc@arm.com>
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

On 24.04.2026 14:18, Steven Price wrote:
> On 22/04/2026 13:25, Adrián Larumbe wrote:
> > In future commits that will implement repeated mappings, only repeat
> > values multiple of GPU page sizes will be tolerated. That means these
> > values must be made known to UM. Do it through a queriable GPU info
> > value.
> >
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_device.h |  3 +++
> >  drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
> >  drivers/gpu/drm/panthor/panthor_mmu.c    |  9 ++++++++-
> >  include/uapi/drm/panthor_drm.h           | 13 +++++++++++++
> >  4 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> > index 5cba272f9b4d..d856a4fe1d61 100644
> > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > @@ -158,6 +158,9 @@ struct panthor_device {
> >  	/** @csif_info: Command stream interface information. */
> >  	struct drm_panthor_csif_info csif_info;
> >
> > +	/** @mmu_info: MMU info */
> > +	struct drm_panthor_mmu_info mmu_info;
> > +
> >  	/** @hw: GPU-specific data. */
> >  	struct panthor_hw *hw;
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> > index 73fc983dc9b4..a8090bc4e33c 100644
> > --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > @@ -175,6 +175,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
> >  	_Generic(_obj_name, \
> >  		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
> >  		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
> > +		 PANTHOR_UOBJ_DECL(struct drm_panthor_mmu_info, page_size_bitmap), \
> >  		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
> >  		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
> >  		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
> > @@ -946,6 +947,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
> >  			args->size = sizeof(ptdev->csif_info);
> >  			return 0;
> >
> > +		case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
> > +			args->size = sizeof(ptdev->mmu_info);
> > +			return 0;
> > +
> >  		case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
> >  			args->size = sizeof(timestamp_info);
> >  			return 0;
> > @@ -966,6 +971,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
> >  	case DRM_PANTHOR_DEV_QUERY_CSIF_INFO:
> >  		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
> >
> > +	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
> > +		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
> > +
> >  	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
> >  		ret = copy_struct_from_user(&timestamp_info,
> >  					    sizeof(timestamp_info),
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index fa8b31df85c9..dad56a01c597 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -2750,7 +2750,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
> >  	refcount_set(&vm->as.active_cnt, 0);
> >
> >  	pgtbl_cfg = (struct io_pgtable_cfg) {
> > -		.pgsize_bitmap	= SZ_4K | SZ_2M,
> > +		.pgsize_bitmap	= ptdev->mmu_info.page_size_bitmap,
> >  		.ias		= va_bits,
> >  		.oas		= pa_bits,
> >  		.coherent_walk	= ptdev->coherent,
> > @@ -3195,6 +3195,11 @@ static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
> >  	destroy_workqueue(res);
> >  }
> >
> > +static void panthor_mmu_info_init(struct panthor_device *ptdev)
> > +{
> > +	ptdev->mmu_info.page_size_bitmap = SZ_4K | SZ_2M;
> > +}
> > +
> >  /**
> >   * panthor_mmu_init() - Initialize the MMU logic.
> >   * @ptdev: Device.
> > @@ -3207,6 +3212,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
> >  	struct panthor_mmu *mmu;
> >  	int ret, irq;
> >
> > +	panthor_mmu_info_init(ptdev);
> > +
> >  	mmu = drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
> >  	if (!mmu)
> >  		return -ENOMEM;
> > diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> > index 0e455d91e77d..dc2704fc2829 100644
> > --- a/include/uapi/drm/panthor_drm.h
> > +++ b/include/uapi/drm/panthor_drm.h
> > @@ -246,6 +246,9 @@ enum drm_panthor_dev_query_type {
> >  	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface information. */
> >  	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
> >
> > +	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
> > +	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
> > +
>
> This is why I dislike enums... there's a comment above this:
>
> > /**
> >  * enum drm_panthor_dev_query_type - Query type
> >  *
> >  * Place new types at the end, don't re-order, don't remove or replace.
> >  */
>
> As it says - you need to place new types at the end, otherwise it
> changes the values for existing types (i.e. QUERY_TIMESTAMP_INFO below
> ends up with a new value).
>
> otherwise this will break old user space.

Thanks for catching this, it had completely escaped me.

> thanks,
> Steve
>
> >  	/** @DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO: Query timestamp information. */
> >  	DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO,
> >
> > @@ -487,6 +490,16 @@ struct drm_panthor_timestamp_info {
> >  	__u64 cpu_timestamp_nsec;
> >  };
> >
> > +/**
> > + * struct drm_panthor_mmu_info - MMU information
> > + *
> > + * Structure grouping all queryable information relating to the MMU.
> > + */
> > +struct drm_panthor_mmu_info {
> > +	/** @page_size_bitmap: Allowed page sizes */
> > +	__u64 page_size_bitmap;
> > +};
> > +
> >  /**
> >   * struct drm_panthor_group_priorities_info - Group priorities information
> >   *

Adrian Larumbe
