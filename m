Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E2606A335
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrgmyDDe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E62810E0F3;
	Wed,  4 Nov 2026 22:57:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDE010E0F3
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:57:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3813460207;
 Wed,  4 Nov 2026 22:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D1D1F000C1;
 Wed,  4 Nov 2026 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793833059;
 bh=l/kYBtv2IeyOOpCWY//uVazahD7yILbiOvcZNgbIoVs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RrgmyDDeS5b5fktwjMbVuUqjyG4E4Slqgi/JFeoSAp3HKX5CaPejXVWubcYORlQoZ
 jBGisGi4Tm74BPmI4d2hsMAKR92HbOWV0J00ghKAXaaNHwnOcN3QpFjN5nyOVNi3XT
 fOZbid3nAgohzLN2A+awrek5n0+T4Cv4lrRHmDf/dNdv2D2zUXvTuKZOAImBOADYnk
 yElCIzHEcthgaY6zI30Z1PTfrEAo/77oTVCskWcipqalhUnP3qdXiVT/GSBj2w+LXn
 SqOvsFeTccdiQNsDz3EAGZoB1vM54h1f5x/xXwoiF2mfqxIO9v+9Ahry+S8bNDOOTg
 Rclt/4qb7Rc/A==
Message-ID: <sashiko-outbox-198254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma-buf/sw_sync: Avoid taking references to released
 fences
To: "Kirtikumar Anandrao Ramchandani" <kirtiar15502@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <CADZg-m0hnuZ+KpqkUgwZvkhjUdN24syvc8qxuR+oZC5rkJHSNw@mail.gmail.com>
References: <CADZg-m3A_i_X0L-UBi=eMEx7RzhR_sqU5NVLrQ75JJdR=2ASKQ@mail.gmail.com>
 <CADZg-m0hnuZ+KpqkUgwZvkhjUdN24syvc8qxuR+oZC5rkJHSNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:57:39 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dma-buf/sw_sync: leaving zero-ref sync_pt on pt_list in sync_timel=
ine_signal()
--

commit 0caa32d111a52826b2d396e063857e0fec8d7dcf
Author: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>

dma-buf/sw_sync: Avoid taking references to released fences

This patch replaces dma_fence_get() with dma_fence_get_rcu() in
sync_timeline_signal() so that sync points whose reference count has
already dropped to zero are skipped rather than incremented from zero.

> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9e..7f1eadee4cdff 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -221,7 +221,8 @@ static void sync_timeline_signal(struct sync_timeline=
 *obj, unsigned int inc)
>  		if (!timeline_fence_signaled(&pt->base))
>  			break;
> =20
> -		dma_fence_get(&pt->base);
> +		if (!dma_fence_get_rcu(&pt->base))
> +			continue;

[Severity: High]
Can skipping a zero-refcount sync_pt here without removing it from
obj->pt_list and obj->pt_tree break the timeline ordering invariants?

When the last dma_fence_put() drops pt->base.refcount to zero, and
sync_timeline_signal() acquires obj->lock before timeline_fence_release()
does, obj->value is advanced past pt->base.seqno. Continuing without
unlinking pt leaves a point with seqno <=3D obj->value in obj->pt_list and
obj->pt_tree after obj->lock is dropped.

Before timeline_fence_release() acquires obj->lock, several problems can
occur:

1. In sync_pt_create(), tree insertion compares sequence numbers using
signed 32-bit difference:

    other =3D rb_entry(parent, typeof(*pt), node);
    cmp =3D value - other->base.seqno;

If a new fence is created with value in (pt->base.seqno + INT_MAX,
obj->value + INT_MAX], cmp overflows to a negative value against the stale
pt, inserting the later fence to the left of pt and placing it into
obj->pt_list ahead of earlier unsignaled fences. Even after
timeline_fence_release() removes pt, obj->pt_list remains misordered, so
subsequent sync_timeline_signal() calls will hit the later unsignaled fence
first and break out of the loop without signaling earlier fences behind it.

2. Similarly, if another sync_timeline_signal() call advances obj->value
past pt->base.seqno + INT_MAX before timeline_fence_release() runs,
timeline_fence_signaled(&pt->base) will evaluate __dma_fence_is_later() as
true at the head of obj->pt_list and break early without signaling live
fences queued behind pt.

3. If debugfs reads the timeline via sync_info_debugfs_show() ->
sync_print_obj() -> sync_print_fence() while holding obj->lock,
dma_fence_get_status_locked() calls dma_fence_is_signaled_locked(), which
signals pt->base and sets DMA_FENCE_FLAG_SIGNALED_BIT while leaving pt on
obj->pt_list. If sw_sync_debugfs_release() then iterates over obj->pt_list
before timeline_fence_release() runs:

    list_for_each_entry_safe(pt, next, &obj->pt_list, link) {
        dma_fence_set_error(&pt->base, -ENOENT);
        dma_fence_signal_locked(&pt->base);
    }

dma_fence_set_error() will trigger WARN_ON(test_bit(DMA_FENCE_FLAG_SIGNALED=
_BIT,
&fence->flags)).

Since timeline_fence_release() checks !list_empty(&pt->link) under
obj->lock:

    dma_fence_lock_irqsave(fence, flags);
    if (!list_empty(&pt->link)) {
        list_del(&pt->link);
        rb_erase(&pt->node, &parent->pt_tree);
    }
    dma_fence_unlock_irqrestore(fence, flags);

should sync_timeline_signal() still unlink pt via list_del_init(&pt->link)
and rb_erase(&pt->node, &obj->pt_tree) when dma_fence_get_rcu(&pt->base)
returns NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CADZg-m0hnuZ+KpqkUg=
wZvkhjUdN24syvc8qxuR+oZC5rkJHSNw@mail.gmail.com?part=3D1
