Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B26606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 04:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZN9SgMLp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7780010E157;
	Thu,  5 Nov 2026 04:30:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CF510E157
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 04:30:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F101B601DE;
 Thu,  5 Nov 2026 04:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858121F00919;
 Thu,  5 Nov 2026 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793853019;
 bh=bf9OiT99iFCzWJtLX2orH8baD7k+xbX5Uyhz9Fejpyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZN9SgMLpuJq/A+cQEeVRbuXgqnZ9m5coz6WkEnEFMkOFo7TBnxjFNcbETgaORAoeF
 gdV547LeFyDCJ08H4BuNdZWW+M+KBVsQzjC0WONoOvWaEG5xbyMjTUNngpARUze2rr
 jqWSh8GyXr0quWMFbGL5/oyI4JXFp4gVC6NIXuAm1leXCLkVOZ9UQwyUczdHqW+qlH
 gLsgxys7eUlN5puc/UUH8GuXBDYNPNPmXOIzO2NJU50ZC8dh8YamefhP9xR66DD/Mc
 kunHEyc3p8vbHEaIQnHVby+WtC95zIQKrfQMrBMGCy+OknvkCyaDcPIV3RqGoHNxhV
 fKB7jiUFT9FUw==
Message-ID: <sashiko-outbox-198550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf/sw_sync: Optimize the retrieval of fence
 reference counts
To: "Edward Adam Davis" <eadavis@sina.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261105041446.51979-1-eadavis@sina.com>
References: <6aead2eb.3c6f2eba.20048d.0000.GAE@google.com>
 <20261105041446.51979-1-eadavis@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 04:30:17 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dma-buf: dma_fence_get() uses kref_get_unless_zero() breaking API =
contract
- [High] dma-buf/sw_sync: sync_timeline_signal() leaves zero-refcount pt li=
nked
--

commit 6ff0958843bbbad778cdc3d38a038557ac00bd49
Author: Edward Adam Davis <eadavis@sina.com>

dma-buf/sw_sync: Optimize the retrieval of fence reference counts

This commit changes dma_fence_get() to use kref_get_unless_zero() and updat=
es
sync_timeline_signal() to skip fences when dma_fence_get() returns NULL. Th=
is
is intended to avoid a refcount addition-on-zero when racing with fence rel=
ease
in sw_sync.

> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9e..ad60ad5e5cd9e 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -221,7 +221,8 @@ static void sync_timeline_signal(struct sync_timeline=
 *obj, unsigned int inc)
>  		if (!timeline_fence_signaled(&pt->base))
>  			break;
> =20
> -		dma_fence_get(&pt->base);
> +		if (!dma_fence_get(&pt->base))
> +			continue;

[Severity: High]
When acquiring a reference to pt->base fails because its refcount has alrea=
dy
dropped to zero on another CPU, is it safe to continue without unlinking pt
from obj->pt_list and obj->pt_tree?

Continuing here leaves a fence with pt->base.seqno <=3D obj->value linked a=
t the
head of obj->pt_list and in obj->pt_tree until timeline_fence_release()
acquires obj->lock:

drivers/dma-buf/sw_sync.c:timeline_fence_release() {
	...
	dma_fence_lock_irqsave(fence, flags);
	if (!list_empty(&pt->link)) {
		list_del(&pt->link);
		rb_erase(&pt->node, &parent->pt_tree);
	}
	dma_fence_unlock_irqrestore(fence, flags);
	...
}

Before timeline_fence_release() takes obj->lock, leaving this stale entry
linked can cause several regressions:

1. In sw_sync_ioctl_inc(), increments larger than INT_MAX call
sync_timeline_signal(obj, INT_MAX) in a loop (or consecutive SW_SYNC_IOC_INC
calls may run):

	while (value > INT_MAX)  {
		sync_timeline_signal(obj, INT_MAX);
		value -=3D INT_MAX;
	}

	sync_timeline_signal(obj, value);

If obj->value advances by more than INT_MAX past the stale pt->base.seqno at
the head of obj->pt_list, the signed difference in
timeline_fence_signaled() -> __dma_fence_is_later() wraps positive.
timeline_fence_signaled(&pt->base) then returns false at the stale head ent=
ry,
causing sync_timeline_signal() to break out of the loop early without
signaling active fences later in obj->pt_list.

2. In sync_pt_create(), rbtree insertion assumes all nodes in obj->pt_tree
have seqno in (obj->value, obj->value + INT_MAX]:

			parent =3D *p;
			other =3D rb_entry(parent, typeof(*pt), node);
			cmp =3D value - other->base.seqno;

If a stale pt with seqno <=3D obj->value remains in obj->pt_tree and a new
unsignaled fence is created with value in (pt->base.seqno + INT_MAX,
obj->value + INT_MAX], cmp overflows a signed 32-bit int to a negative valu=
e.
That inserts the new fence to the left of the stale pt and ahead of earlier
active fences in obj->pt_list, corrupting the list and tree ordering even
after timeline_fence_release() later removes the stale pt.

3. If sync_info_debugfs_show() -> sync_print_obj() -> sync_print_fence() ru=
ns
while the skipped pt is still on obj->pt_list, dma_fence_get_status_locked()
calls dma_fence_is_signaled_locked(&pt->base), which sees
timeline_fence_signaled(&pt->base) is true and sets
DMA_FENCE_FLAG_SIGNALED_BIT on pt->base. If sw_sync_debugfs_release() then
runs before timeline_fence_release() acquires obj->lock:

	list_for_each_entry_safe(pt, next, &obj->pt_list, link) {
		dma_fence_set_error(&pt->base, -ENOENT);
		dma_fence_signal_locked(&pt->base);
	}

dma_fence_set_error() triggers WARN_ON(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
&fence->flags)).

Since timeline_fence_release() checks !list_empty(&pt->link) under obj->loc=
k,
should sync_timeline_signal() unlink pt with list_del_init(&pt->link) and
rb_erase(&pt->node, &obj->pt_tree) before continuing when acquiring the fen=
ce
reference fails?

> =20
>  		list_move_tail(&pt->link, &signalled);
>  		rb_erase(&pt->node, &obj->pt_tree);
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3b..4d885c8e1d4f5 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -320,8 +320,9 @@ static inline void dma_fence_put(struct dma_fence *fe=
nce)
>  static inline struct dma_fence *dma_fence_get(struct dma_fence *fence)
>  {
>  	if (fence)
> -		kref_get(&fence->refcount);
> -	return fence;
> +		if (kref_get_unless_zero(&fence->refcount))
> +			return fence;
> +	return NULL;
>  }

[Severity: High]
Does changing dma_fence_get() to use kref_get_unless_zero() break the
dma_fence_get() API contract across the kernel?

dma_fence_get() is meant for callers that already hold a valid reference to=
 a
fence, and its kernel-doc comment right above states that it returns the sa=
me
fence with its refcount increased by 1.

Replacing kref_get() with kref_get_unless_zero() here suppresses refcount_t
addition-on-zero warnings and saturation when a caller has a genuine
use-after-free bug. Because dma_fence_get() is not annotated with
__must_check, callers that do not check its return value (such as
dma_resv_add_fence(), dma_buf_poll(), dma_fence_array_enable_signaling(),
dma_fence_chain_enable_signaling(), drm_syncobj_add_point(), and
drm_syncobj_replace_fence()) will silently fail to take a reference and lat=
er
underflow the refcount in dma_fence_put(). Other callers that pass a non-NU=
LL
fence and dereference or pass the return value to container_of() (such as
i915_request_get(), sync_file_create(), dma_resv_replace_fences(), and
__dma_fence_unwrap_merge()) can unexpectedly receive NULL.

include/linux/dma-fence.h already provides dma_fence_get_rcu() right below
dma_fence_get() for acquiring a reference when the refcount might be zero:

static inline struct dma_fence *dma_fence_get_rcu(struct dma_fence *fence)
{
	if (kref_get_unless_zero(&fence->refcount))
		return fence;
	else
		return NULL;
}

And drivers/dma-buf/sw_sync.c already uses dma_fence_get_rcu() in
sync_pt_create() for this exact situation:

			} else {
				if (dma_fence_get_rcu(&other->base)) {
					sync_timeline_put(obj);
					kfree(pt);
					pt =3D other;
					goto unlock;
				}
				p =3D &parent->rb_left;
			}

Should dma_fence_get() be left unchanged and sync_timeline_signal() call
dma_fence_get_rcu(&pt->base) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105041446.5197=
9-1-eadavis@sina.com?part=3D1
