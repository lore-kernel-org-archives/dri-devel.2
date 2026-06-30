Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5799FC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7FC10E07C;
	Tue, 30 Jun 2026 13:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FOWgQkBs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0B010EC8A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XfC367PanZ/MhdfAxK3iQuakzmkgZDJ5GXThqz4xAEY=; b=FOWgQkBs+0QtysBntPujpAEQo+
 UoJMRj5GLJrboUWj9qGTwGe+koapbsYlp9Fm+zHfVNa3xpHcDg+TmuyB7Hiq57AjqC0BTDSSgbdDK
 0k1WpYs3irbgJgBtQ4pPADC98shJV6S74/qmIGXMxG1hOCA3V5kGCLGqWiiwrdFf+ggcnVW2ArTDN
 DRw7cWgjDOCFeHWOii9DQ01Kp8eOse2QwJC5mcoUnvbVLAYBDGymVC5yo+dJqENU5KqyBfKEcUXZC
 ejv5OJygvgRQASYKmPfO5pr2VmJcb5+alwbMUMtrhcS0FV1JcGn3RUsmlQiMv3MRCoiMbvSOQ+IYl
 tDQ0lkqQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1weYDE-0076La-MK; Tue, 30 Jun 2026 15:09:16 +0200
Message-ID: <169bd4fe-6ef6-489f-83a8-c72925e09611@igalia.com>
Date: Tue, 30 Jun 2026 14:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dma-buf: rename dma_fence_enable_sw_signaling
To: christian.koenig@amd.com, phasta@kernel.org, simona@ffwll.ch,
 sumit.semwal@linaro.org, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <20260624122917.2483-2-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260624122917.2483-2-christian.koenig@amd.com>
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


On 24/06/2026 12:13, Christian König wrote:
> Dropping the _sw_ part from the names was proposed multiple times now and
> IIRC people generally agreed with the idea already.
> 
> The function requests a fence to signal and triggers some sort of HW
> interaction on most backends.
> 
> So this is not really software related at all and the callback is already
> just named enable_signaling as well.
> 
> Just streamline that and use a consistent name everywhere.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I even thought I r-b's a variant of this before, but as I couldn't find 
it, I think my mental note was just that we agreed this makes sense ages 
ago.

For the i915 part also an ack to land via drm-misc.

Regards,

Tvrtko

> 
> Assisted-by: Claude Sonet 4
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c                   |  8 ++--
>   drivers/dma-buf/st-dma-fence-chain.c          |  4 +-
>   drivers/dma-buf/st-dma-fence-unwrap.c         | 42 +++++++++----------
>   drivers/dma-buf/st-dma-fence.c                | 16 +++----
>   drivers/dma-buf/st-dma-resv.c                 | 10 ++---
>   drivers/gpu/drm/i915/i915_active.c            |  2 +-
>   .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
>   drivers/gpu/drm/ttm/ttm_bo.c                  |  2 +-
>   drivers/gpu/drm/xe/xe_bo.c                    |  2 +-
>   drivers/gpu/drm/xe/xe_sched_job.c             |  2 +-
>   drivers/gpu/drm/xe/xe_svm.c                   |  2 +-
>   drivers/gpu/drm/xe/xe_userptr.c               |  2 +-
>   drivers/gpu/drm/xe/xe_vm.c                    |  4 +-
>   include/linux/dma-fence.h                     |  4 +-
>   14 files changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a..0ec81a568bbd 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -534,7 +534,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
>   
>   	__dma_fence_might_wait();
>   
> -	dma_fence_enable_sw_signaling(fence);
> +	dma_fence_enable_signaling(fence);
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> @@ -656,14 +656,14 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
>   }
>   
>   /**
> - * dma_fence_enable_sw_signaling - enable signaling on fence
> + * dma_fence_enable_signaling - enable signaling on fence
>    * @fence: the fence to enable
>    *
>    * This will request for sw signaling to be enabled, to make the fence
>    * complete as soon as possible. This calls &dma_fence_ops.enable_signaling
>    * internally.
>    */
> -void dma_fence_enable_sw_signaling(struct dma_fence *fence)
> +void dma_fence_enable_signaling(struct dma_fence *fence)
>   {
>   	unsigned long flags;
>   
> @@ -671,7 +671,7 @@ void dma_fence_enable_sw_signaling(struct dma_fence *fence)
>   	__dma_fence_enable_signaling(fence);
>   	dma_fence_unlock_irqrestore(fence, flags);
>   }
> -EXPORT_SYMBOL(dma_fence_enable_sw_signaling);
> +EXPORT_SYMBOL(dma_fence_enable_signaling);
>   
>   /**
>    * dma_fence_add_callback - add a callback to be called when the fence
> diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
> index a3023d3fedc9..e0d9b69bfa76 100644
> --- a/drivers/dma-buf/st-dma-fence-chain.c
> +++ b/drivers/dma-buf/st-dma-fence-chain.c
> @@ -82,7 +82,7 @@ static void test_sanitycheck(struct kunit *test)
>   
>   	chain = mock_chain(NULL, f, 1);
>   	if (chain)
> -		dma_fence_enable_sw_signaling(chain);
> +		dma_fence_enable_signaling(chain);
>   	else
>   		KUNIT_FAIL(test, "Failed to create chain");
>   
> @@ -139,7 +139,7 @@ static int fence_chains_init(struct fence_chains *fc, unsigned int count,
>   
>   		fc->tail = fc->chains[i];
>   
> -		dma_fence_enable_sw_signaling(fc->chains[i]);
> +		dma_fence_enable_signaling(fc->chains[i]);
>   	}
>   
>   	fc->chain_length = i;
> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
> index 4e7ee25372ba..4d9d313b460c 100644
> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
> @@ -103,7 +103,7 @@ static void test_sanitycheck(struct kunit *test)
>   	f = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	array = mock_array(1, f);
>   	KUNIT_ASSERT_NOT_NULL(test, array);
> @@ -122,7 +122,7 @@ static void test_unwrap_array(struct kunit *test)
>   	f1 = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = mock_fence();
>   	if (!f2) {
> @@ -131,7 +131,7 @@ static void test_unwrap_array(struct kunit *test)
>   		return;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f2);
> +	dma_fence_enable_signaling(f2);
>   
>   	array = mock_array(2, f1, f2);
>   	KUNIT_ASSERT_NOT_NULL(test, array);
> @@ -160,7 +160,7 @@ static void test_unwrap_chain(struct kunit *test)
>   	f1 = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = mock_fence();
>   	if (!f2) {
> @@ -169,7 +169,7 @@ static void test_unwrap_chain(struct kunit *test)
>   		return;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f2);
> +	dma_fence_enable_signaling(f2);
>   
>   	chain = mock_chain(f1, f2);
>   	KUNIT_ASSERT_NOT_NULL(test, chain);
> @@ -198,7 +198,7 @@ static void test_unwrap_chain_array(struct kunit *test)
>   	f1 = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = mock_fence();
>   	if (!f2) {
> @@ -207,7 +207,7 @@ static void test_unwrap_chain_array(struct kunit *test)
>   		return;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f2);
> +	dma_fence_enable_signaling(f2);
>   
>   	array = mock_array(2, f1, f2);
>   	KUNIT_ASSERT_NOT_NULL(test, array);
> @@ -239,7 +239,7 @@ static void test_unwrap_merge(struct kunit *test)
>   	f1 = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = mock_fence();
>   	if (!f2) {
> @@ -247,7 +247,7 @@ static void test_unwrap_merge(struct kunit *test)
>   		goto error_put_f1;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f2);
> +	dma_fence_enable_signaling(f2);
>   
>   	f3 = dma_fence_unwrap_merge(f1, f2);
>   	if (!f3) {
> @@ -285,7 +285,7 @@ static void test_unwrap_merge_duplicate(struct kunit *test)
>   	f1 = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = dma_fence_unwrap_merge(f1, f1);
>   	if (!f2) {
> @@ -322,7 +322,7 @@ static void test_unwrap_merge_seqno(struct kunit *test)
>   	f1 = __mock_fence(ctx[1], 1);
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = __mock_fence(ctx[1], 2);
>   	if (!f2) {
> @@ -330,7 +330,7 @@ static void test_unwrap_merge_seqno(struct kunit *test)
>   		goto error_put_f1;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f2);
> +	dma_fence_enable_signaling(f2);
>   
>   	f3 = __mock_fence(ctx[0], 1);
>   	if (!f3) {
> @@ -338,7 +338,7 @@ static void test_unwrap_merge_seqno(struct kunit *test)
>   		goto error_put_f2;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f3);
> +	dma_fence_enable_signaling(f3);
>   
>   	f4 = dma_fence_unwrap_merge(f1, f2, f3);
>   	if (!f4) {
> @@ -378,7 +378,7 @@ static void test_unwrap_merge_order(struct kunit *test)
>   	f1 = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = mock_fence();
>   	if (!f2) {
> @@ -387,7 +387,7 @@ static void test_unwrap_merge_order(struct kunit *test)
>   		return;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f2);
> +	dma_fence_enable_signaling(f2);
>   
>   	a1 = mock_array(2, f1, f2);
>   	KUNIT_ASSERT_NOT_NULL(test, a1);
> @@ -442,7 +442,7 @@ static void test_unwrap_merge_complex(struct kunit *test)
>   	f1 = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = mock_fence();
>   	if (!f2) {
> @@ -450,7 +450,7 @@ static void test_unwrap_merge_complex(struct kunit *test)
>   		goto error_put_f1;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f2);
> +	dma_fence_enable_signaling(f2);
>   
>   	f3 = dma_fence_unwrap_merge(f1, f2);
>   	if (!f3) {
> @@ -510,7 +510,7 @@ static void test_unwrap_merge_complex_seqno(struct kunit *test)
>   	f1 = __mock_fence(ctx[0], 2);
>   	KUNIT_ASSERT_NOT_NULL(test, f1);
>   
> -	dma_fence_enable_sw_signaling(f1);
> +	dma_fence_enable_signaling(f1);
>   
>   	f2 = __mock_fence(ctx[1], 1);
>   	if (!f2) {
> @@ -518,7 +518,7 @@ static void test_unwrap_merge_complex_seqno(struct kunit *test)
>   		goto error_put_f1;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f2);
> +	dma_fence_enable_signaling(f2);
>   
>   	f3 = __mock_fence(ctx[0], 1);
>   	if (!f3) {
> @@ -526,7 +526,7 @@ static void test_unwrap_merge_complex_seqno(struct kunit *test)
>   		goto error_put_f2;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f3);
> +	dma_fence_enable_signaling(f3);
>   
>   	f4 = __mock_fence(ctx[1], 2);
>   	if (!f4) {
> @@ -534,7 +534,7 @@ static void test_unwrap_merge_complex_seqno(struct kunit *test)
>   		goto error_put_f3;
>   	}
>   
> -	dma_fence_enable_sw_signaling(f4);
> +	dma_fence_enable_signaling(f4);
>   
>   	f5 = mock_array(2, dma_fence_get(f1), dma_fence_get(f2));
>   	if (!f5) {
> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
> index 499272229696..856d0d302a5d 100644
> --- a/drivers/dma-buf/st-dma-fence.c
> +++ b/drivers/dma-buf/st-dma-fence.c
> @@ -42,7 +42,7 @@ static void test_sanitycheck(struct kunit *test)
>   	f = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	dma_fence_signal(f);
>   	dma_fence_put(f);
> @@ -55,7 +55,7 @@ static void test_signaling(struct kunit *test)
>   	f = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	if (dma_fence_is_signaled(f)) {
>   		KUNIT_FAIL(test, "Fence unexpectedly signaled on creation");
> @@ -127,7 +127,7 @@ static void test_late_add_callback(struct kunit *test)
>   	f = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	dma_fence_signal(f);
>   
> @@ -209,7 +209,7 @@ static void test_status(struct kunit *test)
>   	f = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	if (dma_fence_get_status(f)) {
>   		KUNIT_FAIL(test, "Fence unexpectedly has signaled status on creation");
> @@ -233,7 +233,7 @@ static void test_error(struct kunit *test)
>   	f = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	dma_fence_set_error(f, -EIO);
>   
> @@ -260,7 +260,7 @@ static void test_wait(struct kunit *test)
>   	f = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	if (dma_fence_wait_timeout(f, false, 0) != 0) {
>   		KUNIT_FAIL(test, "Wait reported complete before being signaled");
> @@ -300,7 +300,7 @@ static void test_wait_timeout(struct kunit *test)
>   	wt.f = mock_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, wt.f);
>   
> -	dma_fence_enable_sw_signaling(wt.f);
> +	dma_fence_enable_signaling(wt.f);
>   
>   	if (dma_fence_wait_timeout(wt.f, false, 1) != 0) {
>   		KUNIT_FAIL(test, "Wait reported complete before being signaled");
> @@ -379,7 +379,7 @@ static int thread_signal_callback(void *arg)
>   			break;
>   		}
>   
> -		dma_fence_enable_sw_signaling(f1);
> +		dma_fence_enable_signaling(f1);
>   
>   		rcu_assign_pointer(t->fences[t->id], f1);
>   		smp_wmb();
> diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
> index 95a4becdb892..0b96136bbd54 100644
> --- a/drivers/dma-buf/st-dma-resv.c
> +++ b/drivers/dma-buf/st-dma-resv.c
> @@ -48,7 +48,7 @@ static void test_sanitycheck(struct kunit *test)
>   	f = alloc_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	dma_fence_signal(f);
>   	dma_fence_put(f);
> @@ -73,7 +73,7 @@ static void test_signaling(struct kunit *test)
>   	f = alloc_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	dma_resv_init(&resv);
>   	r = dma_resv_lock(&resv, NULL);
> @@ -117,7 +117,7 @@ static void test_for_each(struct kunit *test)
>   	f = alloc_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	dma_resv_init(&resv);
>   	r = dma_resv_lock(&resv, NULL);
> @@ -176,7 +176,7 @@ static void test_for_each_unlocked(struct kunit *test)
>   	f = alloc_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	dma_resv_init(&resv);
>   	r = dma_resv_lock(&resv, NULL);
> @@ -246,7 +246,7 @@ static void test_get_fences(struct kunit *test)
>   	f = alloc_fence();
>   	KUNIT_ASSERT_NOT_NULL(test, f);
>   
> -	dma_fence_enable_sw_signaling(f);
> +	dma_fence_enable_signaling(f);
>   
>   	dma_resv_init(&resv);
>   	r = dma_resv_lock(&resv, NULL);
> diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> index 5cb7a72774a0..e7632c1ff4be 100644
> --- a/drivers/gpu/drm/i915/i915_active.c
> +++ b/drivers/gpu/drm/i915/i915_active.c
> @@ -543,7 +543,7 @@ static void enable_signaling(struct i915_active_fence *active)
>   	if (!fence)
>   		return;
>   
> -	dma_fence_enable_sw_signaling(fence);
> +	dma_fence_enable_signaling(fence);
>   	dma_fence_put(fence);
>   }
>   
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> index 2db221f6fc3a..56ad8ef32584 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -69,7 +69,7 @@ static void dma_resv_kunit_active_fence_init(struct kunit *test,
>   	struct dma_fence *fence;
>   
>   	fence = alloc_mock_fence(test);
> -	dma_fence_enable_sw_signaling(fence);
> +	dma_fence_enable_signaling(fence);
>   
>   	dma_resv_lock(resv, NULL);
>   	dma_resv_reserve_fences(resv, 1);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bcd76f6bb7f0..3980f376e3ba 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -224,7 +224,7 @@ static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
>   
>   	dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
>   	dma_resv_for_each_fence_unlocked(&cursor, fence)
> -		dma_fence_enable_sw_signaling(fence);
> +		dma_fence_enable_signaling(fence);
>   	dma_resv_iter_end(&cursor);
>   }
>   
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 4c80bac67622..85e6d9a0f575 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -670,7 +670,7 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
>   		dma_resv_iter_begin(&cursor, bo->ttm.base.resv,
>   				    DMA_RESV_USAGE_BOOKKEEP);
>   		dma_resv_for_each_fence_unlocked(&cursor, fence)
> -			dma_fence_enable_sw_signaling(fence);
> +			dma_fence_enable_signaling(fence);
>   		dma_resv_iter_end(&cursor);
>   	}
>   
> diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
> index ae5b38b2a884..a4fa00632a30 100644
> --- a/drivers/gpu/drm/xe/xe_sched_job.c
> +++ b/drivers/gpu/drm/xe/xe_sched_job.c
> @@ -214,7 +214,7 @@ void xe_sched_job_set_error(struct xe_sched_job *job, int error)
>   
>   	trace_xe_sched_job_set_error(job);
>   
> -	dma_fence_enable_sw_signaling(job->fence);
> +	dma_fence_enable_signaling(job->fence);
>   	xe_hw_fence_irq_run(job->q->fence_irq);
>   }
>   
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index e1651e70c8f0..dba73786d82a 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -1090,7 +1090,7 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>   				dma_resv_wait_timeout(bo->ttm.base.resv, DMA_RESV_USAGE_KERNEL,
>   						      false, MAX_SCHEDULE_TIMEOUT);
>   			else if (pre_migrate_fence)
> -				dma_fence_enable_sw_signaling(pre_migrate_fence);
> +				dma_fence_enable_signaling(pre_migrate_fence);
>   		}
>   
>   		drm_pagemap_devmem_init(&bo->devmem_allocation, dev, mm,
> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> index 6761005c0b90..2e45e42c648f 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -180,7 +180,7 @@ xe_vma_userptr_invalidate_pass1(struct xe_vm *vm, struct xe_userptr_vma *uvma)
>   	dma_resv_iter_begin(&cursor, xe_vm_resv(vm),
>   			    DMA_RESV_USAGE_BOOKKEEP);
>   	dma_resv_for_each_fence_unlocked(&cursor, fence) {
> -		dma_fence_enable_sw_signaling(fence);
> +		dma_fence_enable_signaling(fence);
>   		if (signaled && !dma_fence_is_signaled(fence))
>   			signaled = false;
>   	}
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 080c2fff0e95..73ac031ffb04 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -256,7 +256,7 @@ int xe_vm_add_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q)
>   	 */
>   	wait = __xe_vm_userptr_needs_repin(vm) || preempt_fences_waiting(vm);
>   	if (wait)
> -		dma_fence_enable_sw_signaling(pfence);
> +		dma_fence_enable_signaling(pfence);
>   
>   	xe_svm_notifier_unlock(vm);
>   
> @@ -287,7 +287,7 @@ void xe_vm_remove_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q)
>   		--vm->preempt.num_exec_queues;
>   	}
>   	if (q->lr.pfence) {
> -		dma_fence_enable_sw_signaling(q->lr.pfence);
> +		dma_fence_enable_signaling(q->lr.pfence);
>   		dma_fence_put(q->lr.pfence);
>   		q->lr.pfence = NULL;
>   	}
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index b52ab692b22e..158cd609f103 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -448,7 +448,7 @@ int dma_fence_add_callback(struct dma_fence *fence,
>   			   dma_fence_func_t func);
>   bool dma_fence_remove_callback(struct dma_fence *fence,
>   			       struct dma_fence_cb *cb);
> -void dma_fence_enable_sw_signaling(struct dma_fence *fence);
> +void dma_fence_enable_signaling(struct dma_fence *fence);
>   
>   /**
>    * DOC: Safe external access to driver provided object members
> @@ -534,7 +534,7 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
>    * Returns true if the fence was already signaled, false if not. Since this
>    * function doesn't enable signaling, it is not guaranteed to ever return
>    * true if dma_fence_add_callback(), dma_fence_wait() or
> - * dma_fence_enable_sw_signaling() haven't been called before.
> + * dma_fence_enable_signaling() haven't been called before.
>    *
>    * It's recommended for seqno fences to call dma_fence_signal when the
>    * operation is complete, it makes it possible to prevent issues from

