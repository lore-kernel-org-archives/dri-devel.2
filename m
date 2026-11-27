Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7689606A324
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRZenAVf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3521129D3;
	Fri, 27 Nov 2026 10:36:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17AAE1129A7;
 Fri, 27 Nov 2026 10:36:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8337661445;
 Fri, 27 Nov 2026 10:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CE01F000C1;
 Fri, 27 Nov 2026 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795775790;
 bh=UaFDFHL9ZX8AZv2Vwzwl89NvNmx4ZQKYTQP2PuBrj5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NRZenAVf+0ZtJv+dd11INLq3NqtlPuOI7Ea12MNl+pqwjFqu1I4oohgDd15uEgbJA
 wDl+aTXWsPSDM5R+Ycxz+xAtbbJEPy7+kVrTnefIe1DSB+LvQoQl/ZGfUYDvw2mmhC
 5qnRVExbEgPkhe2HIhXCYlIk/24bJe+6urD9UFNDqGmVgTNPlnh1Eap8oBQqAO9u48
 vj8mdL9/c6lKD3/NjU8HWrCXf3eVAm2G3VDh9rwJaZOxAAXLc0iDZlxcO5Xgl+Phm/
 7c3sw5fcStH555WfWomOCL5KVSWSBRypFWAp4YYYo7RIWUwe0aQIm+6rJ9jhJxATTX
 vjjoW1Lc93Kzg==
Message-ID: <sashiko-outbox-237144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/8] dma-buf: dma-fence: Remove TIMESTAMP bit
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261127101812.2706432-10-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
 <20261127101812.2706432-10-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:36:29 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] dma-buf: sync_debug: recursive spinlock deadlock in
  sync_print_fence()
- [Medium] dma-buf: dma-fence: race in dma_fence_timestamp() with i915
  fence signaling
- [Medium] drm/sched: unlocked timestamp write in
  drm_sched_overwrite_scheduled_ts()
--

commit c345425f67e4cc845c145d7cb57df4a3a2b40256
Author: Philipp Stanner <phasta@kernel.org>

dma-buf: dma-fence: Remove TIMESTAMP bit

This commit removes DMA_FENCE_FLAG_TIMESTAMP_BIT from enum
dma_fence_flag_bits and stops setting it in
dma_fence_signal_timestamp_locked().

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 0776ca7c795e8..64d3ac4f0b8fa 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -376,9 +376,7 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
> =20
>  	/* Stash the cb_list before replacing it with the timestamp */
>  	list_replace(&fence->cb_list, &cb_list);
> -
>  	fence->timestamp =3D timestamp;
> -	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
> =20
>  	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
>  		INIT_LIST_HEAD(&cur->node);

[Severity: Medium]
Does removing DMA_FENCE_FLAG_TIMESTAMP_BIT allow dma_fence_timestamp() to
read rq->fence.cb_list.next as the timestamp on i915 request fences?

In struct dma_fence, cb_list and timestamp share a union.  i915 sets
DMA_FENCE_FLAG_SIGNALED_BIT via __dma_fence_signal() before acquiring
rq->lock to replace cb_list and write rq->fence.timestamp:

CPU0                              CPU1
irq_signal_request()
  __dma_fence_signal(&rq->fence)
    test_and_set_bit(SIGNALED_BIT,
                     &fence->flags)
                                  sync_file_ioctl_fence_info()
                                    sync_fill_fence_info()
                                      dma_fence_timestamp(&rq->fence, &ts)
                                        dma_fence_lock_irqsave(...)
                                        if (dma_fence_test_signaled_flag())
                                          *ts =3D fence->timestamp;
                                          <-- reads fence->cb_list.next
                                        dma_fence_unlock_irqrestore(...)
  irq_work_queue(&b->irq_work)
...
signal_irq_work()
  spin_lock(&rq->lock)
  list_replace(&rq->fence.cb_list, ...)
  __dma_fence_signal__timestamp(...)
  spin_unlock(&rq->lock)

Because dma_fence_timestamp() now only checks DMA_FENCE_FLAG_SIGNALED_BIT
under the fence lock, a concurrent call during this window reads the raw
kernel pointer in cb_list.next as the timestamp and copies it to userspace
in struct sync_fence_info.timestamp_ns via SYNC_IOC_FILE_INFO.

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 0a7ffda6a4cfe..7fd9393e60035 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
[ ... ]
> @@ -114,7 +113,6 @@ enum dma_fence_flag_bits {
>  	DMA_FENCE_FLAG_INLINE_LOCK_BIT,
>  	DMA_FENCE_FLAG_SEQNO64_BIT,
>  	DMA_FENCE_FLAG_SIGNALED_BIT,
> -	DMA_FENCE_FLAG_TIMESTAMP_BIT,
>  	DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> =20
>  	DMA_FENCE_FLAG_USER_BITS, /* must always be last member */

[Severity: High]
Does replacing the DMA_FENCE_FLAG_TIMESTAMP_BIT check with spinlock
serialization in dma_fence_timestamp() cause a recursive spinlock deadlock
in sync_print_obj() -> sync_print_fence()?

In drivers/dma-buf/sw_sync.c, sync_pt_create() initializes each pt->base
with &obj->lock as its fence spinlock.  When /sys/kernel/debug/sync/info is
read, sync_print_obj() already holds &obj->lock when it calls
sync_print_fence():

sync_info_debugfs_show()
  sync_print_obj()
    spin_lock(&obj->lock)
    sync_print_fence(&pt->base)
      dma_fence_timestamp(&pt->base, &ts)
        dma_fence_lock_irqsave(fence, flags)  <-- deadlocks on &obj->lock

[Severity: Medium]
With fence->timestamp now synchronized by the fence spinlock instead of
DMA_FENCE_FLAG_TIMESTAMP_BIT, is the unlocked write in
drm_sched_overwrite_scheduled_ts() a data race?

drivers/gpu/drm/scheduler/sched_main.c:drm_sched_overwrite_scheduled_ts() {
    ...
	if (dma_fence_timestamp(current_fence, &current_finished) =3D=3D 0)
		next_fence->timestamp =3D current_finished;
}

drm_sched_overwrite_scheduled_ts() only holds sched->job_list_lock when
overwriting next_fence->timestamp, racing with concurrent readers such as
amdgpu_ctx_fence_time() calling dma_fence_timestamp(&s_fence->scheduled,
&scheduled_ts) under the fence spinlock and risking torn 64-bit ktime_t
reads on 32-bit architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101812.2706=
432-2-phasta@kernel.org?part=3D8
