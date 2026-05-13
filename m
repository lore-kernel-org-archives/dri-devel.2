Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC61CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 21:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6978510F071;
	Wed, 13 May 2026 21:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lv5PgIrR";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5071A10F071
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:12:10 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-45297094718so5821742f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778706729; x=1779311529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R9TJEllZVBVlfNRyGXAoH6FjyIcbPkUmAnCqlgQgp5k=;
 b=Lv5PgIrRM/zpPJ2VO3OweA3Zvq8Q2F2EKraINvSviVYxPSjf003TTMxGlJEWDVwDPw
 R/dJh34OJhN8gjPIsyZyxUG5tPvxtls4HuA6ATAwVoZG3c5ID8IQBUKi2pjhYZoNPyjI
 E2z51/G9eBtE78PTotmjh+uUlQa2M2Lz9VG6udSU+RjaMWl4xV+LlcnXax5nT4qBnijW
 thLYiz60oUx7zlFAt4YgdHQ9B9MWHgW7lPP8OMuvowsdTiizPitZlfSd6kr8DM6mgbzm
 Vj5uUeOYv+0Dy9dtlSh9zjOvTNYWfR9zh4sMWiBzY4/WXsAbCvnZ5Jd6eDOUUlGc5IIF
 RW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778706729; x=1779311529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R9TJEllZVBVlfNRyGXAoH6FjyIcbPkUmAnCqlgQgp5k=;
 b=k6SbKFqu1qbpV4lcWnxybrAnmqhU5ZZMh9CmwYVBCZNr/2YP3WoWa6D1jHweI2mxXv
 Y7sVpql6s+PPOItpPDadvVV0nl3IKK22O4plcGmTZ4Z4rQJKDPvKlg9mySpfVZ5P1FKL
 fpV9WQv5NbfdbV+69pqe8npzPyvuF9dnEc7STR0ZJPN3Suv6A+PUjJds1TvuYaoQlMbG
 tL98lvNWjMfe1rbEy7Y0/bDnflZefYZZINSRaQMmHKFlUYP842ys5WcmbTE64PZbXluN
 v79StmzhvzpBBG9yrxoENJqqevLaxD2qg/slzyYcihernBlVu2OivYVc29OcmzSq0bd9
 cwzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hjHzNIIMHHRcIq2o+CYMe2FzuIS44aowkG+8n4XrEY9Rd44/Y3d6JQQPsmJWLib7hJ+RsEHKrMzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8yqLDaZO6P1WGWglwxNpT9ikGn66ftWeu8QdU1HGkfplApL1F
 x4YhugAOgKUbqrB5GKyTlQg5RCkNN0Cy+Lr+MkU+sG2lYANR/FXKh6g=
X-Gm-Gg: Acq92OE4i+D8mOVOm90ivk5X2sT6ygtu55qFWksOjCoQ4hrfLl/HDF4RDUPrEjphfta
 hp5krlwBLe6oK0Nu5uneOzP3Ng89ropvqBTkJXFlYQNNjg2o6mNmDahvuGu+cVoFn575WVBmIbR
 xGRH4XxMXTaxGXbb6byaZV0/Vckzj3wAKq0fcb9XdAmgjPwEIlC5wz5rYaeJs4/AFTgoGx8+hKd
 USKqeEyEZzg0n1+VCUk/2fm367g1Wj1hfHFbWDx6exQsca7hm4G/Rla2II/0MrxvkcpJbkNoycA
 mpuCsnYjuIuo+6uusgKZPFdYllKFxPUAT9pusMg2ofyrvcTHgaVYoK1r4r6sVsx49TwOUYICvD+
 l6UtcYmg5aEb8N9o9xICq8RQgCRTWHAw76mh9TBXiFKyeGEPjc48fOt3F888Tc6Nbq4soozwQyz
 zMtd56eNJOoSyWPoBZtmb5+sCiMQgpy/VapTZO70quJbradsOM6GVFfj75REW3xjegaHYraDGak
 aWk9CEf4A==
X-Received: by 2002:a05:6000:1a8e:b0:43f:dfb6:78e1 with SMTP id
 ffacd0b85a97d-45c5859efdemr7339438f8f.8.1778706728525; 
 Wed, 13 May 2026 14:12:08 -0700 (PDT)
Received: from [192.168.1.7] (host-87-11-168-94.retail.telecomitalia.it.
 [87.11.168.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm1568446f8f.22.2026.05.13.14.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 14:12:08 -0700 (PDT)
Message-ID: <8bb75390-62be-43ce-a44b-da3eb8e35a4a@gmail.com>
Date: Wed, 13 May 2026 23:12:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/16] drm/msm: Add basic perfcntr infrastructure
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
 <20260511130017.96867-11-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <20260511130017.96867-11-robin.clark@oss.qualcomm.com>
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


On 5/11/26 14:59, Rob Clark wrote:
> Add the basic infrastructure for tracking assigned perfcntrs.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile               |   1 +
>  drivers/gpu/drm/msm/adreno/adreno_device.c |   8 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    |   5 +-
>  drivers/gpu/drm/msm/msm_drv.h              |   6 +
>  drivers/gpu/drm/msm/msm_gpu.c              |  12 ++
>  drivers/gpu/drm/msm/msm_gpu.h              |  57 +++++++++-
>  drivers/gpu/drm/msm/msm_perfcntr.c         | 124 +++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_perfcntr.h         |  23 ++++
>  8 files changed, 230 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.c
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 337634e7e247..2466cb32dac5 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -122,6 +122,7 @@ msm-y += \
>  	msm_gpu_devfreq.o \
>  	msm_io_utils.o \
>  	msm_iommu.o \
> +	msm_perfcntr.o \
>  	msm_rd.o \
>  	msm_ringbuffer.o \
>  	msm_submitqueue.o \
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index fc38331ce640..7f20320ef66a 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -307,8 +307,10 @@ MODULE_DEVICE_TABLE(of, dt_match);
>  static int adreno_runtime_resume(struct device *dev)
>  {
>  	struct msm_gpu *gpu = dev_to_gpu(dev);
> -
> -	return gpu->funcs->pm_resume(gpu);
> +	int ret = gpu->funcs->pm_resume(gpu);
> +	if (!ret)
> +		ret = msm_perfcntr_resume(gpu);
> +	return ret;
>  }
>  
>  static int adreno_runtime_suspend(struct device *dev)
> @@ -322,6 +324,8 @@ static int adreno_runtime_suspend(struct device *dev)
>  	 */
>  	WARN_ON_ONCE(gpu->active_submits);
>  
> +	msm_perfcntr_suspend(gpu);
> +
>  	return gpu->funcs->pm_suspend(gpu);
>  }
>  
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 72b71e9e44f0..ee0bcf985934 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -702,11 +702,10 @@ void adreno_recover(struct msm_gpu *gpu)
>  	struct drm_device *dev = gpu->dev;
>  	int ret;
>  
> -	// XXX pm-runtime??  we *need* the device to be off after this
> -	// so maybe continuing to call ->pm_suspend/resume() is better?
> -
> +	msm_perfcntr_suspend(gpu);
>  	gpu->funcs->pm_suspend(gpu);
>  	gpu->funcs->pm_resume(gpu);
> +	msm_perfcntr_resume(gpu);
>  
>  	ret = msm_gpu_hw_init(gpu);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index e53e4f220bed..f00b2e7aeb91 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -235,6 +235,12 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>  int msm_ioctl_vm_bind(struct drm_device *dev, void *data,
>  		      struct drm_file *file);
>  
> +int msm_perfcntr_resume(struct msm_gpu *gpu);
> +void msm_perfcntr_suspend(struct msm_gpu *gpu);
> +
> +struct msm_perfcntr_state * msm_perfcntr_init(struct msm_gpu *gpu);
> +void msm_perfcntr_cleanup(struct msm_gpu *gpu);
> +
>  #ifdef CONFIG_DEBUG_FS
>  unsigned long msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_to_scan);
>  #endif
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 1bac70473f80..bf6845e5719e 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -1028,6 +1028,17 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  
>  	refcount_set(&gpu->sysprof_active, 1);
>  
> +	mutex_init(&gpu->perfcntr_lock);
> +
> +	if (gpu->num_perfcntr_groups > 0) {
> +		gpu->perfcntrs = msm_perfcntr_init(gpu);
> +		if (IS_ERR(gpu->perfcntrs)) {
> +			ret = PTR_ERR(gpu->perfcntrs);
> +			gpu->perfcntrs = NULL;
> +			goto fail;
> +		}
> +	}
> +
>  	return 0;
>  
>  fail:
> @@ -1066,6 +1077,7 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
>  	}
>  
>  	msm_devfreq_cleanup(gpu);
> +	msm_perfcntr_cleanup(gpu);
>  
>  	platform_set_drvdata(gpu->pdev, NULL);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 19484774f369..be922641a14f 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -25,6 +25,7 @@ struct msm_gem_vm_log_entry;
>  struct msm_gpu_state;
>  struct msm_context;
>  struct msm_perfcntr_group;
> +struct msm_perfcntr_stream;
>  
>  struct msm_gpu_config {
>  	const char *ioname;
> @@ -93,6 +94,13 @@ struct msm_gpu_funcs {
>  	 */
>  	bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>  	void (*sysprof_setup)(struct msm_gpu *gpu);
> +
> +	/* Configure perfcntr SELect regs: */
> +	void (*perfcntr_configure)(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> +				   const struct msm_perfcntr_stream *stream);
> +
> +	/* Flush perfcntrs before reading (optional): */
> +	void (*perfcntr_flush)(struct msm_gpu *gpu);
>  };
>  
>  /* Additional state for iommu faults: */
> @@ -266,6 +274,11 @@ struct msm_gpu {
>  
>  	const struct msm_perfcntr_group *perfcntr_groups;
>  	unsigned num_perfcntr_groups;
> +
> +	struct msm_perfcntr_state *perfcntrs;
> +
> +	/** @perfcntr_lock: protects perfcntr related state */
> +	struct mutex perfcntr_lock;
>  };
>  
>  static inline struct msm_gpu *dev_to_gpu(struct device *dev)
> @@ -311,10 +324,52 @@ static inline bool msm_gpu_active(struct msm_gpu *gpu)
>  	return false;
>  }
>  
> +/**
> + * struct msm_perfcntr_group_state - Tracking for the currently allocated counter state
> + */
> +struct msm_perfcntr_group_state {
> +	/**
> +	 * @allocated_counters:
> +	 *
> +	 * allocated counters for global counter collection.  The
> +	 * corresponding counters are allocated from highest to
> +	 * lowest, to minimize chance of conflict with old userspace
> +	 * allocating from lowest to highest.
> +	 */
> +	unsigned allocated_counters;
> +
> +	/**
> +	 * @countables:
> +	 *
> +	 * The correspnding SELect reg values for the allocated counters
> +	 */
> +	uint32_t countables[];
> +};
> +
> +/**
> + * struct msm_perfcntr_state - overall global perfcntr state
> + */
> +struct msm_perfcntr_state {
> +	/** @stream: current global counter stream if active */
> +	struct msm_perfcntr_stream *stream;
> +
> +	/**
> +	 * @groups: Global perfcntr stream group state.
> +	 *
> +	 * Conceptually this is part of msm_perfcntr_stream state, but is
> +	 * statically pre-allocated when the gpu is initialized to simplify
> +	 * error path cleanup in PERFCNTR_CONFIG ioctl.  (__free(kfree)
> +	 * doesn't really help with variable length arrays of allocated
> +	 * pointers.)
> +	 */
> +	struct msm_perfcntr_group_state *groups[];
> +};
> +
>  static inline bool
>  msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
>  {
> -	return refcount_read(&gpu->sysprof_active) > 1;
> +	return (refcount_read(&gpu->sysprof_active) > 1) ||
> +		(gpu->perfcntrs && READ_ONCE(gpu->perfcntrs->stream));
>  }
>  
>  static inline bool
> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
> new file mode 100644
> index 000000000000..dad98c96863c
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include "msm_drv.h"
> +#include "msm_gpu.h"
> +#include "msm_perfcntr.h"
> +
> +static int
> +msm_perfcntr_resume_locked(struct msm_perfcntr_stream *stream)
> +{
> +	return 0;
> +}
> +
> +int
> +msm_perfcntr_resume(struct msm_gpu *gpu)
> +{
> +	if (!gpu->perfcntrs)
> +		return 0;
> +	guard(mutex)(&gpu->perfcntr_lock);
> +	return msm_perfcntr_resume_locked(gpu->perfcntrs->stream);
> +}
> +
> +static void
> +msm_perfcntr_suspend_locked(struct msm_perfcntr_stream *stream)
> +{
> +}
> +
> +void
> +msm_perfcntr_suspend(struct msm_gpu *gpu)
> +{
> +	if (!gpu->perfcntr_groups)
> +		return;
> +	guard(mutex)(&gpu->perfcntr_lock);
> +	msm_perfcntr_suspend_locked(gpu->perfcntrs->stream);
> +}
> +
> +/**
> + * msm_perfcntr_group_idx - map idx of perfcntr group to group_idx
> + * @stream: The global perfcntr stream
> + * @n: The requested group_idx
> + *
> + * The PERFCNTR_CONFIG ioctl requested N counters/countables per perfcntr
> + * group, but the order of groups is not required to match the order they
> + * are defined in the perfcntr tables (which is not stable/UABI, only the
> + * group names are UABI).
> + *
> + * But the order samples are returned in the stream should match the
> + * order they are requested in the PERFCNTR_CONFIG ioctl.  This helper
> + * handles the order remapping.
> + *
> + * Returns an index into gpu->perfcntr_groups[] and perfcntrs->groups[].
> + */
> +uint32_t
> +msm_perfcntr_group_idx(const struct msm_perfcntr_stream *stream, uint32_t n)
> +{
> +	WARN_ON_ONCE(n > stream->nr_groups);
> +	return stream->group_idx[n];
> +}
> +
> +/**
> + * msm_perfcntr_counter_base - get idx of the first counter in group
> + * @stream: The global perfcntr stream
> + * @group_idx: the index of the counter group
> + *
> + * For global counter collection, counters are allocated from the end
> + * (last counter) to minimize the chance of conflict with an old UMD
> + * which predates PERFCNTR_CONFIG ioctl (since UMD assigned from 0..N-1).
As is this comment seems to imply that userspace wont't be allocating from the start anymore which isn't the case.
May I suggest:
For global counter collection, counters are allocated from the end while UMD
allocates them from the start. Since UMD always allocated them from the start
it also minimizes the chance of conflict when using old UMD which predates
PERFCNTR_CONFIG ioctl.

Aside from this nit series is:
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>> + *
> + * Returns the index of first counter to use.  An index into
> + * msm_perfcntr_group::counters[].
> + */
> +uint32_t
> +msm_perfcntr_counter_base(const struct msm_perfcntr_stream *stream, uint32_t group_idx)
> +{
> +	struct msm_gpu *gpu = stream->gpu;
> +	struct msm_perfcntr_state *perfcntrs = gpu->perfcntrs;
> +	unsigned num_counters = gpu->perfcntr_groups[group_idx].num_counters;
> +	unsigned allocated_counters = perfcntrs->groups[group_idx]->allocated_counters;
> +
> +	return num_counters - allocated_counters;
> +}
> +
> +struct msm_perfcntr_state *
> +msm_perfcntr_init(struct msm_gpu *gpu)
> +{
> +	struct msm_perfcntr_state *perfcntrs;
> +	struct device *dev = &gpu->pdev->dev;
> +	size_t sz;
> +
> +	sz = struct_size(perfcntrs, groups, gpu->num_perfcntr_groups);
> +	perfcntrs = devm_kzalloc(dev, sz, GFP_KERNEL);
> +	if (!perfcntrs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (unsigned i = 0; i < gpu->num_perfcntr_groups; i++) {
> +		const struct msm_perfcntr_group *group =
> +			&gpu->perfcntr_groups[i];
> +
> +		sz = struct_size(perfcntrs->groups[i], countables, group->num_counters);
> +		perfcntrs->groups[i] = devm_kzalloc(dev, sz, GFP_KERNEL);
> +		if (!perfcntrs->groups[i]) {
> +			msm_perfcntr_cleanup(gpu);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	return perfcntrs;
> +}
> +
> +void
> +msm_perfcntr_cleanup(struct msm_gpu *gpu)
> +{
> +	struct msm_perfcntr_state *perfcntrs = gpu->perfcntrs;
> +	struct device *dev = &gpu->pdev->dev;
> +
> +	gpu->perfcntrs = NULL;
> +
> +	for (unsigned i = 0; i < gpu->num_perfcntr_groups; i++)
> +		devm_kfree(dev, perfcntrs->groups[i]);
> +
> +	devm_kfree(dev, perfcntrs);
> +}
> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.h b/drivers/gpu/drm/msm/msm_perfcntr.h
> index 7f0654182496..bfda19e01535 100644
> --- a/drivers/gpu/drm/msm/msm_perfcntr.h
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.h
> @@ -35,6 +35,29 @@ struct msm_perfcntr_group {
>     const struct msm_perfcntr_counter *counters;
>  };
>  
> +/**
> + * struct msm_perfcntr_stream - state for a single open stream fd
> + */
> +struct msm_perfcntr_stream {
> +	/** @gpu: Back-link to the GPU */
> +	struct msm_gpu *gpu;
> +
> +	/** @nr_groups: # of counter groups with enabled counters */
> +	uint32_t nr_groups;
> +
> +	/**
> +	 * @group_idx: array of nr_groups
> +	 *
> +	 * Maps the order of groups in PERFCNTR_CONFIG ioctl to group idx,
> +	 * so that results in the results stream can be ordered to match
> +	 * the ioctl call that setup the stream
> +	 */
> +	uint32_t *group_idx;
> +};
> +
> +uint32_t msm_perfcntr_group_idx(const struct msm_perfcntr_stream *stream, uint32_t n);
> +uint32_t msm_perfcntr_counter_base(const struct msm_perfcntr_stream *stream, uint32_t group_idx);
> +
>  /**
>   * struct msm_perfcntr_context_state - per-msm_context counter state
>   *

