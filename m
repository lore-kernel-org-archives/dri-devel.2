Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEA4CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2155E10E359;
	Tue,  6 Oct 2026 13:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kj584qAZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AE210E359
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:11:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 93FFF6022C;
 Tue,  6 Oct 2026 13:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F2D1F000FF;
 Tue,  6 Oct 2026 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791292315;
 bh=XyzpIdZ169f+bYLUduLxbD03IjA+J5BpiwHLMJRjoF0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kj584qAZTArUpJCBcSfoqW6jS+mU2WWzDvOHnwPkNPLKk/O6s7ZgmVlQDAfb7Cy2F
 OWAW0zAkkCTqxHXnkammPUOvgDKBPY+GTv5RDnTNWFhGTFf1yilKUbbZdDd4uYgduV
 9vRjxs6M26V3EF97cnq9V9FR7PhCRIuIuARWcJObkq9/b5RxhSGQgxkgyw79WSks9S
 13PtXfxj1ECA7ArPoqIjngbIG3K/XbNk1prOLcLUIHIbgBK7RjqZWOmTyb3FUhs0B9
 GV2/3YnAIoseWZmUSJS/cVdLRDqR/faZqh5U0X8BN96JIC9KuAfmtAqau0Z+Tam6X2
 gmY5Bx39vNmWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] drm/microchip: add a driver for the Microchip
 GFX2D GPU
To: "Cyrille Pitchen" <cyrille.pitchen@microchip.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261006-cpitchen-mainline_gfx2d-v9-2-74bd3df2e183@microchip.com>
References: <20261006-cpitchen-mainline_gfx2d-v9-0-74bd3df2e183@microchip.com>
 <20261006-cpitchen-mainline_gfx2d-v9-2-74bd3df2e183@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 13:11:54 +0000
Message-Id: <20261006131155.04F2D1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] pm: unsafe hardware register access in IRQ handlers when device is=
 runtime suspended
- [High] irq: use-after-free and crash due to missing IRQ synchronization o=
n teardown
- [High] irq: hardware access crash due to requesting IRQ before enabling p=
eripheral clock
- [High] drm: double free of command rectangles and GEM objects in free_cmd=
list cleanup
- [Medium] uapi: structures use compiler-dependent enum types and contain i=
mplicit padding holes
- [Medium] mm: layering violation and API misuse via manual flush_cache_mm()
- [Medium] drm: GEM handle and object reference leak in mchp_gfx2d_ioctl_im=
port_buffer error path
- [Medium] pm: PM runtime usage count leak for running commands during tear=
down
--

commit 22d96d52a44db473414b78bd380f4a039a0bb91a
Author: Cyrille Pitchen <cyrille.pitchen@microchip.com>

drm/microchip: add a driver for the Microchip GFX2D GPU

The Microchip GFX2D is a 2D GPU, which supports very basic graphics
instructions.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_cmd.c
> index 0000000000000..b84c11c3511d5 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c
[ ... ]
> @@ -1577,15 +1577,15 @@ void mchp_gfx2d_cleanup_command_queue(struct mchp=
_gfx2d_device *priv,
>  				      bool is_clk_enabled)
>  {
>  	struct device *dev =3D priv->drm.dev;
>  	struct mchp_gfx2d_command *cmd, *tmp;
>  	uint32_t i;
> =20
>  	if (is_clk_enabled) {
>  		writel(GFX2D_IRQ_EXEND, priv->regs + GFX2D_ID);
>  		writel(GFX2D_GD_DISABLE, priv->regs + GFX2D_GD);
>  	}
> =20
>  	mutex_lock(&priv->cmdlist_mutex);
>  	list_for_each_entry_safe(cmd, tmp, &priv->running_cmdlist, cmd_node) {
>  		list_del(&cmd->cmd_node);
>  		mchp_gfx2d_release_command(priv, cmd, false);
>  		kmem_cache_free(priv->cmd_cache, cmd);
>  	}

[Severity: Medium]
Does this leak PM runtime usage counts for the running commands?

When commands are added to running_cmdlist, pm_runtime_get_noresume()
increments the usage count (in mchp_gfx2d_queue_running()). This loop
removes commands without dropping their associated PM runtime references
via pm_runtime_put_noidle(), permanently leaking the usage counter and
preventing runtime suspend.

> =20
>  	list_for_each_entry_safe(cmd, tmp, &priv->pending_cmdlist, cmd_node) {
>  		list_del(&cmd->cmd_node);
>  		mchp_gfx2d_release_command(priv, cmd, false);
>  		kmem_cache_free(priv->cmd_cache, cmd);
>  	}
>  	mutex_unlock(&priv->cmdlist_mutex);
> =20
>  	mutex_lock(&priv->free_cmdlist_mutex);
>  	list_for_each_entry_safe(cmd, tmp, &priv->free_cmdlist, cmd_node) {
>  		list_del(&cmd->cmd_node);
>  		mchp_gfx2d_release_command(priv, cmd, false);
>  		kmem_cache_free(priv->cmd_cache, cmd);
>  	}
>  	mutex_unlock(&priv->free_cmdlist_mutex);

[Severity: High]
Does this cause a double-free of command rectangles and GEM objects?

When a command completes normally, mchp_gfx2d_release_command() frees
its rectangles and drops GEM references, then places the command on
priv->free_cmdlist without clearing the pointers. This loop in
mchp_gfx2d_cleanup_command_queue() blindly re-releases commands that
have already been completely released, causing use-after-free and double-fr=
ee
issues that corrupt the slab allocator and DRM core state.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_drv.c
> index 0000000000000..d415bd94110bc 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c
[ ... ]
> @@ -71,15 +71,15 @@ static irqreturn_t mchp_gfx2d_interrupt(int irq, void=
 *dev_id)
>  {
>  	struct mchp_gfx2d_device *priv =3D dev_id;
>  	u32 status, mask, pending;
> =20
>  	status =3D readl(priv->regs + GFX2D_IS);
>  	mask =3D readl(priv->regs + GFX2D_IM);

[Severity: High]
Does this code crash with a synchronous external abort if the peripheral
clock is disabled?

The hard IRQ handler unconditionally accesses hardware registers (GFX2D_IS)
without verifying if the device is runtime active. Spurious interrupts can
trigger this path when the device is suspended and the clock is off. As
mandated by the subsystem guide, IRQ handlers must use
pm_runtime_get_if_active() before accessing hardware registers.

[ ... ]
> @@ -89,15 +89,15 @@ static irqreturn_t mchp_gfx2d_thread(int irq, void *d=
ev_id)
>  {
>  	struct mchp_gfx2d_device *priv =3D dev_id;
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	struct device *dev =3D priv->drm.dev;
>  	bool is_suspended =3D false;
>  	bool enable_exend =3D false;
> =20
>  	drm_dbg(&priv->drm, "enter IRQ thread\n");
> =20
>  	pm_runtime_get_noresume(dev);
> =20
>  	writel(GFX2D_IRQ_EXEND, priv->regs + GFX2D_ID);

[Severity: High]
Is it safe to use pm_runtime_get_noresume() here before blindly accessing
registers?

This function increments the usage counter but does not resume the device,
meaning it may still be suspended when writel() is called. This can cause
a kernel panic if the clock is disabled.

[ ... ]
> @@ -182,15 +182,15 @@ static int mchp_gfx2d_probe(struct platform_device =
*pdev)
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "failed to get the IRQ\n");
>  		ret =3D irq;
>  		goto err_exit;
>  	}
> =20
>  	ret =3D devm_request_threaded_irq(&pdev->dev, irq,
>  					mchp_gfx2d_interrupt,
>  					mchp_gfx2d_thread,
>  					0, dev_name(&pdev->dev), priv);

[Severity: High]
Could this crash if an interrupt fires immediately?

The IRQ handler is registered via devm_request_threaded_irq() before the
peripheral clock is fetched and enabled via clk_prepare_enable(). If an
interrupt line is asserted (e.g., from a previous boot or spurious event), =
the
hard IRQ handler will execute and read from a hardware register while the c=
lock
is still off.

[ ... ]
> @@ -245,15 +245,15 @@ static void mchp_gfx2d_remove(struct platform_devic=
e *pdev)
>  {
>  	struct mchp_gfx2d_device *priv =3D platform_get_drvdata(pdev);
>  	int ret;
> =20
>  	drm_dev_unregister(&priv->drm);
> =20
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	mchp_gfx2d_cleanup_command_queue(priv, !ret);
>  	if (ret) {
>  		dev_warn(&pdev->dev, "Failed to resume device on remove\n");
>  	} else {
>  		pm_runtime_put_noidle(&pdev->dev);
>  		clk_disable(priv->pclk);
>  	}
> =20
>  	pm_runtime_disable(&pdev->dev);
> =20
>  	clk_unprepare(priv->pclk);
>  }

[Severity: High]
Does this sequence create a use-after-free window for the IRQ thread?

Resources are manually torn down and the clock disabled while the devres-ma=
naged
IRQ thread is still permitted to run. Since devm_request_threaded_irq() def=
ers
IRQ teardown until after remove() returns, the IRQ thread can execute
concurrently, accessing freed memory (like priv->mbx freed in
mchp_gfx2d_cleanup_command_queue()) and unclocked registers.

[ ... ]
> @@ -265,15 +265,15 @@ static int __maybe_unused mchp_gfx2d_runtime_suspen=
d(struct device *dev)
>  	struct mchp_gfx2d_device *priv =3D dev_get_drvdata(dev);
>  	unsigned long to;
> =20
>  	mutex_lock(&priv->cmdlist_mutex);
>  	priv->is_suspended =3D true;
>  	reinit_completion(&priv->running_cmdlist_empty);
>  	mutex_unlock(&priv->cmdlist_mutex);
> =20
>  	(void)mchp_gfx2d_progress(priv);
>  	to =3D msecs_to_jiffies(GFX2D_PM_RUNTIME_SUSPEND_DELAY);
>  	if (!wait_for_completion_timeout(&priv->running_cmdlist_empty, to)) {
>  		mutex_lock(&priv->cmdlist_mutex);
>  		priv->is_suspended =3D false;
>  		pm_runtime_mark_last_busy(dev);
>  		mutex_unlock(&priv->cmdlist_mutex);
>  		writel(GFX2D_IRQ_EXEND, priv->regs + GFX2D_IE);
>  		return -EBUSY;
>  	}
> =20
>  	clk_disable(priv->pclk);

[Severity: High]
Can this tear down hardware access underneath the threaded IRQ handler?

The suspend path disables the clock the moment the completion is signaled. =
This
could race with the threaded IRQ handler still executing, causing a synchro=
nous
external abort.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c b/drivers/gpu/d=
rm/microchip/mchp_gfx2d_ioctl.c
> index 0000000000000..a989d63db7b52 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c
[ ... ]
> @@ -187,15 +187,15 @@ static int mchp_gfx2d_ioctl_import_buffer(struct dr=
m_device *dev, void *data,
>  	/* Is it the first import of this object? (gfx2d_obj->width =3D=3D 0 me=
ans it is) */
>  	if (!gfx2d_obj->width) {
>  		if (!mchp_gfx2d_valid_size(args->stride, args->height, obj->size)) {
>  			drm_gem_handle_delete(file_priv, args->handle);
>  			ret =3D -EINVAL;
>  			goto unlock;
>  		}
> =20
>  		gfx2d_obj->width =3D args->width;
>  		gfx2d_obj->height =3D args->height;
>  		gfx2d_obj->stride =3D args->stride;
>  		gfx2d_obj->format =3D args->format;
>  		/*
>  		 * Leave 'gfx2d_obj->direction' unchanged (hence set to 'DMA_NONE') as
>  		 * imported buffers (from the atmel-hlcdc driver) always use coherent
>  		 * memory (allocated with dma_alloc_wc()).
>  		 */
>  	} else {
>  		if (gfx2d_obj->width !=3D args->width ||
>  		    gfx2d_obj->height !=3D args->height ||
>  		    gfx2d_obj->stride !=3D args->stride ||
>  		    gfx2d_obj->format !=3D args->format)
>  			ret =3D -EINVAL;
>  	}
> =20
>  unlock:
>  	mutex_unlock(&gfx2d_obj->mutex);

[Severity: Medium]
Does this error path leak the GEM handle and object reference?

If the buffer was already imported but the new parameters do not match, the=
 code
sets ret =3D -EINVAL and jumps to unlock. It misses the
drm_gem_handle_delete(file_priv, args->handle) call that is correctly prese=
nt
in the other error path, leaking a GEM object reference and an allocated DRM
GEM handle.

[ ... ]
> @@ -301,15 +301,15 @@ static int mchp_gfx2d_ioctl_sync_for_gpu(struct drm=
_device *dev, void *data,
>  					 struct drm_file *file_priv)
>  {
>  	struct mchp_gfx2d_device *priv =3D drm_to_dev(dev);
>  	struct drm_mchp_gfx2d_sync_for_gpu *args =3D data;
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	enum dma_data_direction dir;
>  	struct drm_gem_object *obj;
> =20
>  	obj =3D drm_gem_object_lookup(file_priv, args->handle);
>  	if (!obj)
>  		return -ENOENT;
> =20
>  	gfx2d_obj =3D to_mchp_gfx2d_bo(obj);
> =20
>  	dir =3D gfx2d_obj->direction;
>  	if (valid_dma_direction(dir)) {
>  		dma_sync_single_for_device(dev->dev, gfx2d_obj->base.dma_addr,
>  					   obj->size, dir);
> =20
>  		if (priv->caps->has_cache_aliasing && current->mm)
>  			flush_cache_mm(current->mm);

[Severity: Medium]
Is it appropriate to bypass standard DMA coherence primitives here?

Directly calling flush_cache_mm(current->mm) performs an inefficient
whole-address-space cache flush and uses a low-level mm API which may not
be exported for loadable modules or behave uniformly across architectures.
The driver should rely on standard dma_sync_single_for_device() or DRM
cache helpers.

> diff --git a/include/uapi/drm/microchip_drm.h b/include/uapi/drm/microchi=
p_drm.h
> index 0000000000000..c7c4436276387 100644
> --- /dev/null
> +++ b/include/uapi/drm/microchip_drm.h
[ ... ]
> @@ -148,15 +148,15 @@ struct drm_mchp_gfx2d_rop {
>  	__u32 mask_handle;
>  	enum drm_mchp_gfx2d_rop_mode mode;
>  	__u8 high;
>  	__u8 low;
>  };
> =20
>  struct drm_mchp_gfx2d_submit {
>  	__u64 rectangles;
>  	__u32 num_rectangles;
>  	__u32 target_handle;
>  	struct drm_mchp_gfx2d_source sources[2];
>  	enum drm_mchp_gfx2d_operation operation;
>  	union {
>  		struct drm_mchp_gfx2d_fill fill;
>  		struct drm_mchp_gfx2d_blend blend;
>  		struct drm_mchp_gfx2d_rop rop;
>  	};
>  };

[Severity: Medium]
Are these structures safe for the Application Binary Interface (ABI)?

The UAPI structure drm_mchp_gfx2d_submit uses a C enum type which has an
implementation-defined size, and the union results in 4 bytes of implicit
padding at the end of the structure due to leading __u64 alignment. This
can cause incompatibility between 32-bit and 64-bit userspace or across
different compiler flags. UAPI structures must use explicitly sized types
like __u32.

[ ... ]
> @@ -224,15 +224,15 @@ struct drm_mchp_gfx2d_alloc_buffer {
>  	__u32 size;     /* in bytes for mmap() */
>  	__u16 width;
>  	__u16 height;
>  	__u16 stride;
>  	enum drm_mchp_gfx2d_pixel_format format;
>  	enum drm_mchp_gfx2d_direction direction;
> =20
>  	__u32 handle;
>  	__u64 offset;
>  };

[Severity: Medium]
Does this UAPI structure also contain implicit padding holes and enum types?

There is a 2-byte implicit padding hole after the __u16 stride field, and
enum types are used for format and direction. Explicit padding fields
and explicitly sized types should be used.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-cpitchen-m=
ainline_gfx2d-v9-0-74bd3df2e183@microchip.com?part=3D2
