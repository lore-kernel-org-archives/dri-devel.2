Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC0EF5A8DE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 11:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D11189E33;
	Wed, 22 Apr 2026 11:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="lEz2hu3/";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6381289E33
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 11:37:05 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso30854035e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1776857824; x=1777462624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AAjkzDW3dUMmYnC6wUG2L3asSga3XbechqWM9IgW1us=;
 b=lEz2hu3/6bRMGuJQY2TkiwbFc4ojHDkMI8hEH2cIKNs+LLtkBzKmn8Ybvi91Vspjyg
 leyDyb4NLFfm5gHYdoxrVSLonpU4eRUXBFERXK2J+xqDjrlQjhNZg5/A2h3nxzUKdUES
 7cJTWo8Q1RZOxj069iXf3zZ0OdTM1wTrVWSx+toLB/oy4Es7c1tbBnOKtjDzo4yd379W
 YCaSGwQeMeTuub8pZT0KSldl1NjC9gMMuyDN9lLZ4bVgd3j00oEr9g/pvo25semzEu1y
 MQ4Cw0Lk/n6RrP0riST2oLFx3amW3slwTXS5CmvdzaCMexo/C12dvYyV/CYkceVDsXWq
 htsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776857824; x=1777462624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AAjkzDW3dUMmYnC6wUG2L3asSga3XbechqWM9IgW1us=;
 b=Rx8nlUr1aH105anWVncYqZFN8BJquafzHRvIfwAIFbxZm2aMaoohSuMhjVYT46DwKM
 0RtreJjQBahxQ3P4ejpyoxCgQDph6cEExIZO5MRbYPrKR5X9kaIzAnfNr82mOr8rGxGe
 7Mmod8cMlZ23sKpjfZ4fjzrvSp6AfdavryC2iCB3JZ1qbbrTPSbb5280Bc/5hhsEa00t
 /iBzs+AaPrt5JdBne1o3T5tUei94ssWis1bEcl1LQmmzhKk7Ri+15QheZSDLnQ8Hpygg
 uW5lfDc0BtMFkBj+zGTd5H4M4PE8IlE8ts9/0TdKgSiU9gthtH8ukYdEbe5gfrNhKKX2
 7TDQ==
X-Gm-Message-State: AOJu0YzBvCkt+VDKuV0/aGhWcvafrquAc9eD3O7x7wIQ7h4RyYsBiVh6
 E3+gL+o4E7mGx+wIfFxbyowJSKi2hi4e0jRBOg7QNpqENDyFfueHObKFdp6atiQG+bo=
X-Gm-Gg: AeBDiesFx1m2K3zh9l1/HwuPLKk5uuVChT0ndBM1DNpjYAfWoMw4qhu12L1hDaKZVOD
 giNQqQ2F7K1SOkydGfGv+0cMMeSAFyC73lTF48Hj3dhSpDOl8rYZVTPKZ1d1B4MTs6sxx3BX5Hv
 SgfcMI/G5FSW9IvQblFXve4fe/Ex3w4W4+49GGtH1tzrsgzsM3+LGPQdxk1/1NpesJxCaNEs4gK
 t7NIMh7YfNi4JAbZR1ofrxQNfZcTXdt8uehtSRR7GGB238WnVyCawoWC/jIGtOZQBjBof+olK2j
 8s7P+Mq4JQNEmRvPI/MNsW/f2fmNFGeL+ghx9eMrjnzYLDNcT0NeHKl9A4Qmdr4sGL9LOTWLG3+
 7QlecHN3CmJLORvja3QuScZBD8xZVrjFHcRK5UfciMTnmR4pKp7s0E0ZUOxS1mS6Gd38MIqx+nX
 a1GciqDJgiJ4HJIMGIeDzLx30gmDAvTvnwSA62Y8GZukKUBXyS0IMtCOg=
X-Received: by 2002:a05:600c:6289:b0:488:f941:aab2 with SMTP id
 5b1f17b1804b1-488fb78a561mr304825005e9.30.1776857823600; 
 Wed, 22 Apr 2026 04:37:03 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0d51sm44976014f8f.10.2026.04.22.04.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 04:37:03 -0700 (PDT)
Message-ID: <5e15b5d8-8184-4496-8da0-793ccd592d10@ursulin.net>
Date: Wed, 22 Apr 2026 12:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-buf/dma_fence_array: optimize handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260422103012.1647-1-christian.koenig@amd.com>
 <20260422103012.1647-2-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260422103012.1647-2-christian.koenig@amd.com>
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
> Removing the signal on any feature allows to simplfy the dma_fence_array
> code a lot and saves us from the need to install a callback on all fences
> at the same time.
> 
> This results in less memory and CPU overhead.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence-array.c | 130 +++++++++++++-----------------
>   include/linux/dma-fence-array.h   |  22 ++---
>   2 files changed, 59 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
> index 5e10e8df372f..f1b4b3296c87 100644
> --- a/drivers/dma-buf/dma-fence-array.c
> +++ b/drivers/dma-buf/dma-fence-array.c
> @@ -42,97 +42,80 @@ static void dma_fence_array_clear_pending_error(struct dma_fence_array *array)
>   	cmpxchg(&array->base.error, PENDING_ERROR, 0);
>   }
>   
> -static void irq_dma_fence_array_work(struct irq_work *wrk)
> +static void dma_fence_array_cb_func(struct dma_fence *f,
> +				    struct dma_fence_cb *cb)
>   {
> -	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
> +	struct dma_fence_array *array =
> +		container_of(cb, struct dma_fence_array, callback);
>   
> -	dma_fence_array_clear_pending_error(array);
> +	irq_work_queue(&array->work);
> +}
> +
> +static void dma_fence_array_arm_cb(struct dma_fence_array *array)
> +{
> +	while (array->num_pending) {
> +		struct dma_fence *f = array->fences[array->num_pending - 1];
> +
> +		if (!dma_fence_add_callback(f, &array->callback,
> +					    dma_fence_array_cb_func))
> +			return;
> +
> +		dma_fence_array_set_pending_error(array, f->error);
> +		WRITE_ONCE(array->num_pending, array->num_pending - 1);

Do you think the WRITE_ONCEs are needed? As the loop will restart with 
un-annotated read anyway, but not just that, I don't think it can be 
compiled away in the kernel with this usage pattern. Maybe I am mistaken.

> +	}
>   
>   	dma_fence_signal(&array->base);
>   	dma_fence_put(&array->base);
>   }
>   
> -static void dma_fence_array_cb_func(struct dma_fence *f,
> -				    struct dma_fence_cb *cb)
> +static void dma_fence_array_irq_work(struct irq_work *wrk)
>   {
> -	struct dma_fence_array_cb *array_cb =
> -		container_of(cb, struct dma_fence_array_cb, cb);
> -	struct dma_fence_array *array = array_cb->array;
> -
> -	dma_fence_array_set_pending_error(array, f->error);
> +	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
>   
> -	if (atomic_dec_and_test(&array->num_pending))
> -		irq_work_queue(&array->work);
> -	else
> -		dma_fence_put(&array->base);
> +	WRITE_ONCE(array->num_pending, array->num_pending - 1);
> +	dma_fence_array_arm_cb(array);

So for x86 going from one irqwork latency to num_fences latencies is 
probably passable but I am not sure how other architectures fare.

>   }
>   
>   static bool dma_fence_array_enable_signaling(struct dma_fence *fence)
>   {
>   	struct dma_fence_array *array = to_dma_fence_array(fence);
> -	struct dma_fence_array_cb *cb = array->callbacks;
> -	unsigned i;
> -
> -	for (i = 0; i < array->num_fences; ++i) {
> -		cb[i].array = array;
> -		/*
> -		 * As we may report that the fence is signaled before all
> -		 * callbacks are complete, we need to take an additional
> -		 * reference count on the array so that we do not free it too
> -		 * early. The core fence handling will only hold the reference
> -		 * until we signal the array as complete (but that is now
> -		 * insufficient).
> -		 */
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
> -	}
>   
> +	/*
> +	 * As we may report that the fence is signaled before all
> +	 * callbacks are complete, we need to take an additional
> +	 * reference count on the array so that we do not free it too
> +	 * early. The core fence handling will only hold the reference
> +	 * until we signal the array as complete (but that is now
> +	 * insufficient).
> +	 */
> +	dma_fence_get(&array->base);
> +	dma_fence_array_arm_cb(array);
>   	return true;

Are you sure it is safe to always return true?

Regards,

Tvrtko

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
> @@ -171,15 +154,12 @@ EXPORT_SYMBOL(dma_fence_array_ops);
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
> @@ -203,10 +183,13 @@ void dma_fence_array_init(struct dma_fence_array *array,
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
> @@ -220,11 +203,6 @@ void dma_fence_array_init(struct dma_fence_array *array,
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
> @@ -265,7 +243,7 @@ struct dma_fence_array *dma_fence_array_create(int num_fences,
>   {
>   	struct dma_fence_array *array;
>   
> -	array = dma_fence_array_alloc(num_fences);
> +	array = dma_fence_array_alloc();
>   	if (!array)
>   		return NULL;
>   
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

