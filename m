Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8E606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgeX1PZR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EA310E3AF;
	Sat, 14 Nov 2026 19:40:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F1310E3AF
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 19:40:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0E3440A23;
 Sat, 14 Nov 2026 19:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95771F000C4;
 Sat, 14 Nov 2026 19:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794685245;
 bh=fToNnkuY3RIbfXXfUTqY/L6VA5rrlrIPpEyi5KOce4o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JgeX1PZRYh06v96UFTdxjSVfACMAgvnhr4abUmgPpWkNRFvgZPb2Dl3wRMb2prcA+
 9cfp9zQ8x1nwN0NSMH6Vo8n30hfmZInKXk83NsLnFL2Vy/pxhs9oEyIJCG6a05cbmc
 Vj6lE0OkGYDhOtVOiKBKZEO1L1mqvXTZ7FKeoT38nBl83B4aEUSccZd/r115xnQA6F
 vvR2v07jP+f32XkaIaqKwlQ335nm0UH7p+/ntzxxXv5LcsbXolRjF+s/Qh0uIaN6Kg
 SeJ6mEijPg2EzFyfZOO3FhpYYOXvjuT63eXvpdRWaej3e0EHXqaCoXGsfLBLBrRZ81
 XrfP65BHlY/5A==
Message-ID: <sashiko-outbox-214979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/vc4: Complete async page flips from an
 ordered workqueue
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114-vc4-async-flip-fixes-v2-2-d33cbe99ed5d@igalia.com>
References: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
 <20261114-vc4-async-flip-fixes-v2-2-d33cbe99ed5d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:40:45 +0000
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
- [High] drm/vc4: inline flip in vc4_async_set_fence_cb() races with
  pending flips
--

commit 6426f110104db1e4dcc5dd10cee848879c7ef9a8
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Complete async page flips from an ordered workqueue

This commit defers async page flip completion from the dma_fence callback
to a per-CRTC ordered workqueue so completion work that may sleep does not
run in interrupt context.

> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crt=
c.c
> index c558b527c7e60..177ee27ab6d15 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c

[ ... ]

> @@ -930,17 +933,19 @@ vc4_async_page_flip_complete(struct vc4_async_flip_=
state *flip_state)
>  		drm_framebuffer_put(flip_state->old_fb);
>  	}
> =20
> +	dma_fence_put(flip_state->fence);
>  	kfree(flip_state);
>  }
> =20
> -static void vc4_async_page_flip_fence_complete(struct dma_fence *fence,
> -					       struct dma_fence_cb *cb)
> +static void vc4_async_page_flip_fence_cb(struct dma_fence *fence,
> +					 struct dma_fence_cb *cb)
>  {
>  	struct vc4_async_flip_state *flip_state =3D
>  		container_of(cb, struct vc4_async_flip_state, cb);
> +	struct vc4_crtc *vc4_crtc =3D to_vc4_crtc(flip_state->crtc);
> =20
> -	vc4_async_page_flip_complete(flip_state);
> -	dma_fence_put(fence);
> +	/* Completing the flip may sleep, so defer it to a worker. */
> +	queue_work(vc4_crtc->async_flip_wq, &flip_state->work);
>  }
> =20
>  static int vc4_async_set_fence_cb(struct drm_device *dev,
> @@ -948,23 +953,26 @@ static int vc4_async_set_fence_cb(struct drm_device=
 *dev,
>  {
>  	struct drm_framebuffer *fb =3D flip_state->fb;
>  	struct drm_gem_dma_object *dma_bo =3D drm_fb_dma_get_gem_obj(fb, 0);
> -	struct dma_fence *fence;
> +	struct vc4_crtc *vc4_crtc =3D to_vc4_crtc(flip_state->crtc);
>  	int ret;
> =20
> -	ret =3D dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ, =
&fence);
> +	INIT_WORK(&flip_state->work, vc4_async_page_flip_work);
> +
> +	ret =3D dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ,
> +				     &flip_state->fence);
>  	if (ret)
>  		return ret;
> =20
> -	/* If there's no fence, complete the page flip immediately */
> -	if (!fence) {
> -		vc4_async_page_flip_fence_complete(fence, &flip_state->cb);
> +	if (flip_state->fence &&
> +	    !dma_fence_add_callback(flip_state->fence, &flip_state->cb,
> +				    vc4_async_page_flip_fence_cb))
>  		return 0;
> -	}
> =20
> -	/* If the fence has already been completed, complete the page flip */
> -	if (dma_fence_add_callback(fence, &flip_state->cb,
> -				   vc4_async_page_flip_fence_complete))
> -		vc4_async_page_flip_fence_complete(fence, &flip_state->cb);
> +	/* No fence or the fence has already signaled. Complete the flip
> +	 * immediately, after earlier queued flips.
> +	 */
> +	flush_workqueue(vc4_crtc->async_flip_wq);
> +	vc4_async_page_flip_work(&flip_state->work);

[Severity: High]
Can an inline vc4_async_page_flip_work() call here race with or overtake
an earlier async flip on the same CRTC?

flush_workqueue() only waits for work items already queued on
vc4_crtc->async_flip_wq.  If an earlier flip (flip1, to fb1) registered
vc4_async_page_flip_fence_cb() on an unsignaled fence, flip1->work is not
queued until that fence signals.  If a second async flip (flip2, to fb2)
on the same CRTC has no fence or an already-signaled fence:

CPU0                                    CPU1 (irq / kworker)
vc4_async_page_flip_common() [flip1]
  flip1->old_fb =3D fb0
  plane->state->fb =3D fb1
  dma_fence_add_callback(fence1, ...)

vc4_async_page_flip_common() [flip2]
  flip2->old_fb =3D fb1
  plane->state->fb =3D fb2
  flush_workqueue(async_flip_wq)
  vc4_async_page_flip_work(&flip2->work)
    vc4_plane_async_set_fb(plane, fb2)
    vc4_bo_dec_usecnt(fb1)
    drm_framebuffer_put(fb1)
                                        dma_fence_signal(fence1)
                                          queue_work(..., &flip1->work)
                                        vc4_async_page_flip_work(&flip1->wo=
rk)
                                          vc4_plane_async_set_fb(plane, fb1)
                                          drm_framebuffer_put(fb1)
                                            <-- HVS scans out unreferenced =
fb1

flip2 completes before flip1 and drops the old_fb reference and BO usecnt
for fb1.  When flip1->work later runs, it overwrites the HVS scanout
address back to fb1 and drops flip1->fb, leaving the HVS scanning out fb1
after its flip references and BO usecnt have been released.

If fence1 signals while flip2 is past flush_workqueue(), both
vc4_async_page_flip_work() instances also run concurrently on the same
plane and update vc4_state->hw_dlist and vc4_state->dlist in
vc4_plane_async_set_fb() without locking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-vc4-async-=
flip-fixes-v2-0-d33cbe99ed5d@igalia.com?part=3D2
