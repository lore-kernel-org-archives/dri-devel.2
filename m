Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5077AF419A4
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC07D10E226;
	Wed, 15 Apr 2026 13:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dbH/HisP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3560B10E226
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776258618;
 bh=3GVMTIzOAz5VDJleaYw4BrAw2svn2De6ZgUg6RNAFWg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dbH/HisPEdrFCHPNaE2zye0RV2q7leFnjp90oX5lEN3izHTdueZeTdkEQFDYmCj9Q
 9hrv0A0DwAXZcR1djBAjy8UkXZJ25k2VMO189FvAAUp7djw3MBmKZYCOTNuyDm+iwo
 e10dpv23eCjFu6gkX7I9Cs44toeSCAxoapPZ4h+hZh6dYatjV7mv34lLq+bKhplUj8
 qvmw/6zrL22/1zi3c/iNWioxIgRi5a8bVB/4GnJ3oaOzsTKqij+3M54JdIray6ATIv
 aRP/t/9uxhevX4h+7evp9dMZYqpbmvAUM9PHtSf7XMkpGppGt1oeqMh59ag5eqY7jB
 8ETi88o/38FHg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BC3117E1356;
 Wed, 15 Apr 2026 15:10:18 +0200 (CEST)
Date: Wed, 15 Apr 2026 15:10:13 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v7 1/6] drm/panthor: Expose GPU page sizes to UM
Message-ID: <20260415151013.4d9c6bb0@fedora>
In-Reply-To: <20260415112900.681834-2-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-2-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 15 Apr 2026 12:28:45 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> In future commits that will implement repeated mappings, only repeat
> values multiple of GPU page sizes will be tolerated. That means these
> values must be made known to UM. Do it through a queriable GPU info
> value.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.h |  3 +++
>  drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  9 ++++++++-
>  include/uapi/drm/panthor_drm.h           | 13 +++++++++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 5cba272f9b4d..d856a4fe1d61 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -158,6 +158,9 @@ struct panthor_device {
>  	/** @csif_info: Command stream interface information. */
>  	struct drm_panthor_csif_info csif_info;
> =20
> +	/** @mmu_info: MMU info */
> +	struct drm_panthor_mmu_info mmu_info;
> +
>  	/** @hw: GPU-specific data. */
>  	struct panthor_hw *hw;
> =20
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index 73fc983dc9b4..a8090bc4e33c 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -175,6 +175,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_a=
rray *in, u32 min_stride,
>  	_Generic(_obj_name, \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_mmu_info, page_size_bitmap), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestam=
p), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
> @@ -946,6 +947,10 @@ static int panthor_ioctl_dev_query(struct drm_device=
 *ddev, void *data, struct d
>  			args->size =3D sizeof(ptdev->csif_info);
>  			return 0;
> =20
> +		case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
> +			args->size =3D sizeof(ptdev->mmu_info);
> +			return 0;
> +
>  		case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
>  			args->size =3D sizeof(timestamp_info);
>  			return 0;
> @@ -966,6 +971,9 @@ static int panthor_ioctl_dev_query(struct drm_device =
*ddev, void *data, struct d
>  	case DRM_PANTHOR_DEV_QUERY_CSIF_INFO:
>  		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
> =20
> +	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
> +		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
> +
>  	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
>  		ret =3D copy_struct_from_user(&timestamp_info,
>  					    sizeof(timestamp_info),
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index bd41c892beb7..01577be88933 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2769,7 +2769,7 @@ panthor_vm_create(struct panthor_device *ptdev, boo=
l for_mcu,
>  	refcount_set(&vm->as.active_cnt, 0);
> =20
>  	pgtbl_cfg =3D (struct io_pgtable_cfg) {
> -		.pgsize_bitmap	=3D SZ_4K | SZ_2M,
> +		.pgsize_bitmap	=3D ptdev->mmu_info.page_size_bitmap,
>  		.ias		=3D va_bits,
>  		.oas		=3D pa_bits,
>  		.coherent_walk	=3D ptdev->coherent,
> @@ -3214,6 +3214,11 @@ static void panthor_mmu_release_wq(struct drm_devi=
ce *ddev, void *res)
>  	destroy_workqueue(res);
>  }
> =20
> +static void panthor_mmu_info_init(struct panthor_device *ptdev)
> +{
> +	ptdev->mmu_info.page_size_bitmap =3D SZ_4K | SZ_2M;
> +}
> +
>  /**
>   * panthor_mmu_init() - Initialize the MMU logic.
>   * @ptdev: Device.
> @@ -3226,6 +3231,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	struct panthor_mmu *mmu;
>  	int ret, irq;
> =20
> +	panthor_mmu_info_init(ptdev);
> +
>  	mmu =3D drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
>  	if (!mmu)
>  		return -ENOMEM;
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_dr=
m.h
> index 0e455d91e77d..dc2704fc2829 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -246,6 +246,9 @@ enum drm_panthor_dev_query_type {
>  	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface in=
formation. */
>  	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
> =20
> +	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
> +	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
> +
>  	/** @DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO: Query timestamp information.=
 */
>  	DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO,
> =20
> @@ -487,6 +490,16 @@ struct drm_panthor_timestamp_info {
>  	__u64 cpu_timestamp_nsec;
>  };
> =20
> +/**
> + * struct drm_panthor_mmu_info - MMU information
> + *
> + * Structure grouping all queryable information relating to the MMU.
> + */
> +struct drm_panthor_mmu_info {
> +	/** @page_size_bitmap: Allowed page sizes */

Maybe add more info there: like, page size is a power of two, and each
bit encodes a particular page size.

> +	__u64 page_size_bitmap;
> +};
> +
>  /**
>   * struct drm_panthor_group_priorities_info - Group priorities informati=
on
>   *

