Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCDDC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2064F10E903;
	Mon,  6 Jul 2026 11:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tDolZ/YH";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD1210E8FB
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:47:48 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-51c4436d02cso10949791cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783338467; x=1783943267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jeUzzNuc68hNQnQNK1WEGB7MmGEA3c6zNELlf0L56qE=;
 b=tDolZ/YHQsh3obCKHSirziyv8MdEeJil49/04q0UUy4MQxOLzLqVLP7cNvptL7H/X6
 M66IBapubRcGTxA032ZaMkWI3lPwJfxQK7l5u4cqdIyKgolrBomHvBAJt/F70bWmRgCf
 6LdvcAiZWqvWfCNkHW+656KIK/4HR+08lmlrmfybrCGtXPR82Qua5yZw7Dr26kS4XO3l
 Hd7UA/cDfUJykpaPLSh9pl2mYIPiVSJK5fskScDzmysnA7fVoVkHSAjxcspy4m6AGCma
 8AWt2THPWmxR+31m7Zc/3d5ZEFeNit5FYcMBYf82BPy9x29ojw501DCVF5qSfBa7Y2Wi
 v9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783338467; x=1783943267;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jeUzzNuc68hNQnQNK1WEGB7MmGEA3c6zNELlf0L56qE=;
 b=E0BTggM7xZaw85eYeGMF6gCzFt4R7tVK7gWZTGKJMzz7LOfVnRknX+pGtzbE9zkAk0
 AVUd7tYKO6ZwPjUjYQYU9odCKbjclo7Tfc1Oaqr/SXxZlRVWlHEKrX6meSKUyTKtEeL8
 ISOJ0jB/4VB1GVxcahnnKzcJ3qs3pAEoIHBWbAPWZAL23uvXVHHpyOWnv851Za56a9JG
 M9RlE4Nh/UL54w4+Qv4X31CJV0yaTsCMCEfvmxOgGyn2RT5/x4NSZWxvJsM4Tzf7McmA
 7k/R9gat5I5CUHJwXtetAgJNsweuO0PQREvzgDq8XUIP0FjoIGy22NWkxlyAJ7m+46yB
 D//g==
X-Gm-Message-State: AOJu0Yx8pmE59UvJSgmfq2nEMoZebrMSJD7AkX4/jilne3tLtjthe+BQ
 LP4AFKATTcDX95agJyaNI5RQBsqnMUo+xlTov45TvsrDDd73tZxaiYQsKUa73g==
X-Gm-Gg: AfdE7cmj3j3wy/X4ro+++GY1VTockf0pP2YdYiumpQnRHKy8pt3w6S1ApVV4RNmoKVl
 hFyCXgeVxzN73LQAo9D49fLqaTxJZ9xeK7Di2+Bbob7Sx1LkMONxTSb0IpowzBim29DBnw1mLov
 a0toPyL7sd8JxnE2P6iW70/Sami4PSjqZ3zlAV4FWNlgj9WNlePrSXWWRshpw4ITsI/QKdML8Sm
 4IkQ0Uxb66/Qe7Qv4KDEoUelSTlutZ6AUpc8BmDko8eodUbcNAVNymlnckoXW2Isw8ZXzt2M0Pd
 8taXkx7QGobYssrHBxvl5RD4Coqn3w9P00YqHofHRqrXenIefHAdMYxk0Pp/a4ZeqbXfd0ZTIp4
 sFAl/gk8MjMYqru1a1vYij1HQy6sjAwzAVpdzAY7Knb47D+c9alb4nL49GxfRJ0aWpcN0oPff50
 Jx3ibyAYa05hBqVYDdJny3l1o+HjcGmdFuPPKdO50AK5Is
X-Received: by 2002:a05:622a:4009:b0:51a:8c99:1f14 with SMTP id
 d75a77b69052e-51c748af7b5mr485761cf.67.1783338466816; 
 Mon, 06 Jul 2026 04:47:46 -0700 (PDT)
Received: from [10.254.122.221] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41b7671csm95918691cf.13.2026.07.06.04.47.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:47:46 -0700 (PDT)
Message-ID: <c3fe849a-9ffa-4635-ba5d-782014000e90@gmail.com>
Date: Mon, 6 Jul 2026 13:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] drm/ttm: replace TTMs refcount with the DRM
 refcount v4
To: Natalie Vock <nat@pixelcluster.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
 <20260706-ttm_2_drm_exec-v2-2-4bf6bfc0d320@pixelcluster.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260706-ttm_2_drm_exec-v2-2-4bf6bfc0d320@pixelcluster.dev>
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

On 7/6/26 12:07, Natalie Vock wrote:
> Instead of keeping a separate reference count for the TTM object also use
> the reference count for DRM GEM objects inside TTM.
> 
> Apart from avoiding two reference counts for one object this approach has
> the clear advantage of being able to use drm_exec inside TTM.
> 
> v2: adjust XE assert as well and re-enable disabled test
> v3: handle another case in i915
> v4: set GEM driver funcs of transfer BOs to point to the TTM free
> callback (Natalie)
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Since you also made changes to the code you should probably add Co-developed-by: Natalie Vock <nat@pixelcluster.dev>. Apart from that good catch with the transfer BOs.

Can somebody else review this now?

Regards,
Christian.

> Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c          |  35 +++---
>  drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |   8 +-
>  drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c    |   2 -
>  drivers/gpu/drm/ttm/ttm_bo.c                     | 135 +++++++++++------------
>  drivers/gpu/drm/ttm/ttm_bo_internal.h            |  17 ++-
>  drivers/gpu/drm/ttm/ttm_bo_util.c                |  15 ++-
>  drivers/gpu/drm/xe/xe_bo.c                       |   2 +-
>  include/drm/ttm/ttm_bo.h                         |   9 --
>  8 files changed, 111 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index df3fcc2b1248e..642296602de69 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -939,7 +939,7 @@ void i915_ttm_adjust_lru(struct drm_i915_gem_object *obj)
>  	 * Don't manipulate the TTM LRUs while in TTM bo destruction.
>  	 * We're called through i915_ttm_delete_mem_notify().
>  	 */
> -	if (!kref_read(&bo->kref))
> +	if (!kref_read(&bo->base.refcount))
>  		return;
>  
>  	/*
> @@ -957,30 +957,21 @@ void i915_ttm_adjust_lru(struct drm_i915_gem_object *obj)
>  	 *
>  	 * TODO: consider maybe also bumping the shrinker list here when we have
>  	 * already unpinned it, which should give us something more like an LRU.
> -	 *
> -	 * TODO: There is a small window of opportunity for this function to
> -	 * get called from eviction after we've dropped the last GEM refcount,
> -	 * but before the TTM deleted flag is set on the object. Avoid
> -	 * adjusting the shrinker list in such cases, since the object is
> -	 * not available to the shrinker anyway due to its zero refcount.
> -	 * To fix this properly we should move to a TTM shrinker LRU list for
> -	 * these objects.
>  	 */
> -	if (kref_get_unless_zero(&obj->base.refcount)) {
> -		if (shrinkable != obj->mm.ttm_shrinkable) {
> -			if (shrinkable) {
> -				if (obj->mm.madv == I915_MADV_WILLNEED)
> -					__i915_gem_object_make_shrinkable(obj);
> -				else
> -					__i915_gem_object_make_purgeable(obj);
> -			} else {
> -				i915_gem_object_make_unshrinkable(obj);
> -			}
> -
> -			obj->mm.ttm_shrinkable = shrinkable;
> +	i915_gem_object_get(obj);
> +	if (shrinkable != obj->mm.ttm_shrinkable) {
> +		if (shrinkable) {
> +			if (obj->mm.madv == I915_MADV_WILLNEED)
> +				__i915_gem_object_make_shrinkable(obj);
> +			else
> +				__i915_gem_object_make_purgeable(obj);
> +		} else {
> +			i915_gem_object_make_unshrinkable(obj);
>  		}
> -		i915_gem_object_put(obj);
> +
> +		obj->mm.ttm_shrinkable = shrinkable;
>  	}
> +	i915_gem_object_put(obj);
>  
>  	/*
>  	 * Put on the correct LRU list depending on the MADV status
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> index 56ad8ef325840..904cb4da6c9b3 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -127,7 +127,7 @@ static void ttm_bo_init_reserved_sys_man(struct kunit *test)
>  	dma_resv_unlock(bo->base.resv);
>  
>  	KUNIT_EXPECT_EQ(test, err, 0);
> -	KUNIT_EXPECT_EQ(test, kref_read(&bo->kref), 1);
> +	KUNIT_EXPECT_EQ(test, kref_read(&bo->base.refcount), 1);
>  	KUNIT_EXPECT_PTR_EQ(test, bo->bdev, priv->ttm_dev);
>  	KUNIT_EXPECT_EQ(test, bo->type, bo_type);
>  	KUNIT_EXPECT_EQ(test, bo->page_alignment, PAGE_SIZE);
> @@ -176,7 +176,7 @@ static void ttm_bo_init_reserved_mock_man(struct kunit *test)
>  	dma_resv_unlock(bo->base.resv);
>  
>  	KUNIT_EXPECT_EQ(test, err, 0);
> -	KUNIT_EXPECT_EQ(test, kref_read(&bo->kref), 1);
> +	KUNIT_EXPECT_EQ(test, kref_read(&bo->base.refcount), 1);
>  	KUNIT_EXPECT_PTR_EQ(test, bo->bdev, priv->ttm_dev);
>  	KUNIT_EXPECT_EQ(test, bo->type, bo_type);
>  	KUNIT_EXPECT_EQ(test, ctx.bytes_moved, size);
> @@ -969,6 +969,8 @@ static void ttm_bo_validate_allowed_only_evict(struct kunit *test)
>  	ttm_mock_manager_fini(priv->ttm_dev, mem_multihop);
>  }
>  
> +extern const struct drm_gem_object_funcs ttm_deleted_object_funcs;
> +
>  static void ttm_bo_validate_deleted_evict(struct kunit *test)
>  {
>  	struct ttm_operation_ctx ctx_init = { }, ctx_val  = { };
> @@ -999,7 +1001,7 @@ static void ttm_bo_validate_deleted_evict(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, ttm_resource_manager_usage(man), big);
>  
>  	dma_resv_unlock(bo_big->base.resv);
> -	bo_big->deleted = true;
> +	bo_big->base.funcs = &ttm_deleted_object_funcs;
>  
>  	bo_small = ttm_bo_kunit_init(test, test->priv, small, NULL);
>  	bo_small->type = bo_type;
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> index 5cfe8f3f80d75..b7ab19e0e4b2b 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> @@ -189,8 +189,6 @@ struct ttm_buffer_object *ttm_bo_kunit_init(struct kunit *test,
>  	bo->bdev = devs->ttm_dev;
>  	bo->destroy = dummy_ttm_bo_destroy;
>  
> -	kref_init(&bo->kref);
> -
>  	return bo;
>  }
>  EXPORT_SYMBOL_GPL(ttm_bo_kunit_init);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3980f376e3ba4..2b470c1746f60 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -246,88 +246,84 @@ static void ttm_bo_delayed_delete(struct work_struct *work)
>  	ttm_bo_put(bo);
>  }
>  
> -static void ttm_bo_release(struct kref *kref)
> +/*
> + * All other callbacks should never ever be called on a deleted TTM object.
> + */
> +const struct drm_gem_object_funcs ttm_deleted_object_funcs = {
> +	.free = ttm_bo_free
> +};
> +EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_deleted_object_funcs);
> +
> +/* Returns true if the BO is about to get deleted */
> +static bool ttm_bo_is_zombie(struct ttm_buffer_object *bo)
> +{
> +	return bo->base.funcs == &ttm_deleted_object_funcs;
> +}
> +
> +void ttm_bo_fini(struct ttm_buffer_object *bo)
>  {
> -	struct ttm_buffer_object *bo =
> -	    container_of(kref, struct ttm_buffer_object, kref);
>  	struct ttm_device *bdev = bo->bdev;
>  	int ret;
>  
>  	WARN_ON_ONCE(bo->pin_count);
>  	WARN_ON_ONCE(bo->bulk_move);
>  
> -	if (!bo->deleted) {
> -		ret = ttm_bo_individualize_resv(bo);
> -		if (ret) {
> -			/* Last resort, if we fail to allocate memory for the
> -			 * fences block for the BO to become idle
> -			 */
> -			dma_resv_wait_timeout(bo->base.resv,
> -					      DMA_RESV_USAGE_BOOKKEEP, false,
> -					      30 * HZ);
> -		}
> +	ret = ttm_bo_individualize_resv(bo);
> +	if (ret) {
> +		/* Last resort, if we fail to allocate memory for the
> +		 * fences block for the BO to become idle
> +		 */
> +		dma_resv_wait_timeout(bo->base.resv, DMA_RESV_USAGE_BOOKKEEP,
> +				      false, 30 * HZ);
> +	}
>  
> -		if (bdev->funcs->release_notify)
> -			bdev->funcs->release_notify(bo);
> +	if (bo->bdev->funcs->release_notify)
> +		bo->bdev->funcs->release_notify(bo);
>  
> -		drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
> -		ttm_mem_io_free(bdev, bo->resource);
> +	drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
> +	ttm_mem_io_free(bdev, bo->resource);
>  
> -		if (!dma_resv_test_signaled(&bo->base._resv,
> -					    DMA_RESV_USAGE_BOOKKEEP) ||
> -		    (want_init_on_free() && (bo->ttm != NULL)) ||
> -		    bo->type == ttm_bo_type_sg ||
> -		    !dma_resv_trylock(bo->base.resv)) {
> -			/* The BO is not idle, resurrect it for delayed destroy */
> -			ttm_bo_flush_all_fences(bo);
> -			bo->deleted = true;
> +	if (!dma_resv_test_signaled(&bo->base._resv, DMA_RESV_USAGE_BOOKKEEP) ||
> +	    (want_init_on_free() && (bo->ttm != NULL)) ||
> +	    bo->type == ttm_bo_type_sg ||
> +	    !dma_resv_trylock(bo->base.resv)) {
> +		/* The BO is not idle, resurrect it for delayed destroy */
> +		ttm_bo_flush_all_fences(bo);
>  
> -			spin_lock(&bdev->lru_lock);
> -
> -			/*
> -			 * Make pinned bos immediately available to
> -			 * shrinkers, now that they are queued for
> -			 * destruction.
> -			 *
> -			 * FIXME: QXL is triggering this. Can be removed when the
> -			 * driver is fixed.
> -			 */
> -			if (bo->pin_count) {
> -				bo->pin_count = 0;
> -				ttm_resource_move_to_lru_tail(bo->resource);
> -			}
> +		spin_lock(&bo->bdev->lru_lock);
>  
> -			kref_init(&bo->kref);
> -			spin_unlock(&bdev->lru_lock);
> +		/*
> +		 * Make pinned bos immediately available to
> +		 * shrinkers, now that they are queued for
> +		 * destruction.
> +		 *
> +		 * FIXME: QXL is triggering this. Can be removed when the
> +		 * driver is fixed.
> +		 */
> +		if (bo->pin_count) {
> +			bo->pin_count = 0;
> +			ttm_resource_move_to_lru_tail(bo->resource);
> +		}
>  
> -			INIT_WORK(&bo->delayed_delete, ttm_bo_delayed_delete);
> +		kref_init(&bo->base.refcount);
> +		bo->base.funcs = &ttm_deleted_object_funcs;
> +		spin_unlock(&bo->bdev->lru_lock);
>  
> -			/* Schedule the worker on the closest NUMA node. This
> -			 * improves performance since system memory might be
> -			 * cleared on free and that is best done on a CPU core
> -			 * close to it.
> -			 */
> -			queue_work_node(bdev->pool.nid, bdev->wq, &bo->delayed_delete);
> -			return;
> -		}
> +		INIT_WORK(&bo->delayed_delete, ttm_bo_delayed_delete);
>  
> +		/* Schedule the worker on the closest NUMA node. This
> +		 * improves performance since system memory might be
> +		 * cleared on free and that is best done on a CPU core
> +		 * close to it.
> +		 */
> +		queue_work_node(bdev->pool.nid, bdev->wq, &bo->delayed_delete);
> +	} else {
>  		ttm_bo_cleanup_memtype_use(bo);
>  		dma_resv_unlock(bo->base.resv);
> -	}
>  
> -	atomic_dec(&ttm_glob.bo_count);
> -	bo->destroy(bo);
> -}
> -
> -/* TODO: remove! */
> -void ttm_bo_put(struct ttm_buffer_object *bo)
> -{
> -	kref_put(&bo->kref, ttm_bo_release);
> -}
> -
> -void ttm_bo_fini(struct ttm_buffer_object *bo)
> -{
> -	ttm_bo_put(bo);
> +		atomic_dec(&ttm_glob.bo_count);
> +		bo->destroy(bo);
> +	}
>  }
>  EXPORT_SYMBOL(ttm_bo_fini);
>  
> @@ -470,7 +466,7 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
>  	if (!bo->resource || bo->resource->mem_type != mem_type)
>  		goto out_bo_moved;
>  
> -	if (bo->deleted) {
> +	if (ttm_bo_is_zombie(bo)) {
>  		ret = ttm_bo_wait_ctx(bo, ctx);
>  		if (!ret)
>  			ttm_bo_cleanup_memtype_use(bo);
> @@ -524,7 +520,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>  	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
>  		return 0;
>  
> -	if (bo->deleted) {
> +	if (ttm_bo_is_zombie(bo)) {
>  		lret = ttm_bo_wait_ctx(bo, walk->arg.ctx);
>  		if (!lret)
>  			ttm_bo_cleanup_memtype_use(bo);
> @@ -624,7 +620,6 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>  void ttm_bo_pin(struct ttm_buffer_object *bo)
>  {
>  	dma_resv_assert_held(bo->base.resv);
> -	WARN_ON_ONCE(!kref_read(&bo->kref));
>  	spin_lock(&bo->bdev->lru_lock);
>  	if (bo->resource)
>  		ttm_resource_del_bulk_move(bo->resource, bo);
> @@ -643,7 +638,6 @@ EXPORT_SYMBOL(ttm_bo_pin);
>  void ttm_bo_unpin(struct ttm_buffer_object *bo)
>  {
>  	dma_resv_assert_held(bo->base.resv);
> -	WARN_ON_ONCE(!kref_read(&bo->kref));
>  	if (WARN_ON_ONCE(!bo->pin_count))
>  		return;
>  
> @@ -934,7 +928,6 @@ int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,
>  {
>  	int ret;
>  
> -	kref_init(&bo->kref);
>  	bo->bdev = bdev;
>  	bo->type = type;
>  	bo->page_alignment = alignment;
> @@ -1131,8 +1124,8 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
>  		goto out;
>  	}
>  
> -	if (bo->deleted) {
> -		pgoff_t num_pages = tt->num_pages;
> +	if (ttm_bo_is_zombie(bo)) {
> +		pgoff_t num_pages = bo->ttm->num_pages;
>  
>  		ret = ttm_bo_wait_ctx(bo, ctx);
>  		if (ret)
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_internal.h b/drivers/gpu/drm/ttm/ttm_bo_internal.h
> index e0d48eac74b03..ded2a47be0bcb 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_internal.h
> +++ b/drivers/gpu/drm/ttm/ttm_bo_internal.h
> @@ -27,6 +27,14 @@
>  
>  #include <drm/ttm/ttm_bo.h>
>  
> +static inline void ttm_bo_free(struct drm_gem_object *gobj)
> +{
> +	struct ttm_buffer_object *bo = container_of(gobj, typeof(*bo), base);
> +
> +	atomic_dec(&ttm_glob.bo_count);
> +	bo->destroy(bo);
> +}
> +
>  /**
>   * ttm_bo_get - reference a struct ttm_buffer_object
>   *
> @@ -34,7 +42,7 @@
>   */
>  static inline void ttm_bo_get(struct ttm_buffer_object *bo)
>  {
> -	kref_get(&bo->kref);
> +	drm_gem_object_get(&bo->base);
>  }
>  
>  /**
> @@ -50,11 +58,14 @@ static inline void ttm_bo_get(struct ttm_buffer_object *bo)
>  static inline __must_check struct ttm_buffer_object *
>  ttm_bo_get_unless_zero(struct ttm_buffer_object *bo)
>  {
> -	if (!kref_get_unless_zero(&bo->kref))
> +	if (!kref_get_unless_zero(&bo->base.refcount))
>  		return NULL;
>  	return bo;
>  }
>  
> -void ttm_bo_put(struct ttm_buffer_object *bo);
> +static inline void ttm_bo_put(struct ttm_buffer_object *bo)
> +{
> +	drm_gem_object_put(&bo->base);
> +}
>  
>  #endif
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 3e3c201a02226..7ed085adf1c9b 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -41,6 +41,18 @@
>  
>  #include "ttm_bo_internal.h"
>  
> +static void ttm_transfer_object_free(struct drm_gem_object *obj)
> +{
> +	struct ttm_buffer_object *bo =
> +		container_of(obj, struct ttm_buffer_object, base);
> +
> +	ttm_bo_fini(bo);
> +}
> +
> +const struct drm_gem_object_funcs ttm_transfer_object_funcs = {
> +	.free = ttm_transfer_object_free,
> +};
> +
>  struct ttm_transfer_obj {
>  	struct ttm_buffer_object base;
>  	struct ttm_buffer_object *bo;
> @@ -247,7 +259,8 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
>  	atomic_inc(&ttm_glob.bo_count);
>  	drm_vma_node_reset(&fbo->base.base.vma_node);
>  
> -	kref_init(&fbo->base.kref);
> +	kref_init(&fbo->base.base.refcount);
> +	fbo->base.base.funcs = &ttm_transfer_object_funcs;
>  	fbo->base.destroy = &ttm_transfered_destroy;
>  	fbo->base.pin_count = 0;
>  	if (bo->type != ttm_bo_type_sg)
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 85e6d9a0f575b..5843f850339c7 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1651,7 +1651,7 @@ static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
>  	struct xe_device *xe = ttm_to_xe_device(ttm_bo->bdev);
>  	bool locked;
>  
> -	xe_assert(xe, !kref_read(&ttm_bo->kref));
> +	xe_assert(xe, !kref_read(&ttm_bo->base.refcount));
>  
>  	/*
>  	 * We can typically only race with TTM trylocking under the
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 8310bc3d55f90..1eae9eea5ff32 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -78,11 +78,8 @@ enum ttm_bo_type {
>   * @type: The bo type.
>   * @page_alignment: Page alignment.
>   * @destroy: Destruction function. If NULL, kfree is used.
> - * @kref: Reference count of this buffer object. When this refcount reaches
> - * zero, the object is destroyed or put on the delayed delete list.
>   * @resource: structure describing current placement.
>   * @ttm: TTM structure holding system pages.
> - * @deleted: True if the object is only a zombie and already deleted.
>   * @bulk_move: The bulk move object.
>   * @priority: Priority for LRU, BOs with lower priority are evicted first.
>   * @pin_count: Pin count.
> @@ -109,17 +106,11 @@ struct ttm_buffer_object {
>  	uint32_t page_alignment;
>  	void (*destroy) (struct ttm_buffer_object *);
>  
> -	/*
> -	* Members not needing protection.
> -	*/
> -	struct kref kref;
> -
>  	/*
>  	 * Members protected by the bo::resv::reserved lock.
>  	 */
>  	struct ttm_resource *resource;
>  	struct ttm_tt *ttm;
> -	bool deleted;
>  	struct ttm_lru_bulk_move *bulk_move;
>  	unsigned priority;
>  	unsigned pin_count;
> 

