Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF062606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsEld7/q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68C389B01;
	Thu, 26 Nov 2026 08:29:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C2089B01
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:28:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0560A41685;
 Thu, 26 Nov 2026 08:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612B21F000C6;
 Thu, 26 Nov 2026 08:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795681734;
 bh=4+YTMB1I4r4SNT5CNL+sOUXnbNhRoIjDYRgg1xZXgQ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CsEld7/qzakhbL3211S5hEjo7BLpyLH755KQJgo9pFMeXUGT8JOtJv5WPBQcGSloz
 GS+sPT5odwEfawZEuU5xLr2HQozVOaYYUfCCI8kl7nMRNnjf9bka8n/CPVhLSnh0gv
 vpdyxK2VNGVW+Y31OGK6wYCoXCccI/Zf7WzSgkm4GCKgUaqQLd4fKQd2yA+/jsjAoh
 PiTiX4NuNhvrRJZTR+b9ju3cD2A0S7qIX2mDsNF27xdYODrLUnh7++XxjSSd/E7UxU
 lSEK7+0E2qrPhprEy0SA1UqT1ZvkHAwjL7+jUOY/ynNDKYdqMvZQhpZYaDzRvlJg/q
 veBpWbyjjrrgA==
Message-ID: <sashiko-outbox-235015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/imagination: guard fence release against device
 removal
To: "Lewis Lakerink" <lewis@retsim.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <010101a211d07798-70c4219d-e457-43d8-835c-321a7c035057-000000@us-west-2.amazonses.com>
References: <20261125082637.2839673-1-lewis@retsim.com>
 <010101a211d07798-70c4219d-e457-43d8-835c-321a7c035057-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:28:53 +0000
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
- [High] drm/imagination: pvr_queue_fence_release() leaks context when
  unplugged
--

commit 9773b5621e802ef35e9ac3c4db81027170ee1477
Author: Lewis Lakerink <lewis@retsim.com>

drm/imagination: guard fence release against device removal

This commit guards work queueing in pvr_queue_fence_release() with
drm_dev_enter(), freeing the fence directly and skipping
fence->release_work when the DRM device is marked unplugged.

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 34b826381aa2b..2a6bfb090fadd 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
> @@ -122,8 +123,19 @@ static void pvr_queue_fence_release(struct dma_fence=
 *f)
>  {
>  	struct pvr_queue_fence *fence =3D container_of(f, struct pvr_queue_fenc=
e, base);
>  	struct pvr_device *pvr_dev =3D fence->queue->ctx->pvr_dev;
> +	int idx;
> =20
> -	queue_work(pvr_dev->sched_wq, &fence->release_work);
> +	/*
> +	 * Fences held by drm_syncobj are released in drm_file_free() before
> +	 * postclose. After unplug, sched_wq and kernel_vm_ctx may already be
> +	 * torn down; free the fence directly and leak the context reference.
> +	 */
> +	if (drm_dev_enter(from_pvr_device(pvr_dev), &idx)) {
> +		queue_work(pvr_dev->sched_wq, &fence->release_work);
> +		drm_dev_exit(idx);
> +	} else {
> +		dma_fence_free(&fence->base);
> +	}
>  }

[Severity: High]
Does taking the else branch leak fence->queue->ctx on runtime device loss
as well as on driver unbind?

pvr_device_lost() calls drm_dev_unplug() at runtime when a GPU hard reset
or MMU flush fails, while the device is still bound and sched_wq is still
active.  Every pvr_queue_fence released after pvr_device_lost() (or after
drm_dev_unplug() in pvr_remove()) will skip pvr_context_put(), so
pvr_context_release() never runs.

That leaves the context's queues, firmware objects and ctx->vm_ctx
allocated, triggering WARN_ON(!list_empty(&pvr_dev->fw_dev.fw_objs.list))
in pvr_fw_fini() and WARN_ON(!xa_empty(&pvr_dev->ctx_ids)) in
pvr_context_device_fini() on unbind, and keeps ctx->vm_ctx->gpuvm_mgr's
drm_device reference alive so struct pvr_device is never freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010101a211d07798-70=
c4219d-e457-43d8-835c-321a7c035057-000000@us-west-2.amazonses.com?part=3D1
