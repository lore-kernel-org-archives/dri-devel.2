Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04832CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 09:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 487AC10E4FB;
	Mon, 11 May 2026 09:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NTGQztaf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D395110E4FB
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778490268; x=1810026268;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1hHtE+qiixejcQON712uNfesppDbsdiUfLRUqiVc6aI=;
 b=NTGQztafJFJg6Xs9i9+pSkxX4k3aFYEGr/0yXk9/BBgBTBPenkKrjvdT
 G46ar7oIEVh1H3d2UmIBk8I58HJu7HkI/siehTfkWWAJdn83w496cJhb7
 QfbxxoF6df45kfQs0sAgdAFJFirI3vKYyrSh8IyPSFxe03n8MHInrcGV8
 ZoPcQCmy74/ik2Iw8gh0m8ISDF5pBKWFXTRosqIvbfux306HyDNz1tffd
 QjK+VDwCPfNY1JUZ6wS1Gu7u87xIfQWQHPbrs6IZxaj15ih9vhXT/+hUb
 ykLfQM1smcl61yqXtVOm5ZBMkglhuLj2TE3BY6UxQFh5IbCDjvXRknmgr g==;
X-CSE-ConnectionGUID: XdqQGVYiSLW3yWpPuw7IpQ==
X-CSE-MsgGUID: a8Vb1Pr4QmiMjLtf4diwpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="89676599"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="89676599"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:04:27 -0700
X-CSE-ConnectionGUID: 1jP2xWNfQPCQ5XZKIGqUtg==
X-CSE-MsgGUID: U9GJ5rlqTfOIW8tFirLliw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="241372324"
Received: from unknown (HELO [10.102.88.33]) ([10.102.88.33])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:04:23 -0700
Message-ID: <0097f608-dbac-482d-9851-ce306b0c7b78@linux.intel.com>
Date: Mon, 11 May 2026 11:04:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Reject PRIME export of userptr BOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ziyi Guo <guoziyi114@gmail.com>, maciej.falkowski@linux.intel.com,
 jacek.lawrynowicz@linux.intel.com
Cc: ogabbay@kernel.org, sumit.semwal@linaro.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Ziyi Guo <n7l8m4@u.northwestern.edu>
References: <20260508162856.1131843-1-n7l8m4@u.northwestern.edu>
 <14b62cee-c46e-4fb9-91ab-aa09c0962834@amd.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <14b62cee-c46e-4fb9-91ab-aa09c0962834@amd.com>
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

On 5/11/2026 9:39 AM, Christian König wrote:
> Hi Zivi,
> 
> On 5/8/26 18:28, Ziyi Guo wrote:
>>   Userptr BOs wrap pinned user pages in a private dma-buf solely for
>>   internal use by the NPU driver. Allowing userspace to re-export such a
>>   BO via DRM_IOCTL_PRIME_HANDLE_TO_FD would expose those pages to other
>>   drivers through an interface that was never intended to be shared.
>>
>>   Override the driver's prime_handle_to_fd callback to detect dma-bufs
>>   backed by ivpu_gem_userptr_dmabuf_ops and reject the export with
>>   -EINVAL.
>>
>> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> 

Hi Christian

> first of all thanks a lot for pointing that out! The patch which orginally added that somehow slipped through the cracks.
> 
> Then @Karol and @Jacek, using DMA-buf like that is a pretty big NO-GO from the DMA-buf side!
> 
> Using page which you don't own (especially file system backend ones) in a DMA-buf is absolutely *NOT* something you can do.
> 
> I hope that it is not the case here, but if you also allow to mmap() them then you have create a massive security problem which can lead to random file system corruptions.

This is not allowed, ivpu userpointer dma_buf_ops have no .mmap handler,
this results in -EINVAL when invoked.

Regards,
Karol

> 
> Regards,
> Christian.
> 
>> ---
>>  drivers/accel/ivpu/ivpu_drv.c         |  1 +
>>  drivers/accel/ivpu/ivpu_gem.c         | 28 +++++++++++++++++++++++++++
>>  drivers/accel/ivpu/ivpu_gem.h         |  3 +++
>>  drivers/accel/ivpu/ivpu_gem_userptr.c |  5 +++++
>>  4 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
>> index 2801378e3e19..086d4c769b33 100644
>> --- a/drivers/accel/ivpu/ivpu_drv.c
>> +++ b/drivers/accel/ivpu/ivpu_drv.c
>> @@ -545,6 +545,7 @@ static const struct drm_driver driver = {
>>
>>         .gem_create_object = ivpu_gem_create_object,
>>         .gem_prime_import = ivpu_gem_prime_import,
>> +       .prime_handle_to_fd = ivpu_gem_prime_handle_to_fd,
>>
>>         .ioctls = ivpu_drm_ioctls,
>>         .num_ioctls = ARRAY_SIZE(ivpu_drm_ioctls),
>> diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
>> index 4f2005a8d496..82079f372b39 100644
>> --- a/drivers/accel/ivpu/ivpu_gem.c
>> +++ b/drivers/accel/ivpu/ivpu_gem.c
>> @@ -12,6 +12,7 @@
>>  #include <drm/drm_cache.h>
>>  #include <drm/drm_debugfs.h>
>>  #include <drm/drm_file.h>
>> +#include <drm/drm_prime.h>
>>  #include <drm/drm_utils.h>
>>
>>  #include "ivpu_drv.h"
>> @@ -249,6 +250,33 @@ struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev,
>>         return ERR_PTR(ret);
>>  }
>>
>> +int ivpu_gem_prime_handle_to_fd(struct drm_device *dev, struct drm_file *file_priv,
>> +                               u32 handle, u32 flags, int *prime_fd)
>> +{
>> +       struct ivpu_device *vdev = to_ivpu_device(dev);
>> +       struct dma_buf *dmabuf;
>> +       int fd;
>> +
>> +       dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
>> +       if (IS_ERR(dmabuf))
>> +               return PTR_ERR(dmabuf);
>> +
>> +       if (ivpu_gem_is_userptr_dma_buf(dmabuf)) {
>> +               ivpu_dbg(vdev, IOCTL, "Exporting userptr BO is not allowed\n");
>> +               dma_buf_put(dmabuf);
>> +               return -EINVAL;
>> +       }
>> +
>> +       fd = dma_buf_fd(dmabuf, flags);
>> +       if (fd < 0) {
>> +               dma_buf_put(dmabuf);
>> +               return fd;
>> +       }
>> +
>> +       *prime_fd = fd;
>> +       return 0;
>> +}
>> +
>>  static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 flags)
>>  {
>>         struct drm_gem_shmem_object *shmem;
>> diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
>> index 0c3350f22b55..bfd15ce02354 100644
>> --- a/drivers/accel/ivpu/ivpu_gem.h
>> +++ b/drivers/accel/ivpu/ivpu_gem.h
>> @@ -29,6 +29,9 @@ void ivpu_bo_unbind_all_bos_from_context(struct ivpu_device *vdev, struct ivpu_m
>>
>>  struct drm_gem_object *ivpu_gem_create_object(struct drm_device *dev, size_t size);
>>  struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf);
>> +int ivpu_gem_prime_handle_to_fd(struct drm_device *dev, struct drm_file *file_priv,
>> +                               u32 handle, u32 flags, int *prime_fd);
>> +bool ivpu_gem_is_userptr_dma_buf(struct dma_buf *dma_buf);
>>  struct ivpu_bo *ivpu_bo_create(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx,
>>                                struct ivpu_addr_range *range, u64 size, u32 flags);
>>  struct ivpu_bo *ivpu_bo_create_runtime(struct ivpu_device *vdev, u64 addr, u64 size, u32 flags);
>> diff --git a/drivers/accel/ivpu/ivpu_gem_userptr.c b/drivers/accel/ivpu/ivpu_gem_userptr.c
>> index 7cbf3a4cdc73..45eabea5961e 100644
>> --- a/drivers/accel/ivpu/ivpu_gem_userptr.c
>> +++ b/drivers/accel/ivpu/ivpu_gem_userptr.c
>> @@ -61,6 +61,11 @@ static const struct dma_buf_ops ivpu_gem_userptr_dmabuf_ops = {
>>         .release = ivpu_gem_userptr_dmabuf_release,
>>  };
>>
>> +bool ivpu_gem_is_userptr_dma_buf(struct dma_buf *dma_buf)
>> +{
>> +       return dma_buf->ops == &ivpu_gem_userptr_dmabuf_ops;
>> +}
>> +
>>  static struct dma_buf *
>>  ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
>>                            size_t size, uint32_t flags)
>> --
>> 2.34.1
>>
> 

