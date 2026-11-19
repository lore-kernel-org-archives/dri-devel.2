Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDC9606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QM1nUJG4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E91010E178;
	Thu, 19 Nov 2026 02:51:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B0810E178
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:51:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6E58645E8;
 Thu, 19 Nov 2026 02:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471A41F000C4;
 Thu, 19 Nov 2026 02:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795056698;
 bh=1YoF3W75Wki/EmM8xsZykc16EpdiMnyZwX5aXEK1TBo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QM1nUJG4Lskbn+EeMrarnjyLawWSUh10oPSw5ZCJBbL3NMtSr4POLiezVaXl304c+
 FMmbYO1DRvyXFrmxVU9lQCJn7NnPAPQeFm0nnyNAlX5nDONiLG4ap+ABfN+IMnaImr
 nDA+W/OLHhQuyNEoUJBOb58Wl+ADeJWF77l5w2AYfbJxIMKrbJUFK4sUW024Agnqk+
 l6vD92S8mlPAObD1fgIeJe7o2Ljz2aTdZRjM68LEVmxq69IB+87L401GWXA5Y6hSWC
 zVA8UMfMkkF8/kQa6vuIJED7CFwfjPymjRHmcGTJf5yKOC2G23MpPqzOIXTxF87LJl
 B51rKHthla2nQ==
Message-ID: <sashiko-outbox-222347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/flip: drain the flip work on cleanup
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119023604.1495603-1-shunsheng1218@gmail.com>
References: <20261119023604.1495603-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 02:51:37 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/msm: NULL deref and UAF in unref_cursor_worker() on flip
  cleanup
- [Low] drm/flip: missing Fixes: trailers on bug-fix commit
--

commit 73632c7ec76b9cf83dec08873d97bb312392eec3
Author: Yaohan Li <shunsheng1218@gmail.com>

> drm/flip: drain the flip work on cleanup
>
> drm_flip_work_cleanup() only warns when the queued or the committed list
> is not empty.  Nothing cancels the worker and nothing runs the tasks
> that are still queued, so the caller silently leaks whatever the tasks
> hold (framebuffer references, vblank references, ...) and, if the
> worker is still pending, it can run after the structure embedding the
> flip work has been freed.
>
> Cancel the worker and run the remaining tasks from
> drm_flip_work_cleanup().  The work item is the only producer of the
> committed list, so after cancel_work_sync() the two lists can be
> spliced out and iterated without holding the lock.
>
> The helper only drains the work items that exist when it is called, so
> the callers have to make sure that no new item can be queued.  Both
> in-tree callers already do:
>
>  - Rockchip VOP: rockchip_drm_unbind() runs drm_atomic_helper_shutdown()
>    before component_unbind_all(), and vop_unbind() calls
>    pm_runtime_disable() before vop_destroy_crtc().  The CRTC is disabled
>    and the device cannot be resumed when the cleanup runs, so neither
>    vop_plane_atomic_update() nor vop_crtc_atomic_flush() can queue a new
>    item, and vop_isr() returns early because
>    pm_runtime_get_if_in_use() fails.
>
>  - MSM mdp4/mdp5: msm_drm_uninit() destroys the KMS, which releases the
>    interrupt, before drm_dev_put() runs the drmm actions.  The flip
>    cleanup action is registered after drmm_crtc_alloc_with_planes(), so
>    it runs before drmm_crtc_cleanup() and after the vblank interrupt
>    that commits the work is gone.
>
> Rockchip VOP called drm_flip_work_cleanup() after drm_crtc_cleanup(),
> which memsets the CRTC.  Its worker calls drm_crtc_vblank_put() on that
> CRTC, so the drain has to happen before the CRTC is cleaned up.
>
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

[Severity: Low]
Since this fixes the missing drain in drm_flip_work_cleanup() and the
cleanup ordering in Rockchip VOP, should it include Fixes: tags?

  Fixes: cabaafc78935 ("drm: add flip-work helper")
  Fixes: 47a7eb459777 ("drm/rockchip: Unreference framebuffers from flip wo=
rk")

> diff --git a/drivers/gpu/drm/drm_flip_work.c b/drivers/gpu/drm/drm_flip_w=
ork.c
> index 52c437746d483..b8ce3966fa9ab 100644
> --- a/drivers/gpu/drm/drm_flip_work.c
> +++ b/drivers/gpu/drm/drm_flip_work.c
> @@ -149,10 +149,29 @@ EXPORT_SYMBOL(drm_flip_work_init);
>   * drm_flip_work_cleanup - cleans up flip-work
>   * @work: the flip-work to cleanup
>   *
> - * Destroy resources allocated for the flip-work
> + * Cancel the worker and run the tasks that are still queued, so that the
> + * resources they hold are released even if the work never made it to the
> + * workqueue.  Must be called before the object embedding @work is freed=
 and
> + * after the driver has stopped the code that calls drm_flip_work_queue()
> + * and drm_flip_work_commit(): only the work items that exist when this
> + * function is called are drained.
>   */
>  void drm_flip_work_cleanup(struct drm_flip_work *work)
>  {
> -	WARN_ON(!list_empty(&work->queued) || !list_empty(&work->commited));
> +	struct drm_flip_task *task, *tmp;
> +	LIST_HEAD(tasks);
> +	unsigned long flags;
> +
> +	cancel_work_sync(&work->worker);
> +
> +	spin_lock_irqsave(&work->lock, flags);
> +	list_splice_tail_init(&work->queued, &tasks);
> +	list_splice_tail_init(&work->commited, &tasks);
> +	spin_unlock_irqrestore(&work->lock, flags);
> +
> +	list_for_each_entry_safe(task, tmp, &tasks, node) {
> +		work->func(work, task->data);
> +		kfree(task);
> +	}
>  }

[Severity: High]
Can calling work->func() here cause a NULL pointer dereference and
use-after-free in MSM mdp4 and mdp5 when an uncommitted cursor task
remains in unref_cursor_work.queued at teardown?

In msm_drm_uninit(), KMS is torn down and ddev->dev_private is cleared
before drm_dev_put() runs the drmm-registered mdp4_crtc_flip_cleanup() /
mdp5_crtc_flip_cleanup() actions:

drivers/gpu/drm/msm/msm_drv.c:msm_drm_uninit() {
    ...
	if (priv->kms)
		msm_drm_kms_uninit(dev);
    ...
	ddev->dev_private =3D NULL;
	drm_dev_put(ddev);
}

msm_drm_kms_uninit() flushes kms->wq (which only runs tasks already
committed by a vblank IRQ) and then calls mdp4_destroy() or
mdp5_kms_destroy(), which drops kms->vm via drm_gpuvm_put(kms->vm).

If a cursor update was queued via mdp4_crtc_cursor_set() or
mdp5_crtc_cursor_set() without a subsequent vblank interrupt to commit it,
the task stays in unref_cursor_work.queued until drm_dev_put() runs
drm_flip_work_cleanup().  That invokes unref_cursor_worker():

drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c:unref_cursor_worker() {
	struct mdp5_crtc *mdp5_crtc =3D
		container_of(work, struct mdp5_crtc, unref_cursor_work);
	struct mdp5_kms *mdp5_kms =3D get_kms(&mdp5_crtc->base);
	struct msm_kms *kms =3D &mdp5_kms->base.base;

	msm_gem_unpin_iova(val, kms->vm);
	drm_gem_object_put(val);
}

get_kms() reads crtc->dev->dev_private (now NULL) and dereferences
priv->kms, and kms->vm has already been destroyed (along with the
devm-allocated KMS structures if an open DRM fd delayed the final
drm_dev_put() past device unbind).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119023604.1495=
603-1-shunsheng1218@gmail.com?part=3D1
