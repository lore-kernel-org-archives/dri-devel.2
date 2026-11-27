Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66633606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYpKPjKD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C4810E3EA;
	Fri, 27 Nov 2026 10:35:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0473010E3EA;
 Fri, 27 Nov 2026 10:35:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29DBC61B56;
 Fri, 27 Nov 2026 10:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263DA1F000C1;
 Fri, 27 Nov 2026 10:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795775728;
 bh=0xja+0GKMmRheGErI9HJTUJPSU5i3DYem3CYHf5b/qQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IYpKPjKDKJI9XAL8rtN0IjCUggUyK+NGi9SjVUQEze8iUjyRzKgJmlV8bJZBD3pd9
 CWOsOWfkBXCrwXkEAm1MmCWJrDiqysULB5rN79kVyzZiBwcrv+QgJiXJt2vQzSmIVN
 mGz2GpvbUmt6EAN9f0j8/9Imta+Ygt5JE0P33yCAFXLCXo4+O3UVwkg3THV4GTXlbA
 rFtgz4X+kIsK3cXXWuj0s02gLEC2ZkbHP2abHejnuqabYZM9kPfpmyYXG+zGDaG6hi
 x5TyDZDMKnycSybENb576GSyBrdLz3gsa2u+E5m78vpIfDgUeLPwBG/ky6j92wb6Da
 DC2kxqJwy3qoA==
Message-ID: <sashiko-outbox-237143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/8] drm/i915: Remove TIMESTAMP bit
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261127101812.2706432-9-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
 <20261127101812.2706432-9-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:35:27 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/i915: race in __dma_fence_signal__timestamp() leaks
  cb_list as timestamp
--

commit 2eef29a2b337dc954527ca9b1dc02ace1dc68145
Author: Philipp Stanner <phasta@kernel.org>

drm/i915: Remove TIMESTAMP bit

This commit removes the set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags)
call from __dma_fence_signal__timestamp() in the i915 breadcrumb signaler.

> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/dr=
m/i915/gt/intel_breadcrumbs.c
> index c10ac0ab3bfa8..a43d774ba7793 100644
> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> @@ -138,7 +138,6 @@ static void
>  __dma_fence_signal__timestamp(struct dma_fence *fence, ktime_t timestamp)
>  {
>  	fence->timestamp =3D timestamp;
> -	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>  	trace_dma_fence_signaled(fence);
>  }

[Severity: Medium]
Can removing DMA_FENCE_FLAG_TIMESTAMP_BIT let dma_fence_timestamp() read
rq->fence.cb_list.next as the timestamp while the fence is being signaled?

In struct dma_fence, cb_list and timestamp share an anonymous union.
Unlike dma_fence_signal_timestamp_locked(), i915 splits signaling across an
unlocked window: __dma_fence_signal() sets DMA_FENCE_FLAG_SIGNALED_BIT
without holding rq->lock, and signal_irq_work() only takes rq->lock later
to detach cb_list and write fence->timestamp:

CPU0                                  CPU1
irq_signal_request()
  __dma_fence_signal(&rq->fence)
    test_and_set_bit(SIGNALED_BIT)
  irq_work_queue(&b->irq_work)
                                      sync_file_ioctl(SYNC_IOC_FILE_INFO)
                                        ...
                                          dma_fence_timestamp(&rq->fence)
                                            spin_lock(&rq->lock)
                                            test_bit(SIGNALED_BIT) -> true
                                            *ts =3D fence->timestamp
                                              <-- reads cb_list.next
                                            spin_unlock(&rq->lock)
signal_irq_work()
  spin_lock(&rq->lock)
  list_replace(&rq->fence.cb_list, ...)
  __dma_fence_signal__timestamp()
    fence->timestamp =3D timestamp
  spin_unlock(&rq->lock)

Waiters polling an i915 out-fence with SYNC_IOC_FILE_INFO or merging fences
during that window will receive a raw kernel pointer from cb_list.next as
the timestamp instead of waiting or getting a valid ktime_t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101812.2706=
432-2-phasta@kernel.org?part=3D7
