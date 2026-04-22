Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C481F9B617
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0BE410E0A3;
	Wed, 22 Apr 2026 10:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="k4ZHEJ0x";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5902810E0A3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:49:59 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-ba6838e76f2so448072166b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1776854998; x=1777459798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V8jo+eXQKHxt4pR8E+RE1xea7eDUNRLe+aHpb5aFbRA=;
 b=k4ZHEJ0xbe+fTUZrB9HGrnIaz30qzMIeTHCo/gjMF0pw7Bzrtf1r8AFG4C5/LcXY/I
 erHzHGXST+jaY8kjvrOLMLGl/i4U8JfQ9GE4XMpz3IrC1uhSyeIL4srPzKo8/Pd1+IrX
 y/SWCqMOD9sWSsct+6Sw257sP1FpMHooEdhKGSIPhqkLsgrq/wkv4j3XL378O+Li/CEg
 mjo6xSSyU2mm0ZTDJ03n2EjLwQtr+eR/GB5y+TWfSII5igL6FS9LbOBtUZ1/+gR1nj5r
 j4WA8hLMddZHwvrex1ikTj2uCyzyQy01nDismCImpUtZVx2APCIYXJr0mtCYJz9wfVkc
 us+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776854998; x=1777459798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V8jo+eXQKHxt4pR8E+RE1xea7eDUNRLe+aHpb5aFbRA=;
 b=fU/bJgA2H345Cgx1AUwTUsr76oKBqBU/Ak4gyRzPEmlZIGW4in4pljqNAVjnmcx5gf
 MPfEp+kWeJpSMFgPhwPJ8SbrbFPXSjT6OApidHmXZiNa6UU23XKvdL4NeLUJtJgxafOI
 You7FiDBzZYjXeo5k1K84Fmz25oRfDF3mbIXBjZWtZGd06Av1/g0Iv21Fyjf4tvkhXE2
 Ose5tS3yEamOpTonHnbQf+4AKX0RDpMsxFoAdDnsGaUDPl8R4rdxqXfuFpFbrrisSmUm
 u9m2YThyBL/V5GMIaRf0PqneaECe+edBuOhWCOQ039KkHR0viiCMFqeHRB+K1s+C5th1
 pOiA==
X-Gm-Message-State: AOJu0YzK+XgKUU9GVAQr6duAqTNHQzEDChS16KDk/iZrRdq0IsiOQb/f
 y1nZX0jlUFpRMw28x4n9KswHL/FrZ3hsB53cEG6qWmCVY3wGsN+/62Y8PAZ0MQtVkA4=
X-Gm-Gg: AeBDieshwgujMvqSxeU2xs7lqZlur2NVoQvMGduqH3WPeHGcLIRGb14fqsn3Qsg9Eqa
 /c1gmvNFYchhH6JSDryRHOM+U3NqU9XWLUF1sLmTkcwcK5gApYMX0VH1koWOW2esWubzo3YtsaV
 jr7UrnUI4qiGD0Crb6owjDerho8fKY4QDDxGrrNYsxhrCrMA1gsumJTJI6HSdn3pskpV0sXvA18
 FtpmJIMLCC/OnBn7Y1/WSr3WXXqmj3hArjycjQBDkDQ77DyoTU5C5VJN1y/+i74HzvT9tmr7oux
 hIlbms1KdxWYsaPs/qMr+sfZ6UPgv0cjs3BIpvN3zfZZ9xXe7Xm3p6HIv28w5eqlZBPT3YGPQrw
 ZXy1b/+4FcotRMK4gxdVP34PQ5+0C4RJ/0fe5MAmssO9OL+Nk12boj8w61fVqBTbJdP6y08tsLM
 p3/TUMGaj14qOwhasTuj30KGelPlUBN+DaFyjPmVqxLo6spCEPfjtqOgOcd4g5Ps4z0w==
X-Received: by 2002:a17:907:934c:b0:ba5:4f56:69a2 with SMTP id
 a640c23a62f3a-ba54f566b33mr858200866b.13.1776854997330; 
 Wed, 22 Apr 2026 03:49:57 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba454d1b694sm532372966b.29.2026.04.22.03.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 03:49:56 -0700 (PDT)
Message-ID: <096a34ce-fb73-4d56-81b4-aa6a0342c322@ursulin.net>
Date: Wed, 22 Apr 2026 11:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-buf/dma_fence_array: remove unused functionality
 v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260422103012.1647-1-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260422103012.1647-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 22/04/2026 11:30, Christian König wrote:
> Amdgpu was the only user of the signal on any feature and we dropped
> that use case recently, so we can remove that functionality.
> 
> v2: update num_pending only after the fence is signaled
> v3: separate out simplifying dma_fence_array implementation
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence-array.c              | 13 ++++---------
>   drivers/dma-buf/dma-fence-unwrap.c             |  3 +--
>   drivers/dma-buf/dma-resv.c                     |  3 +--
>   drivers/dma-buf/st-dma-fence-unwrap.c          |  2 +-
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |  3 +--
>   drivers/gpu/drm/xe/xe_sync.c                   |  2 +-
>   drivers/gpu/drm/xe/xe_vm.c                     |  4 ++--
>   include/linux/dma-fence-array.h                |  6 ++----
>   8 files changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
> index 089f69469524..5e10e8df372f 100644
> --- a/drivers/dma-buf/dma-fence-array.c
> +++ b/drivers/dma-buf/dma-fence-array.c
> @@ -190,15 +190,13 @@ EXPORT_SYMBOL(dma_fence_array_alloc);
>    * @fences:		[in]	array containing the fences
>    * @context:		[in]	fence context to use
>    * @seqno:		[in]	sequence number to use
> - * @signal_on_any:	[in]	signal on any fence in the array
>    *
>    * Implementation of @dma_fence_array_create without allocation. Useful to init
>    * a preallocated dma fence array in the path of reclaim or dma fence signaling.
>    */
>   void dma_fence_array_init(struct dma_fence_array *array,
>   			  int num_fences, struct dma_fence **fences,
> -			  u64 context, unsigned seqno,
> -			  bool signal_on_any)
> +			  u64 context, unsigned seqno)
>   {
>   	static struct lock_class_key dma_fence_array_lock_key;
>   
> @@ -222,7 +220,7 @@ void dma_fence_array_init(struct dma_fence_array *array,
>   	 */
>   	lockdep_set_class(&array->base.inline_lock, &dma_fence_array_lock_key);
>   
> -	atomic_set(&array->num_pending, signal_on_any ? 1 : num_fences);
> +	atomic_set(&array->num_pending, num_fences);
>   	array->fences = fences;
>   
>   	array->base.error = PENDING_ERROR;
> @@ -249,7 +247,6 @@ EXPORT_SYMBOL(dma_fence_array_init);
>    * @fences:		[in]	array containing the fences
>    * @context:		[in]	fence context to use
>    * @seqno:		[in]	sequence number to use
> - * @signal_on_any:	[in]	signal on any fence in the array
>    *
>    * Allocate a dma_fence_array object and initialize the base fence with
>    * dma_fence_init().
> @@ -264,8 +261,7 @@ EXPORT_SYMBOL(dma_fence_array_init);
>    */
>   struct dma_fence_array *dma_fence_array_create(int num_fences,
>   					       struct dma_fence **fences,
> -					       u64 context, unsigned seqno,
> -					       bool signal_on_any)
> +					       u64 context, unsigned seqno)
>   {
>   	struct dma_fence_array *array;
>   
> @@ -273,8 +269,7 @@ struct dma_fence_array *dma_fence_array_create(int num_fences,
>   	if (!array)
>   		return NULL;
>   
> -	dma_fence_array_init(array, num_fences, fences,
> -			     context, seqno, signal_on_any);
> +	dma_fence_array_init(array, num_fences, fences, context, seqno);
>   
>   	return array;
>   }
> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
> index 07fe9bf45aea..53bb40e70b27 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -180,8 +180,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>   
>   	if (count > 1) {
>   		result = dma_fence_array_create(count, array,
> -						dma_fence_context_alloc(1),
> -						1, false);
> +						dma_fence_context_alloc(1), 1);
>   		if (!result) {
>   			for (i = 0; i < count; i++)
>   				dma_fence_put(array[i]);
> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index ce9e6c04897f..39a92d9f2413 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -648,8 +648,7 @@ int dma_resv_get_singleton(struct dma_resv *obj, enum dma_resv_usage usage,
>   	}
>   
>   	array = dma_fence_array_create(count, fences,
> -				       dma_fence_context_alloc(1),
> -				       1, false);
> +				       dma_fence_context_alloc(1), 1);
>   	if (!array) {
>   		while (count--)
>   			dma_fence_put(fences[count]);
> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
> index 51c87869b7b8..4e7ee25372ba 100644
> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
> @@ -64,7 +64,7 @@ static struct dma_fence *mock_array(unsigned int num_fences, ...)
>   
>   	array = dma_fence_array_create(num_fences, fences,
>   				       dma_fence_context_alloc(1),
> -				       1, false);
> +				       1);
>   	if (!array)
>   		goto error_free;
>   	return &array->base;
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 942f4eed817f..4a1a9031f9db 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -3205,8 +3205,7 @@ eb_composite_fence_create(struct i915_execbuffer *eb, int out_fence_fd)
>   	fence_array = dma_fence_array_create(eb->num_batches,
>   					     fences,
>   					     eb->context->parallel.fence_context,
> -					     eb->context->parallel.seqno++,
> -					     false);
> +					     eb->context->parallel.seqno++);
>   	if (!fence_array) {
>   		kfree(fences);
>   		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 24d6d9af20d6..37866768d64c 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
> @@ -376,7 +376,7 @@ xe_sync_in_fence_get(struct xe_sync_entry *sync, int num_sync,
>   		xe_assert(vm->xe, current_fence == num_fence);
>   		cf = dma_fence_array_create(num_fence, fences,
>   					    dma_fence_context_alloc(1),
> -					    1, false);
> +					    1);
>   		if (!cf)
>   			goto err_out;
>   
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 56e2db50bb36..8f472911469d 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3370,7 +3370,7 @@ static struct dma_fence *ops_execute(struct xe_vm *vm,
>   		goto err_trace;
>   	}
>   
> -	cf = dma_fence_array_alloc(n_fence);
> +	cf = dma_fence_array_alloc();

Patch splitting mistake here.

The rest LGTM. So with this hunk dropped:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>   	if (!cf) {
>   		fence = ERR_PTR(-ENOMEM);
>   		goto err_out;
> @@ -3414,7 +3414,7 @@ static struct dma_fence *ops_execute(struct xe_vm *vm,
>   
>   	xe_assert(vm->xe, current_fence == n_fence);
>   	dma_fence_array_init(cf, n_fence, fences, dma_fence_context_alloc(1),
> -			     1, false);
> +			     1);
>   	fence = &cf->base;
>   
>   	for_each_tile(tile, vm->xe, id) {
> diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
> index 370b3d2bba37..1b1d87579c38 100644
> --- a/include/linux/dma-fence-array.h
> +++ b/include/linux/dma-fence-array.h
> @@ -81,13 +81,11 @@ to_dma_fence_array(struct dma_fence *fence)
>   struct dma_fence_array *dma_fence_array_alloc(int num_fences);
>   void dma_fence_array_init(struct dma_fence_array *array,
>   			  int num_fences, struct dma_fence **fences,
> -			  u64 context, unsigned seqno,
> -			  bool signal_on_any);
> +			  u64 context, unsigned seqno);
>   
>   struct dma_fence_array *dma_fence_array_create(int num_fences,
>   					       struct dma_fence **fences,
> -					       u64 context, unsigned seqno,
> -					       bool signal_on_any);
> +					       u64 context, unsigned seqno);
>   
>   bool dma_fence_match_context(struct dma_fence *fence, u64 context);
>   

