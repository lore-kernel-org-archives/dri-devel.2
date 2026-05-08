Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1694ACD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 17:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B60510F57A;
	Fri,  8 May 2026 17:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YXUdUfzS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A77A010F57A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778261419; x=1809797419;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6RBLVHT763iWCAiYJpYG5D13YdW8r7qO5LV7VD/wqLs=;
 b=YXUdUfzSJJm5tLJ0nzAFCqmGitSHm4ENQAxaO2Td7rifzYMH9xlfI3rU
 FmyiAWa20EkSziCpPhBbcVkJlgxP0P6Snx6VH/+U1PDpolZSUPe01bhql
 s4WUXiqHn30a949AaaC4fbYvb2Pg65A82qxLzaHJTYuFH8XIczqqWlg5e
 L1sHzo45/xUOjG0IFOYqG5bV6dJiuvWc2tuzq+nGwEbo5S5hgkaK2XJ8q
 l0JvXZDT5q7H9etvz/Y7BgpS/jSCSfcXCMw6bdJUWKCnVaUrW27Exjqxq
 Z9aOeUZ1pjkbjjy1Nm4CFCEErKDz8d8Sg2B8GYjRCvhGtflFDkSPq6Kge w==;
X-CSE-ConnectionGUID: fbzAqHQ8TO2D3zeVaLXuzw==
X-CSE-MsgGUID: DvN0e6fkQfSmOQjlkF//sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="89938812"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="89938812"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 10:30:17 -0700
X-CSE-ConnectionGUID: o76zTJr+Ra+d+4BhWnyHLw==
X-CSE-MsgGUID: 7OjNYW/5Q4SD0uBTnc3hwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="235841029"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.246.20.129])
 ([10.246.20.129])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 10:30:13 -0700
Message-ID: <17c27a42-a1ec-4b7a-b6c7-ad6fb2d50df1@linux.intel.com>
Date: Fri, 8 May 2026 19:30:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Reject PRIME export of userptr BOs
To: Ziyi Guo <guoziyi114@gmail.com>, maciej.falkowski@linux.intel.com
Cc: ogabbay@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Ziyi Guo <n7l8m4@u.northwestern.edu>
References: <20260508162856.1131843-1-n7l8m4@u.northwestern.edu>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260508162856.1131843-1-n7l8m4@u.northwestern.edu>
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

On 5/8/2026 6:28 PM, Ziyi Guo wrote:
>   Userptr BOs wrap pinned user pages in a private dma-buf solely for
>   internal use by the NPU driver. Allowing userspace to re-export such a
>   BO via DRM_IOCTL_PRIME_HANDLE_TO_FD would expose those pages to other
>   drivers through an interface that was never intended to be shared.
> 
>   Override the driver's prime_handle_to_fd callback to detect dma-bufs
>   backed by ivpu_gem_userptr_dmabuf_ops and reject the export with
>   -EINVAL.
> 
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>

Hi,

Thank you for submission. Actually very similar (with the same intent)
patch was already applied:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/accel/ivpu/ivpu_drv.c?id=51d24842acb9b8d643046c71314cc3d7a846a3cf

Kind regards,
Karol


> ---
>  drivers/accel/ivpu/ivpu_drv.c         |  1 +
>  drivers/accel/ivpu/ivpu_gem.c         | 28 +++++++++++++++++++++++++++
>  drivers/accel/ivpu/ivpu_gem.h         |  3 +++
>  drivers/accel/ivpu/ivpu_gem_userptr.c |  5 +++++
>  4 files changed, 37 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 2801378e3e19..086d4c769b33 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -545,6 +545,7 @@ static const struct drm_driver driver = {
>  
>  	.gem_create_object = ivpu_gem_create_object,
>  	.gem_prime_import = ivpu_gem_prime_import,
> +	.prime_handle_to_fd = ivpu_gem_prime_handle_to_fd,
>  
>  	.ioctls = ivpu_drm_ioctls,
>  	.num_ioctls = ARRAY_SIZE(ivpu_drm_ioctls),
> diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
> index 4f2005a8d496..82079f372b39 100644
> --- a/drivers/accel/ivpu/ivpu_gem.c
> +++ b/drivers/accel/ivpu/ivpu_gem.c
> @@ -12,6 +12,7 @@
>  #include <drm/drm_cache.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_file.h>
> +#include <drm/drm_prime.h>
>  #include <drm/drm_utils.h>
>  
>  #include "ivpu_drv.h"
> @@ -249,6 +250,33 @@ struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev,
>  	return ERR_PTR(ret);
>  }
>  
> +int ivpu_gem_prime_handle_to_fd(struct drm_device *dev, struct drm_file *file_priv,
> +				u32 handle, u32 flags, int *prime_fd)
> +{
> +	struct ivpu_device *vdev = to_ivpu_device(dev);
> +	struct dma_buf *dmabuf;
> +	int fd;
> +
> +	dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	if (ivpu_gem_is_userptr_dma_buf(dmabuf)) {
> +		ivpu_dbg(vdev, IOCTL, "Exporting userptr BO is not allowed\n");
> +		dma_buf_put(dmabuf);
> +		return -EINVAL;
> +	}
> +
> +	fd = dma_buf_fd(dmabuf, flags);
> +	if (fd < 0) {
> +		dma_buf_put(dmabuf);
> +		return fd;
> +	}
> +
> +	*prime_fd = fd;
> +	return 0;
> +}
> +
>  static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 flags)
>  {
>  	struct drm_gem_shmem_object *shmem;
> diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
> index 0c3350f22b55..bfd15ce02354 100644
> --- a/drivers/accel/ivpu/ivpu_gem.h
> +++ b/drivers/accel/ivpu/ivpu_gem.h
> @@ -29,6 +29,9 @@ void ivpu_bo_unbind_all_bos_from_context(struct ivpu_device *vdev, struct ivpu_m
>  
>  struct drm_gem_object *ivpu_gem_create_object(struct drm_device *dev, size_t size);
>  struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf);
> +int ivpu_gem_prime_handle_to_fd(struct drm_device *dev, struct drm_file *file_priv,
> +				u32 handle, u32 flags, int *prime_fd);
> +bool ivpu_gem_is_userptr_dma_buf(struct dma_buf *dma_buf);
>  struct ivpu_bo *ivpu_bo_create(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx,
>  			       struct ivpu_addr_range *range, u64 size, u32 flags);
>  struct ivpu_bo *ivpu_bo_create_runtime(struct ivpu_device *vdev, u64 addr, u64 size, u32 flags);
> diff --git a/drivers/accel/ivpu/ivpu_gem_userptr.c b/drivers/accel/ivpu/ivpu_gem_userptr.c
> index 7cbf3a4cdc73..45eabea5961e 100644
> --- a/drivers/accel/ivpu/ivpu_gem_userptr.c
> +++ b/drivers/accel/ivpu/ivpu_gem_userptr.c
> @@ -61,6 +61,11 @@ static const struct dma_buf_ops ivpu_gem_userptr_dmabuf_ops = {
>  	.release = ivpu_gem_userptr_dmabuf_release,
>  };
>  
> +bool ivpu_gem_is_userptr_dma_buf(struct dma_buf *dma_buf)
> +{
> +	return dma_buf->ops == &ivpu_gem_userptr_dmabuf_ops;
> +}
> +
>  static struct dma_buf *
>  ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
>  			   size_t size, uint32_t flags)

