Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6132FC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8051410EEB4;
	Wed,  9 Sep 2026 04:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a/5Iw78b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA0C410EEB4;
 Wed,  9 Sep 2026 04:56:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AD9E601FB;
 Wed,  9 Sep 2026 04:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE911F00A3D;
 Wed,  9 Sep 2026 04:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788929774;
 bh=j8Jev1mTH4E6aeu8O24nvzH4Vw4CApKSuUsLQBbXMcI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a/5Iw78bwCL3z36Ox2zeAZAxMaOP2rPNBpi19naFG+twVBQE3LwBWqKhkri/5Xht7
 9TOnpj9TYn4jFsi4TqG7fIvasllifGvFICtbKSnB/khsQ6GsCVXp9dPFOjFapcSL4P
 Z9wMJLTrfLwvtEeQyJHjCBkNlNo7KhHUJVb5PXgJptaGS+V5JWU0R2qtET1RH1W4V0
 nGvxg0tlLQnXFI7U/698xWfPClK0WEo4ob/44D2IAupRlIh9yPe0jifc9hibQ66eL1
 CuSh77Re7a98LjI3bfCgvfpMpuXKezgYMF3V5zH/mgBShKDiInXkSaOByW0iN0zCDp
 Ipd9NnTA0Xzrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] drm: Add drm_work_fence helper
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260909044454.399340-2-srinivasan.shanmugam@amd.com>
References: <20260909044454.399340-1-srinivasan.shanmugam@amd.com>
 <20260909044454.399340-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:56:14 +0000
Message-Id: <20260909045614.AFE911F00A3D@smtp.kernel.org>
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
- [High] drm_work_fence_cancel_sync() fails to synchronize with the dma-fen=
ce callback, allowing queue_work() to be called concurrently with driver te=
ardown.
- [High] The driver's ops->destroy() callback can unexpectedly be executed =
in hard IRQ context during the cancellation race.
--

commit 781c5ea671786cbee47b9bed0159aa892cc5e2b7
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm: Add drm_work_fence helper

This commit introduces drm_work_fence, a helper that queues a work item
when a dma-fence signals. It manages dma-fence callbacks, kref lifetime,
and workqueue dispatch.

> diff --git a/drivers/gpu/drm/drm_work_fence.c b/drivers/gpu/drm/drm_work_=
fence.c
> new file mode 100644
> index 0000000000000..5e0cbc53edb80
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_work_fence.c
[ ... ]
> +static void drm_work_fence_destroy(struct kref *kref)
> +{
> +	struct drm_work_fence *wfence =3D
> +		container_of(kref, struct drm_work_fence, refcount);
> +	struct dma_fence *fence =3D wfence->fence;
> +
> +	wfence->ops->destroy(wfence);

[Severity: High]
Can this ops->destroy() callback be executed in hard IRQ context?

If a dma-fence callback races with driver teardown and queue_work() fails,
the final reference might be dropped directly from the IRQ callback:

drm_work_fence_cb() -> drm_work_fence_queue()

If queue_work() returns false, drm_work_fence_put() drops the last reference
here, triggering this destroy callback under the dma-fence spinlock with
IRQs disabled.

> +	dma_fence_put(fence);	/* NULL-safe */
> +}
[ ... ]
> +static void drm_work_fence_queue(struct drm_work_fence *wfence)
> +{
> +	if (!queue_work(wfence->wq, &wfence->work))
> +		drm_work_fence_put(wfence);
> +}

[Severity: High]
Is there a use-after-free risk if wfence->wq is accessed here during a
concurrent driver teardown?

This relies on drm_work_fence_cancel_sync() successfully synchronizing
against the callback. However, if the synchronization fails, wfence->wq
could be accessed after the workqueue has been destroyed by the caller.

[ ... ]
> +void drm_work_fence_cancel_sync(struct drm_work_fence *wfence)
> +{
> +	if (drm_work_fence_cancel(wfence))
> +		return;
> +	if (disable_work_sync(&wfence->work))
> +		drm_work_fence_put(wfence);
> +}

[Severity: High]
Does this provide the expected synchronous cancellation guarantee, or does
it leave a window for concurrent execution during teardown?

If the dma-fence signals, the callback is dequeued but hasn't called
queue_work() yet. If drm_work_fence_cancel_sync() is called concurrently:

1. drm_work_fence_cancel() calls dma_fence_remove_callback(), which
   returns false because the callback is already dequeued.
2. disable_work_sync() returns false immediately because the work is
   not yet queued.
3. The function returns, falsely indicating the work is fully canceled.

This allows the driver teardown to proceed while the in-flight callback
might then call queue_work() on a potentially destroyed workqueue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909044454.3993=
40-1-srinivasan.shanmugam@amd.com?part=3D1
