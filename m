Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176F606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOZ41S3C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CF310E09C;
	Thu, 12 Nov 2026 13:17:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209BF11211D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:17:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A62D2470BB;
 Thu, 12 Nov 2026 13:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5641F00A05;
 Thu, 12 Nov 2026 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794489425;
 bh=ozFLT3NuimNqyGCMesmqkyiRpMwm4IvI5DwhpyOVBPM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XOZ41S3CvKgQ/1n8os/lqLku/MOROTPOctM98X4l2U4sU7ICUJr3fBqndihsR/C3C
 zFgcAQH8n+6jJdR1eEEBAjQeHAwJB25yg3yXJtmm+wZnMR8D8DWRAfFX84VXRUZwlT
 SHbl6T4rv3uN+1kV1xJ0/LvJYDiTWQ1yEt6jQ1zIDOSw2tVnYFsCj8wIMPGjxPzLTX
 jMP39uI0XKm6I+aH7yo4U4NGQPWUBWFcNot0Uz21Q/QUF+V+9FSYdkObjcOA5ZN5Wu
 /7eLit9v2QqqOx4tyMHo6rso8FHr90nEq58hCpZTf5afk+Z6KCnyiAiVqKFTqZHnza
 l4f9AwZQxRehg==
Message-ID: <sashiko-outbox-211159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/vc4: Complete async page flips from an ordered
 workqueue
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-vc4-async-flip-fixes-v1-2-42449a703840@igalia.com>
References: <20261112-vc4-async-flip-fixes-v1-0-42449a703840@igalia.com>
 <20261112-vc4-async-flip-fixes-v1-2-42449a703840@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:17:05 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/vc4: inline flip in vc4_async_set_fence_cb() overtakes
  pending flips
- [Medium] drm/vc4: NULL data->name and inverted drmm order in
  __vc4_crtc_init()
--

commit 350614eb18304f31f6b7fcd5f4826c9bda20f32b
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Complete async page flips from an ordered workqueue

This commit defers async page flip completion from the dma_fence callback to
a per-CRTC ordered workqueue so that sleeping operations do not run in
atomic context.

> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crt=
c.c
> index c558b527c7e60..623b636a03652 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -884,15 +884,18 @@ struct vc4_async_flip_state {
>  	struct drm_framebuffer *fb;
>  	struct drm_framebuffer *old_fb;
>  	struct drm_pending_vblank_event *event;
> +	struct dma_fence *fence;
>  	struct dma_fence_cb cb;
> +	struct work_struct work;
>  };
> =20
> -/* Called when the V3D execution for the BO being flipped to is done, so=
 that
> - * we can actually update the plane's address to point to it.
> +/* Executed when the V3D execution for the BO being flipped to is done, =
so
> + * that we can actually update the plane's address to point to it.
>   */
> -static void
> -vc4_async_page_flip_complete(struct vc4_async_flip_state *flip_state)
> +static void vc4_async_page_flip_work(struct work_struct *work)
>  {
> +	struct vc4_async_flip_state *flip_state =3D
> +		container_of(work, struct vc4_async_flip_state, work);
>  	struct drm_crtc *crtc =3D flip_state->crtc;
>  	struct drm_device *dev =3D crtc->dev;
>  	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
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
Can an inline flip in vc4_async_set_fence_cb() overtake or race with an
earlier flip whose fence has not yet queued its work item?

flush_workqueue() only waits for work items already on async_flip_wq.  If
flip 1 (to fb1) is still waiting on an unsignaled fence when flip 2 (to fb2,
with no fence or an already-signaled fence) runs, flip 2 completes inline
first:

CPU0 (ioctl)                              CPU1 (kworker)
vc4_async_page_flip_common() [flip 1, fb1]
  plane->state->fb =3D fb1
  dma_fence_add_callback(fence1, ...)

vc4_async_page_flip_common() [flip 2, fb2]
  flip2->old_fb =3D fb1
  plane->state->fb =3D fb2
  flush_workqueue(async_flip_wq)
  vc4_async_page_flip_work(flip2)
    vc4_plane_async_set_fb(plane, fb2)
    vc4_bo_dec_usecnt(fb1)
    drm_framebuffer_put(fb1)
                                          <fence1 signals, queues work>
                                          vc4_async_page_flip_work(flip1)
                                            vc4_plane_async_set_fb(plane, f=
b1)
                                            drm_framebuffer_put(fb1)
                                              <-- HVS scans out unreference=
d fb1

If fence1 signals around the time of flip 2, both vc4_async_page_flip_work()
calls can also run concurrently and race in vc4_plane_async_set_fb() on
vc4_state->dlist and vc4_state->hw_dlist without locking.  When flip 1
finishes after flip 2, it overwrites the display list with the older fb1 and
drops flip 1's reference to fb1 after flip 2 already dropped fb1's old_fb
reference and BO usecnt, leaving the HVS scanning out a framebuffer whose
references and usecnt have been released.

[ ... ]

> @@ -1387,7 +1395,13 @@ int __vc4_crtc_init(struct drm_device *drm,
>  	vc4_crtc->data =3D data;
>  	vc4_crtc->pdev =3D pdev;
>  	vc4_crtc->feeds_txp =3D feeds_txp;
> +	vc4_crtc->async_flip_wq =3D drmm_alloc_ordered_workqueue(drm, "%s-async=
-flip",
> +							       0, data->name);
> +	if (IS_ERR(vc4_crtc->async_flip_wq))
> +		return PTR_ERR(vc4_crtc->async_flip_wq);
> +
>  	spin_lock_init(&vc4_crtc->irq_lock);
> +
>  	ret =3D drmm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
>  					 crtc_funcs, data->name);

[Severity: Medium]
Does allocating async_flip_wq before drmm_crtc_init_with_planes() pass a
NULL data->name on BCM2712 and invert the drmm teardown order?

bcm2712_pv0_data and bcm2712_pv1_data leave .base.name as NULL and rely on
drmm_crtc_init_with_planes() to assign a default crtc->name, so data->name
formats the workqueue name as "(null)-async-flip" on Raspberry Pi 5.

In addition, drmm actions run in reverse registration order, so
drmm_crtc_init_with_planes_cleanup() calls drm_crtc_cleanup() and zeroes
*crtc (including crtc->dev and crtc->primary) before
__drmm_workqueue_release() drains and destroys async_flip_wq.  Allocating
the workqueue after drmm_crtc_init_with_planes() using crtc->name avoids
both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-vc4-async-=
flip-fixes-v1-0-42449a703840@igalia.com?part=3D2
