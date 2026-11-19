Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA850606A337
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGVRaWi5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365F811240E;
	Thu, 19 Nov 2026 13:42:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534EB112420
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:42:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22B65479CB;
 Thu, 19 Nov 2026 13:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C359A1F000C7;
 Thu, 19 Nov 2026 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795095735;
 bh=hNbJgyKjbUc12nWcRCMDjRMNZXHCN2KdSgFAJxX8OaU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dGVRaWi5+RHXF7Jeyqq9pqIRzCrEE6DaIyyrLEkG/Yh8BhdkMpYyXGwvmBvsCII7p
 WfDVpSONDZkWzv4sEogaHCtMmrYzggvMx1u8EL75UFLKJrArDN8CVkn0J3Vi0t+3do
 rhT+bXy7H+n44bcmPqR4LjOpBBviEaui+aOzJrgr7JQ3IT25KgGrgXTYjcAkYAJUZP
 eXzg9KoXKqWEaJyqoeJToEldjYSqKpSShDV8dpi0frtdqkKm/dEvwLu7VealhxXMLt
 M2EOh5HIlb7wN1CUTz4jYA8MmgDAdS8seCcqyv/MWWeOQ8pnn4fMIStfkKqIxZbT4I
 hzEXmKzSShTUw==
Message-ID: <sashiko-outbox-223192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dma-buf/dma-fence: Ensure correct ordering in
 dma_fence_timestamp()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261119131830.2535266-3-phasta@kernel.org>
References: <20261119131830.2535266-2-phasta@kernel.org>
 <20261119131830.2535266-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:42:14 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dma-buf/dma-fence: dma_fence_timestamp() reads cb_list.next
  on i915 fences
--

commit 095b11917635c3969d6a6f93941ebe8376eacd96
Author: Philipp Stanner <phasta@kernel.org>

dma-buf/dma-fence: Ensure correct ordering in dma_fence_timestamp()

This commit replaces the lockless test_bit() and cpu_relax() loop in
dma_fence_timestamp() with fence spinlock acquisition to ensure memory
ordering when reading fence->timestamp.

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3b..34aefb63a7fe8 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -708,13 +708,17 @@ static inline void dma_fence_set_error(struct dma_f=
ence *fence,
>   */
>  static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
>  {
> -	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
> -		return ktime_get();
> +	unsigned long flags;
> +	ktime_t ret;
> =20
> -	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
> -		cpu_relax();
> +	dma_fence_lock_irqsave(fence, flags);
> +	if (WARN_ON(!dma_fence_test_signaled_flag(fence)))
> +		ret =3D ktime_get();
> +	else
> +		ret =3D fence->timestamp;
> +	dma_fence_unlock_irqrestore(fence, flags);
> =20
> -	return fence->timestamp;
> +	return ret;
>  }
> =20
>  signed long dma_fence_wait_timeout(struct dma_fence *,

[Severity: Medium]
Can dma_fence_timestamp() read fence->cb_list.next instead of a valid
timestamp when a fence signals in two phases?

In struct dma_fence, cb_list and timestamp share an anonymous union.
i915 signals request fences in two phases in
drivers/gpu/drm/i915/gt/intel_breadcrumbs.c: __dma_fence_signal() first
sets DMA_FENCE_FLAG_SIGNALED_BIT without holding rq->lock, and
signal_irq_work() only later acquires rq->lock, replaces cb_list, and
calls __dma_fence_signal__timestamp() to write fence->timestamp and set
DMA_FENCE_FLAG_TIMESTAMP_BIT:

CPU0                                    CPU1
irq_signal_request()
  __dma_fence_signal(&rq->fence)
    test_and_set_bit(SIGNALED_BIT, ...)
  irq_work_queue(&b->irq_work)
                                        sync_file_ioctl_fence_info()
                                          sync_fill_fence_info()
                                            dma_fence_is_signaled() -> true
                                            dma_fence_timestamp()
                                              spin_lock(&rq->lock)
                                              ret =3D fence->timestamp
                                              <-- reads fence->cb_list.next
                                              spin_unlock(&rq->lock)
signal_irq_work()
  spin_lock(&rq->lock)
  list_replace(&rq->fence.cb_list, ...)
  __dma_fence_signal__timestamp()
    fence->timestamp =3D timestamp
    set_bit(TIMESTAMP_BIT, ...)
  spin_unlock(&rq->lock)

Because dma_fence_timestamp() no longer waits for
DMA_FENCE_FLAG_TIMESTAMP_BIT, callers such as sync_fill_fence_info() can
read the raw kernel pointer in fence->cb_list.next as the completion
timestamp and copy it to userspace in info->timestamp_ns.

Also, the kernel-doc comment above dma_fence_timestamp() still states
that this helper busy-waits for the timestamp to appear.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119131830.2535=
266-2-phasta@kernel.org?part=3D1
