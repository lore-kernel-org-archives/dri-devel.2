Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF7CC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2482910E04C;
	Tue, 14 Jul 2026 10:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bp/UdxdA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176CF10E04C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 10:22:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 878A342DAE;
 Tue, 14 Jul 2026 10:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1AA1F000E9;
 Tue, 14 Jul 2026 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784024573;
 bh=NRtXT2w73USuRfO0yVROnqhtwi6aa2Kr/8VlPHJS2zc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bp/UdxdAwxH11GEOY4qLP5fxUfc3XrSzoz/jlFA08lVk3dNGohHXgPhEsjKnkOBDO
 as2QZNak6QeCCIKxXoCzwYK+orXOE7pvk16WtDxM5Xr+g3Vt4W5eNG02vLGR46Fb8s
 xBTjHQ6YXmguln+tl8+x0FSAsXk92oWgxouiMoZi33iCzVu6Z3xAYNy2JaP+ogcl28
 TceIEFQG14mvj/3Tz5CmVYJVdK0GiG/GmwfpM5Y0W2WZnUh0E6/uG34F7vc/HTiSnD
 f51MoxsIqpUVLtE3YUrfZA/0Svt1jmnukxaf3nO86F6fZ9xISYJuDAQYZ4qJy70eiT
 D4B+ds+/LQioA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: uninstall the IRQ before freeing the
 command buffer manager on unload
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714094511.2960308-1-fanwu01@zju.edu.cn>
References: <20260714094511.2960308-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:22:52 +0000
Message-Id: <20260714102253.3A1AA1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Use-After-Free of `cman` and `fman` in hibernation and module load=
 error paths.
- [High] List corruption in `vmw_fence_fifo_down` due to missing lock.
--

--- Patch [1]: [PATCH] drm/vmwgfx: uninstall the IRQ before freeing the com=
mand buffer manager on unload ---
commit b967a1f434a9288823516c01c5ade490f5c844f2
Author: Fan Wu <fanwu01@zju.edu.cn>

drm/vmwgfx: uninstall the IRQ before freeing the command buffer manager on =
unload

This commit reorders the unload path to drain pending fences, uninstall
the IRQ, and then free the command buffer manager. This prevents a
use-after-free where the threaded handler dereferences the manager after
it has been freed.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index 0f101aedb49a0..a35b44dd3aa46 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1181,10 +1181,11 @@ static void vmw_driver_unload(struct drm_device *=
dev)
>  	vmw_devcaps_destroy(dev_priv);
>  	vmw_vram_manager_fini(dev_priv);
>  	ttm_device_fini(&dev_priv->bdev);
> -	vmw_release_device_late(dev_priv);
> -	vmw_fence_manager_takedown(dev_priv->fman);
> +	vmw_fence_fifo_down(dev_priv->fman);

[Severity: High]
This isn't a bug introduced by this patch, but since vmw_fence_fifo_down()
is now called while the IRQ is still active, it exposes a potential list
corruption.

In drivers/gpu/drm/vmwgfx/vmwgfx_fence.c:vmw_fence_fifo_down():

	spin_lock(&fman->lock);
	fman->fifo_down =3D true;
	while (!list_empty(&fman->fence_list)) {
		...
		spin_unlock(&fman->lock);

		ret =3D vmw_fence_obj_wait(fence, false, false,
					 VMW_FENCE_WAIT_TIMEOUT);

		if (unlikely(ret !=3D 0)) {
			list_del_init(&fence->head);
			dma_fence_signal(&fence->base);
		}

If the wait times out, list_del_init() modifies the list without holding
fman->lock. Since vmw_fences_update() in the active IRQ thread could be
modifying or traversing the same fman->fence_list concurrently, could this
cause list corruption?

>  	if (dev_priv->capabilities & SVGA_CAP_IRQMASK)
>  		vmw_irq_uninstall(&dev_priv->drm);
> +	vmw_release_device_late(dev_priv);
> +	vmw_fence_manager_takedown(dev_priv->fman);

[Severity: High]
This is a pre-existing issue, but while this patch fixes the unload path,
does the same use-after-free still exist in the hibernation and module load
error paths?

In drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:vmw_pm_freeze(),
vmw_release_device_late() frees dev_priv->cman while the device IRQ is
still active. If an interrupt triggers vmw_thread_fn(), it will
dereference the freed cman.

Similarly, in vmw_driver_load(), the error path out_no_bdev calls
vmw_fence_manager_takedown() to free dev_priv->fman before
vmw_irq_uninstall() is called under out_no_fman. This leaves a window
where vmw_thread_fn() could access the freed fman if an IRQ fires.

> =20
>  	ttm_object_device_release(&dev_priv->tdev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714094511.2960=
308-1-fanwu01@zju.edu.cn?part=3D1
