Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53706CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BA510E812;
	Thu,  8 Oct 2026 13:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="moEKVMOT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CDC10E80E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:41:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB58C43991;
 Thu,  8 Oct 2026 13:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794D81F000FF;
 Thu,  8 Oct 2026 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791466899;
 bh=bP81AfWLYIFezbzP08BeEjgDRP3UokmbcHIAk/eV9nI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=moEKVMOTpU2gy3Dk5f93DAO1dVAZVk05er5NyK7GhBQ5VVWdLiLZbZc03jLVedDsh
 cC+X3D5yIWjZzHp9SGwbqay4QVy1LhyZT2la+zFf831UwXASfJyPTn80sfyAovFbzL
 2woy3zsUgvFNyil1fpFwZ/SHPGggBQKW5Q+R91v7FGwmAhcDgbHVqP+pObKUQDKyJf
 k9hrVljPMfCfo5dg+TB3Lsq8ftL04IV+tnFG9mcVZEfSfg/JV8DQBpxhlY/eGESHnq
 bmAx+M55SLzZhUCbndoIcTpbMZY25hfmayoNZ400vmVMZsUjHiwvowwGzyseVtHc/Q
 xdrq2zIC92GZQ==
Message-ID: <sashiko-outbox-164235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/5] drm/microchip: add a driver for the Microchip
 GFX2D GPU
To: "Cyrille Pitchen" <cyrille.pitchen@microchip.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-cpitchen-mainline_gfx2d-v10-2-67ca2477b3d5@microchip.com>
References: <20261008-cpitchen-mainline_gfx2d-v10-0-67ca2477b3d5@microchip.com>
 <20261008-cpitchen-mainline_gfx2d-v10-2-67ca2477b3d5@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 13:41:39 +0000
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

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] drm/microchip: unvalidated tv_nsec causes multi-second CPU stall v=
ia unbounded loop
- [High] drm/microchip: missing bounds check for ROP4 mask buffer allows DM=
A out-of-bounds read
- [High] drm/microchip: out-of-order command ID queuing permanently deadloc=
ks command completion
- [High] drm/microchip: disabling software IRQ flag before hardware interru=
pt causes infinite IRQ storm on remove
- [High] pm: unchecked pm_runtime_resume_and_get() in IRQ thread leads to P=
M usage counter underflow and bus errors
- [High] drm/microchip: missing ioctl teardown serialization causes Use-Aft=
er-Free of device resources on removal
- [High] drm/microchip: module build failure due to unexported flush_cache_=
mm()
- [High] drm/microchip: lockless read of clear-on-read GFX2D_IS register ca=
uses spurious interrupts
- [Medium] drm/microchip: holding gfx2d_obj->mutex while sleeping breaks no=
n-blocking wait semantics
- [Medium] drm/microchip: concurrent SUBMIT can access incompletely initial=
ized object properties during buffer allocation/import
- [Low] build: use of undefined macro kzalloc_obj() causes immediate build =
failure
--

commit ea5f37bc540dbea4278662c06269eada9a99aa50
Author: Cyrille Pitchen <cyrille.pitchen@microchip.com>
drm/microchip: add a driver for the Microchip GFX2D GPU

This commit introduces a new DRM driver for the Microchip GFX2D GPU.
It supports basic 2D graphics instructions like FILL, COPY, BLEND, and ROP
by queuing commands into a ring buffer.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_cmd.c
> --- a/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c
[ ... ]
> static int
> mchp_gfx2d_set_rop_params(struct mchp_gfx2d_device *priv,
> 			  struct drm_file *file_priv,
> 			  const struct drm_mchp_gfx2d_submit *args,
> 			  struct mchp_gfx2d_command *cmd)
> {
> 	uint32_t handle =3D args->rop.mask_handle;
[ ... ]
> 	if (handle) {
> 		cmd->mask =3D mchp_gfx2d_gem_addref(file_priv, handle);
> 		if (!cmd->mask)
> 			return -ENOENT;

[Severity: High]
Is there a missing bounds check for the ROP4 mask buffer here?

When the mask handle is resolved to a GEM object, its dimensions are not
validated against the operation size.

Later in mchp_gfx2d_clip_rect(), the drawing rectangle is intersected with
the target and source buffers, but the bounds of the mask buffer are ignore=
d.

Since the mask's physical DMA address is pushed to the GPU, a small mask
buffer alongside large target/source buffers could cause the GPU to perform
an out-of-bounds DMA read from physical memory.

Could this lead to hardware faults or leak adjacent physical memory content=
s?

[ ... ]
> static struct mchp_gfx2d_command *
> mchp_gfx2d_alloc_command(struct mchp_gfx2d_device *priv)
> {
> 	static atomic_t next_id;
> 	struct mchp_gfx2d_command *cmd =3D NULL;
[ ... ]
> 	memset(cmd, 0, sizeof(*cmd));
> 	cmd->id =3D (uint32_t)atomic_fetch_inc(&next_id);
>=20
> 	return cmd;
> }

[Severity: High]
Could this lockless assignment of command IDs cause a permanent deadlock?

In mchp_gfx2d_submit(), cmd->id is assigned via atomic_fetch_inc() before
priv->cmdlist_mutex is acquired. Concurrent submissions could acquire IDs
out of order.

For example, Thread A gets ID 5 and Thread B gets ID 6. They could queue
them into running_cmdlist and the hardware ring buffer in the reverse order
if Thread B acquires the lock first.

Since the GPU executes them in ring buffer order, it would write these IDs
to the completion mailbox. When mchp_gfx2d_process_completed_commands()
checks completion, it relies on a monotonically increasing mailbox value.

If the mailbox has already been overwritten with 5, the completion check for
command 6 evaluates to false, permanently stalling the command queue.

[ ... ]
> int mchp_gfx2d_wait(struct mchp_gfx2d_device *priv,
> 		    struct mchp_gfx2d_gem_object *gfx2d_obj,
> 		    const struct drm_mchp_timespec *timeout)
> {
[ ... ]
> 	mutex_lock(&gfx2d_obj->mutex);
>=20
> 	ret =3D mchp_gfx2d_gem_wait(gfx2d_obj, NULL);
> 	if (!ret || !timeout)
> 		goto unlock;
>=20
> 	drm_dbg(&priv->drm, "obj %u: wait for object\n", gfx2d_obj->id);
>=20
> 	mutex_lock(&priv->wlist_mutex);
> 	list_add_tail(&gfx2d_obj->w_node, &priv->wlist);
> 	mutex_unlock(&priv->wlist_mutex);
>=20
> 	mchp_gfx2d_enable_exend(priv);
>=20
> 	ret =3D mchp_gfx2d_gem_wait(gfx2d_obj, timeout);

[Severity: Medium]
Does holding gfx2d_obj->mutex while sleeping break the non-blocking wait
semantics?

This function acquires the mutex and then calls mchp_gfx2d_gem_wait(),
which sleeps in wait_event_interruptible_timeout().

If another thread calls the WAIT ioctl on the same object with the
DRM_MCHP_GFX2D_WAIT_NONBLOCK flag, it will block on the mutex lock instead
of returning immediately.

It seems the mutex should only protect the w_node list manipulation and be
released before sleeping.

[ ... ]
> bool mchp_gfx2d_progress(struct mchp_gfx2d_device *priv)
> {
> 	bool did_something;
>=20
> 	/* Clear pending interrupts */
> 	(void)readl(priv->regs + GFX2D_IS);

[Severity: High]
Can this lockless read of GFX2D_IS cause spurious interrupts?

Because GFX2D_IS appears to be a clear-on-read hardware register, reading it
here from process context clears pending interrupts.

If an interrupt is raised by the hardware and latched by the interrupt
controller, but this function reads GFX2D_IS before the primary IRQ handler
executes, the IRQ handler will read 0 and return IRQ_NONE.

Repeated IRQ_NONE returns can trigger the kernel's spurious interrupt
detector to permanently disable the IRQ line.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_drv.c
> --- a/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c
[ ... ]
> static int mchp_gfx2d_open(struct drm_device *dev, struct drm_file *file_=
priv)
> {
> 	struct mchp_gfx2d_file *ctx;
>=20
> 	ctx =3D kzalloc_obj(*ctx);

[Severity: Low]
Does this code fail to compile?

The macro kzalloc_obj() is not defined anywhere in the kernel or the driver,
which will lead to an immediate compile-time failure.

[ ... ]
> static irqreturn_t mchp_gfx2d_thread(int irq, void *dev_id)
> {
> 	struct mchp_gfx2d_device *priv =3D dev_id;
[ ... ]
> 	pm_runtime_resume_and_get(dev);
>=20
> 	writel(GFX2D_IRQ_EXEND, priv->regs + GFX2D_ID);

[Severity: High]
Is it safe to ignore the return value of pm_runtime_resume_and_get() here?

If the device is undergoing system suspend and it fails, it returns a
negative error and does not increment the PM usage counter. Proceeding to
access the hardware registers could trigger a bus fault if the peripheral
clock is off.

[ ... ]
> put_autosuspend:
> 	pm_runtime_mark_last_busy(dev);
> 	pm_runtime_put_autosuspend(dev);

[Severity: High]
Furthermore, unconditionally calling pm_runtime_put_autosuspend() at the end
will drop a reference that was never acquired if the resume failed, causing=
 a
PM usage counter underflow.

[ ... ]
> static void mchp_gfx2d_remove(struct platform_device *pdev)
> {
> 	struct mchp_gfx2d_device *priv =3D platform_get_drvdata(pdev);
> 	int ret;
>=20
> 	drm_dev_unregister(&priv->drm);
>=20
> 	mchp_gfx2d_disable_irq(priv);
>=20
> 	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> 	mchp_gfx2d_cleanup_command_queue(priv, !ret);

[Severity: High]
Are there two race conditions in this teardown sequence?

First, the driver does not use drm_dev_enter() and drm_dev_exit() to
serialize its ioctls against device unbinding.

While drm_dev_unregister() prevents new opens, it does not wait for actively
executing ioctls to finish. A concurrently executing ioctl could access core
resources (like the command cache) after they are destroyed in
mchp_gfx2d_cleanup_command_queue(), leading to a use-after-free.

Second, mchp_gfx2d_disable_irq() clears the software flag
(priv->irq_active =3D false) before the hardware interrupt is actually disa=
bled.

Since pm_runtime_resume_and_get() can sleep in between, if the GPU asserts a
level-triggered interrupt during this window, the hardirq handler will see
priv->irq_active as false and return IRQ_NONE without clearing the interrupt
source.

Could this lock up the CPU in an infinite IRQ storm?

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_gem.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_gem.c
> --- a/drivers/gpu/drm/microchip/mchp_gfx2d_gem.c
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_gem.c
[ ... ]
> struct drm_gem_object *
> mchp_gfx2d_gem_create_object(struct drm_device *dev, size_t size)
> {
> 	static atomic_t next_id;
> 	struct mchp_gfx2d_gem_object *gfx2d_obj;
> 	struct drm_gem_dma_object *dma_obj;
> 	struct drm_gem_object *obj;
>=20
> 	if (!size)
> 		return ERR_PTR(-EINVAL);
>=20
> 	gfx2d_obj =3D kzalloc_obj(*gfx2d_obj);

[Severity: Low]
Similar to the issue in mchp_gfx2d_open(), does this code fail to compile?

The macro kzalloc_obj() is not defined anywhere in the kernel or the driver,
which will lead to an immediate compile-time failure.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c b/drivers/gpu/d=
rm/microchip/mchp_gfx2d_ioctl.c
> --- a/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c
[ ... ]
> unsigned long mchp_timeout_to_jiffies(const struct drm_mchp_timespec *tim=
eout)
> {
> 	struct timespec64 ts, to =3D {
> 		.tv_sec =3D timeout->tv_sec,
> 		.tv_nsec =3D timeout->tv_nsec,
> 	};
>=20
> 	ktime_get_ts64(&ts);
>=20
> 	/* timeots before "now" have already expired */
> 	if (timespec64_compare(&to, &ts) <=3D 0)
> 		return 0;
>=20
> 	ts =3D timespec64_sub(to, ts);

[Severity: High]
Could an unvalidated tv_nsec value cause a CPU stall here?

This function takes timeout->tv_nsec directly from userspace without
validating that it is less than NSEC_PER_SEC. It passes this value to
timespec64_sub(), which normalizes the time using a while loop.

A malicious user could provide an extremely large value, causing the kernel
to loop billions of times and stall the CPU, triggering a soft lockup.

[ ... ]
> static int mchp_gfx2d_ioctl_alloc_buffer(struct drm_device *dev, void *da=
ta,
> 					 struct drm_file *file_priv)
> {
> 	struct drm_mchp_gfx2d_alloc_buffer *args =3D data;
> 	struct mchp_gfx2d_gem_object *gfx2d_obj;
[ ... ]
> 	gfx2d_obj =3D mchp_gfx2d_gem_create_with_handle(file_priv, dev,
> 						      args->size, dir,
> 						      &args->handle);
> 	if (IS_ERR(gfx2d_obj))
> 		return PTR_ERR(gfx2d_obj);
>=20
> 	gfx2d_obj->width =3D args->width;
> 	gfx2d_obj->height =3D args->height;
> 	gfx2d_obj->stride =3D args->stride;
> 	gfx2d_obj->format =3D args->format;

[Severity: Medium]
Is there a race condition if a concurrent thread guesses or receives this
GEM handle?

The handle is created and exposed to userspace by
mchp_gfx2d_gem_create_with_handle() before the driver-specific properties
like width, height, stride, and format are assigned.

If a concurrent SUBMIT ioctl uses this handle immediately, it could read
uninitialized properties, potentially causing the GPU to execute with
incorrect parameters.

[ ... ]
> static int mchp_gfx2d_ioctl_sync_for_gpu(struct drm_device *dev, void *da=
ta,
> 					 struct drm_file *file_priv)
> {
[ ... ]
> 		/*
> 		 * On SAM9X60 and SAM9X75 SoCs (ARM926), dma_sync_single_for_device()
> 		 * flushes the data cache based on the kernel virtual address of
> 		 * the DRM GEM object.
> 		 * However, the user-space virtual address created by mmap is
> 		 * different from the kernel one. Since, ARM926 has a VIVT data cache,
> 		 * there are cache aliasing issues resulting in graphical glitches
> 		 * if the data cache is not flushed properly.
> 		 * So, one work-around is to call flush_cache_mm() here.
> 		 */
> 		if (priv->caps->has_cache_aliasing && current->mm)
> 			flush_cache_mm(current->mm);

[Severity: High]
Does this call to flush_cache_mm() cause a module link failure on ARM?

Because flush_cache_mm() is an architecture-specific internal API, it is not
exported to modules via EXPORT_SYMBOL on ARM configurations with VIPT caches
enabled. Compiling this driver as a module will result in an undefined
reference error.

Also, synchronously flushing the entire process address space cache from a
driver ioctl is an architectural violation and can lead to severe
performance degradation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-cpitchen-m=
ainline_gfx2d-v10-0-67ca2477b3d5@microchip.com?part=3D2
