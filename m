Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9F0CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF3310E146;
	Wed,  6 May 2026 09:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DVsaldBt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802C510E146
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778058901;
 bh=06C2qHH59OhXzqVMBdMq/suIja8tImr+yasYlUa5fI8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DVsaldBtO6Cm41DSMAvyFjU2Qn9rmDgR+Tv/wv7rF8hnNrvb5wffdwNG3nrbHUNBl
 2IW12heqWSfFUGLOoFx3+nq+LcBcolYjNeUKURcdBfh0XBCSG9nTNnpBwmORWeNpCQ
 pGAVT2ViRzhK4qj8NQopsGR8QcMwbXWDfbXliWKoxOdNJnMi7ythH4QYOMf/sZVV7q
 MLWscdAGpmjrrZIuvwG0dAwFi2SGU1hXIopcX5Et59FVo/IHPLRMt6VAyRZkbSa/fN
 Fwiqcscz2IhFU5YVzMqMpOFe0nGE1zPxHWp9mdjWJfFGgdCupCp8Y3NL3F3urgynhG
 DCAhfAb/K9/aQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CD44617E1525;
 Wed,  6 May 2026 11:15:00 +0200 (CEST)
Date: Wed, 6 May 2026 11:14:56 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 8/8] drm/panthor: Expose protected rendering features
Message-ID: <20260506111456.70721b13@fedora>
In-Reply-To: <20260505140516.1372388-9-ketil.johnsen@arm.com>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-9-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue,  5 May 2026 16:05:14 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> Add query for protected rendering capability.
> Add flag to group creation to specify need for protected rendering.
> Bump panthor version number.
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   | 21 +++++++++++-
>  drivers/gpu/drm/panthor/panthor_sched.c | 21 +++++++-----
>  include/uapi/drm/panthor_drm.h          | 45 +++++++++++++++++++++++--
>  3 files changed, 76 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 73fc983dc9b44..817df17f31f15 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -177,6 +177,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_protected_info, features), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
> @@ -928,12 +929,20 @@ static void panthor_query_group_priorities_info(struct drm_file *file,
>  	}
>  }
>  
> +static void panthor_query_protected_info(struct panthor_device *ptdev,
> +					 struct drm_panthor_protected_info *arg)
> +{
> +	arg->features =
> +		ptdev->protm.heap ? DRM_PANTHOR_PROTECTED_FEATURE_BASIC : 0;
> +}
> +
>  static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct drm_file *file)
>  {
>  	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
>  	struct drm_panthor_dev_query *args = data;
>  	struct drm_panthor_timestamp_info timestamp_info;
>  	struct drm_panthor_group_priorities_info priorities_info;
> +	struct drm_panthor_protected_info protected_info;
>  	int ret;
>  
>  	if (!args->pointer) {
> @@ -954,6 +963,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  			args->size = sizeof(priorities_info);
>  			return 0;
>  
> +		case DRM_PANTHOR_DEV_QUERY_PROTECTED_INFO:
> +			args->size = sizeof(protected_info);
> +			return 0;
> +
>  		default:
>  			return -EINVAL;
>  		}
> @@ -984,6 +997,11 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  		panthor_query_group_priorities_info(file, &priorities_info);
>  		return PANTHOR_UOBJ_SET(args->pointer, args->size, priorities_info);
>  
> +	case DRM_PANTHOR_DEV_QUERY_PROTECTED_INFO:
> +		panthor_query_protected_info(ptdev, &protected_info);
> +		return PANTHOR_UOBJ_SET(args->pointer, args->size,
> +					protected_info);
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1779,6 +1797,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>   *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
>   *       - adds drm_panthor_gpu_info::selected_coherency
>   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
> + * - 1.9 - adds DEV_QUERY_PROTECTED_INFO query

It's adding more than just DEV_QUERY_PROTECTED_INFO (it also adds a new
flags field to group_create and a flag that tells that the group intends
to use protected mode).

>   */
>  static const struct drm_driver panthor_drm_driver = {
>  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> @@ -1792,7 +1811,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.name = "panthor",
>  	.desc = "Panthor DRM driver",
>  	.major = 1,
> -	.minor = 8,
> +	.minor = 9,
>  
>  	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
>  	.gem_prime_import = panthor_gem_prime_import,
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index acb04250c7def..0e8a1059de589 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3868,6 +3868,7 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
>  }
>  
>  #define MAX_GROUPS_PER_POOL		128
> +#define GROUP_CREATE_FLAGS DRM_PANTHOR_GROUP_CREATE_PROTECTED
>  
>  int panthor_group_create(struct panthor_file *pfile,
>  			 const struct drm_panthor_group_create *group_args,
> @@ -3882,10 +3883,10 @@ int panthor_group_create(struct panthor_file *pfile,
>  	u32 gid, i, suspend_size;
>  	int ret;
>  
> -	if (group_args->pad)
> +	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
>  		return -EINVAL;
>  
> -	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
> +	if (group_args->flags & ~GROUP_CREATE_FLAGS)
>  		return -EINVAL;
>  
>  	if ((group_args->compute_core_mask & ~ptdev->gpu_info.shader_present) ||
> @@ -3937,12 +3938,16 @@ int panthor_group_create(struct panthor_file *pfile,
>  		goto err_put_group;
>  	}
>  
> -	suspend_size = csg_iface->control->protm_suspend_size;
> -	group->protm_suspend_buf = panthor_fw_alloc_protm_suspend_buf_mem(ptdev, suspend_size);
> -	if (IS_ERR(group->protm_suspend_buf)) {
> -		ret = PTR_ERR(group->protm_suspend_buf);
> -		group->protm_suspend_buf = NULL;
> -		goto err_put_group;
> +	if (group_args->flags & DRM_PANTHOR_GROUP_CREATE_PROTECTED) {
> +		suspend_size = csg_iface->control->protm_suspend_size;
> +		group->protm_suspend_buf =
> +			panthor_fw_alloc_protm_suspend_buf_mem(ptdev,
> +							       suspend_size);
> +		if (IS_ERR(group->protm_suspend_buf)) {
> +			ret = PTR_ERR(group->protm_suspend_buf);
> +			group->protm_suspend_buf = NULL;
> +			goto err_put_group;
> +		}
>  	}
>  
>  	group->syncobjs = panthor_kernel_bo_create(ptdev, group->vm,
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 0e455d91e77d4..914110003bcd1 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -253,6 +253,11 @@ enum drm_panthor_dev_query_type {
>  	 * @DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO: Query allowed group priorities information.
>  	 */
>  	DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO,
> +
> +	/**
> +	 * @DRM_PANTHOR_DEV_QUERY_PROTECTED_INFO: Query supported protected rendering information.
> +	 */
> +	DRM_PANTHOR_DEV_QUERY_PROTECTED_INFO,
>  };
>  
>  /**
> @@ -504,6 +509,28 @@ struct drm_panthor_group_priorities_info {
>  	__u8 pad[3];
>  };
>  
> +/**
> + * enum drm_panthor_protected_feature_flags - Supported protected rendering features

Protected rendering is a bit vague, especially since it's usually
referred as protected memory/content in graphics APIs. Maybe we should
have a short paragraph explaining what we mean by that (access of
protected memory from the GPU).

> + *
> + * Place new types at the end, don't re-order, don't remove or replace.
> + */
> +enum drm_panthor_protected_feature_flags {
> +	/** @DRM_PANTHOR_PROTECTED_FEATURE_BASIC: Protected rendering available */
> +	DRM_PANTHOR_PROTECTED_FEATURE_BASIC = 1 << 0,

I'm not a huge fan of this _BASIC specifier, since it doesn't
tell much about the actual implementation, and what the UMD
has to do to access protected memory from the GPU. Given the
feature/CS-instruction is named _PROTM, I'd go for

	/**
	 * @DRM_PANTHOR_PROTECTED_FEATURE_PROTM: Protected memory access
	 * based on PROTM CS instructions
	 *
	 * This is currently the only option to access protected
	 * memory from the GPU. Other modes or advanced features might
	 * be added at some point.
	 */
	DRM_PANTHOR_PROTECTED_FEATURE_PROTM = 1 << 0,
> +};
> +
> +/**
> + * struct drm_panthor_protected_info - protected support information
> + *
> + * Structure grouping all queryable information relating to the allowed group priorities.
> + */
> +struct drm_panthor_protected_info {
> +	/**
> +	 * @features: Combination of enum drm_panthor_protected_feature_flags flags.
> +	 */
> +	__u32 features;
> +};
> +
>  /**
>   * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
>   */
> @@ -843,6 +870,18 @@ enum drm_panthor_group_priority {
>  	PANTHOR_GROUP_PRIORITY_REALTIME,
>  };
>  
> +/**
> + * enum drm_panthor_group_create_flags - Group create flags
> + */
> +enum drm_panthor_group_create_flags {

s/drm_panthor_group_create_flags/drm_panthor_group_feature_flags/

> +	/**
> +	 * @DRM_PANTHOR_GROUP_CREATE_PROTECTED: Support protected mode
> +	 *
> +	 * Enable protected rendering work to be executed on this group.
> +	 */
> +	DRM_PANTHOR_GROUP_CREATE_PROTECTED = 1 << 0,

I'd go directly DRM_PANTHOR_GROUP_FEATURE_PROTM, since this is the
instruction the group will use to enter protected mode. If we ever have
multiple ways to do protected rendering, I guess it would materialize
as a different flag, allowing the KMD to know exactly the way
protected rendering is going to be done.

> +};
> +
>  /**
>   * struct drm_panthor_group_create - Arguments passed to DRM_IOCTL_PANTHOR_GROUP_CREATE
>   */
> @@ -877,8 +916,10 @@ struct drm_panthor_group_create {
>  	/** @priority: Group priority (see enum drm_panthor_group_priority). */
>  	__u8 priority;
>  
> -	/** @pad: Padding field, MBZ. */
> -	__u32 pad;
> +	/**
> +	 * @flags: Flags. Must be a combination of drm_panthor_group_create_flags flags.
> +	 */
> +	__u32 flags;
>  
>  	/**
>  	 * @compute_core_mask: Mask encoding cores that can be used for compute jobs.

