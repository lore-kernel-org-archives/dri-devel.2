Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FE7C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9773510E3F4;
	Thu, 27 Aug 2026 13:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WMSEtkOO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5207E10E3F4;
 Thu, 27 Aug 2026 13:31:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 72561600DB;
 Thu, 27 Aug 2026 13:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA0D1F00A3A;
 Thu, 27 Aug 2026 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787837513;
 bh=lims4Yjr4mNDBCy10TiCmuASdsWQAEZQN+PZOJtC1Dw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WMSEtkOOx0CtiPKb0qIl25CfF1dpHQKTzeyiOWAEAxdAMC9GRtqecAAOjIC+4IhWC
 pT7k3p2vVC3U2jQaSxCf1gwsn86W9j8JMu0/OtDLHUBVJ8FxAA+EwWcQXYvtAtjuWm
 mbX1U1fZe9o7vfOBuyPXGsVkkrDbCGRzH9YP4CWI4c+j9rywPvWg1ASVPtKiRDpWGF
 x67swE6B9qIsjlK3jRjCbV04Dr+FysvDVPXbb9ebqrpCYoHfHVn0hYS21XH42KyN6R
 7Wq6DnDY20XGNZokucW5KuKVNMNm8iQ+pnSEU0rzaUgKfiIhI0XcDjQPgVxZ2I/MUL
 qO/bX4gl4s3hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] dma-buf: Inline dma_resv_init and remove
 allocated flag
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-11-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-11-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:31:52 +0000
Message-Id: <20260827133152.DDA0D1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Synchronous freeing of shared dma_resv objects causes Use-Afte=
r-Free for concurrent lockless RCU readers.
- [High] Drivers like i915 leak dynamically allocated dma_resv objects when=
 destroying GEM objects because they bypass standard DRM cleanup routines.
--

commit d696682993c0c4cb40a8a895d00e6e7b158307dd
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

dma-buf: Inline dma_resv_init and remove allocated flag

This commit migrates all dma_resv object initializations directly into
dma_resv_alloc() and removes the dma_resv_init() function. It also makes
dma_resv objects strictly dynamically allocated, removing the allocated
flag and simplifying the cleanup in dma_resv_release() to an unconditional
kfree().

> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index 1251b18e1b540..b553ad9c87445 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
[ ... ]
> -/**
> - * dma_resv_init - initialize a reservation object
> - * @obj: the reservation object
> - */
> -void dma_resv_init(struct dma_resv *obj)
> -{
> -	kref_init(&obj->refcount);
> -	obj->allocated =3D false;
> -	ww_mutex_init(&obj->lock, &reservation_ww_class);
> -
> -	RCU_INIT_POINTER(obj->fences, NULL);
> -}
> -EXPORT_SYMBOL(dma_resv_init);

[Severity: High]
Does replacing the static initialization with dynamic allocation via
dma_resv_alloc() cause memory leaks in drivers that bypass standard DRM
cleanup routines?

Drivers like i915 use custom cleanup logic. For instance,
i915_gem_object_alloc() calls drm_gem_private_object_init(), which
dynamically allocates obj->resv via dma_resv_alloc(). When the object is
freed, i915 uses __i915_gem_free_object(), which bypasses
drm_gem_object_release() and only calls __i915_gem_object_fini().

Since dma_resv_fini() was removed from __i915_gem_object_fini() and not
replaced with a call to dma_resv_put(obj->base.resv), the reference is
never dropped. Could this permanently leak the dma_resv allocation on every
GEM object destruction?

[ ... ]
> @@ -159,8 +146,7 @@ static void dma_resv_release(struct kref *kref)
> =20
>  	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
>  	ww_mutex_destroy(&obj->lock);
> -	if (obj->allocated)
> -		kfree(obj);
> +	kfree(obj);
>  }

[Severity: Critical]
Does this synchronous free cause a use-after-free for concurrent lockless
RCU readers?

In the i915 driver, GEM objects are destroyed using call_rcu() (via
__i915_gem_free_object_rcu). Lockless readers like i915_gem_busy_ioctl()
look up objects under rcu_read_lock() and access obj->base.resv.

If an object shares its resv instance (e.g., via obj->shares_resv_from with
an i915_address_space), __i915_gem_free_object() drops the lock reference
synchronously via i915_vm_resv_put(). If that drops the last reference,
dma_resv_release() synchronously frees the memory here.

However, the GEM object itself remains valid during the RCU grace period.
Can concurrent RCU readers dereference the already freed dma_resv pointer
when calling dma_resv_iter_begin(&cursor, obj->base.resv, ...) in
i915_gem_busy_ioctl()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D10
