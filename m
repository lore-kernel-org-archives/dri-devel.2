Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B60ECD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 08:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B3A10EB07;
	Wed,  6 May 2026 08:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="YbBA0Opf";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB4E10ECF1
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 08:04:19 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so1773610f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1778054658; x=1778659458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LiS/ij6r165ba7gZt06iVY0/MOUwEsreAaIASyC63GA=;
 b=YbBA0OpfUBUpJ6aDp7t4LtW04yJ6iEATq5DdmsN4QPzecL5KPMJX7+aTrBIwLQO0VT
 /y3Su7T0SoT38q49wzh3UZaW+p3SDGm02xCDPOV98VXCSOE4FKQZVJfXhMSnaQDafqzv
 c8J8ZtAQ4qJj6t7vMARqxPpB8/8MjOwdHYQSn9aJqrTit6VzwspY/MjzrxqFQrOzoLdE
 q5sCAIRXRFEKXUkzP1z8etc5A09uppK6zAw6YBLkVrtU8o+Rt1IeMxNoYQ+rGQxb6p0H
 UgC+GskSjRjTwsJn3/E596FCRBoDtVDIo1hW+FSjeIlegsD209l7pUK0eblIhg0KTFkP
 cA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054658; x=1778659458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LiS/ij6r165ba7gZt06iVY0/MOUwEsreAaIASyC63GA=;
 b=EgK8okmiLoBsFjuVSodL2Vitqb8Rwpeepv7keuqLRp6irKnb5p5oRFkuJlTS8yrBK4
 KuqwpzqFyNfSA1t/Cjxy5ykfBim6kaEqt1yXs0q6xNHsb/MFGUEaofcZL40n66qteSwA
 PNe4rvLmqo/NDhlCkgU6TPvwdPRYqPfivhtKFekkBD6jg+7nROClPiM31PKbwSFvCrbV
 W6W1sFQjGH348AxG9+aGQA5UkxliFq0UOYTayv1HqttxtGi8sqoIxD23VuH/y4AC9Oln
 BIXx5nNk4qAy+yLf7ycsjuw21FGmQOKsJxU3VWQnbNwYpLY7nfGYvsSldvC/vYVN3uLl
 1UiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MULaLuDbw89IAD74v2qwkXQsEWt3JRxsnujna2BeWZMmmAwZTS9I5Udq0AC3G3ftxHaiqqX2jjRI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz40rd214iX2XWHlRVCMfUBtGAsckTVj6JIovO+7qMEeN+smdWG
 q5QKw9OYr1EcFaPjzuo/I9Tq7276pehvkFTkT7G6M0Xx78hPWUOTfxESqtjnmiMWBiE=
X-Gm-Gg: AeBDieuvOh5+N97wuirp09aBWbiMf3Tn1FmtP+uBclPbxT2TsQKJ6nc6hJS/6W5K8a8
 fOKsMFHpzDyE6hn9CLh2vg8CIogZ827UoRCw7PexGXce15aewWwenbsz8GbHkYqWGJNV4x/oHTK
 /R+3TTF8Ug93dfWnNAIqgY1Iyx9dGM+BPi7mmlIOK+5nCN06WLAbpFhBBmoRXCJE2g+vd3tuhbS
 PzDY7OFnVkeJV3Uv4XeCsLSsk/qslLFVYtC3CU5sd0TbCZaALnYLTFvoPsOl8Gc6cbh9gU8ooDr
 K8+jrRJPUt/j/T/Md/RPL6U+A/3KGV9dgozOUp4HR5+iT5s/5dLlunJWS0Mqzbsyk4ASQtX2vEg
 AdrGbDLdvj1qBkG1QneVdAFzyuBCtSvHPbh24JWwvzRgdYGNzyqL7uS7dVNZDqgpyNpACF3aKmS
 ioPwCyn8pVc6u+jJQxDbJJMlBP2As8FGZGo5TlXwgKdCp3Yc6j7jELVsuMp0wkKM2Leg==
X-Received: by 2002:a05:600c:a08b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48e51f4119bmr39672925e9.21.1778054657634; 
 Wed, 06 May 2026 01:04:17 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530cf964sm19380375e9.1.2026.05.06.01.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 01:04:17 -0700 (PDT)
Message-ID: <21121a6f-4431-497a-a8ff-61219cb00ad6@ursulin.net>
Date: Wed, 6 May 2026 09:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma_fence_array: optimize handling v2
To: christian.koenig@amd.com, sumit.semwal@linaro.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260505110828.1574-1-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260505110828.1574-1-christian.koenig@amd.com>
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


On 05/05/2026 12:08, Christian König wrote:
> Removing the signal on any feature allows to simplfy the dma_fence_array
> code a lot and saves us from the need to install a callback on all fences
> at the same time.
> 
> This results is less memory and CPU overhead.

Code looks good but I still worry about the new potential for num_fences 
irq work latencies whereas the existing implementation only has one.

Also, whether or not current or this implementation uses less or more 
CPU overhead depends on the signalling pattern (time distribution) of 
the fences in the array.

Apart from more latency it could even be more CPU usage in the 
pathological case.

It would be less if, when the last fence in the array signals, all 
others have already signaled. Although it would still need to go through 
all dma_fence_add_callback() calls so that part is the same as the 
current implementation. Only the CPU cycles from the signaling side 
would be saved.

But in the pathological case, where fences signal one by one from the 
first to last, and are spaced more in time than a single irq work 
latency, the new implementation needs more CPU time and more latency.

I do agree it would be nice to be able to drop the callbacks array but 
for the above reasons I am worried whether it is safe.

Some other minor comments below.

> v2: fix potential double locking pointed out by Tvrtko
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence-array.c | 134 +++++++++++++-----------------
>   drivers/gpu/drm/xe/xe_vm.c        |   2 +-
>   include/linux/dma-fence-array.h   |  22 ++---
>   3 files changed, 66 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
> index 5e10e8df372f..8b94c6287482 100644
> --- a/drivers/dma-buf/dma-fence-array.c
> +++ b/drivers/dma-buf/dma-fence-array.c
> @@ -42,97 +42,88 @@ static void dma_fence_array_clear_pending_error(struct dma_fence_array *array)
>   	cmpxchg(&array->base.error, PENDING_ERROR, 0);
>   }
>   
> -static void irq_dma_fence_array_work(struct irq_work *wrk)
> +static void dma_fence_array_cb_func(struct dma_fence *f,
> +				    struct dma_fence_cb *cb)
>   {
> -	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
> -
> -	dma_fence_array_clear_pending_error(array);
> +	struct dma_fence_array *array =
> +		container_of(cb, struct dma_fence_array, callback);
>   
> -	dma_fence_signal(&array->base);
> -	dma_fence_put(&array->base);
> +	irq_work_queue(&array->work);
>   }
>   
> -static void dma_fence_array_cb_func(struct dma_fence *f,
> -				    struct dma_fence_cb *cb)
> +static bool dma_fence_array_try_add_cb(struct dma_fence_array *array)
>   {
> -	struct dma_fence_array_cb *array_cb =
> -		container_of(cb, struct dma_fence_array_cb, cb);
> -	struct dma_fence_array *array = array_cb->array;
> +	while (array->num_pending) {
> +		struct dma_fence *f = array->fences[array->num_pending - 1];

Maybe add above this line something like:

/*
  * Install callbacks from the reverse so the check in
  * dma_fence_array_signaled() can be optimized.
  */

>   
> -	dma_fence_array_set_pending_error(array, f->error);
> +		if (!dma_fence_add_callback(f, &array->callback,
> +					    dma_fence_array_cb_func))
> +			return true;
>   
> -	if (atomic_dec_and_test(&array->num_pending))
> -		irq_work_queue(&array->work);
> -	else
> +		dma_fence_array_set_pending_error(array, f->error);
> +		--array->num_pending;
> +	}
> +	return false;
> +}
> +
> +static void dma_fence_array_irq_work(struct irq_work *wrk)
> +{
> +	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
> +
> +	--array->num_pending;
> +	if (!dma_fence_array_try_add_cb(array)) {
> +		dma_fence_signal(&array->base);
>   		dma_fence_put(&array->base);
> +	}
>   }
>   
>   static bool dma_fence_array_enable_signaling(struct dma_fence *fence)
>   {
>   	struct dma_fence_array *array = to_dma_fence_array(fence);
> -	struct dma_fence_array_cb *cb = array->callbacks;
> -	unsigned i;
>   
> -	for (i = 0; i < array->num_fences; ++i) {
> -		cb[i].array = array;
> +	/*
> +	 * As we may report that the fence is signaled before all
> +	 * callbacks are complete, we need to take an additional
> +	 * reference count on the array so that we do not free it too
> +	 * early. The core fence handling will only hold the reference
> +	 * until we signal the array as complete (but that is now
> +	 * insufficient).
> +	 */
> +	dma_fence_get(&array->base);
> +	if (!dma_fence_array_try_add_cb(array)) {
>   		/*
> -		 * As we may report that the fence is signaled before all
> -		 * callbacks are complete, we need to take an additional
> -		 * reference count on the array so that we do not free it too
> -		 * early. The core fence handling will only hold the reference
> -		 * until we signal the array as complete (but that is now
> -		 * insufficient).
> +		 * When all fences are already signaled we can drop the reference again
> +		 * and report to the caller that the array can be signaled as well.

Optional nit - above two lines end up only lines over 80 in the file.

Regards,

Tvrtko

>   		 */
> -		dma_fence_get(&array->base);
> -		if (dma_fence_add_callback(array->fences[i], &cb[i].cb,
> -					   dma_fence_array_cb_func)) {
> -			int error = array->fences[i]->error;
> -
> -			dma_fence_array_set_pending_error(array, error);
> -			dma_fence_put(&array->base);
> -			if (atomic_dec_and_test(&array->num_pending)) {
> -				dma_fence_array_clear_pending_error(array);
> -				return false;
> -			}
> -		}
> +		dma_fence_put(&array->base);
> +		return false;
>   	}
> -
>   	return true;
>   }
>   
>   static bool dma_fence_array_signaled(struct dma_fence *fence)
>   {
>   	struct dma_fence_array *array = to_dma_fence_array(fence);
> -	int num_pending;
> +	int num_pending, error = 0;
>   	unsigned int i;
>   
>   	/*
> -	 * We need to read num_pending before checking the enable_signal bit
> -	 * to avoid racing with the enable_signaling() implementation, which
> -	 * might decrement the counter, and cause a partial check.
> -	 * atomic_read_acquire() pairs with atomic_dec_and_test() in
> -	 * dma_fence_array_enable_signaling()
> -	 *
> -	 * The !--num_pending check is here to account for the any_signaled case
> -	 * if we race with enable_signaling(), that means the !num_pending check
> -	 * in the is_signalling_enabled branch might be outdated (num_pending
> -	 * might have been decremented), but that's fine. The user will get the
> -	 * right value when testing again later.
> +	 * Reading num_pending without a memory barrier here is correct since
> +	 * that is only for optimization, it is perfectly acceptable to have a
> +	 * stale value for it. In all other cases num_pending is accessed by a
> +	 * single call chain.
>   	 */
> -	num_pending = atomic_read_acquire(&array->num_pending);
> -	if (test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &array->base.flags)) {
> -		if (num_pending <= 0)
> -			goto signal;
> -		return false;
> -	}
> +	num_pending = READ_ONCE(array->num_pending);
> +	for (i = 0; i < num_pending; ++i) {
> +		struct dma_fence *f = array->fences[i];
>   
> -	for (i = 0; i < array->num_fences; ++i) {
> -		if (dma_fence_is_signaled(array->fences[i]) && !--num_pending)
> -			goto signal;
> -	}
> -	return false;
> +		if (!dma_fence_is_signaled(f))
> +			return false;
>   
> -signal:
> +		if (!error)
> +			error = f->error;
> +	}
> +	dma_fence_array_set_pending_error(array, error);
>   	dma_fence_array_clear_pending_error(array);
>   	return true;
>   }
> @@ -171,15 +162,12 @@ EXPORT_SYMBOL(dma_fence_array_ops);
>   
>   /**
>    * dma_fence_array_alloc - Allocate a custom fence array
> - * @num_fences:		[in]	number of fences to add in the array
>    *
>    * Return dma fence array on success, NULL on failure
>    */
> -struct dma_fence_array *dma_fence_array_alloc(int num_fences)
> +struct dma_fence_array *dma_fence_array_alloc(void)
>   {
> -	struct dma_fence_array *array;
> -
> -	return kzalloc_flex(*array, callbacks, num_fences);
> +	return kzalloc_obj(struct dma_fence_array);
>   }
>   EXPORT_SYMBOL(dma_fence_array_alloc);
>   
> @@ -203,10 +191,13 @@ void dma_fence_array_init(struct dma_fence_array *array,
>   	WARN_ON(!num_fences || !fences);
>   
>   	array->num_fences = num_fences;
> +	array->num_pending = num_fences;
> +	array->fences = fences;
> +	array->base.error = PENDING_ERROR;
>   
>   	dma_fence_init(&array->base, &dma_fence_array_ops, NULL, context,
>   		       seqno);
> -	init_irq_work(&array->work, irq_dma_fence_array_work);
> +	init_irq_work(&array->work, dma_fence_array_irq_work);
>   
>   	/*
>   	 * dma_fence_array_enable_signaling() is invoked while holding
> @@ -220,11 +211,6 @@ void dma_fence_array_init(struct dma_fence_array *array,
>   	 */
>   	lockdep_set_class(&array->base.inline_lock, &dma_fence_array_lock_key);
>   
> -	atomic_set(&array->num_pending, num_fences);
> -	array->fences = fences;
> -
> -	array->base.error = PENDING_ERROR;
> -
>   	/*
>   	 * dma_fence_array objects should never contain any other fence
>   	 * containers or otherwise we run into recursion and potential kernel
> @@ -265,7 +251,7 @@ struct dma_fence_array *dma_fence_array_create(int num_fences,
>   {
>   	struct dma_fence_array *array;
>   
> -	array = dma_fence_array_alloc(num_fences);
> +	array = dma_fence_array_alloc();
>   	if (!array)
>   		return NULL;
>   
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 62a87a051be7..8f472911469d 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3370,7 +3370,7 @@ static struct dma_fence *ops_execute(struct xe_vm *vm,
>   		goto err_trace;
>   	}
>   
> -	cf = dma_fence_array_alloc(n_fence);
> +	cf = dma_fence_array_alloc();
>   	if (!cf) {
>   		fence = ERR_PTR(-ENOMEM);
>   		goto err_out;
> diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
> index 1b1d87579c38..3ee55c0e2fa4 100644
> --- a/include/linux/dma-fence-array.h
> +++ b/include/linux/dma-fence-array.h
> @@ -15,16 +15,6 @@
>   #include <linux/dma-fence.h>
>   #include <linux/irq_work.h>
>   
> -/**
> - * struct dma_fence_array_cb - callback helper for fence array
> - * @cb: fence callback structure for signaling
> - * @array: reference to the parent fence array object
> - */
> -struct dma_fence_array_cb {
> -	struct dma_fence_cb cb;
> -	struct dma_fence_array *array;
> -};
> -
>   /**
>    * struct dma_fence_array - fence to represent an array of fences
>    * @base: fence base class
> @@ -33,18 +23,17 @@ struct dma_fence_array_cb {
>    * @num_pending: fences in the array still pending
>    * @fences: array of the fences
>    * @work: internal irq_work function
> - * @callbacks: array of callback helpers
> + * @callback: callback structure for signaling
>    */
>   struct dma_fence_array {
>   	struct dma_fence base;
>   
> -	unsigned num_fences;
> -	atomic_t num_pending;
> +	unsigned int num_fences;
> +	unsigned int num_pending;
>   	struct dma_fence **fences;
>   
>   	struct irq_work work;
> -
> -	struct dma_fence_array_cb callbacks[] __counted_by(num_fences);
> +	struct dma_fence_cb callback;
>   };
>   
>   /**
> @@ -78,11 +67,10 @@ to_dma_fence_array(struct dma_fence *fence)
>   	for (index = 0, fence = dma_fence_array_first(head); fence;	\
>   	     ++(index), fence = dma_fence_array_next(head, index))
>   
> -struct dma_fence_array *dma_fence_array_alloc(int num_fences);
> +struct dma_fence_array *dma_fence_array_alloc(void);
>   void dma_fence_array_init(struct dma_fence_array *array,
>   			  int num_fences, struct dma_fence **fences,
>   			  u64 context, unsigned seqno);
> -
>   struct dma_fence_array *dma_fence_array_create(int num_fences,
>   					       struct dma_fence **fences,
>   					       u64 context, unsigned seqno);

