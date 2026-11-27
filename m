Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247A606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW1bY2Q2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F63E1129EF;
	Fri, 27 Nov 2026 10:26:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF141129E1;
 Fri, 27 Nov 2026 10:26:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E4F96277D;
 Fri, 27 Nov 2026 10:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CC71F00899;
 Fri, 27 Nov 2026 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795775162;
 bh=GoB63DtN9Oy0jScWwu1FwYjE4Q+RSkfSjv7LTIGqp7U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dW1bY2Q2h2sPM2GfG/uP+po6aEdJzAgnXxaaY7PtwNPjzfOYp8DHBvq2DhzSp/+qX
 FOgqNJvJV2i6zVV+hGAY87tofOass5JweMc7xopXJWo/NQ/d2CqFTX2Hki0496q4/H
 e7hUoQ4r3k3TmhTn9wfwzA/1wCxHpI1DJM0OuhSTb81btco21COyrrA0eU4z+UCNcL
 FkG+IZcMFwjkuv6zK/pCYTf4htHBRUhx9EbQ4vwxSML2+In1gfcwyv491lOzLJ0LSI
 fqxV+CniGUmWs4Mylh7qsCh4V37CcThr06syjQntK8VM3A3HouPhdMN0l4rZ+QwCcZ
 75e8dvYNrrU5w==
Message-ID: <sashiko-outbox-237126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/8] dma-buf: sync_debug: don't use TIMESTAMP bit
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261127101812.2706432-8-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
 <20261127101812.2706432-8-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:26:01 +0000
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
- [High] dma-buf: sync_debug: recursive spinlock deadlock in
  sync_print_fence()
--

commit 771cc9b6d800a1a39680e74552adf1782c101ea3
Author: Philipp Stanner <phasta@kernel.org>

dma-buf: sync_debug: don't use TIMESTAMP bit

This commit replaces the direct DMA_FENCE_FLAG_TIMESTAMP_BIT check in
sync_print_fence() with a call to dma_fence_timestamp().

> diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
> index 9e5d662cd4e84..58c0d00ba5b3c 100644
> --- a/drivers/dma-buf/sync_debug.c
> +++ b/drivers/dma-buf/sync_debug.c
> @@ -46,6 +46,8 @@ static void sync_print_fence(struct seq_file *s,
>  			     struct dma_fence *fence, bool show)
>  {
>  	struct sync_timeline *parent =3D dma_fence_parent(fence);
> +	struct timespec64 ts64;
> +	ktime_t ts;
>  	int status;
> =20
>  	status =3D dma_fence_get_status_locked(fence);
> @@ -55,10 +57,8 @@ static void sync_print_fence(struct seq_file *s,
>  		   show ? "_" : "",
>  		   sync_status_str(status));
> =20
> -	if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags)) {
> -		struct timespec64 ts64 =3D
> -			ktime_to_timespec64(fence->timestamp);
> -
> +	if (dma_fence_timestamp(fence, &ts) =3D=3D 0) {
> +		ts64 =3D ktime_to_timespec64(ts);
>  		seq_printf(s, "@%ptSp", &ts64);
>  	}

[Severity: High]
Does calling dma_fence_timestamp() here self-deadlock on obj->lock?

sync_pt_create() initializes each sync_pt fence with &obj->lock as its
external fence spinlock, and sync_print_obj() already holds obj->lock when =
it
calls sync_print_fence() (which is why dma_fence_get_status_locked() is used
above):

sync_info_debugfs_show()
  spin_lock_irq(&sync_timeline_list_lock)
  sync_print_obj()
    spin_lock(&obj->lock)
    sync_print_fence()
      dma_fence_timestamp()
        dma_fence_lock_irqsave()  <-- spins forever on &obj->lock

Reading /sys/kernel/debug/sync/info while any sync_timeline has a sync_pt on
obj->pt_list will deadlock the CPU with interrupts disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101812.2706=
432-2-phasta@kernel.org?part=3D6
